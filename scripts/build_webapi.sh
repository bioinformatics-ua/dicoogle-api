usage () { echo "$(basename "$0") [-h] -d dicoogle_version -i dicoogle_directory -o output_directory -- program to generate Dicoogle webapi

where:
    -h  Show this help text
    -d  Dicoogle version to build; Must be one of the list [$DICOOGLE_VERSIONS]
    -i  Dicoogle root source folder location
    -s  Directory where the static files are located
    -o  Output folder to store the generated index.html file"; 
}

options=':d:i:o:s:h:er'
while getopts $options option
do
    case "$option" in
        o  ) WEBAPI_DIR=$OPTARG;;
        s  ) STATIC_DIR=$OPTARG;;
        h  ) usage; exit;;
        \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done

if [ "x" == "x$WEBAPI_DIR" ]; then
  echo "-o [output_directory] is required"
  exit 1
fi

if [ "x" == "x$STATIC_DIR" ]; then
  echo "-s [static_directory] is required"
  exit 1
fi

echo "Trying to build webapi for Dicoogle version $VERSION_TO_BUILD"

API_FILE="dicoogle_web_api.yaml"
if [ -f "$API_FILE" ]; then
  echo "Generating documentation files in ${WEBAPI_DIR}..."
  
  mkdir -p $WEBAPI_DIR
  npx api2html -t Googlecode -c $STATIC_DIR/images/webapi/webapi_icon_dark.png -P $STATIC_DIR/styles/webapi.css -o $WEBAPI_DIR/index.html $API_FILE
else
  echo "Error: ${API_FILE} not found. Cannot continue."
  exit 3
fi
