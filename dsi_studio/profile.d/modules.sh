##############################################################################
# Module
unset __Init_Default_Modules
if [ "$EUID" != "0" ]; then
    . /usr/local/lmod/lmod/init/profile
    export -f module

    for g in $(/usr/bin/groups) ; do
        GROUPMODPATH="/home/$g/shared/modulefiles"
        if [ -d "$GROUPMODPATH" ] ; then
            export MODULEPATH=$(/usr/local/lmod/lmod/libexec/addto --append MODULEPATH "$GROUPMODPATH")
        fi
    done

    export MODULEPATH=$(/usr/local/lmod/lmod/libexec/addto --append MODULEPATH /util/opt/hcc-modules/Common)
    export LMOD_AVAIL_STYLE="system:<en_grouped>"
    export LMOD_MODULERCFILE=/util/opt/modulefiles/modulerc:/util/opt/hcc-modules/modulerc

    if [ -z "$__Init_Default_Modules" ]; then
       export __Init_Default_Modules=1;

       ## ability to predefine elsewhere the default list
       LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"${SLURM_CLUSTER_NAME}"}
       export LMOD_SYSTEM_DEFAULT_MODULES
       module --initial_load --no_redirect restore
    else
       module refresh
    fi
fi

# Add path for random HCC-ey things
export PATH=$PATH:/util/opt/bin
