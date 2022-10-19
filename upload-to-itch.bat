:: Notes
:: :: is used for comments in batch files.
:: # is used for comments in PowerShell.

:: What is
:: Batch (.bat) files: https://en.wikipedia.org/wiki/Batch_file
:: PowerShell: https://learn.microsoft.com/en-us/powershell
:: Butler: https://itch.io/docs/butler

:: Hide commands, you can remove this command to see the batch commands. (@ is used to hide a single command)
@echo off

:: Echo is used to print text to screen.
echo Launching.

:: Run the PowerShell code below (using PowerShell because it is easier to work with and more powerfull)
powershell.exe $name = '%~n0'; Invoke-Expression ((Get-Content '%0' -Raw) -Split '# PowerShell Code' ^| Select -Last 1)

:: If script was not run with argument /passive, pause to show output to user
if not "%1"=="/passive" pause >nul

:: Exit so it does not try to run powershell code
exit /b

# PowerShell Code # - The text below is PowerShell code, do not remove this line.

# Split the file name by _
$tokens = $name -Split '_'

# If file name is not split in 4, show guide
if ($tokens.Count -ne 4)
{
	echo ""
	echo "Please rename the script file to: upload-to-itch_MYUSER_MYPROJECT_MYBUILD"
	echo ""
	echo "Replace MYUSER, MYPROJECT & MYBUILD with your information."
	echo ""
	echo "You can get USER & PROJECT from your itch url. It looks like this: https://USER.itch.io/PROJECT"
	echo ""
	echo "MYBUILD is the folder/file/platform of your project. Platforms: windows, mac, linux or android.apk "
	echo "Example: You have a folder named windows where your windows build is, then your MYBUILD is windows, place this script beside it."
	echo "Read more: https://itch.io/docs/butler/pushing.html#channel-names"
	echo ""
	echo "Final name looks something like this: upload-to-itch_nordicsoftworks_cardbattlesimulator_windows"
	echo ""
	echo "When you run the script Itch will then popup and ask you to login."

	exit
}

# Get the information from name and display it
$user = $tokens[1]
$project = $tokens[2]
$build = $tokens[3]
echo ""
echo "User    = $user"
echo "Project = $project"
echo "Build   = $build"
echo "URL     = https://$user.itch.io/$project"
echo ""

$butlerInstallLocation = "$env:temp\itchiobutler"
$butler = "$butlerInstallLocation\butler.exe"

# If butler does not exist, download it
if (-not (Test-Path $butler))
{
	echo "Downloading itch.io butler utility."
	
	# Download zip with butler
	wget https://broth.itch.ovh/butler/windows-amd64/LATEST/archive/default -OutFile $env:temp\butler.zip
	
	# Expand zip
	Expand-Archive $env:temp\butler.zip -DestinationPath $butlerInstallLocation
	
	# Delete zip
	Remove-Item $env:temp\butler.zip
}

# Make sure butler is updated
&$butler upgrade

# Upload to itch.io
&$butler push $build "$user/$project`:$build" --if-changed --ignore *DoNotShip* --ignore *DontShip*

echo "Upload complete. You can follow the status on your itch.io edit page."