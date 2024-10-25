#!/bin/bash
VERSION=$(cat version.txt)
NUGET=https://www.idesis-gmbh.de:9003/v3/index.json
NUGET_KEY=$1

if [ -z "$NUGET_KEY" ]
  then
    echo -e "\033[1;31m$0 benötigt den Schlüssel für den Zugriff auf $NUGET als ersten Parameter.\033[0m"
	echo -e "\033[1;31mDas Script wird beendet.\033[0m"
	
	exit -1
fi
#
#	NuGet-Paket veröffentlichen 
#
dotnet pack Weasyprint.Wrapped -c Release -o ./distribution/lib
dotnet pack Weasyprint.Wrapped --include-source -c Debug -o ./distribution/lib

dotnet nuget push -s $NUGET -k $NUGET_KEY ./distribution/lib/Weasyprint.Wrapped.$VERSION.nupkg
dotnet nuget push -s $NUGET -k $NUGET_KEY ./distribution/lib/Weasyprint.Wrapped.$VERSION.symbols.nupkg
