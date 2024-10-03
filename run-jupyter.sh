#!/bin/bash
set -e
set -m

cd ${HOME}
 
jupyter notebook  --ExtensionApp.default_url="/notebooks/tutorial.ipynb" --ip=0.0.0.0 --port=8888 --ServerApp.trust_xheaders=True --ServerApp.allow_origin=*
