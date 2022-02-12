#!/bin/bash

docker-compose run --rm real-esrgan python inference_realesrgan.py -n RealESRGAN_x4plus -i inputs --face_enhance --tile 200
