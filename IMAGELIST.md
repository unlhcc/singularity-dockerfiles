| Software       | Version  | Command to Run | Additional Notes |
| --------       | -------- | --------       | ----- |
| DREAM3D        | 6.3.29, 6.5.36 | `singularity exec docker://unlhcc/dream3d PipelineRunner`        | |
| Spades         | 3.11.0    | `singularity exec docker://unlhcc/spades spades.py` | |
| Macaulay2      | 1.9.2     | `singularity exec docker://unlhcc/macaulay2 M2` | |
| CUDA (Ubuntu)  | 9.2       | `singularity exec docker://unlhcc/cuda-ubuntu <my CUDA program>` | Ubuntu 16.04.1 LTS w/CUDA Toolkit |
| TensorFlow GPU | 1.4, 1.12          | `singularity exec docker://unlhcc/tensorflow-gpu python /path/to/my_tf_code.py` | Use `python3` for Python3 code |
| Keras w/Tensorflow GPU backend| 2.0.4, 2.1.5, 2.2.4 | `singularity exec docker://unlhcc/keras-tensorflow-gpu python /path/to/my_keras_code.py` | Use `python3` for Python3 code |
| Octave         | 4.2.1     | `singularity exec docker://unlhcc/octave octave` | |
| Sonnet GPU     | 1.13, 1.27      | `singularity exec docker://unlhcc/sonnet-gpu python /path/to/my_sonnet_code.py` | Use `python3` for Python3 code |
| Neurodocker w/ANTs | 2.2.0 | `singularity exec docker://unlhcc/neurodocker-ants <ants script>` | Replace `<ants script>` with the desired ANTs program |
| GNU Radio      | 3.7.11    | `singularity exec docker://unlhcc/gnuradio python /path/to/my_gnuradio_code.py` | Replace `python /path/to/my_gnuradio_code.py` with other GNU Radio commands to run |
| Neurodocker w/AFNI | 17.3.00 | `singularity exec docker://unlhcc/neurodocker-afni <AFNI program>` | Replace `<AFNI program>` with the desired AFNI program |
| Neurodocker w/FreeSurfer | 6.0.0 | `singularity run -B <path to your FS license>:/opt/freesurfer/license.txt docker://unlhcc/neurodocker-freesurfer recon-all` | Substitute `<path to your FS license>` with the full path to your particular FS license file.  Replace `recon-all` with other FreeSurfer commands to run. |
| fMRIprep       | 1.0.7     | `singularity exec docker://unlhcc/fmriprep fmriprep` | |
| ndmg           | 0.0.50    | `singularity exec docker://unlhcc/ndmg ndmg_bids` | |
| NIPYPE (Python2)   | 1.0.0   | `singularity exec docker://unlhcc/nipype-py27 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| NIPYPE (Python3)   | 1.0.0   | `singularity exec docker://unlhcc/nipype-py36 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| DPARSF         | 4.3.12    | `singularity exec docker://unlhcc/dparsf <DPARSF program>` | Replace `<DPARSF program>` with the desired DPARSF program |
| Caffe GPU      | 1.0       | `singularity exec docker://unlhcc/caffe-gpu caffe` | Use `python3` for Python interface |
| ENet Caffe GPU | 427a014   | `singularity exec docker://unlhcc/enet-caffe-gpu <ENET program>` | Replace `<ENET program>` with the desired ENET program |
| ROS Kinetic | 1.3.1   | `singularity exec docker://unlhcc/ros-kinetic <ROS program>` | Replace `<ROS program>` with the desired ROS program |
| Mitsuba        | 1.5.0     | `singularity exec docker://unlhcc/mitsuba mitsuba` | |
| FImpute        | 2.2       | `singularity exec docker://unlhcc/fimpute FImpute <control file>` | Replace `<control file>` with the control file you have prepared |
| Neurodocker w/FSL | 5.0.11 | `singularity run docker://unlhcc/neurodocker-fsl <FSL program>` | Replace `<FSL program>` with the desired FSL program. This image includes GPU support. |
| gdc-client     | 1.4.0     | `singularity exec docker://unlhcc/gdc-client gdc-client <sub-command>` | Replace `<sub-command>` with the desired gdc-client sub-command |
| BLUPF90 | 1.0 | `singularity exec docker://unlhcc/blupf90 <command>` | Replace `<command>` with any command from the suite (`blupf90`, `renumf90`, etc.) |
| RMark | 2.2.5 | `singularity exec docker://unlhcc/rmark Rscript my_r_script.r` | |
| SURPI | 1.0.18 | `singularity exec docker://unlhcc/surpi SURPI.sh -f </path/to/config>` | Replace `</path/to/config>` with the full path to your config file |
| PyTorch | 1.0.1 | `singularity exec docker://unlhcc/pytorch python /path/to/my_torch_code.py` | Use `python3` for Python3 code. This image includes both CPU and GPU support. |
| bioBakery | 1.1 | `singularity exec docker://unlhcc/biobakery <bioBakery program>` | Replace `<bioBakery program>` with the desired bioBakery program and its arguments |
| LIONS | 0.2 | `singularity exec -B <resource directory>:/LIONS-docker/resources/<genomeName> -B <data_directory>:/LIONS-data docker://unlhcc/lions lions.sh <path/to/parameter/ctrl>` | Replace `<path/to/parameter/ctrl>` with the path to your parameter file. |
| lyve-SET | 1.1.4f | `singularity exec docker://unlhcc/lyve-set <lyve-SET program>` | Replace `<lyve-SET program>` with any command from the lyve-SET suite |
| RASTtk | 1.3.0 | `singularity exec docker://unlhcc/rasttk <rasttk program>` | Replace `<rasttk program>` with any command from the RASTtk suite. |
