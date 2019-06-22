#!/bin/bash
# Initialize (Only tested for Mac 06/22/2019 Kathy Lu, shaoying.lu@gmail.com)
FLUOCELL_PATH=/Applications/Fluocell/fluocell
MATLAB_PATH=/Applications/MATLAB_R2017a.app
echo "Running install.sh"
echo "FLUOCELL_PATH="$FLUOCELL_PATH
echo "MATLAB_PATH="$MATLAB_PATH "..."

# 1. Make a shortcut for fluocellJava.jar on the desktop
EXECUTABLE_PATH=$FLUOCELL_PATH/src/gui/java
EXECUTABLE_FILE=$EXECUTABLE_PATH/fluocellJava.jar
echo "1. Making a shortcut for fluocellJava.jar on Desktop for "
echo $EXECUTABLE_FILE "..."
if [ ! -f $HOME/Desktop/'fluocell2 alias' ] ; then
    ln -s $EXECUTABLE_FILE $HOME/Desktop/'fluocell2 alias'
else
    echo "Shortcut file already exists. "
fi 

# 2. Link fluocell to MATLAB (inform the location of MATLAB)
# cp $EXECUTABLE_PATH/mac-default.property $EXECUTABLE_PATH/default.property
MATLAB_EXECUTABLE=$MATLAB_PATH/bin/matlab
echo "2. Inform fluocell the location of MATLAB at"
echo $MATLAB_EXECUTABLE "..."
sed "s|/Applications/MATLAB_R2016a.app/bin/matlab|$MATLAB_EXECUTABLE|" \
$EXECUTABLE_PATH/mac-default.property > $EXECUTABLE_PATH/default.property 

# 3. Link MATLAB to fluocell (add fluocell source path to MATLAB)
# pathdef.m 
PATHDEF_FILE=$MATLAB_PATH/toolbox/local/pathdef.m
# cp $PATHDEF_FILE $PATHDEF_FILE.copy
echo "3. Link MATLAB to fluocell (add fluocell paths to MATLAB pathdef.m). "
echo $PATHDEF_FILE "."
# \\ escape \, \  to escape space
declare -a arr=("src/api" "src/detect" "src/post" "src/pre" "src/track" "src/utility"\
"src/vis" "app" "contrib/simpletracker" "app/polarity" "app/fa_analysis" "app/quantify")
for i in "${arr[@]}"
do
    sed "/BEGIN ENTRIES/a\\ 
    \ \ \ \ \ '$FLUOCELL_PATH/$i:', ...\\
    " $PATHDEF_FILE > $MATLAB_PATH/toolbox/local/pathdef2.m 
    cp $MATLAB_PATH/toolbox/local/pathdef2.m $PATHDEF_FILE
done




