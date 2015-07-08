default[:inspircd][:web][:packages] = ['nodejs', 'nodejs-legacy', 'npm']
default[:inspircd][:web][:version] = '0.51.1'
default[:inspircd][:web][:user] = 'irc'

default[:inspircd][:web][:config] = Mash.new(
  :public => true,
  :port => 8999,
  :autoload => false,
  :prefetch => true,
  :displayNetwork => false,
  :theme => 'themes/example.css',
  :defaults => {
    :name => 'd2o support',
    :host => '127.0.0.1',
    :port => 8992,
    :tls => false,
    :nick => 'guest',
    :username => 'guest',
    :realname => 'guest',
    :join => '#support'
  },
  :transports => [
    'polling',
    'websocket'
  ]
)
