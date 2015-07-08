node.set[:nginx][:default_site_enabled] = false

include_recipe 'nginx'
include_recipe 'runit'

package 'nginx-extras'

node[:inspircd][:web][:packages].each do |w_pkg|
  package w_pkg
end

directory '/etc/shout'
directory '/etc/shout/users'

file '/etc/shout/config.js' do
  content lazy{
    js_frmt = lambda do |obj|
      case obj
      when Hash
        str = '{'
        str << obj.map do |k,v|
          "#{k}:#{js_frmt.call(v)}"
        end.join(',')
        str << '}'
        str
      else
        obj.inspect
      end
    end
    "module.exports = #{js_frmt.call(node[:inspircd][:web][:config])}"
  }
  mode 0644
  if(node[:inspircd][:complete])
    notifies :restart, 'runit_service[shout]'
  end
end


execute 'install shout' do
  command "npm install -g shout@#{node[:inspircd][:web][:version]}"
  not_if "shout --version | grep #{node[:inspircd][:web][:version]}"
  if(node[:inspircd][:complete])
    notifies :restart, 'runit_service[shout]'
  end
end

runit_service 'shout' do
  default_logger true
  options(
    :user => node[:inspircd][:web][:user],
    :group => node[:inspircd][:web][:user]
  )
  action [:enable, :start]
end

template File.join(node[:nginx][:dir], 'sites-available', 'shout') do
  source 'shout-nginx.erb'
  mode 0644
  notifies :reload, 'service[nginx]'
end

nginx_site 'shout'

service 'nginx' do
  action :start
end
