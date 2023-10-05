##############################################################################
# Module
source /util/opt/lmod/lmod/init/cshrc
set GROUPMODPATH=`echo ${HOME} | sed -e 's/\/'${USER}'$/\/shared\/modulefiles/g'`
if ( -d $GROUPMODPATH ) then
        set mp=`/util/opt/lmod/lmod/libexec/addto  --append MODULEPATH $GROUPMODPATH`
        setenv MODULEPATH $mp
endif
set mp=`/util/opt/lmod/lmod/libexec/addto  --append MODULEPATH /util/opt/hcc-modules/Common`
setenv MODULEPATH $mp
setenv LMOD_AVAIL_STYLE "system:<en_grouped>"
setenv LMOD_MODULERCFILE /util/opt/modulefiles/modulerc:/util/opt/hcc-modules/modulerc
if ( ! $?__Init_Default_Modules )  then
  setenv __Init_Default_Modules 1
  if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
    setenv LMOD_SYSTEM_DEFAULT_MODULES "swan"
  endif
  module --initial_load restore
else
  module refresh
endif

# Add path for random HCC-ey things
setenv PATH $PATH":/util/opt/bin"
