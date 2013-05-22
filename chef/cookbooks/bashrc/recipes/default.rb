user_name = "insertyourusernamehere"

template "bashrc" do
  source "bashrc.erb"
  path "/home/#{user_name}/.bashrc"
  mode 0644
  owner "#{user_name}"
  group "#{user_name}"
end


template "bashrc" do
  source "bash_profile.erb"
  path "/home/#{user_name}/.bash_profile"
  mode 0644
  owner "#{user_name}"
  group "#{user_name}"
end
