# Start with our TensorFlow GPU image
FROM unlhcc/tensorflow-gpu

RUN pip install dm-sonnet==1.13 && pip3 install dm-sonnet==1.13

# install dependencies
RUN apt-get update && apt-get install -y libcurl4-openssl-dev zlib1g-dev cmake libjpeg-dev libpng12-dev libpng-dev

# Env setup
ADD environment /environment
ADD docker_environment /docker_environment
