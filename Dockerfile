# This is the docker file for the audiveris-docker project
FROM    ubuntu:14.04
MAINTAINER Lucas Wilson-Richter <audiveris-docker@lucasrichter.id.au>

LABEL Description="Audiveris Open Music Scanner, version 4.2.3318"

# Basic message
RUN echo "Building docker image"

# Install installer helper tools
RUN apt-get install -y software-properties-common

# Add global apt repos for dependencies
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise universe" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse"

# Update and upgrade the repositories once
RUN apt-get update && apt-get -y upgrade

# Install the dependencies of opencv
RUN apt-get -y remove ffmpeg x264 libx264-dev
RUN apt-get -y install libopencv-dev
RUN apt-get -y install build-essential checkinstall cmake pkg-config yasm
RUN apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev
RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev
RUN apt-get -y install python-dev python-numpy
RUN apt-get -y install libtbb-dev
RUN apt-get -y install libqt4-dev libgtk2.0-dev
RUN apt-get -y install libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev
RUN apt-get -y install x264 v4l-utils ffmpeg
RUN apt-get -y install libgtk2.0-dev
RUN apt-get -y install git wget ghostscript

# Install opencv on the image, its needed for something or other
RUN     git clone https://github.com/Khalian/Install-OpenCV
RUN     chmod +x /Install-OpenCV/Ubuntu/2.4/opencv2_4_9.sh
RUN	    sh /Install-OpenCV/Ubuntu/2.4/opencv2_4_9.sh

# Install java
RUN     apt-get -y install openjdk-7-jdk

# The installation of tessaract and audiveris prototypes, under construction
RUN     apt-get -y install tesseract-ocr liblept4 libtesseract3 tesseract-ocr-deu tesseract-ocr-eng tesseract-ocr-fra tesseract-ocr-ita

# This is an old version of Audiveris, and could be updated.
RUN     wget https://kenai.com/projects/audiveris/downloads/download/oldies/audiveris-4.2.3318-ubuntu-amd64.deb -O audiveris.deb
RUN     dpkg -i audiveris.deb
RUN chmod +x /usr/bin/audiveris/audiveris.sh

ENV PATH $PATH:/usr/bin/audiveris

# Using an ENTRYPOINT like this would make using the container more like using a command.
# ENTRYPOINT ["audiveris.sh"]