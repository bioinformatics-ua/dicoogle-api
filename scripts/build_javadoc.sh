DICOOGLE_VERSIONS="2.0.0 2.1.0 2.2.0 2.3.0 2.3.1 2.4.0 2.5.0 master dev"

usage () { echo "$(basename "$0") [-h] -d dicoogle_version -i dicoogle_directory -o output_directory -- program to generate Dicoogle javadoc

where:
    -h  Show this help text
    -d  Dicoogle version to build; Must be one of the list [$DICOOGLE_VERSIONS]
    -i  Dicoogle root source folder location
    -o  Output folder to store the generated javadoc"; 
}

options=':d:i:o:h:er'
while getopts $options option
do
    case "$option" in
        d  ) VERSION_TO_BUILD=$OPTARG;;
        i  ) DICOOGLE_DIR=$OPTARG;;
        o  ) JAVADOC_DIR=$OPTARG;;
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

if [ "x" == "x$JAVADOC_DIR" ]; then
  echo "-o [output_directory] is required"
  exit 1
fi

echo "Trying to build javadoc for Dicoogle version $VERSION_TO_BUILD"

if [[ ! $DICOOGLE_VERSIONS =~ (^|[[:space:]])"$VERSION_TO_BUILD"($|[[:space:]]) ]] ; then
    echo >&1 "Error: Invalid Dicoogle version. Available versions:\n$DICOOGLE_VERSIONS"; exit 2;
fi

git submodule update --init --recursive
cd $DICOOGLE_DIR
git fetch && git fetch --tags
git checkout $VERSION_TO_BUILD  -B v$VERSION_TO_BUILD
SOURCE_LIST=`find $DICOOGLE_DIR -type f -name "*.java"`
javadoc -Xdoclint:none -Xdoclint:-missing -notimestamp -quiet -d $JAVADOC_DIR -linksource $SOURCE_LIST

echo "Dicoogle v$VERSION_TO_BUILD available at $JAVADOC_DIR."

