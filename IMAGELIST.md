| Software       | Version  | Command to Run | Additional Notes |
| --------       | -------- | --------       | ----- |
| DREAM3D        | 6.3.29, 6.5.36, 6.5.137, 6.5.138 | `singularity exec docker://unlhcc/dream3d PipelineRunner`        | |
| Spades         | 3.11.0    | `singularity exec docker://unlhcc/spades spades.py` | |
| Macaulay2      | 1.15, 1.9.2     | `singularity exec docker://unlhcc/macaulay2 M2 <options>` | Replace `<options>` with the desired options for Macaulay2. |
| CUDA (Ubuntu)  | 10.2       | `singularity exec docker://unlhcc/cuda-ubuntu <my CUDA program>` | Ubuntu 16.04.1 LTS w/CUDA Toolkit |
| TensorFlow GPU | 1.4, 1.12, 1.14, 2.0.0, 2.1.0, 2.2.0 | `singularity exec docker://unlhcc/tensorflow-gpu python /path/to/my_tf_code.py` | Provides Python 3.7 |
| Keras w/Tensorflow GPU backend| 2.0.4, 2.1.5, 2.2.4, 2.3.1 | `singularity exec docker://unlhcc/keras-tensorflow-gpu python /path/to/my_keras_code.py` | Use `python3` for Python3 code |
| Octave         | 4.2.1     | `singularity exec docker://unlhcc/octave octave` | |
| Sonnet GPU     | 1.13, 1.27, 1.34, 2.0.0  | `singularity exec docker://unlhcc/sonnet-gpu python /path/to/my_sonnet_code.py` | Provides Python 3.7 |
| Neurodocker w/ANTs | 2.2.0, 2.3.4 | `singularity exec docker://unlhcc/neurodocker-ants <ants script>` | Replace `<ants script>` with the desired ANTs program |
| GNU Radio      | 3.7.11, 3.7.13.5  | `singularity exec docker://unlhcc/gnuradio python /path/to/my_gnuradio_code.py` | Replace `python /path/to/my_gnuradio_code.py` with other GNU Radio commands to run |
| Neurodocker w/AFNI | 17.3.00, 19.2.20, 19.2.21, 20.3.01 | `singularity exec docker://unlhcc/neurodocker-afni <AFNI program>` | Replace `<AFNI program>` with the desired AFNI program |
| Neurodocker w/FreeSurfer | 6.0.0 | `singularity run -B <path to your FS license>:/opt/freesurfer/license.txt docker://unlhcc/neurodocker-freesurfer recon-all` | Substitute `<path to your FS license>` with the full path to your particular FS license file.  Replace `recon-all` with other FreeSurfer commands to run. |
| fMRIprep       | 1.0.7     | `singularity exec docker://unlhcc/fmriprep fmriprep` | |
| ndmg           | 0.0.50    | `singularity exec docker://unlhcc/ndmg ndmg_bids` | |
| NIPYPE (Python2)   | 1.0.0   | `singularity exec docker://unlhcc/nipype-py27 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| NIPYPE (Python3)   | 1.0.0   | `singularity exec docker://unlhcc/nipype-py36 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| DPARSF         | 4.3.12    | `singularity exec docker://unlhcc/dparsf <DPARSF program>` | Replace `<DPARSF program>` with the desired DPARSF program |
| Caffe GPU      | 1.0, 1.0-136-g9b89154  | `singularity exec docker://unlhcc/caffe-gpu caffe` | Image provides Python 3.7. Matcaffe is included; load `matlab/r2016b` module and add `-B $MATLAB_ROOT:/opt/matlab` to the singularity options to use. |
| ENet Caffe GPU | 427a014, 22d356c   | `singularity exec docker://unlhcc/enet-caffe-gpu <ENET program>` | Replace `<ENET program>` with the desired ENET program |
| ROS Kinetic | 1.3.1, 1.3.2   | `singularity exec docker://unlhcc/ros-kinetic <ROS program>` | Replace `<ROS program>` with the desired ROS program |
| Mitsuba        | 1.5.0     | `singularity exec docker://unlhcc/mitsuba mitsuba` | |
| FImpute        | 2.2       | `singularity exec docker://unlhcc/fimpute FImpute <control file>` | Replace `<control file>` with the control file you have prepared |
| Neurodocker w/FSL | 6.0.3, 5.0.11 | `singularity run docker://unlhcc/neurodocker-fsl <FSL program>` | Replace `<FSL program>` with the desired FSL program. This image includes GPU support; add `--nv` to the `singularity run` args to enable it. |
| gdc-client     | 1.4.0     | `singularity exec docker://unlhcc/gdc-client gdc-client <sub-command>` | Replace `<sub-command>` with the desired gdc-client sub-command |
| BLUPF90 | 1.0 | `singularity exec docker://unlhcc/blupf90 <command>` | Replace `<command>` with any command from the suite (`blupf90`, `renumf90`, etc.) |
| RMark | 2.2.5 | `singularity exec docker://unlhcc/rmark Rscript my_r_script.r` | |
| SURPI | 1.0.18 | `singularity exec docker://unlhcc/surpi SURPI.sh -f </path/to/config>` | Replace `</path/to/config>` with the full path to your config file |
| PyTorch | 1.0.1, 1.1.0, 1.2.0, 1.5.0 | `singularity exec docker://unlhcc/pytorch python /path/to/my_torch_code.py` | This image includes both CPU and GPU support, and provides Python 3.7. |
| bioBakery | 1.1, 3.0.0 | `singularity exec docker://unlhcc/biobakery <bioBakery program>` | Replace `<bioBakery program>` with the desired bioBakery program and its arguments |
| LIONS | 0.2 | `singularity exec -B <resource directory>:/LIONS-docker/resources/<genomeName> -B <data_directory>:/LIONS-data docker://unlhcc/lions lions.sh <path/to/parameter/ctrl>` | Replace `<path/to/parameter/ctrl>` with the path to your parameter file. |
| lyve-SET | 1.1.4f | `singularity exec docker://unlhcc/lyve-set <lyve-SET program>` | Replace `<lyve-SET program>` with any command from the lyve-SET suite |
| RASTtk | 1.3.0 | `singularity exec docker://unlhcc/rasttk <rasttk program>` | Replace `<rasttk program>` with any command from the RASTtk suite. |
| CellRanger | 3.0.2, 3.1.0, 4.0.0 | `singularity exec docker://unlhcc/cellranger cellranger <cellranger program>` | Replace `<cellranger program>` with any command from the CellRanger suite. |
| SkylineRunner | 3.0.19158 | `singularity run -B $PWD:/data -B /tmp:/mywineprefix docker://unlhcc/skylinerunner mywine SkylineCmd <options>` | Replace `$PWD` with an absolute path if not running from the directory containing data. |
| MXNet GPU (Python only) | 1.5.0, 1.6.0 | `singularity exec docker://unlhcc/mxnet-gpu python /path/to/my_mxnet_code.py` | Provides Python 3.7. |
| ORFfinder | 0.4.3 | `singularity exec docker://unlhcc/orffinder ORFfinder <options>` | Replace `<options>` with the available options for ORFfinder. |
| ARG_OAP | 2.0 | `singularity exec docker://unlhcc/arg_oap <arg_oap program>` | Replace `<arg_oap program>` with the desired ARG_OAP program and its arguments. |
| CRISPRCasFinder | 4.2.20, 4.2.19 | `singularity exec docker://unlhcc/crisprcasfinder CRISPRCasFinder.pl -in </path/to/input/fasta> <options> -soFile /opt/CRISPRCasFinder/sel392v2.so` | Replace `<path/to/input/fasta>` with the path to your input fasta file, and replace `<options>` with the available options for CRISPRCasFinder. |
| WINE | 5.0 | `singularity exec -B /tmp:/mywineprefix docker://unlhcc/wine-ubuntu mywine <windows program>` | Replace `<windows program>` with the full path to the Windows binary. |
| Slicer | 4.10.2 | `singularity exec docker://unlhcc/slicer Slicer <options>` | Slicer comes with multiple CLI modules that are located in `/home/slicer/lib/Slicer-4.10/cli-modules/` within the image. For example, to use Slicer with the module BRAINSFit, one can run Slicer as `singularity exec docker://unlhcc/slicer Slicer --launch /home/slicer/lib/Slicer-4.10/cli-modules/BRAINSFit <options>` where `<options>` are the available options for BRAINSFit. |
| Inverted Repeats Finder (IRF) | 3.07 | `singularity exec docker://unlhcc/irf irf307.linux.exe` | |
| COMSOL | 5.5, 5.6 | `singularity run -B $COMSOL_ROOT:/opt/comsol docker://unlhcc/comsol comsol batch <comsol args>` | This image does NOT include COMSOL itself. It is a thin wrapper to allow newer (>=5.5) versions of COMSOL to run in batch mode on Crane. You must also load the respective `comsol` module. On Rhino, using this image is not necessary - load and run comsol directly. |
| r-inla | 20.03.17 | `singularity exec docker://unlhcc/r-inla Rscript /path/to/my/script.R` | Provides R 3.6 with the INLA package and tidyverse suite. |
| Blender | 2.83.1 | `singularity exec docker://unlhcc/blender blender <options>` | Replace `<options>` with any of the Blender CLI arguments. |
| ASAP         | 1.9 | `singularity exec docker://unlhcc/asap ASAP` | |
| freesurfer | 5.3, 6.0 | `singularity run -B $MATLAB_ROOT:/opt/matlab docker://unlhcc/freesurfer recon-all <options> | Provides FreeSurfer 5.3, 6.0. Load a matlab module additionally to make it available in the container. |
| PATRIC | 1.035 | `singularity exec docker://unlhcc/patric <p3-command>` | Provides the [PATRIC command line interface](https://docs.patricbrc.org/cli_tutorial/index.html). Replace `<p3-command>` with the specific PATRIC command to run. |
| AlphaFold | 2.0.0 | `singularity run -B /work/HCC/BCRF/app_specific/alphafold/2.0.0/:/data -B .:/etc --pwd /app/alphafold --nv docker://unlhcc/alphafold <options>` | Replace `<options>` with any of the AlphaFold CLI arguments. |
