# RasJam
Currently in planning phase.
This project has the goal to manage and setup multiple Raspberry Pis using Jamulus from a central server.
This is mainly for large groups wanting to jam together and needing a simple setup.

## Thoughts: 

* One person (admin) sets up a jamulus server to which all clients (Raspis) connect to.
* All Raspberry Pis reverse ssh into the server to allow the admin to update/... the clients
* All Raspberry Pis run a headless (?) build of jamulus client which is somehow locally controlled (webbrowser, MIDI controller,...)
* All Raspberry Pis automatically start jamulus and connect to the server if switched on
* All Raspberry Pis are centrally managed e.g. via ansible
* During setup phase admin executes a script on every pi which sets up jamulus and the ssh tunnel and gets the ssh key of the raspi
 
