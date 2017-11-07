| Software       | Version  | Command to Run | Additional Notes |
| --------       | -------- | --------       | ----- |
| DREAM3D        | 6.3.29    | `singularity exec docker://unlhcc/dream3d PipelineRunner`        | |
| Spades         | 3.9.0     | `singularity exec docker://unlhcc/spades spades.py` | |
| Macaulay2      | 1.6       | `singularity exec docker://unlhcc/macaulay2 M2` | |
| CUDA (Ubuntu)  | 8.0       | `singularity exec docker://unlhcc/cuda-ubuntu <my CUDA program>` | Ubuntu 16.04.1 LTS w/CUDA 8.0 |
| TensorFlow GPU | 1.3          | `singularity exec docker://unlhcc/tensorflow-gpu python /path/to/my_tf_code.py` | Use `python3` for Python3 code |
| Keras w/Tensorflow GPU backend| 2.0.4     | `singularity exec docker://unlhcc/keras-tensorflow-gpu python /path/to/my_keras_code.py` | Use `python3` for Python3 code |
| Octave         | 4.2.1     | `singularity exec docker://unlhcc/octave octave` | |
| Sonnet GPU     | 1.13      | `singularity exec docker://unlhcc/sonnet-gpu python /path/to/my_sonnet_code.py` | Use `python3` for Python3 code |
| Neurodocker w/ANTs | 2.2.0 | `singularity exec docker://unlhcc/neurodocker-ants <ants script>` | Replace `<ants script>` with the desired ANTs program |
| GNU Radio      | 3.7.11    | `singularity exec docker://unlhcc/gnuradio python /path/to/my_gnuradio_code.py` | Replace `python /path/to/my_gnuradio_code.py` with other GNU Radio commands to run |
| Neurodocker w/AFNI | 17.3.00 | `singularity exec docker://unlhcc/neurodocker-afni <AFNI program>` | Replace `<AFNI program>` with the desired AFNI program |
| Neurodocker w/FreeSurfer | 6.0.0 | `singularity -B <path to your FS license>:/opt/freesurfer/license.txt run docker://unlhcc/neurodocker-freesurfer recon-all` | Substitute `<path to your FS license>` with the full path to your paricular FS license file.  Replace `recon-all` with other FreeSurfer commands to run |
