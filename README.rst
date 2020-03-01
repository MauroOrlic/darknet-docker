darknet-docker
==============

Introduction
------------

The purpose of this repository is to create a docker image used to train and run YOLOv3 models using the Darknet framework. This image uses AlexeyAB's fork of Darknet found
`here <https://github.com/AlexeyAB/darknet>`__ compiled with CUDA and OpenCV support.

Currently the image is based on CentOS 8 linux distro. Darknet is compiled with support for CUDA 10.2 and OpenCV 3.4.

Repository contents
~~~~~~~~~~~~~~~~~~~

-  ``Dockerfile`` - dockerfile from which the image is built
-  ``build_image.sh`` - small script used to build and tag the image
-  ``darknet-docker`` - a thin wrapper around the ``docker run`` command used to run darknet commands

Requirements
------------

-  Nvidia driver >=440
-  Docker >=19.03
-  `Nvidia container toolkit <https://github.com/NVIDIA/nvidia-container-runtime>`__

Usage
-----

#. Build the docker image using ``build_image.sh`` script.

#. Use ``darknet-docker`` script to run Darknet as usual. For a full list of arguments and instructions on how to use darknet consult https://github.com/AlexeyAB/darknet#how-to-use-on-the-command-line.

**Additional information:**

-  Any arguments passed to the script will be passed to darknet.
-  The image will mount the current directory as its working directory so make sure to place any needed files in your current working directory or its subdirectories in order for the image to be able to access them.
-  By default ``darknet-docker`` script will use all available GPUs. To only use specific devices consult `nvidia-docker official documentation <https://github.com/NVIDIA/nvidia-docker#usage>`__ and modify the script accordingly.

Example usage
~~~~~~~~~~~~~

Basic training from scratch
^^^^^^^^^^^^^^^^^^^^^^^^^^^

``./darknet-docker detector train coco.data coco.cfg darknet53.conv.74``

Continue training from existing .weights file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``./darknet-docker detector train coco.data coco.cfg backup/all_last.weights``

Training from scratch with mAP graph served over http
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``./darknet-docker detector train coco.data coco.cfg darknet53.conv.74 -dont_show -map -mjpeg_port 8090``

Graph is avaliable on http://localhost:8090 (might take a bit to load)

Frequently asked Questions
--------------------------

/
