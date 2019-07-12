# Start with our TensorFlow GPU image

FROM unlhcc/tensorflow-gpu:1.14

RUN pip install dm-sonnet==1.34 && pip3 install dm-sonnet==1.34

# install dependencies
RUN apt-get -qq update && apt-get -qq install -y libcurl4-openssl-dev zlib1g-dev cmake libjpeg-dev libpng12-dev libpng-dev
