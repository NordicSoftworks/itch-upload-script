# Itch upload script
A simple script to upload your itch projects, just save it and double click to use. (Windows only)

# How to
1. Copy the contents of [upload-to-itch.bat](https://github.com/NordicSoftworks/itch-upload-script/raw/main/upload-to-itch.bat)
2. Open notepad and insert the contents.
3. Save it beside your build as `upload-to-itch_MYUSER_MYPROJECT_MYBUILD.bat`
3. You can now upload your project by double clicking the script. (The first time Itch will ask you to login.)

# What is MYUSER, MYPROJECT & MYBUILD?
You can get MYUSER & MYPROJECT from your itch url. https://MYUSER.itch.io/MYPROJECT

MYBUILD is the folder/file/platform of your project. Example: windows, mac, linux or android.apk 

Final name looks something like this: upload-to-itch_nordicsoftworks_cardbattlesimulator_windows.bat

# Notes

The script uses Itch's butler behind the scenes to do the upload. (Butler: https://itch.io/docs/butler)

It is faster than manually uploading zip files, it only uploads the changes.

It only uploads if there were changes and automatically ignores items with DoNotShip and DontShip in the name. You can edit the options in the bottom of the script. (Options: https://itch.io/docs/butler/pushing.html)