#
# Cookbook Name:: browser
# Recipe:: browser::firefox
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "apt-get update" do
  ignore_failure true
  action :nothing
end.run_action(:run) if node['platform_family'] == "ubuntu"


# firefox のインストール
package "firefox" do
	action :install
end


# Selenium RC で発生するエラーの対応
case node['platform']
when "ubuntu"
	link "/usr/bin/firefox-bin" do
		to "/usr/lib/firefox/firefox"
	end
when "centos"
	link "/usr/bin/firefox-bin" do
		to "/usr/lib64/firefox/firefox"
	end
end


# X転送でFirefoxを起動できない問題を解決
case node['platform']
when "centos"
        execute "dbus-uuidgen" do
                command "/bin/dbus-uuidgen >> /var/lib/dbus/machine-id"
		creates "/var/lib/dbus/machine-id"
        end
end
