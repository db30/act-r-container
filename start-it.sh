#!/bin/bash
set -e
set -m

if [ "$1" = '' ]

then
  rm environment.html 
  rm environment-jupyter.html
  rm environment-play-with-docker.html
  rm expwindow.html
  rm expwindow-jupyter.html

  cp -n -r -t actr7.x/tutorial actr7.x/original-tutorial/*
  
  sbcl --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (echo-act-r-output) (mp-print-versions) (run-node-env))'

elif [ "$1" = "act-r.sh" ]
then
  rm environment.html 
  rm environment-jupyter.html
  rm expwindow.html
  rm expwindow-jupyter.html

  mv actr7.x/original-tutorial actr7.x/tutorial
  mv environment-play-with-docker.html actr7.x/examples/connections/nodejs/environment.html
 
  /act-r.sh

elif [ "$1" = "run-jupyter.sh" ]
then


  rm environment.html 
  rm environment-play-with-docker.html
  rm expwindow.html

  mv environment-jupyter.html actr7.x/examples/connections/nodejs/environment.html
  mv expwindow-jupyter.html actr7.x/examples/connections/nodejs/expwindow.html
 
  cp -n -r -t actr7.x/tutorial actr7.x/original-tutorial/*

  export PYTHONPATH=${PYTHONPATH}:${HOME}/actr7.x/tutorial/python

  sbcl --non-interactive --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (run-node-env) (loop))' > /dev/null 2>&1 &

  /run-jupyter.sh

else 
  mv environment.html actr7.x/examples/connections/nodejs/
  mv expwindow.html actr7.x/examples/connections/nodejs/
  mv actr7.x/original-tutorial actr7.x/tutorial

  export PYTHONPATH=${PYTHONPATH}:${HOME}/actr7.x/tutorial/python

  rm environment-play-with-docker.html
  rm expwindow-jupyter.html
  rm environment-jupyter.html
  
  sbcl --non-interactive --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (run-node-env) (loop))' > /dev/null 2>&1 &
  
  echo "$@" > cmd.txt
  exec "$@"

fi
