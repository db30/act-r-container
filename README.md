# act-r-container
Speculative code to build a Docker container with ACT-R in it.

Currently builds a container that'll run ACT-R and the Browser based version of the Environment
which will be available at localhost:4000 and localhost:4000/expwindow.html.  However, since the
server is in the container and the browser connecting to the server isn't, you can't use the
load model button in the Environment.
