node[:users].each do |u|
  name = u[:id]
  home = u[:home] || "/home/#{name}"

  user name do
    home home
    password u[:password]
    not_if "grep #{name} /etc/passwd"
  end

  u[:groups].each do |g|
    execute "usermod -G #{g} #{name}" do
      command "usermod -G #{g} #{name}"
    end
  end

  if u.has_key?('ssh-keys')
    directory "#{home}/.ssh" do
      owner name
      group name
      mode '0700'
      not_if File.exists? "#{home}/.ssh"
    end

    file "#{home}/.ssh/authorized_keys" do
      content u['ssh-keys'].join("\n")
      owner name
      group name
      mode '0600'
      not_if File.exists? "#{home}/.ssh/authorized_keys"
    end
  end
end
