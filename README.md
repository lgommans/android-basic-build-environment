# Basic Android build environment

Do you just want to run some Java code on an Android device? Don't want to download a 10GB IDE? You are in the right place.

Prerequisites: adb, about 500MB disk space and (obviously) GNU/Linux.

## TL;DR

1. Download command line tools [here](https://developer.android.com/studio/index.html#linux-tools).

2. Run `tools/android` and select what you need (details in step 5 and 6 below).

3. Perform steps 8 and 9 below.

You can now run the `create.sh` and `run.sh` tools from this repository. If you run them without arguments, they'll tell you what to do.

## Setup

1. Download the SDK from [Get just the command line tools](https://developer.android.com/studio/index.html#linux-tools). You need to accept their license.  
   *It's not FOSS, but the license contains nothing weird. Just silly stuff like no reverse engineering or modifying or copying or blah blah blah.*

2. Extract and run `tools/android` -- which will pop up a GUI.  
   *For those on whom the irony was lost, we just downloaded "just the command line tools", and yet this pops a GUI. Sad trombone dot com.*

3. Give the GUI a minute.  
   *It needs to download about 40KB, but for some reason this takes longer than you'd expect when you hear 40KB.*

4. Use 'Deselect all' near the bottom.  
   *They try to get you to download the latest stable and the latest beta and even complete disk images for various CPU architectures.*

5. Tick 'Android SDK Platform-tools' and 'Android SDK Build-tools'.  
   *Even if your distribution's package repository already had them, the build stuff seems to look only in the folder where you extracted your download, so we need to download it again.*

6. Expand your API target (mine was 4.4) and select at least 'SDK Platform'. I also ticked 'Google APIs' since it was small and I thought I might need it, but honestly I have no idea what it is.

7. Hit 'Install x packages'.  
   *You need to accept a license for each individual file, but by default you get a 'cat'ed version and can accept them all at the same time. I assumed it to be the same nonsense as from step 1 so
   I went ahead and accepted without reading.*

8. Add the `android` tool we just ran to your `$PATH` to make the tools from this repostitory work.  
   *I symlinked `android` in my `~/bin` folder, which is already in `$PATH`, using `ln -s ~/bin/programfiles/android-sdk-linux/tools/android ~/bin/android`*

9. Run `keytool -genkey` and fill in random stuff. Use the password `123123` or the tools will fail.

10. Clone this repository or grab the two `.sh` files manually. They assume `android` and `adb` are in your `$PATH`.

11. Run `./create.sh example` to create a project called 'example'.  

12. Use `vim` (or an inferior editor) to put your desired code in `$output_dir/main.java`.

13. Run `./run.sh $output_dir` to build and install on your default device.

Congratulations, you can now successfully run code on your own device! That only took half a gigabyte, four non-permissive licenses, and all the sweat and tears that went into finding the answers
necessary to create these shell scripts and instructions.
