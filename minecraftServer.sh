#!/bin/sh

#################
# Description: This program is to be used for managing the minecraft server
#       that is maintained through the Bukkit server platform
################

#################
# to do:
#  TEST IT!
################

startPath=/home/todd/minecraft/startBukkitPP.sh
CONNECTED=`lsof -i -P | grep 25565 | grep ESTABLISHED | awk '{print $9}'`
screenName=MinecraftServer
toppingScreen=TopM

## Convert ALL characters input to lower case
a1=`echo $1 | tr '[:upper:]' '[:lower:]'` #command given i.e. start, stop, update, save, add, remove
a2=`echo $2 | tr '[:upper:]' '[:lower:]'` #userName to add/remove
a3=`echo $3 | tr '[:upper:]' '[:lower:]'` #userGroup to add/remove

isRunning () {
        currentStatus=`ps aux | grep -i -m 1 -o java | tr '[:upper:]' '[:lower:]' | sed 's/\ //'`

        if [ currentStatus == "java" ]
        then
                return 1;
        else
                return 0;
        fi
} #isRunning ()


############################
Start() {
if [ isRunning == "0" ] && [ $1 == "Starting" ]
then
        echo Starting the server
        echo This isn\'t going to work very well
        screen -dmS $screenName -p 0 -X $startPath
else
        echo Server is already running
fi
} #Start()


#############################
Stop () {
if [ isRunning == "1" ] #&& [ $1 == "Stopping" ]
then
        if [ $CONNECTED != "" ]
        then
                echo Stopping server now
                screen -S $screenName -p 0 -X eval 'stuff "say Stopping server... Goodbye"\015'
                sleep 30
                echo sent stop command
                screen -S $screenName -p 0 -X eval 'stuff "stop"\015'
                sleep 5
                echo exiting the minecraft screen session
                screen -S $screenName -p 0 -X exit
        else
                echo "There are still people connected, letting them know"
                screen -S $screenName -p 0 -X eval 'stuff "say Stopping Server, please exit the server now"\015'
                screen -S $screenName -p 0 -X eval 'stuff "say Server will shut down in 2 minutes"\015'
                sleep 120
                screen -S $screenName -p 0 -X eval 'stuff "stop"\015'
        fi
else
        echo Server is not currently running
fi
} #Stop()


#############################
Update () {
if [ isRunning == "1" ] && [ $1 == "Updating" ]
then
        echo Stub Updating
else
        echo Stub Updating -- else clause
fi
} #Update ()

#############################
Save () {
if [ isRunning == "1" ] && [ $1 == "Saving"]
then
        #echo Stub Saving
        screen -S $screenName -p 0 -X eval 'stuff "save-all"\015'
else
        echo "Save not executed; Server not running"
fi
} #Save ()

#############################
AddPlayer () {
if [ isRunning == "1" ] && [ $1 == "Adding" ]
then
        echo "Adding $a2 to group : $a3"
        screen -S $screenName -p 0 -X eval 'stuff "whilelist add $a2"\015'
        screen -S $screenName -p 0 -X eval 'stuff "permissions player addgroup $a2 $a3"\015'
else
        echo "Not Adding; Server not running"
fi
} # AddPlayer ()

#############################
RemovePlayer () {
if [ isRunning == "1" ] && [ $1 == "Removing" ]
then
        echo Removing player $a2
        screen -S $screenName -p 0 -X eval 'stuff "permissions player removegroup $a2 $a3"\015'
        sleep 5
        screen -S $screenName -p 0 -X eval 'stuff "whitelist remove $a2"\015'
else
        echo Not Removing\; Server not running
fi
} # RemovePlayer ()

#############################
SysTop () {
if [ $1 == "Topping" ]
then
        echo "Starting a Top -M Session"
        screen -dmS $toppingScreen -X top^M
#       #screen -S $toppingScreen -p 0 -X top
        #screen -r $toppingScreen
else
        echo Can\'t top for some reason
fi
}


## Pass the buck to each function
if [ $a1 == "start" ]
then
        Start Starting
elif [ $a1 == "stop" ]
then
        Stop Stopping
elif [ $a1 == "update" ]
then
        Update Updating
elif [ $a1 == "save" ]
then
        Save Saving
elif [ $a1 == "addplayer" ]
then
        AddPlayer Adding
elif [ $a1 == "add" ]
then
        AddPlayer Adding
elif [ $a1 == "removeplayer" ]
then
        RemovePlayer Removing
elif [ $a1 == "remove" ]
then
        RemovePlayer Removing
elif [ $a1 == "rem" ]
then
        RemovePlayer Removing
elif [ $a1 == "top" ]
then
        SysTop Topping
fi
