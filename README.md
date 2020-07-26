# NOEN Reklamebyrå scaffolding

## Required Technology Stack
- Craft Nitro
- PHP 7.4


## Build instructions
1. From developer folder, run the "composer create-project bcdo/project project_name"
2. Add the site to Nitro, with "nitro add". If needed, start a new nitro machine with "nitro init -m machine name" first. If new machine was created all of the following nitro commands has to end with "-m nameOfMachine". For new machines, ssh into machine before installing craft, and run "sudo apt install composer -y && sudo apt install npm -y" then "sudo apt-get update -y && sudo apt-get install -y".
3. Exit the vm and add new db to use for craft "nitro db add".
4. Dublicate the .env.example into .env file, and replace all the REPLACE_ME parts. To get the IP run nitro info.
5. Nitro ssh and Cd into the root folder, and run "composer install --no-scripts --optimize-autoloader --no-interaction", and "npm install". When finished run "npm run debug" in a new terminal - Check if everything compiles properly.
6. Run the "./craft setup", and go through the installation.
7. Exit the vm and cd into the scripts folder. Run "nitro db import seed_db.sql", and choose the same name as when you created the db in step 3. This will seed the db properly.
8. Run "nitro db restart".
9. Nitro ssh into the machine and run "composer install --no-scripts --optimize-autoloader"

Optional
10. Set up aws and cloudfront as explained at https://bit.ly/3g2ZcX8 , and populate the .env file accordingly. Remember the correct region, I use Stockholm which gives me the region of eu-north-1.
11. Set up a image transform service for serverless image handling as explained at https://bit.ly/2ZYx9Cr
12. Populate the .env file. 

Thats it!

To log in to craft, use the following admin details:
User: bjornar@noenreklame.no
Password: letmein

The database uses the Nitro default details.

In the future, will have to work on making it even less complicated.
