include_recipe 'build-essential'
include_recipe 'runit'

package 'cmake'

working_directory = '/usr/src/anope'
unpacked_directory = File.join(working_directory, "anope-#{node[:inspircd][:anope][:version]}-source")
bin_file = File.join(
  node[:inspircd][:anope][:build_config]['INSTDIR'],
  'bin', 'services'
)
tarball = File.join(working_directory, 'anope.tar.gz')

user node[:inspircd][:anope][:user]
directory working_directory

remote_file tarball do
  source "https://github.com/anope/anope/releases/download/#{node[:inspircd][:anope][:version]}/anope-#{node[:inspircd][:anope][:version]}-source.tar.gz"
  backup false
  not_if "#{bin_file} -v | grep #{node[:inspircd][:anope][:version]}"
end

execute 'unpack anope' do
  command 'tar xvf anope.tar.gz'
  action :nothing
  subscribes :run, "remote_file[#{tarball}]", :immediately
  notifies :run, "execute[anope cleanup]"
  cwd working_directory
end

file File.join(unpacked_directory, 'config.cache') do
  content lazy{
    node[:inspircd][:anope][:build_config].map do |k,v|
      "#{k}=#{v}"
    end.join("\n")
  }
  mode 0644
  subscribes :create, 'execute[unpack anope]', :immediately
end

execute 'anope cleanup' do
  command "/bin/true" #rm -rf #{working_directory}"
  action :nothing
end

execute 'anope configure' do
  command './Config -quick -nointro'
  action :nothing
  subscribes :run, 'execute[unpack anope]', :immediately
  cwd unpacked_directory
end

execute 'anope make' do
  command 'make'
  action :nothing
  subscribes :run, 'execute[anope configure]', :immediately
  cwd ::File.join(unpacked_directory, 'build')
end

execute 'anope install' do
  command 'make install'
  action :nothing
  subscribes :run, 'execute[anope make]', :immediately
  cwd ::File.join(unpacked_directory, 'build')
end

unless(node[:inspircd][:anope][:config][:options][:seed])
  node.set[:inspircd][:anope][:config][:options][:seed] = SecureRandom.base64[0,7]
end

file 'anope services config' do
  path lazy{
    ::File.join(
      node[:inspircd][:anope][:build_config]['INSTDIR'],
      'conf',
      'services.conf'
    )
  }
  content lazy{
    node[:inspircd][:anope][:config].map do |key, value|
      [value].flatten.map do |val|
        output = "#{key}\n{\n"
        output << val.map do |k,v|
          v = case v
              when TrueClass
                'yes'
              when FalseClass
                'no'
              when String
                #v.include?(' ') ? v.inspect : v
                v.inspect
              else
                v
              end
          "  #{k} = #{v}"
        end.join("\n")
        output << "\n}"
      end.join("\n")
    end.join("\n")
  }
  mode 0644
  if(node[:inspircd][:complete])
    notifies :restart, 'runit_service[anope]'
  end
end

directory 'anope data directory' do
  path ::File.join(node[:inspircd][:anope][:build_config]['INSTDIR'], 'data')
  recursive true
  owner node[:inspircd][:anope][:user]
end

directory 'anope backup directory' do
  path ::File.join(node[:inspircd][:anope][:build_config]['INSTDIR'], 'backup')
  recursive true
  owner node[:inspircd][:anope][:user]
end

runit_service 'anope' do
  default_logger true
  options(
    :user => node[:inspircd][:anope][:user],
    :group => node[:inspircd][:anope][:user]
  )
  action [:enable, :start]
end
