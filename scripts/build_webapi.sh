DICOOGLE_VERSIONS="master dev"

usage () { echo "$(basename "$0") [-h] -d dicoogle_version -i dicoogle_directory -o output_directory -- program to generate Dicoogle webapi

where:
    -h  Show this help text
    -d  Dicoogle version to build; Must be one of the list [$DICOOGLE_VERSIONS]
    -i  Dicoogle root source folder location
    -o  Output folder to store the generated index.html file"; 
}

options=':d:i:o:h:er'
while getopts $options option
do
    case "$option" in
        d  ) VERSION_TO_BUILD=$OPTARG;;
        i  ) DICOOGLE_DIR=$OPTARG;;
        o  ) WEBAPI_DIR=$OPTARG;;
        h  ) usage; exit;;
        \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done

if [ "x" == "x$VERSION_TO_BUILD" ]; then
  echo "-d [dicoogle_version] is required"
  exit 1
fi

if [ "x" == "x$DICOOGLE_DIR" ]; then
  echo "-i [dicoogle_directory] is required"
  exit 1
fi

if [ "x" == "x$WEBAPI_DIR" ]; then
  echo "-o [output_directory] is required"
  exit 1
fi

echo "Trying to build webapi for Dicoogle version $VERSION_TO_BUILD"

if [[ ! $DICOOGLE_VERSIONS =~ (^|[[:space:]])"$VERSION_TO_BUILD"($|[[:space:]]) ]] ; then
    echo >&1 "Error: Invalid Dicoogle version. Available versions:\n$DICOOGLE_VERSIONS"; exit 2;
fi

cd $DICOOGLE_DIR
git fetch && git fetch --tags
git checkout $VERSION_TO_BUILD  -B v$VERSION_TO_BUILD


API_FILE="$DICOOGLE_DIR/dicoogle_web_api.yaml"
if [ -f "$API_FILE" ]; then
  echo "Generating documentation files in ${WEBAPI_DIR}..."
  
  mkdir -p $WEBAPI_DIR
  npx api2html -c $WEBAPI_DIR/../../images/webapi/webapi_icon_dark.png -P $WEBAPI_DIR/../../styles/webapi.css -o $WEBAPI_DIR/index.html $DICOOGLE_DIR/dicoogle_web_api.yaml
else
  echo "Error: ${API_FILE} not found. Cannot continue."
  exit 3
fi
