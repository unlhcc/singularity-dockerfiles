# Module
if [ "$EUID" != "0" ]; then
    . /util/opt/lmod/lmod/init/profile

    for g in $(/usr/bin/groups) ; do
        GROUPMODPATH="/home/$g/shared/modulefiles"
        if [ -d "$GROUPMODPATH" ] ; then
            export MODULEPATH=$(/util/opt/lmod/lmod/libexec/addto --append MODULEPATH "$GROUPMODPATH")
        fi
    done

    export MODULEPATH=$(/util/opt/lmod/lmod/libexec/addto --append MODULEPATH /util/opt/hcc-modules/Common)
    export LMOD_AVAIL_STYLE="system:<en_grouped>"
    export LMOD_MODULERCFILE=/util/opt/modulefiles/modulerc:/util/opt/hcc-modules/modulerc

    if [ -z "$__Init_Default_Modules" ]; then
       export __Init_Default_Modules=1;

       ## ability to predefine elsewhere the default list
       LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"swan"}
       export LMOD_SYSTEM_DEFAULT_MODULES
       module --initial_load --no_redirect restore
    else
       module refresh
    fi

    # Add path for random HCC-ey things
    export PATH=$PATH:/util/opt/bin
fi
