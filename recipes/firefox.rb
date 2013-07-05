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
case node['platform']
when "ubuntu"
        %w{
                firefox fonts-ipaexfont
        }.each do |package_name|
                package "#{package_name}" do
                        action :install
                end
        end
when "centos","amazon"
        %w{
                firefox ipa-gothic-fonts
        }.each do |package_name|
                package "#{package_name}" do
                        action :install
                end
        end
end


# Selenium RC で発生するエラーの対応
case node['platform']
when "ubuntu"
	link "/usr/bin/firefox-bin" do
		to "/usr/lib/firefox/firefox"
	end
when "centos","amazon"
	link "/usr/bin/firefox-bin" do
		to "/usr/lib64/firefox/firefox"
	end
end


# X転送でFirefoxを起動できない問題を解決
case node['platform']
when "centos","amazon"
        execute "dbus-uuidgen" do
                command "/bin/dbus-uuidgen >> /var/lib/dbus/machine-id"
		creates "/var/lib/dbus/machine-id"
        end
end
