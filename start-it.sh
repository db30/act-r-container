#!/bin/bash
set -e
set -m

if [ "$1" = '' ]

then
 
  cp -n -r -t actr7.x/tutorial actr7.x/original-tutorial/*
  
  sbcl --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (echo-act-r-output) (mp-print-versions) (run-node-env))'

elif [ "$1" = "act-r.sh" ]
then
  
  mv actr7.x/original-tutorial actr7.x/tutorial
  sed -i -e "s/which_interface = 1/which_interface = 4/" -e "s/start-normal -->/start-normal/" -e "s/<\!-- end-normal/end-normal/" -e "s/<\!-- start-container/<\!-- start-container -->/" -e "s/end-container -->/<\!-- end-container -->/" actr7.x/examples/connections/nodejs/environment.html
 
  /act-r.sh

elif [ "$1" = "run-jupyter.sh" ]
then

  sed -i -e "s/which_interface = 1/which_interface = 3/" -e "s/start-normal -->/start-normal/" -e "s/<\!-- end-normal/end-normal/" -e "s/<\!-- start-container/<\!-- start-container -->/" -e "s/end-container -->/<\!-- end-container -->/" -e "s/src=\"\/socket.io/src=\"socket.io/" actr7.x/examples/connections/nodejs/environment.html
  sed -i -e "s/which_interface = 1/which_interface = 3/" -e "s/src=\"\/socket.io/src=\"socket.io/" actr7.x/examples/connections/nodejs/expwindow.html
 
  cp -n -r -t actr7.x/tutorial actr7.x/original-tutorial/*

  export PYTHONPATH=${PYTHONPATH}:${HOME}/actr7.x/tutorial/python

  sbcl --non-interactive --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (run-node-env) (loop))' > /dev/null 2>&1 &

  /run-jupyter.sh

else 

  sed -i -e "s/which_interface = 1/which_interface = 2/" -e "s/start-normal -->/start-normal/" -e "s/<\!-- end-normal/end-normal/" -e "s/<\!-- start-container/<\!-- start-container -->/" -e "s/end-container -->/<\!-- end-container -->/" -e "s/src=\"\/socket.io/src=\"socket.io/" actr7.x/examples/connections/nodejs/environment.html
  sed -i -e "s/which_interface = 1/which_interface = 2/" -e "s/src=\"\/socket.io/src=\"socket.io/" actr7.x/examples/connections/nodejs/expwindow.html
  
  mv actr7.x/original-tutorial actr7.x/tutorial

  export PYTHONPATH=${PYTHONPATH}:${HOME}/actr7.x/tutorial/python
  
  sbcl --non-interactive --load "quicklisp/setup.lisp" --load "actr7.x/load-act-r.lisp" --eval '(progn (init-des) (run-node-env) (loop))' > /dev/null 2>&1 &
  
  exec "$@"

fi
