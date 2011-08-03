package "memcached"
package "python-memcache"

template "memcached" do
  source "memcached.conf.erb"
  path "/etc/memcached.conf"
  mode 0744
  owner "root"
  group "root"
end