# NOEN Reklamebyrå scaffolding

## Required Technology Stack
- Craft Nitro



## Build instructions
1. From developer folder, run the "composer create-project bcdo/project project_name"
2. Add the site to Nitro, with "nitro add". If needed, start a new nitro machine with "nitro init -m machinename". For new machines, ssh into machine before installing craft, and run "sudo apt install composer -y" and "sudo apt install npm -y".
3. Add new db to use for craft "nitro db add", remember -m flag if needed.
4. Dublicate the .env.example into .env file, and replace all the REPLACE_ME parts. To get the IP run nitro info (with -m flag if needed).
3. Nitro ssh and Cd into the root folder, and run "composer install --no-scripts --optimize-autoloader --no-interaction", and "npm install". When finished run "npm run debug" in a new terminal - Check if everything compiles properly.
6. run the "./craft setup", and go through the installation.
7. Run composer update.
