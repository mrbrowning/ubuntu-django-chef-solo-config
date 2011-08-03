package "supervisor"

template "supervisord" do
  source "supervisord.conf.erb"
  path "/etc/supervisor/supervisord.conf"
  mode 0744
  owner "root"
  group "root"
end


script "start_supervisord" do
  interpreter "bash"
  user "designcc"
  code <<-EOH
    killall supervisord
    supervisord
  EOH
end
