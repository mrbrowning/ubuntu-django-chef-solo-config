from fabric.api import *

env.user = 'root'
env.hosts = ['yourhosthere']
env.cookbooks = '/path/to/ubuntu-django-chef-solo-config/chef/'
env.chef_executable = '/var/lib/gems/1.8/bin/chef-solo -c /var/chef/config/solo.rb -j /var/chef/config/node.json'



def install_environment():
    # install the basic softwares
    sudo('apt-get update', pty=True)
    sudo('apt-get install make psmisc', pty=True)
    sudo('apt-get install rsync', pty=True)
    sudo('apt-get install -y rubygems ruby ruby-dev', pty=True)
    sudo('gem install ruby-shadow')
    sudo('gem install chef', pty=True)
    with settings(hide('warnings', 'stdout', 'stderr'), warn_only=True):
        sudo('mkdir /etc/chef')
    # now update the chef cookbooks and rrun
    _sync_config()
    sudo('cd /etc/chef && %s' % env.chef_executable, pty=True)


def update_environment():
    _sync_config()
    sudo('cd /etc/chef && %s' % env.chef_executable, pty=True)
    

def _sync_config():
    local('rsync --exclude "*.py" --exclude "*.pyc" -av %s %s@%s:/var/chef' % (env.cookbooks, env.user, env.hosts[0]))

    