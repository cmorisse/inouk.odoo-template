apt-get update && apt-get install vim htop -y

# build odoo-base
docker build -t inouk/odoo-base .

docker build -t appxy -f Dockerfile.dev .

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


