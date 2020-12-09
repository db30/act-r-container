#!/bin/bash
set -e
set -m

cd ${HOME}
 
jupyter notebook --ip=0.0.0.0 --port=8888 --NotebookApp.trust_xheaders=True --NotebookApp.allow_origin=* simple.ipynb