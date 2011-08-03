## An Experiment With Chef Solo

This is my first chef-solo cookbook that I put together from existing cookbooks and by writing some of my own recipes.  It's rough around the edges but it gets the job done.

## What it cooks

It takes a fresh Ubuntu 10.10 install to a fully configured django app server :  

* git
* postgres+postgis+psycopg2
* nginx
* supervisord
* Python2.6
* pip
* virtualenv & virtualenvwrapper 
* memcached
* PIL

Note that Django is not installed, because that get's installed into each project's virtual environment along with all it's other requirements

## Usage

If you have [Fabric][1] then you need only ssh into the box and place an ssh key for root user. Them simply run the fabric command

`fab install_environment`

If you don't have Fabric then you'll have a little bit more work to do but I'm sure you can figure that out from the commands inside the fabfile.py

[1]: http://fabfile.org
