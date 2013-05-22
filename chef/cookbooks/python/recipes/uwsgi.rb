include_recipe "python::pip"

venv_dir = node['python']['venv_dir']

python_pip "uwsgi" do
  virtualenv venv_dir
  action :install
end

directory "/etc/uwsgi" do
  mode 0755
  owner "root"
  action :create
end

directory "/var/log/uwsgi" do
  mode 0755
  owner "root"
  action :create
end

directory "/etc/uwsgi/apps-available" do
  mode 0755
  owner "root"
  action :create
end

directory "/etc/uwsgi/apps-enabled" do
  mode 0755
  owner "root"
  action :create
end

template "app.ini" do
  path "/etc/uwsgi/apps-available/#{node['python']['app_name']}.ini"
  source "app.ini.erb"
  owner "root"
  group "root"
  mode 0644
end

link "/etc/uwsgi/apps-enabled/#{node['python']['app_name']}.ini" do
  to "/etc/uwsgi/apps-available/#{node['python']['app_name']}.ini"
end

template "uwsgi.conf" do
  path "/etc/init/uwsgi.conf"
  source "uwsgi.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

service "uwsgi" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
