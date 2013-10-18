minecraftServer
===============

Minecraft server startup and management scripts

PURPOSE: Be able to manage a minecraft / modded minecraft server by adding and removing
  players based on the commands given, and to be able to manage the server from starting
  and stopping, to saving and giving the "top" command.
  
USAGE: minecraftServer.sh [command]

Commands: 
Start
Stop
Update
Save
Add [username] [group]
Remove [username]
Top

Takes in command line arguments: start|stop|update|save|add|remove|top

For arguments: add|remove there adds the second argument: player username
  This will allow you to add or remove a player from the server whitelist, 
  and the permissions config files and the groups heirarchy

///////////////////////////////////////////////////////////////////////////////////

Functions: 
  isRunning(): this should test for if the server is actually running (the java executable)
   and it should test to see if users are connected. If the server is running, and users
   are connected, then before it executes a shutdown / restart, it should alert users
   through the in-game console that the server is going down for shutdown/restart.
   
  Start(): Plainly, it starts the server in a "screen" session so as to be able
   to disconnect from the SSH session, but keep the server running.
  
  Stop(): Tests if server is running, if running, will output to game console that 
   the server is stopping
  
  Update(): Tests if server is running, but right now it is just a stub, needs implemented
   
  Save(): Tests if running, echos to the server to save-all
  
  AddPlayer(): if running, add user to whitelist, and add username to group specified;
   the groups are specified in your permissions plug-in configuration file
  
  Remove(): if running, remove user from permissions, and then remove from whitelist
  
  SysTop(): if argument is "top", add a new window to the existing screen session, and execute top command
  
  
NOTE: arguments are passed through a translation statement to translate to lowercase, and then at the end
 calls the functions with the second argument. (i.e. $1 = START ... gets converted to : Start Starting )
