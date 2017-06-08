| Software      | Command to Run | Additional Notes |
| --------      | --------       | ----- |
| DREAM3D       | `singularity exec docker://unlhcc/dream3d PipelineRunner`        | |
| Spades        | `singularity exec docker://unlhcc/spades spades.py` | |
| Macaulay2     | `singularity exec docker://unlhcc/macaulay2 M2` | |
| CUDA (Ubuntu) | `singularity exec docker://unlhcc/cuda-ubuntu <my CUDA program>` | Ubuntu 16.04.1 LTS w/CUDA 8.0 |
| TensorFlow GPU | `singularity exec docker://unlhcc/tensorflow-gpu python /path/to/my_tf_code.py` | Use `python3` for Python3 code |
| Keras w/Tensorflow GPU backend | `singularity exec docker://unlhcc/keras-tensorflow-gpu python /path/to/my_keras_code.py` | Use `python3` for Python3 code |
