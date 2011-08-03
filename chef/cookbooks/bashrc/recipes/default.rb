# update the OFFICE variable in the template with your office or home ip

template "bashrc" do
  source "bashrc.erb"
  path "/home/insertyourusernamehere/.bashrc"
  mode 0644
  owner "designcc"
  group "designcc"
end


template "bashrc" do
  source "bash_profile.erb"
  path "/home/insertyourusernamehere/.bash_profile"
  mode 0644
  owner "designcc"
  group "designcc"
end