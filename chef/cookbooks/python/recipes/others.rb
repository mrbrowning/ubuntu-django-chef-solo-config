include_recipe "python::virtualenv"

venv_dir = node['python']['venv_dir']

python_virtualenv venv_dir do
	interpreter "python"
	action :create
end

python_pip "flask" do
	virtualenv venv_dir
	action :install
end

python_pip "flask-mongoengine" do
	virtualenv venv_dir
	action :install
end
