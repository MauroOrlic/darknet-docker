# darknet-docker

## What is this?
The purpose of this repository is to create a docker image used to train and run YOLOv3 models using the Darknet framework. 
This image uses AlexeyAB's fork of Darknet found [here](https://github.com/AlexeyAB/darknet) compiled with CUDA and OpenCV support.

Currently the image is based on CentOS 8. Darknet is compiled with support for CUDA 10.2 and OpenCV 3.4.

## Requirements
* Nvidia GPU driver >=440
* Docker >=19.03
* [Nvidia container toolkit](https://github.com/NVIDIA/nvidia-container-runtime)

## Usage

Build the docker image using `build_image.sh` script. This will build the docker image tagged as `darknet:cuda10.2-opencv3.4`.

Use `darknet-docker` script to run Darknet as usual. For a full list of arguments consult [AlexeyABs darknet repository](https://github.com/AlexeyAB/darknet).

* Any aguments passed to the script will be passed to darknet. 
* The image will mount the current directory as its working directory so make sure to place any needed files in your current working directory or its subdirectories in order for the image to be able to access them.
* By default `darknet-docker` script will use all available GPUs. To only use specific devices consult [nvidia-docker official documentation](https://github.com/NVIDIA/nvidia-docker#usage) and modify the script accordingly.

### Example usage

#### Basic training from scratch setup
`darknet-docker detector train coco.data coco.cfg darknet53.conv.74`

#### Training with mAP graph served over http
`darknet-docker detector train coco.data coco.cfg darknet53.conv.74 -dont_show -map -mjpeg_port 8090`

Graph is avaliable on http://localhost:8090 (might take a bit to load)
