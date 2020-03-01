FROM centos:8


# Setting up run environment
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,video,utility


# Installing basic build tools
RUN dnf group install -y "Development Tools" \
&&  dnf install -y epel-release \
&&  dnf install -y cmake3 \
&&  alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 \
    --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 \
    --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 \
    --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 \
    --family cmake


# Installing dependencies
RUN dnf install -y --nogpgcheck "https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm" \
&&  dnf install -y --nogpgcheck "https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm" \
                                "https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm" \
&&  dnf config-manager --enable PowerTools \
&&  dnf install -y xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs \
                   opencv opencv-devel

RUN dnf config-manager --add-repo "http://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo" \
&&  dnf install -y cuda

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/cuda/lib64"
ENV PATH="$PATH:/usr/local/cuda-10.2/bin"


# Building and installing darknet
RUN git clone https://github.com/AlexeyAB/darknet.git \
&&  cd darknet && mkdir build-release && cd build-release \
&&  cmake .. \
    -DCMAKE_C_STANDARD=99 \
&&  export DESTDIR=/opt \
&&  make -j $(nproc) && make install \
&&  rm -rf /darknet
ENV PATH="$PATH:/opt/darknet"

RUN mkdir /mnt/dataset
WORKDIR /mnt/dataset

EXPOSE 8090

RUN dnf erase -y opencv-devel 
