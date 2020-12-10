#!/bin/bash
set -e
set -m

cd ${HOME}
 
jupyter notebook  --NotebookApp.default_url="/notebooks/tutorial.ipynb" --ip=0.0.0.0 --port=8888 --NotebookApp.trust_xheaders=True --NotebookApp.allow_origin=*