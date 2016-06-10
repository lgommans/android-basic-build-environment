#!/usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Usage: ./create.sh projectname";
	exit 1;
fi;

echo "Cue magic."

# Target API thingy (from `android list targets`)
target=1 # hardcoded because you only installed the sdk you want, right? We were going for a minimal install after all.
echo "Using target $target"

android -v create project -n $1 -t $target -p $1.$(whoami) -k $1.$(whoami) -a ${1}activity
echo "Created project"

echo "Symlinking main file"
ln -s $(pwd)/$1.$(whoami)/src/$1/$(whoami)/${1}activity.java $1.$(whoami)/main.java

# Remove unnecessary default icons (if you're going to use the default anyway, might as well leave them out)
echo "Removing unnecessary default icons"
sed -i 's/ android:icon="@drawable\/ic_launcher"//' $1.$(whoami)/AndroidManifest.xml
rm -r $1.$(whoami)/res/drawable*

echo "Adding an id for the default textview so we can actually use it"
sed -i '/android:text/ aandroid:id="@+id/output"' $1.$(whoami)/res/layout/main.xml

echo "And calling the id from java as a demo"
sed -i '/import / a\
import android.widget.TextView;' $1.$(whoami)/src/$1/$(whoami)/${1}activity.java
sed -i '/setContentView/ a\
TextView out = (TextView) findViewById(R.id.output);\
out.setText("Initialized.");' $1.$(whoami)/src/$1/$(whoami)/${1}activity.java

target=$(android list targets | grep -A3 "id: $target or" | grep -v Platform | tr -d \\n)
echo Project
echo ... target: $target
echo ... name: $1
echo ... fullID: $1.$(whoami)
echo ... main activity: ${1}activity
echo ... main file: $1.$(whoami)/main.java

