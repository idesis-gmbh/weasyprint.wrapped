workingDir="./standalone-osx-aarch64";
assets="./assets";
version=weasyprint==62.3

if [ -d "$workingDir" ]; then
  echo "*** Cleaning $workingDir"
  rm -rf $workingDir
fi

echo "*** Creating $workingDir"
mkdir $workingDir

if [ -d "$assets" ]; then
  echo "*** $assets" exists
else
  echo "*** Creating $assets"
  mkdir $assets
fi

echo "*** Downloading python (https://github.com/indygreg/python-build-standalone)"
wget -O $workingDir/python.tar.gz 'https://github.com/indygreg/python-build-standalone/releases/download/20241016/cpython-3.10.15+20241016-aarch64-apple-darwin-install_only.tar.gz'
tar -xvzf $workingDir/python.tar.gz -C $workingDir
rm $workingDir/python.tar.gz

cd $workingDir/python/bin/
./python3.10 -m pip install $version 2> /dev/null
./python3.10 -m weasyprint --info

echo "*** Version=$version"
cd ../../
touch "version-$version"
echo "cd python/bin/
./python3.10 -m weasyprint - - --encoding utf8" >> print.sh

echo "*** Create archive $assets/standalone-osx-aarch64.zip"
zip -r "../$assets/standalone-osx-aarch64.zip" .
