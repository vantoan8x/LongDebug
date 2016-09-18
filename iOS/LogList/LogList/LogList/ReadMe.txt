Open Project Setting

-> Drag this Folder "LogList" into project


-> Build Phase, Add preBuild Phase to run script.

${PROJECT_DIR}/LogList/LogList/getIP.sh

or using find

export Path="$(find -L . | grep getIP.sh)"
sh ${Path}
