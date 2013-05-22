from fabric.api import *

env.user = 'root'
env.hosts = ['192.168.82.131']
env.local = '192.168.82.1'
env.app_name = 'app_name'
env.cookbooks = '/Users/%s/projects/deploy/chef/'
env.chef_executable = '/usr/local/bin/chef-solo -c /var/chef/config/solo.rb -j /var/chef/config/node.json'


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


def push_project():
    sudo('git clone ssh://%s@%s/Users/%s/%s/%s /var/www/%s/%s' % (env.user, env.local, env.user, env.app_name, env.app_name, env.app_name, env.app_name), pty=True)
    sudo('chown -R %s:www-data /var/www/%s' % (env.user, env.app_name))
    sudo('mkdir /var/www/%s/%s/log' % (env.app_name, env.app_name))
    sudo('chown %s:www-data /var/www/%s/%s/log' % (env.user, env.app_name, env.app_name))
    sudo('chmod g+w /var/www/%s/%s/log' % (env.app_name, env.app_name))
    sudo('service uwsgi restart')
    sudo('service nginx restart')


def update_environment():
    _sync_config()
    sudo('cd /etc/chef && %s' % env.chef_executable, pty=True)
    

def _sync_config():
    local('rsync --exclude "*.py" --exclude "*.pyc" -av %s %s@%s:/var/chef' % (env.cookbooks, env.user, env.hosts[0]))
