# NOEN Reklamebyrå scaffolding

## What is this?
This is a Craft CMS scaffolding project based on the nystudio107´s docker scaffolding. I needed it to work with vm instead of docker, so I have adjusted it to be used with Craft Nitro. Before trying to use this, make sure you install Nitro first. I will keep updating this project based on my own preferences, as well as follow ups on nystudio107´s updates.

## Required Technology Stack
- Craft Nitro
- PHP 7.4


## Build instructions
1. From developer folder, run _"composer create-project bcdo/project project_name"_
2. Add the site to Nitro, with _"nitro add"_. If needed, start a new nitro machine with _"nitro init -m machineName"_ first. If new machine was created all of the following nitro commands has to end with "-m nameOfMachine". For new machines, ssh into machine before installing craft, and run _"sudo apt install composer -y && sudo apt install npm -y"_ then _"sudo apt-get update -y && sudo apt-get install -y"_.
3. Exit the vm and add new db to use for craft _"nitro db add"_.
4. Duplicate the .env.example into .env file, and replace all the REPLACE_ME parts. To get the IP run nitro info.
5. Nitro ssh and Cd into the root folder, and run _"composer install --no-scripts --optimize-autoloader --no-interaction"_, and _"npm install"_. When finished run _"npm run debug"_ in a new terminal - Check if everything compiles properly.
6. Run the _"./craft setup"_, and go through the installation.
7. Exit the vm and cd into the scripts folder. Run _"nitro db import seed_db.sql"_, and choose the same name as when you created the db in step 3. This will seed the db properly.
8. Run "nitro db restart".
9. Nitro ssh into the machine and run _"composer install --no-scripts --optimize-autoloader"_ from root folder. 


Thats it! Further down you will find optional installs as well, but not required.

To log in to craft, use the following admin details:
User: bjornar@noenreklame.no
Password: letmein

The database uses the Nitro default details.

In the future, will have to work on making it even less complicated.

## Optional
### Asset handling
10. Set up aws and cloudfront as explained at https://bit.ly/3g2ZcX8 , and populate the .env file accordingly. Remember the correct region, I use Stockholm which gives me the region of eu-north-1.
11. Set up a image transform service for serverless image handling as explained at https://bit.ly/2ZYx9Cr
12. Populate the .env file.
### Pagetesting
13. The webperf plugin gives you an optional to input a webpagetest api. Head over to webpagetest.org, get the free api key and populate the .env file.
### DB and Asset sync, and other scripts.
14. In the scripts directory, duplicate the example.env.sh file, and rename it to .env.sh.
15. Edit the .env.sh files and replace REPLAC_ME with appropriate information.
16. Create the .env.sh files for each environment, as this is ignored by git.
Visit https://bit.ly/39xx4bW to understand the content of the scripts folder.
## Pre-commit checklist
17. Follow https://bit.ly/2P0Gtzg to set up a custom pre-commit checklist for safe git commit, project based.
