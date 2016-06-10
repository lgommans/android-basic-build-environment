#!/usr/bin/env bash

# Build and install

if [ $# -ne 1 ]; then
	echo 'The only argument you had to supply was *what* to build.';
	sleep 1;
	echo 'I can see this was too difficult.';
	sleep 2;
	echo 'Human intellect is not what it once was.';
	sleep 2;
	echo 'Marvin is a sad Android.';
	exit 2;
fi;

appid=$(php -r "if (substr('$1',-1)=='/')echo substr('$1',0,-1);else echo '$1';");

if [ ! -d $appid ]; then
	echo "Target $appid not found.";
	exit 3;
fi;

cd $appid

JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 ant release
if [ $? -ne 0 ]; then
	echo "Exiting due to build failure";
	exit 1;
fi;

jarsigner -storepass 123123 bin/soundlocator-release-unsigned.apk mykey

# Should zipalign happen here?

echo "Removing app. Cue toilet break."

adb uninstall $appid

adb install bin/soundlocator-release-unsigned.apk

