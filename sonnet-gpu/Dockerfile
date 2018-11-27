# Start with our TensorFlow GPU image
FROM unlhcc/tensorflow-gpu:1.12

RUN pip install tensorflow-probability-gpu tensorflow-probability wrapt dm-sonnet==1.27 && pip3 install tensorflow-probability-gpu tensorflow-probability wrapt dm-sonnet==1.27

# install dependencies
RUN apt-get update && apt-get install -y libcurl4-openssl-dev zlib1g-dev cmake libjpeg-dev libpng12-dev libpng-dev
