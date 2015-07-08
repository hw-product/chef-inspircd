default[:inspircd][:packages] = ['inspircd']
default[:inspircd][:directory] = '/etc/inspircd'
default[:inspircd][:file_names][:config] = 'inspircd.conf'
default[:inspircd][:file_names][:motd] = 'motd'
default[:inspircd][:file_names][:rules] = 'rules'

default[:inspircd][:local_services] = true

default[:inspircd][:user] = 'irc'

default[:inspircd][:default][:write] = true
default[:inspircd][:default][:path] = '/etc/default/inspircd'
default[:inspircd][:default][:content] = Mash.new(
  'INSPIRCD_ENABLED' => 1
)

default[:inspircd][:content][:motd] = 'Have a great day!'
default[:inspircd][:content][:rules] = "Don't be a jerk!"
default[:inspircd][:content][:config] = Mash.new(
  :pid => {
    :file => '/tmp/.inspircd.pid'
  },
  :server => {
    :name => node.name,
    :description => 'InspIRCd server',
    :network => 'local'
  },
  :admin => {
    :name => 'User',
    :nick => 'user',
    :email => 'user@example.com'
  },
  :bind => [
    Mash.new(
      :address => '*',
      :port => '6667',
      :type => 'clients'
    ),
    Mash.new(
      :address => '*',
      :port => 8992,
      :type => 'clients'
    )
  ],
  :power => {
    :diepass => 3456,
    :restartpass => 7890,
    :pause => 2
  },
  :connect => {
    :allow => '*',
    :timeout => 60,
    :flood => 20,
    :threshold => 1,
    :pingfreq => 60,
    :sendq => 262144,
    :recvq => 8192,
    :localmax => 100,
    :globalmax => 3
  },
  :class => [
    Mash.new(
      :name => 'Shutdown',
      :commands => 'DIE RESTART REHASH LOADMODULE UNLOADMODULE RELOAD'
    ),
    Mash.new(
      :name => 'ServerLink',
      :commands => 'CONNECT SQUIT RCONNECT MKPASSWD MKSHA256'
    ),
    Mash.new(
      :name => 'BanControl',
      :commands => 'KILL GLINE KLINE ZLINE QLINE ELINE'
    ),
    Mash.new(
      :name => 'OperChat',
      :commands => 'WALLOPS GLOBOPS SETIDLE SPYLIST SPYNAMES'
    ),
    Mash.new(
      :name => 'HostCloak',
      :commands => 'SETHOST SETIDENT SETNAME CHGHOST CHGIDENT'
    ),
  ],
  :type => [
    Mash.new(
      :name => 'NetAdmin',
      :classes => 'OperChat BanControl HostCloak Shutdown ServerLink',
      :host => 'netadmin.example.com'
    ),
    Mash.new(
      :name => 'GlobalOp',
      :classes => 'OperChat BanControl HostCloak ServerLink',
      :host => 'ircop.example.com'
    ),
    Mash.new(
      :name => 'Helper',
      :classes => 'HostCloak',
      :host => 'helper.example.com'
    )
  ],
  :oper => [
    Mash.new(
      :name => 'root',
      :password => 'changeme123',
      :host => '*@localhost',
      :type => 'NetAdmin'
    ),
    Mash.new(
      :name => 'spox',
      :password => 'changeme123',
      :host => '*@50.38.73.46',
      :type => 'GlobalOp'
    )
  ],
  :files => {
    :motd => '/etc/inspircd/inspircd.motd',
    :rules => '/etc/inspircd/inspircd.rules'
  },
  :channels => {
    :users => 20,
    :opers => 60
  },
  :dns => {
    :server => '127.0.0.1',
    :timeout => 5
  },
  :cloak => {
    :mode => 'full',
    :key => 'changeme123',
    :prefix => 'd2o-'
  },
  :module => [
    Mash.new(:name => 'md5'),
    Mash.new(:name => 'sha256'),
    Mash.new(:name => 'alias'),
    Mash.new(:name => 'allowinvite'),
    Mash.new(:name => 'auditorium'),
    Mash.new(:name => 'autoop'),
    Mash.new(:name => 'banexception'),
    Mash.new(:name => 'blockcolor'),
    Mash.new(:name => 'botmode'),
    Mash.new(:name => 'chancreate'),
    Mash.new(:name => 'chanhistory'),
    Mash.new(:name => 'cloaking'),
    Mash.new(:name => 'close'),
    Mash.new(:name => 'clones'),
    Mash.new(:name => 'commonchans'),
    Mash.new(:name => 'conn_join'),
    Mash.new(:name => 'hidechans'),
    Mash.new(:name => 'noctcp'),
    Mash.new(:name => 'ojoin'),
    Mash.new(:name => 'operlevels'),
    Mash.new(:name => 'muteban'),
    Mash.new(:name => 'regex_pcre'),
    Mash.new(:name => 'restrictchans'),
    Mash.new(:name => 'rline'),
    Mash.new(:name => 'sajoin'),
    Mash.new(:name => 'sakick'),
    Mash.new(:name => 'saquit'),
    Mash.new(:name => 'services_account'),
    Mash.new(:name => 'xline_db'),
    Mash.new(:name => 'spanningtree')
  ],
  :performance => {
    :nouserdns => false,
    :maxwho => 128,
    :softlimit => 1024,
    :somaxconn => 128,
    :netbuffersize => 10240,
  },
  :security => {
    :hidewhois => false,
    :customversion => '',
    :userstats => 'Pu',
    :hidesplits => false,
    :hidebans => false,
    :operspywhois => false,
    :hidemodes => 'eI',
    :maxtargets => 20
  },
  :options => {
    :prefixquit => 'Quit: ',
    :noservices => false,
    :qaprefixes => false,
    :deprotectself => false,
    :deprotectothers => false,
    :flatlinks => false,
    :hideulines => false,
    :syntaxhints => false,
    :cyclehosts => true,
    :ircumsgprefix => false,
    :announcets => true,
    :disablehmac => false,
    :hostintopic => true,
    :quietbursts => true,
    :pingwarning => 15,
    :allowhalfop => true,
    :exemptchanops => ''
  },
  :timesync => {
    :enable => false,
    :master => false
  },
  :badnick => [
    Mash.new(
      :nick => 'ChanServ',
      :reason => 'Reserved for Services'
    ),
    Mash.new(
      :nick => 'NickServ',
      :reason => 'Reserved for Services'
    ),
    Mash.new(
      :nick => 'OperServ',
      :reason => 'Reserved for Services'
    ),
    Mash.new(
      :nick => 'MemoServ',
      :reason => 'Reserved for Services'
    )
  ]
)
