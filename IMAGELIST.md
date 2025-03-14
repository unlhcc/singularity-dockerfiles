| Software       | Version  | Command to Run | Additional Notes |
| --------       | -------- | --------       | ----- |
| DREAM3D        | 6.3.29, 6.5.36, 6.5.137, 6.5.138 | `apptainer exec docker://unlhcc/dream3d PipelineRunner`        | |
| Spades         | 3.11.0    | `apptainer exec docker://unlhcc/spades spades.py` | |
| Macaulay2      | 1.24.05, 1.15, 1.9.2    | `apptainer exec docker://unlhcc/macaulay2 M2 <options>` | Replace `<options>` with the desired options for Macaulay2. |
| CUDA (Ubuntu)  | 10.2       | `apptainer exec docker://unlhcc/cuda-ubuntu <my CUDA program>` | Ubuntu 16.04.1 LTS w/CUDA Toolkit |
| TensorFlow GPU | 1.4, 1.12, 1.14, 2.0.0, 2.1.0, 2.2.0 | `apptainer exec docker://unlhcc/tensorflow-gpu python /path/to/my_tf_code.py` | Provides Python 3.7 |
| Keras w/Tensorflow GPU backend| 2.0.4, 2.1.5, 2.2.4, 2.3.1 | `apptainer exec docker://unlhcc/keras-tensorflow-gpu python /path/to/my_keras_code.py` | Use `python3` for Python3 code |
| Octave         | 4.2.1     | `apptainer exec docker://unlhcc/octave octave` | |
| Sonnet GPU     | 1.13, 1.27, 1.34, 2.0.0  | `apptainer exec docker://unlhcc/sonnet-gpu python /path/to/my_sonnet_code.py` | Provides Python 3.7 |
| Neurodocker w/ANTs | 2.2.0, 2.3.4 | `apptainer exec docker://unlhcc/neurodocker-ants <ants script>` | Replace `<ants script>` with the desired ANTs program |
| GNU Radio      | 3.7.11, 3.7.13.5  | `apptainer exec docker://unlhcc/gnuradio python /path/to/my_gnuradio_code.py` | Replace `python /path/to/my_gnuradio_code.py` with other GNU Radio commands to run |
| Neurodocker w/AFNI | 17.3.00, 19.2.20, 19.2.21, 20.3.01, 23.2.02 | `apptainer exec docker://unlhcc/neurodocker-afni <AFNI program>` | Replace `<AFNI program>` with the desired AFNI program |
| Neurodocker w/FreeSurfer | 6.0.0 | `apptainer run -B <path to your FS license>:/opt/freesurfer/license.txt docker://unlhcc/neurodocker-freesurfer recon-all` | Substitute `<path to your FS license>` with the full path to your particular FS license file.  Replace `recon-all` with other FreeSurfer commands to run. |
| fMRIprep       | 1.0.7     | `apptainer exec docker://unlhcc/fmriprep fmriprep` | |
| ndmg           | 0.0.50    | `apptainer exec docker://unlhcc/ndmg ndmg_bids` | |
| NIPYPE (Python2)   | 1.0.0   | `apptainer exec docker://unlhcc/nipype-py27 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| NIPYPE (Python3)   | 1.0.0   | `apptainer exec docker://unlhcc/nipype-py36 <NIPYPE program>` | Replace `<NIPYPE program>` with the desired NIPYPE program |
| DPARSF         | 4.3.12    | `apptainer exec docker://unlhcc/dparsf <DPARSF program>` | Replace `<DPARSF program>` with the desired DPARSF program |
| Caffe GPU      | 1.0, 1.0-136-g9b89154  | `apptainer exec docker://unlhcc/caffe-gpu caffe` | Image provides Python 3.7. Matcaffe is included; load `matlab/r2016b` module and add `-B $MATLAB_ROOT:/opt/matlab` to the apptainer options to use. |
| ENet Caffe GPU | 427a014, 22d356c   | `apptainer exec docker://unlhcc/enet-caffe-gpu <ENET program>` | Replace `<ENET program>` with the desired ENET program |
| ROS Kinetic | 1.3.1, 1.3.2   | `apptainer exec docker://unlhcc/ros-kinetic <ROS program>` | Replace `<ROS program>` with the desired ROS program |
| Mitsuba        | 1.5.0     | `apptainer exec docker://unlhcc/mitsuba mitsuba` | |
| FImpute        | 2.2       | `apptainer exec docker://unlhcc/fimpute FImpute <control file>` | Replace `<control file>` with the control file you have prepared |
| Neurodocker w/FSL | 6.0.5.1, 6.0.3, 5.0.11 | `apptainer run docker://unlhcc/neurodocker-fsl <FSL program>` | Replace `<FSL program>` with the desired FSL program |
| gdc-client     | 1.4.0     | `apptainer exec docker://unlhcc/gdc-client gdc-client <sub-command>` | Replace `<sub-command>` with the desired gdc-client sub-command |
| BLUPF90 | 1.0 | `apptainer exec docker://unlhcc/blupf90 <command>` | Replace `<command>` with any command from the suite (`blupf90`, `renumf90`, etc.) |
| RMark | 2.2.5 | `apptainer exec docker://unlhcc/rmark Rscript my_r_script.r` | |
| SURPI | 1.0.18 | `apptainer exec docker://unlhcc/surpi SURPI.sh -f </path/to/config>` | Replace `</path/to/config>` with the full path to your config file |
| PyTorch | 1.0.1, 1.1.0, 1.2.0, 1.5.0 | `apptainer exec docker://unlhcc/pytorch python /path/to/my_torch_code.py` | This image includes both CPU and GPU support, and provides Python 3.7. |
| bioBakery | 1.1, 3.0.0 | `apptainer exec docker://unlhcc/biobakery <bioBakery program>` | Replace `<bioBakery program>` with the desired bioBakery program and its arguments |
| LIONS | 0.2 | `apptainer exec -B <resource directory>:/LIONS-docker/resources/<genomeName> -B <data_directory>:/LIONS-data docker://unlhcc/lions lions.sh <path/to/parameter/ctrl>` | Replace `<path/to/parameter/ctrl>` with the path to your parameter file. |
| lyve-SET | 1.1.4f | `apptainer exec docker://unlhcc/lyve-set <lyve-SET program>` | Replace `<lyve-SET program>` with any command from the lyve-SET suite |
| RASTtk | 1.3.0 | `apptainer exec docker://unlhcc/rasttk <rasttk program>` | Replace `<rasttk program>` with any command from the RASTtk suite. |
| CellRanger | 3.0.2, 3.1.0, 4.0.0, 6.1.2, 7.0.1, 9.0.0 | `apptainer exec docker://unlhcc/cellranger cellranger <cellranger program>` | Replace `<cellranger program>` with any command from the CellRanger suite. If needed, the reference database files can be found in `/work/HCC/BCRF/app_specific/cellranger/2020-A/`. |
| SkylineRunner | 3.0.19158 | `apptainer run -B $PWD:/data -B /tmp:/mywineprefix docker://unlhcc/skylinerunner mywine SkylineCmd <options>` | Replace `$PWD` with an absolute path if not running from the directory containing data. |
| MXNet GPU (Python only) | 1.5.0, 1.6.0 | `apptainer exec docker://unlhcc/mxnet-gpu python /path/to/my_mxnet_code.py` | Provides Python 3.7. |
| ORFfinder | 0.4.3 | `apptainer exec docker://unlhcc/orffinder ORFfinder <options>` | Replace `<options>` with the available options for ORFfinder. |
| ARG_OAP | 2.0 | `apptainer exec docker://unlhcc/arg_oap <arg_oap program>` | Replace `<arg_oap program>` with the desired ARG_OAP program and its arguments. |
| CRISPRCasFinder | 4.2.20, 4.2.19 | `apptainer exec docker://unlhcc/crisprcasfinder CRISPRCasFinder.pl -in </path/to/input/fasta> <options> -soFile /opt/CRISPRCasFinder/sel392v2.so` | Replace `<path/to/input/fasta>` with the path to your input fasta file, and replace `<options>` with the available options for CRISPRCasFinder. |
| WINE | 5.0 | `apptainer exec -B /tmp:/mywineprefix docker://unlhcc/wine-ubuntu mywine <windows program>` | Replace `<windows program>` with the full path to the Windows binary. |
| Slicer | 4.10.2 | `apptainer exec docker://unlhcc/slicer Slicer <options>` | Slicer comes with multiple CLI modules that are located in `/home/slicer/lib/Slicer-4.10/cli-modules/` within the image. For example, to use Slicer with the module BRAINSFit, one can run Slicer as `apptainer exec docker://unlhcc/slicer Slicer --launch /home/slicer/lib/Slicer-4.10/cli-modules/BRAINSFit <options>` where `<options>` are the available options for BRAINSFit. |
| Inverted Repeats Finder (IRF) | 3.07 | `apptainer exec docker://unlhcc/irf irf307.linux.exe` | |
| COMSOL | 5.5, 5.6 | `apptainer run -B $COMSOL_ROOT:/opt/comsol docker://unlhcc/comsol comsol batch <comsol args>` | This image does NOT include COMSOL itself. It is a thin wrapper to allow newer (>=5.5) versions of COMSOL to run in batch mode on Crane. You must also load the respective `comsol` module. On Rhino, using this image is not necessary - load and run comsol directly. |
| r-inla | 20.03.17 | `apptainer exec docker://unlhcc/r-inla Rscript /path/to/my/script.R` | Provides R 3.6 with the INLA package and tidyverse suite. |
| Blender | 2.83.1 | `apptainer exec docker://unlhcc/blender blender <options>` | Replace `<options>` with any of the Blender CLI arguments. |
| ASAP         | 1.9 | `apptainer exec docker://unlhcc/asap ASAP` | |
| freesurfer | 5.3, 6.0 | `apptainer run -B $MATLAB_ROOT:/opt/matlab docker://unlhcc/freesurfer recon-all <options>` | Provides FreeSurfer 5.3, 6.0. Load a matlab module additionally to make it available in the container. |
| PATRIC | 1.035 | `apptainer exec docker://unlhcc/patric <p3-command>` | Provides the [PATRIC command line interface](https://docs.patricbrc.org/cli_tutorial/index.html). Replace `<p3-command>` with the specific PATRIC command to run. |
| AlphaFold | 2.0.0, 2.2.0, 2.3.2 | `apptainer run -B /work/HCC/BCRF/app_specific/alphafold/2.3.2/:/data -B .:/etc --pwd /app/alphafold docker://unlhcc/alphafold <options>` | Replace `<options>` with any of the AlphaFold CLI arguments. |
| AlphaFold 3 | 3.0.1 | `module load alphafold3; apptainer exec docker://unlhcc/alphafold3 run_alphafold.sh --model_dir=$AF3_MODELS --db_dir=$AF3_DBS <options>` | Replace `<options>` with any of the AlphaFold 3 arguments. |
| S3V2_IDEAS_ESMP | d05d3e0 | `apptainer exec docker://unlhcc/s3v2_ideas_esmp S3V2_IDEAS_pipeline.py <options>` | Replace `<options>` with any of the S3V2_IDEAS_ESMP arguments. |
| APSIM Classic | 7.9 | `apptainer exec docker://unlhcc/apsim-classic Apsim.exe <input>` | Replace `<input>` with the APSim input filename. |
| Gate | 9.2 | `apptainer exec -B ${PWD}:/APP docker://unlhcc/gate /runGate.sh <arguments>` | Replace `<arguments>` with Gate program input arguments. |
| HippUnfold | 1.2.0 | `apptainer exec docker://unlhcc/hippunfold hippunfold <options>` | Replace `<options>` with any of the HippUnfold arguments. |
| mfold | 3.6 | `apptainer exec docker://unlhcc/mfold mfold <options>` | Replace `<options>` with any of the mfold arguments. |
| CellRanger ARC | 2.0.2 | `apptainer exec docker://unlhcc/cellranger-arc cellranger-arc <cellranger-arc program>` | Replace `<cellranger-arc program>` with any command from the CellRanger ARC suite. If needed, the reference database files can be found in `/work/HCC/BCRF/app_specific/cellranger-arc/2020-A-2.0.0/`. |
| LROSE | 20230814 | `apptainer exec docker://unlhcc/lrose <lrose program>` | Replace `<lrose program>` with any command from the LROSE suite. |
| MCell_CellBlender | 4.0.6 | `apptainer exec docker://unlhcc/mcell_cellblender <MCell_CellBlender program>` | Replace `<MCell_CellBlender program>` with any of the MCell_CellBlender arguments (mcell, my_blender). |
| RELION | 4.0.0, 4.0.1 | `apptainer exec docker://unlhcc/relion <relion program>` | Replace `<relion program>` with the desired RELION program and its arguments. |
| RELION GPU | 4.0.0, 4.0.1 | `apptainer exec docker://unlhcc/relion-gpu <relion program>` | Replace `<relion program>` with the desired RELION program and its arguments. |
| Fair ESM (Python only) | 2.0.0 | `apptainer exec docker://unlhcc/fair-esm python /path/to/fair_esm_code.py` | Provides Python 3.7. Provided Python scripts can be accessed in $ESM_SCRIPTS/scripts (e.g., `apptainer exec docker://unlhcc/fair-esm python $ESM_SCRIPTS/scripts/esmfold_inference.py`). |
| bcl-convert | 4.2.4, 4.2.7 | `apptainer exec -B .:/var docker://unlhcc/bcl-convert bcl-convert <options>` | Replace `<options>` with any of the bcl-convert arguments. |
| virMAP | 037156e | `export VIRMAP_DB=/work/HCC/BCRF/app_specific/virmap/037156e/db; apptainer exec -B $WORK:/scratch/tmp/ docker://unlhcc//virmap Virmap.pl --taxaJson ${VIRMAP_DB}/Taxonomy.virmap --virDmnd ${VIRMAP_DB}/virDmnd.dmnd --virBbmap ${VIRMAP_DB}/virBbmap --gbBlastn ${VIRMAP_DB}/gbBlastn --gbBlastx ${VIRMAP_DB}/gbBlastx.dmnd <options>` | Replace `<options>` with any of the virmap arguments. |
| ATACgraph | 63526bc | `apptainer exec docker://unlhcc/atacgraph ATACgraph <options>` | Replace `<options>` with any of the ATACgraph arguments. |
| phyluce | 1.7.3 | `apptainer exec docker://unlhcc/phyluce <command> <option>` | Replace `<command>` with any of the phyluce commands and replace <option> with any of the phyluce arguments. |
| RoseTTAFold2 | 0.2 | `module load rosettafold2na; apptainer exec docker://unlhcc/rosettafold2na run_RF2NA.sh <options>` | Replace `<options>` with any of the RoseTTAFold2 arguments. |
| RFdiffusion | 1.1.0 | `apptainer exec -B /work/HCC/BCRF/app_specific/rfdiffusion/1.1.0/models/:/opt/RFdiffusion/models/ -B $PWD/:/opt/RFdiffusion/schedules/ docker://unlhcc/rfdiffusion run_inference.py <options>` | Replace `<options>` with any of the RFdiffusion arguments. |
| SuperConga | 1.1.0 | `apptainer exec -B /tmp:/app/superconga/tmp docker://unlhcc/superconga python /app/superconga/superconga.py <options>` | Replace `<options>` with any of the SuperConga arguments. |
| Xenium Ranger | 3.0.1 | `apptainer exec docker://unlhcc/xeniumranger xeniumranger <options>` | Replace `<options>` with any of the Xenium Ranger arguments. |
| LigandMPNN | 2024.05.07 | `apptainer exec docker://unlhcc/ligandmpnn python3 /opt/LigandMPNN/run.py <options>` | LigandMPNN requires for the model parameters directory to be in the current directory. To download the directory beforehand, run `apptainer exec docker://unlhcc/ligandmpnn bash /opt/LigandMPNN/get_model_params.sh "./model_params"`. Next, run the `run.py` command and replace `<options>` with any of the LigandMPNN arguments. |
| RFDiffusion AA | 2024.03.13 | `apptainer exec docker://unlhcc/rf_diffusion_all_atom python /opt/rf_diffusion_all_atom/run_inference.py inference.ckpt_path=${RFDiffusionAA_WEIGHTS} <options>` | Replace `<options>` with any of the RFDiffusion AA arguments. |
| BirdNET-Analyzer | 1.5.1 | `apptainer exec docker://unlhcc/birdnet-analyzer python3 -m birdnet_analyzer.analyze <options>` | Replace `<options>` with any of the BirdNET-Analyzer arguments. |
| Qbics | 0.3 | `apptainer exec docker://unlhcc/qbics qbics-linux-cpu <options>` | Replace `<options>` with any of the Qbics arguments. |
