

if [ $# -eq 0 ]; then
    PROJECT_NAME=djalpine
    echo "No arguments supplied, default project name selected:"
    echo $PROJECT_NAME
else
    PROJECT_NAME=$1
fi


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp -f $DIR/../template/Vagrantfile.template $DIR/../Vagrantfile

sed -i "s,{{PROJECT_NAME}},$PROJECT_NAME,g" $DIR/../Vagrantfile
