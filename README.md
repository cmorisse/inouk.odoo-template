Introduction
============

Is a template for Odoo 11 docker projects.
As such you must modify it for your projects.
Minimalistic and easy to grap.


Requirements
============

* docker
* inouk.odoo_base image available in you docker images (Cf. https://github.com/cmorisse/inouk.odoo_base )


How to use this repository
==========================

Clone it.
Modify it
Then push it to your own repository.
Example:


    git clone git@github.com:cmorisse/inouk.odoo-template.git  appserver-demo
    cd appserver-demo

    # do your modifications

    git clone rename origin upstream
    git remote add git@github.com:cmorisse/appserverinouk.odoo-template.git
    git push ....
    

Prepare the repository
======================

Clone odoo into odoo_src (note depth=5):

     git clone --depth=5 git@github.com:odoo/odoo odoo_src



How to run your server
======================

2 modes:
* dev (development mode)
* dep (deployment or production)


Development mode
----------------

Dockerfile.dev is used to run in development mode.

Dockerfile.dev is just a shell for the inouk.odoo-base that mounts the current 
directory in /opt/odoo.

By doing this, all files can be modified and changes can be tested just
by relaunching Odoo.



Launching Odoo in Development Mode
==================================


Build the image:

    docker build -t appdemo -f Dockerfile.dev .


Define parameters
=================

Create a file dev_mode.env outside your repository.
This file will contain Odoo sensitive parameters.

    touch ~/appdemo.env.list
    
This file must contain at least:
* ADMIN_PASSWORD
* DB_HOST
* DB_USER
* DB_PASSWORD

To open a shell in container
----------------------------

    # See https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file
    docker run --env-file ~/appdemo.env.list --rm -it -v "$(pwd)":/opt/odoo appdemo /bin/bash

To run Odoo
-----------

    docker run --env-file ~/appdemo.env.list \
                --rm -it \
                -p 8069:8069 \
                -v "$(pwd)":/opt/odoo \
                -v /home/ec2-user/environment/odoo_data_dir:/var/lib/odoo \
                appdemo odoo



TODO
====

Faire un makefile qui recouvre:

* Création de l'image
* execution 
* deboggage

    
    


















==================TO PROCESS===============
===========================================


docker run --rm -it --name devtest --volume "$(pwd)"/odoo_src:/opt/odoo/odoo_src \
                                   --volume "$(pwd)"/project_addons:/opt/odoo/project_addons \
                                   --volume "$(pwd)"/extra_addons:/opt/odoo/extra_addons \
                                   --volume "$(pwd)"/etc:/opt/odoo/etc \
                                   --volume /home/ec2-user/environment/odoo_data_dir:/var/lib/odoo \
                                   -p 8069:8069 \
                                   inouk/appserver-xy

docker run --rm -it -v "$(pwd)":/opt/odoo \
                    -v /home/ec2-user/environment/odoo_data_dir:/var/lib/odoo \
                    -p 8069:8069 -p 15471:15471 \
                    inouk/appserver-xy \
                    odoo
                    
docker run --rm -it -v "$(pwd)":/opt/odoo \
                    -v /home/ec2-user/environment/odoo_data_dir:/var/lib/odoo \
                    -p 8080:8069 -p 15471:15471 \
                    inouk/appserver-xy \
                    python3 -m ikp3db -ik_p=15471 -ik_cwd=/opt/odoo odoo_src/odoo-bin

docker run --rm -it -v "$(pwd)":/opt/odoo appxy /bin/bash





# For ODocker2

Run this in a terminal then Run "ODocker2" runner.

    docker run --rm -it -v $(pwd):/opt/odoo \
                        -v /home/ec2-user/environment/odoo_data_dir:/var/lib/odoo \
                        -p 8080:8069 -p 15471:15471 \
                        appxy \
                        python3 -m ikp3db -ik_a=0.0.0.0 \
                                          -ik_p=15471 \
                                          -ik_l=9 \
                                          -ik_cwd=/opt/odoo/ \
                                          -ik_ccwd=inouk.odoo-template/ \
                                          odoo_src/odoo-bin $args
    # or                                    t.py $args 


