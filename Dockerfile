FROM python:3.8
LABEL maintainer="Dan Bothell <db30@andrew.cmu.edu>"
WORKDIR /ACT-R
COPY . .

RUN apt-get update && apt-get install -y
RUN apt-get install -y wget bzip2 make
RUN apt-get install -y wget unzip curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs


RUN npm install --save express
RUN npm install --save socket.io


# Use actr user and group for non-root environments
RUN groupadd --gid 1001 actr
RUN useradd -u 1001 -g actr actr
RUN mkdir -p /home/actr && \
    chown -R actr:actr /home/actr /ACT-R


# setup lisp environment
RUN wget http://prdownloads.sourceforge.net/sbcl/sbcl-2.0.0-x86-64-linux-binary.tar.bz2
RUN tar -xf sbcl-2.0.0-x86-64-linux-binary.tar.bz2
RUN rm sbcl-2.0.0-x86-64-linux-binary.tar.bz2
RUN cd sbcl-2.0.0-x86-64-linux && sh install.sh
RUN rm -r sbcl-2.0.0-x86-64-linux

USER actr:actr
RUN wget https://beta.quicklisp.org/quicklisp.lisp
RUN sbcl --quit --load quicklisp.lisp --eval '(quicklisp-quickstart:install :path "quicklisp")'
RUN rm quicklisp.lisp

RUN wget http://act-r.psy.cmu.edu/actr7.x/actr7.x.zip
RUN unzip actr7.x.zip
RUN rm -r actr7.x.zip

RUN cp /ACT-R/run-node-env.lisp /ACT-R/actr7.x/user-loads/

RUN sbcl --quit --load quicklisp/setup.lisp --eval '(push :standalone *features*)' --load actr7.x/load-act-r.lisp


ENTRYPOINT [ "sbcl", "--load", "quicklisp/setup.lisp", "--load", "actr7.x/load-act-r.lisp", "--eval", "(progn (init-des) (echo-act-r-output) (mp-print-versions) (run-node-env))"]