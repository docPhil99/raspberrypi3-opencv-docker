[![Docker Stars](https://img.shields.io/docker/stars/mohaseeb/raspberrypi3-python-opencv.svg)](https://hub.docker.com/r/mohaseeb/raspberrypi3-python-opencv/) [![Docker Pulls](https://img.shields.io/docker/pulls/mohaseeb/raspberrypi3-python-opencv.svg)](https://hub.docker.com/r/mohaseeb/raspberrypi3-python-opencv/)

## About
The Git repo of an [OpenCV](https://opencv.org/) [Docker image](https://hub.docker.com/r/mohaseeb/raspberrypi3-python-opencv/)
, for Raspberry Pi 4 with Raspbian OS (Debian). The modules from OpenCV 
contrib are included as well.  It is based on [the resin.io python image](https://hub.docker.com/r/resin/raspberrypi3-python/).

## Usage
See [the image Docker Hub page](https://hub.docker.com/r/mohaseeb/raspberrypi3-python-opencv/)
 for information on how to use the image.

## Build
If you prefer to build the image yourself (takes around 2 hours), you can do it as follows:
* Make sure docker is installed in your Raspberry Pi. See [here](https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/) for 
instructions.
* Clone this repository into your Raspberry Pi.
```commandline
git clone https://github.com/docPhil99/raspberrypi3-opencv-docker.git
```
* Build the image as follows (assumes you want to build the image for OpenvCV 4.1.0):
```commandline
cd raspberrypi3-opencv-docker/opencv_4/4.1.0/
docker build -t my_pi_opencv_img .
```

__NB 3.4.1 has been updated to use python 3.10. Others maybe out of date 2.7__

* And run it
```commandline
docker run -it --rm \
       --name my_opencv_app_run \
       my_pi_opencv_img \
       python -c "import cv2; print(cv2.__version__)"
```
## Example
This demonstrates how you can capture video using your Raspberry Pi camera.
* Save the video capturing script to a file named `save_video.py` in your Raspberry Pi.
```python
# based on https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_gui/py_video_display/py_video_display.html#saving-a-video
import cv2

cap = cv2.VideoCapture(0)

# Define the codec and create VideoWriter object
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter('/videos/output.avi', fourcc, 20.0, (640, 480))
n_frames = 200
while n_frames > 0:
    ret, frame = cap.read()
    if ret == True:
        # write the flipped frame
        out.write(frame)
        n_frames -= 1
    else:
        break
    print('frames to capture: {}'.format(n_frames))

# Release everything when done
cap.release()
out.release()
``` 
* Execute the script as follows (assumes the camera appears as /dev/vidoe0 on 
the Raspberry Pi)
```bash
# run this from the same directory as your save_video.py script
docker run -it --rm \
    -v `pwd`/save_video.py:/save_video.py \
    -v `pwd`:/videos \
    --device /dev/video0 \
    my_pi_opencv_img \
    python /save_video.py
```
* The captured video will be written to file named `output.avi` in the same directory from which the command was executed.
## References
[OpenCV](https://opencv.org/) 
<br>[Blog post on installing OpenCV 3 on Raspberry Pi](https://www.pyimagesearch.com/2016/04/18/install-guide-raspberry-pi-3-raspbian-jessie-opencv-3/)
<br>[Blog post on installing OpenCV 4 on Raspberry Pi](https://www.learnopencv.com/install-opencv-4-on-raspberry-pi/)
## Licence
MIT
