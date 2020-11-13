#!/bin/bash
set -e
set -m

if [ "$1" = '' ]

then
  rm environment.html 
  rm expwindow.html
  cp -n -r -t actr7.x/tutorial actr7.x/original-tutorial/*
  rm environment-play-with-docker.html
  
  sbcl --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (echo-act-r-output) (mp-print-versions) (run-node-env))'

elif [ "$1" = "act-r.sh" ]
then
  rm environment.html 
  rm expwindow.html
  mv actr7.x/original-tutorial actr7.x/tutorial
  mv environment-play-with-docker.html actr7.x/examples/connections/nodejs/environment.html
 
  /act-r.sh

else 
  mv environment.html actr7.x/examples/connections/nodejs/
  mv expwindow.html actr7.x/examples/connections/nodejs/
  export PYTHONPATH=${PYTHONPATH}:${HOME}/actr-python-tutorial
  mv actr7.x/original-tutorial actr7.x/tutorial
  rm environment-play-with-docker.html
  
  sbcl --non-interactive --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (run-node-env) (loop))' > /dev/null 2>&1 &
  exec "$@"

fi