This project has the goal to manage and setup multiple Raspberry Pis using Jamulus from a central server.
This is mainly for large groups wanting to jam together and needing a simple setup.

Thoughts: 

One person (leader) sets up a jamulus server to which all clients (Raspis) connect to.
All Raspberry Pis reverse ssh into the server to allow the admin to update/... the clients
All Raspberry Pis run a headless (?) build of jamulus client which is somehow locally controlled (webbrowser, MIDI controller,...)
All Raspberry Pis automatically setup and start jamulus if they are switched on
All Raspberry Pis are centralli managed e.g. via ansible

 
