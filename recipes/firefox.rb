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


package "firefox" do
	action :install
end


case node['platform']
when "ubuntu"
	link "/usr/bin/firefox-bin" do
		to "/usr/lib/firefox/firefox"
	end
end
