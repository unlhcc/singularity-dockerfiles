#! /bin/bash

# Build apsim on a 16.04 system

echo Building > /tmp/buildStatus

trap "echo Idle > /tmp/buildStatus" EXIT

APSIM=/usr/local/src/apsim/
rm -rf $APSIM
mkdir -p $APSIM/
cd $APSIM/..

if [ -z $1 ] ; then
  git clone https://github.com/APSIMInitiative/APSIMClassic.git apsim
else
  re='^[0-9a-f]+$'
  if ! [[ $1 =~ $re ]] ; then
     echo "error: Argument should be a commit hash" ; exit 1
  fi
  git clone -n https://github.com/APSIMInitiative/APSIMClassic.git apsim
  cd apsim && git checkout $1 && cd ..
fi
MY_BUILD_NUMBER=$1
MAJOR_VERSION=$2
MINOR_VERSION=$3

patch -d apsim -p1 -i /usr/local/src/apsim.patch
cd $APSIM/Model/Build
echo CsiroDMZ\! > /etc/CottonPassword.txt
sh ./BuildAll.sh

#chmod +x $APSIM/Model/Build/VersionInfo.sh
#. $APSIM/Model/Build/VersionInfo.sh

BUILD_NUMBER=$MY_BUILD_NUMBER

# The build number above is the HEAD version, not the BASE.

dest=/usr/local/lib/Apsim$MAJOR_VERSION.$MINOR_VERSION-r$BUILD_NUMBER
mkdir $dest
cp    $APSIM/Apsim.xml   $dest/Apsim.xml
mkdir $dest/Model
cp    $APSIM/Model/*.xml $dest/Model
cp    $APSIM/Model/*.so  $dest/Model

cd $dest/Model
for so in ApsimShared General Protocol ComponentInterface ComponentInterface2 FortranComponentInterface FortranComponentInterface2; do
  rm lib$so.so
  ln -s $so.so lib$so.so
done
cp    $APSIM/Model/*.dll $dest/Model
if [ -f $dest/Model/APSIM.Tests.dll ]; then /bin/rm -f $dest/Model/APSIM.Tests.dll; fi
cp    $APSIM/Model/*.exe $dest/Model
mkdir $dest/Model/TclLink
cp    $APSIM/Model/TclLink/CIDataTypes.tcl $dest/Model/TclLink
mkdir $dest/UserInterface
cp    $APSIM/UserInterface/*.xml $dest/UserInterface
mkdir $dest/UserInterface/ToolBoxes
cp    $APSIM/UserInterface/ToolBoxes/*.xml $dest/UserInterface/ToolBoxes

for i in ApsimUI.exe ApsimToSim.exe ConToSim.exe BundleApsim.exe cscs.exe Apsim.exe JobScheduler.exe; do 
cat > /usr/local/bin/$i << EOF 
#!/bin/sh
mono $dest/Model/$i "\$@"
EOF
chmod +x /usr/local/bin/$i
done
for i in ApsimModel.exe; do
cat > /usr/local/bin/$i << EOF2 
#!/bin/sh
export LD_LIBRARY_PATH=$dest/Model:$LD_LIBRARY_PATH
$dest/Model/$i "\$@"
EOF2
chmod +x /usr/local/bin/$i
done

cd /

#rm -rf $APSIM
#rm -rf $dest
rm -f /etc/CottonPassword.txt

