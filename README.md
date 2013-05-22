## An Experiment With an Experiment with chef-solo

These are a few additions and subtractions I made to this project, namely: fixing the bug in the pip resource where it tried to use the deprecated --environment option with the venv directive, removing some non-dev-environment critical packages like memcached (this was more just to reduce my mental workload in figuring out how chef works, rather than any difficulty presented by those cookbooks themselves), parameterizing the user name stuff a little bit more than it was in the original repo, although it still requires changing in a few places, and adding a few recipes and cookbooks here and there to support a simple Flask/MongoDB/uWSGI app. You'll want to change "app_name" to the name of your app wherever it appears, as well as "user_name" variables and there might  be a few instances of "insertyourusernamehere" that I missed. Also added a git deploy operation to the Fabfile.

## An Experiment With Chef Solo

This is my first chef-solo cookbook that I put together from existing cookbooks and by writing some of my own recipes.  It's rough around the edges but it gets the job done.

## What it cooks

It takes a fresh Ubuntu 10.10 install to a fully configured Flask app server :  

* rather minimal IPTABLES script to block all traffic other than port 80, but all you to connect via ssh (see below)
* git
* mongodb+mongoengine
* nginx
* Python2.7
* pip
* virtualenv
* flask

The Fabfile also creates and sets up the project dir/virtual env in /var/www and clones the git repo from your local machine.

## Usage

You don't want to run this cookbook blind, it's more for learning purposes because I couldn't find a lot of stuff out there when I putting this together.

**important** - you definitely want to edit the iptables.erb template and change OFFICE=XXX.XXX.XXX.XXX to your IP or you may find yourself locked out of your server.

If you have [Fabric][1] then you need only ssh into the box and place an ssh key for root user. Them simply run the fabric command

`fab install_environment`

Then:
`fab push_project`

If you don't have Fabric then you'll have a little bit more work to do but I'm sure you can figure that out from the commands inside the fabfile.py

There are some hardcoded paths and usernames inside this cookbook (I know, I know), but using your favourite text editor just do a search for insertyourusernamehere and replace it with your desired username.



[1]: http://fabfile.org


