package "vim"
package "git-core"


node[:users].each_pair do |username, info|
    group username do
       gid info[:id] 
    end

    user username do 
        comment info[:full_name]
        uid info[:id]
        gid info[:id]
        shell info[:disabled] ? "/sbin/nologin" : "/bin/bash"
        supports :manage_home => true
        home "/home/#{username}"
        password info[:password]
    end

    directory "/home/#{username}/.ssh" do
        owner username
        group username
        mode 0700
    end

    directory "/home/#{username}/logs" do
        owner username
        group username
        mode 0755
    end
    
    directory "/home/#{username}/conf" do
        owner username
        group username
        mode 0755
    end

    directory "/home/#{username}/conf/nginx" do
        owner username
        group username
        mode 0755
    end
    
    directory "/home/#{username}/conf/supervisord/" do
        owner username
        group username
        mode 0755
    end

    file "/home/#{username}/.ssh/authorized_keys" do
        owner username
        group username
        mode 0600
        content info[:key]
    end
    
    execute "generate ssh skys for #{username}." do
        user username
        creates "/home/#{username}/.ssh/id_rsa.pub"
        command "ssh-keygen -t rsa -q -f /home/#{username}/.ssh/id_rsa -P \"\""
    end
    
    execute "add designcc to sudo group" do
      user "root"
      command "usermod -a -G sudo designcc"
    end
    
end


