# RasJam
Currently in planning phase.
This project has the goal to manage and setup multiple Raspberry Pis using Jamulus from a central server.
This is mainly for large groups wanting to jam together and needing a simple setup.
# What should be done? (Suggested workflow)
1. Setup Jamulus and admin server
2. Compile Jamulus with a script
3. Move the copyToStick folder to a stick
4. Burn multiple raspbian light SDs
5. Connect the stick to all the raspis
6. Run a script from the stick
7. After all the raspis, upload SSH keys to the server

## Thoughts:

* One person (admin) sets up a jamulus server to which all clients (Raspis) connect to.
* All Raspberry Pis reverse ssh into the server to allow the admin to update/... the clients
* All Raspberry Pis run a headless (?) build of jamulus client which is somehow locally controlled (webbrowser, MIDI controller,...)
* All Raspberry Pis automatically start jamulus and connect to the server if switched on
* All Raspberry Pis are centrally managed e.g. via ansible
* During setup phase admin executes a script on every pi which sets up jamulus and the ssh tunnel and gets the ssh key of the raspi
* Passwords are saved in plain text on the USB Stick. What about security?
* Integrate an update API (authinticated. Maybe via PHP?)
* What should we do with the ssh key signature of the api server (see sshAccess/startReverseSSHTunnel.sh)? Can we just trust anything???
* On SSH-Key update on server we must send a update message to all the clients
