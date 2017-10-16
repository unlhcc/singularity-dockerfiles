# Start with our TensorFlow GPU image
FROM unlhcc/tensorflow-gpu

RUN pip install dm-sonnet==1.13 && pip3 install dm-sonnet==1.13

# Env setup
ADD environment /environment
ADD docker_environment /docker_environment
