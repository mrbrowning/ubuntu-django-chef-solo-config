template "iptables" do
  source "iptables.erb"
  path "/etc/init.d/iptables"
  mode 0744
  owner "root"
  group "root"
end

script "iptables_on" do
  interpreter "bash"
  user "root"
  code <<-EOH 
  /etc/init.d/iptables stop
  /etc/init.d/iptables start
  EOH
end