# Ark autobackup
The game already makes backups, but they are often too rare and it's impossible to change it. This simple batch script will automatically create backups for ARK: Survival Evolved servers and ensure that every time server save file is changed a copy is made.
# How does it work
Every minute the program checks if the save file change time is equal to what it was one minute before. If it's not - the save file will be copied and a backup created. It's important to do it this way, as it ensures that the save file will never be accessed both by server and script at the same time, which may result in corruption. Unless the server makes saves more often than once in a minute.
# Setting up
1. Put the .bat file in any folder of choice. Note that additional files will be created during the work of the program.
2. Launch the script and provide the requested information. The program will ask for the name of the map. Make sure you enter the same name that is used in the save file. Then you will have to choose the folder where your save files are stored and the folder where you want to store backups.
3. The information you entered will be automatically stored in a sepparate config file, so you don't have to enter it each time. You may even launch this script in your server's start.bat, as it won't ask for any user input next time. If you ever want to change the configuration - ethier do it manually or delete the file and relaunch the script.
4. Script should start listening to file changes and making backups.
