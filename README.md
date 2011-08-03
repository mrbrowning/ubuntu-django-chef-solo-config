## An Experiment With Chef Solo

This is my first chef-solo cookbook that I put together from existing cookbooks and by writing some of my own recipes.  It's rough around the edges but it gets the job done.

## What it cooks

It takes a fresh Ubuntu 10.10 install to a fully configured django app server :  

* rather minimal IPTABLES script to block all traffic other than port 80, but all you to connect via ssh (see below)
* git
* postgres+postgis+psycopg2
* nginx
* supervisord
* Python2.6
* pip
* virtualenv & virtualenvwrapper 
* memcached
* PIL

Note that Django is not installed, because that gets installed into each project's virtual environment along with all it's other requirements

## Usage

You don't want to run this cookbook blind, it's more for learning purposes because I couldn't find a lot of stuff out there when I putting this together.

**important** - you definitely want to edit the iptables.erb template and change OFFICE=XXX.XXX.XXX.XXX to your IP or you may find yourself locked out of your server.

If you have [Fabric][1] then you need only ssh into the box and place an ssh key for root user. Them simply run the fabric command

`fab install_environment`

If you don't have Fabric then you'll have a little bit more work to do but I'm sure you can figure that out from the commands inside the fabfile.py

There are some hardcoded paths and usernames inside this cookbook (I know, I know), but using your favourite text editor just do a search for insertyourusernamehere and replace it with your desired username.



[1]: http://fabfile.org


