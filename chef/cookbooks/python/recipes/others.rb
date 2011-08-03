bash "install-gunicorn" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  pip install gunicorn
  pip install boto
  EOF
end
