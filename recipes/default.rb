include_recipe 'runit'

node[:inspircd][:packages].each do |ircd_pkg|
  package ircd_pkg
end

directory node[:inspircd][:directory]

file File.join(node[:inspircd][:directory], node[:inspircd][:file_names][:motd]) do
  content lazy{ node[:inspircd][:content][:motd] }
  mode 0644
end

file File.join(node[:inspircd][:directory], node[:inspircd][:file_names][:rules]) do
  content lazy{ node[:inspircd][:content][:rules] }
  mode 0644
end

opers = search(:inspircd, "id:oper_*").map do |item|
  item = Mash.new(Chef::EncryptedDataBagItem.load(:inspircd, item.id).to_hash)
  item.delete(:id)
  item
end

unless(opers.empty?)
  node.set[:inspircd][:content][:config][:oper] = opers
end

file File.join(node[:inspircd][:directory], node[:inspircd][:file_names][:config]) do
  content lazy{
    node[:inspircd][:content][:config].map do |key, t_value|
      [t_value].flatten.map do |value|
        attrs = value.map do |k,v|
          case v
          when true
            v = 'yes'
          when false
            v = 'no'
          end
          if(key == 'module')
            v = "m_#{v}.so"
          end
          "#{k}=\"#{v}\""
        end.join(' ')
        "<#{key} #{attrs}>"
      end.join("\n")
    end.join("\n")
  }
  mode 0644
  if(node[:inspircd][:complete])
    notifies :reload, 'runit_service[inspircd]'
  end
end

file node[:inspircd][:default][:path] do
  content lazy{
    node[:inspircd][:default][:content].map do |k,v|
      "#{k}=#{v}"
    end.join("\n")
  }
  mode 0644
  if(node[:inspircd][:complete])
    notifies :reload, 'runit_service[inspircd]'
  end
end

runit_service 'inspircd' do
  default_logger true
  options(
    :user => node[:inspircd][:user],
    :group => node[:inspircd][:user]
  )
  action [:enable, :start]
end

if(node[:inspircd][:local_services])
  include_recipe 'inspircd::services'

  node.set[:inspircd][:content][:config][:link] = Mash.new(
    :name => "services.#{node.fqdn}",
    :ipaddr => '127.0.0.1',
    :port => node[:inspircd][:anope][:config][:uplink][:port],
    :sendpass => node[:inspircd][:anope][:config][:uplink][:password],
    :recvpass => node[:inspircd][:anope][:config][:uplink][:password]
  )
  node.set[:inspircd][:content][:config][:uline] = Mash.new(
    :server => node.fqdn,
    :silent => true
  )
  srvs = (node.default[:inspircd][:content][:config][:bind] || []).to_a
  srvs.push(
    Mash.new(
      :address => '127.0.0.1',
      :port => 7000,
      :type => 'servers'
    )
  )
  node.set[:inspircd][:content][:config][:bind] = srvs.uniq

  include_recipe 'inspircd::web'
end

ruby_block 'flag complete' do
  block do
    node.set[:inspircd][:complete] = true
  end
  not_if{ node[:inspircd][:complete] }
end
