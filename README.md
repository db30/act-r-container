# act-r-container
Code to build a Docker container with ACT-R in it along with the Nodejs server running to support the HTML version of the ACT-R Environment and experiment window viewer.

Here are three ways that one could use this:

1) From mybinder.org (or other BinderHub) to run ACT-R from Python in Jupyter notebooks without any local instalation necessary.
There are Jupyter notebooks with some simple examples of running things included, and this button will start it [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/db30/act-r-container/main?filepath=simple.ipynb)

2) You can also use it to run on a machine which has Docker installed to avoid having to install a Lisp, quicklisp, and the ACT-R code.
If you run it as shown below then you can also connect to the HTML Environment and Experiment window viewer, connect Python (or other remote interface) to it on the default ACT-R port (2650), and have the tutorial files copied from inside the container to a directory on the local machine where they can be editted and still accessed by ACT-R in the container from its actr7.x/tutorial directory (it won't overwrite any files already in that directory on the machine so you can safely work on those files accross different runs of the container).
There is an image already built on DockerHub so you can get it with this:

docker pull db30/act-r-container

Then you can run it like this which will leave you at a Lisp prompt ready to go:

Mac and Linux

docker run -i -p 4000:4000 -p 2650:2650 -v ~/act-r-tutorial:/home/actr/actr7.x/tutorial db30/act-r-container

Windows

docker run -i -p 4000:4000 -p 2650:2650 -v %homedrive%%homepath%\act-r-tutorial:/home/actr/actr7.x/tutorial db30/act-r-container

The -p flags are to expose the ports for the HTML Environment interface and the ACT-R remote interface.  The -v flag sets up the location on the computer where the tutorial files will be stored.  The value before the : is the path on the local machine to the files.  It can be anywhere, and will create the directory if it does not already exist.  The example calls above create an act-r-tutorial directory in the user's home directory.

The Environment will be available from a browser at: http://localhost:4000 and the experiment window viewer at: http://localhost:4000/expwindow.html or by clicking the "Open Experiment Window" button in the Environment.

Note, if you're using MacOS and working with ACT-R from another language, my experience is that it's faster to use the version from the container than it is to run a Lisp locally on the machine!  That's because SBCL is faster than other Lisps, but the MacOS native version of SBCL has some threading or locking performance issues (not entirely sure which).  The SBCL in the container doesn't suffer from those issues, and the container overhead was less costly on my machine than those issues.

3) You could run it similar to step 2 from the Play with Docker site: https://labs.play-with-docker.com/ .That will only give you the Lisp interface, the HTML Environment, and HTML experiment window viewer, but not the remote interface or connecting to local files.

After starting a new session on Play with Docker you can call this:

docker pull db30/act-r-container

Then

docker run -i -p 4000:4000 db30/act-r-container 

Clicking on the 4000 in the top right of the window will open the Environment, and the "Open Experiment WIndow" button will open a window with the experiment window viewer.
