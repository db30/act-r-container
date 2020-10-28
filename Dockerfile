FROM python:3.7-slim
LABEL maintainer="Dan Bothell <db30@andrew.cmu.edu>"

RUN apt-get update && apt-get install -y
RUN apt-get install -y wget bzip2 make unzip curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN npm install --save express
RUN npm install --save socket.io

RUN pip install --no-cache notebook numpy matplotlib scipy jupyter_server_proxy

ARG NB_USER=actr
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}


WORKDIR ${HOME}

# setup lisp environment

RUN wget http://prdownloads.sourceforge.net/sbcl/sbcl-2.0.9-x86-64-linux-binary.tar.bz2
RUN tar -xf sbcl-2.0.9-x86-64-linux-binary.tar.bz2 && \
    rm sbcl-2.0.9-x86-64-linux-binary.tar.bz2
RUN cd sbcl-2.0.9-x86-64-linux && \
    sh install.sh && \
    cd .. && \
    rm -r sbcl-2.0.9-x86-64-linux

USER ${NB_USER}

RUN wget https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --quit --load quicklisp.lisp --eval '(quicklisp-quickstart:install :path "quicklisp")' && \
    rm quicklisp.lisp

RUN wget http://act-r.psy.cmu.edu/actr7.x/actr7.container.zip && \
    unzip actr7.container.zip  && \
    rm -r actr7.container.zip

COPY . .

USER root
RUN chown -R ${NB_UID} ${HOME}
RUN chmod 777 start-it.sh && mv start-it.sh /start-it.sh
RUN chmod 777 act-r.sh && mv act-r.sh /act-r.sh

USER ${NB_USER}

RUN mv run-node-env.lisp actr7.x/user-loads/
RUN mv run-node.sh actr7.x/
RUN mkdir actr-python-tutorial
RUN cp actr7.x/tutorial/python/*.py actr-python-tutorial
RUN rm README.md
RUN rm Dockerfile

RUN mv actr7.x/tutorial actr7.x/original-tutorial

RUN sbcl --quit --load quicklisp/setup.lisp --eval '(push :standalone *features*)' --load actr7.x/load-act-r.lisp

ENTRYPOINT ["/start-it.sh"]