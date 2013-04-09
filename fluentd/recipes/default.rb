
apt_package "unzip"
apt_package "libxslt-dev"
apt_package "libxml2-dev"

fluent_zip = File.join(Chef::Config[:file_cache_path], "/", "fluent.zip")
couch_plugin_zip = File.join(Chef::Config[:file_cache_path], "/", "couch_plugin.zip")

remote_file fluent_zip do
  source "https://github.com/Jimflip/fluentd/archive/master.zip"
  not_if { ::File.exists?(fluent_zip) }
end

remote_file couch_plugin_zip do
  source "https://github.com/Jimflip/fluent-plugin-couch/archive/master.zip"
  not_if { ::File.exists?(couch_plugin_zip) }
end

bash 'gahh1' do
  cwd ::File.dirname("/tmp")

  code <<-EOH
    sudo unzip #{fluent_zip}
    cd fluentd-master
    sudo gem build fluentd.gemspec
    gem install fluentd-0.10.14.gem
  EOH

end

bash 'gahh2' do
  cwd ::File.dirname("/tmp")

  code <<-EOH
    sudo unzip #{couch_plugin_zip}
    cd fluent-plugin-couch-master
    sudo gem build fluent-plugin-couch.gemspec
    gem install fluent-plugin-couch-0.6.0.gem
  EOH

end

bash 'gahh3' do
  #this should work but just seems a mess with opsworks
  #gem_package "fluent-plugin-s3"

  code "gem install fluent-plugin-s3"
end

user "fluent" do
  comment "fluent Administrator"
  supports :manage_home => false
  system true
end

directory "/etc/fluent" do
  owner "fluent"
  group "fluent"
  mode 0755
  action :create
end

directory "/var/log/fluent" do
  owner "fluent"
  group "fluent"
  mode 0755
  action :create
end

template "/etc/fluent/fluent.conf" do
  source "fluent.conf.erb"
  owner "fluent"
  group "fluent"
  mode 0664
end

template "/etc/init/fluentd.conf" do
  source "fluentd.conf.erb"
  owner "root"
  group "root"
end

service "fluentd" do
  provider Chef::Provider::Service::Upstart
  action :start
end