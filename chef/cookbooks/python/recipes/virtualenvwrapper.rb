include_recipe "python::pip"

python_pip "virtualenvwrapper" do
  action :install
end