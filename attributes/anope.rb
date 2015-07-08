default[:inspircd][:anope][:version] = '2.0.2'
default[:inspircd][:anope][:user] = 'irc'
default[:inspircd][:anope][:build_config] = Mash.new(
  'INSTDIR' => '/usr/local/anope',
  'RUNGROUP' => 'irc',
  'UMASK' => '007',
  'DEBUG' => 'no',
  'USE_RUN_CC_PL' => 'no',
  'USE_PCH' => 'no',
  'EXTRA_INCLUDE_DIRS' => '',
  'EXTRA_LIB_DIRS' => '',
  'EXTRA_CONFIG_ARGS' => ''
)
default[:inspircd][:anope][:config] = Mash.new(
  :define => {
    :name => node.name,
    :value => node.fqdn
  },
  :uplink => {
    :host => '127.0.0.1',
    :ipv6 => false,
    :ssl => false,
    :port => 7000,
    :password => 'changeme123'
  },
  :serverinfo => {
    :name => "services.#{node.fqdn}",
    :description => 'Services for IRC',
    :pid => 'data/services.pid',
    :motd => 'conf/services.motd'
  },
  :module => [
    Mash.new(
      :name => 'inspircd20',
      :use_server_side_mlock => true,
      :use_server_side_topiclock => true
    ),
    Mash.new(
      :name => 'db_flatfile',
      :database => 'anope.db',
      :keepbackups => 5,
      :fork => false
    ),
    Mash.new(
      :name => 'enc_sha256'
    ),
    Mash.new(
      :name => 'global',
      :client => 'Global',
      :anonymousglobal => true
    ),
    Mash.new(:name => 'gl_global'),
    Mash.new(
      :name => 'operserv',
      :client => 'OperServ',
      :autokillexpiry => '30d',
      :chankillexpiry => '30d',
      :snlineexpiry => '30d',
      :sqlineexpiry => '30d',
      :akillonadd => true,
      :killonsnline => true,
      :killonsqline => true,
      :addakiller => true,
      :opersonly => true
    ),
    Mash.new(:name => 'os_akill'),
    Mash.new(:name => 'os_chankill'),
    Mash.new(:name => 'os_config'),
    Mash.new(:name => 'os_forbid'),
    Mash.new(:name => 'os_ignore'),
    Mash.new(:name => 'os_info'),
    Mash.new(:name => 'os_jupe'),
    Mash.new(:name => 'os_kick'),
    Mash.new(:name => 'os_kill'),
    Mash.new(:name => 'os_list'),
    Mash.new(:name => 'os_login'),
    Mash.new(:name => 'os_mode'),
    Mash.new(:name => 'os_modinfo'),
    Mash.new(:name => 'os_module'),
    Mash.new(:name => 'os_noop'),
    Mash.new(:name => 'os_oper'),
    Mash.new(:name => 'os_reload'),
    Mash.new(
      :name => 'os_session',
      :defaultsessionlimit => 3,
      :maxsessionlimit => 50,
      :exceptionexpiry => '1d',
      :sessionlimitexceeded => 'Session limit for your IP %IP% has been exceeded.',
      :session_ipv4_cidr => 32,
      :session_ipv6_cidr => 128
    ),
    Mash.new(:name => 'os_shutdown'),
    Mash.new(:name => 'os_stats'),
    Mash.new(:name => 'os_svs'),
    Mash.new(:name => 'os_sxline'),
    Mash.new(:name => 'os_update'),
    Mash.new(
      :name => 'botserv',
      :client => 'BotServ',
      :defaults => 'greet fantasy',
      :minusers => 1,
      :smartjoin => true,
      :botmodes => 'ao'
    ),
    Mash.new(:name => 'bs_assign'),
    Mash.new(:name => 'bs_bot'),
    Mash.new(:name => 'bs_botlist'),
    Mash.new(:name => 'bs_control'),
    Mash.new(:name => 'bs_info'),
    Mash.new(
      :name => 'bs_kick',
      :keepdata => '10m'
    ),
    Mash.new(:name => 'bs_set'),
    Mash.new(:name => 'bs_greet'),
    Mash.new(:name => 'fantasy'),
    Mash.new(
      :name => 'chanserv',
      :client => 'ChanServ',
      :defaults => 'keeptopic securefounder signkick',
      :accessmax => 0,
      :inhabit => '30s',
      :reasonmax => 300,
      :signkickformat => '%m (%n)',
      :disallow_hostmask_access => false,
      :disallow_channel_access => false,
      :always_lower_ts => true
    ),
    Mash.new(
      :name => 'cs_akick',
      :autokickmax => 50,
      :autokickreason => 'User has been banned from the channel'
    ),
    Mash.new(:name => 'cs_ban'),
    Mash.new(:name => 'cs_clone'),
    Mash.new(:name => 'cs_drop'),
    Mash.new(:name => 'cs_enforce'),
    Mash.new(
      :name => 'cs_entrymsg',
      :maxentries => 5
    ),
    Mash.new(:name => 'cs_flags'),
    Mash.new(:name => 'cs_getkey'),
    Mash.new(:name => 'cs_info'),
    Mash.new(:name => 'cs_invite'),
    Mash.new(:name => 'cs_kick'),
    Mash.new(
      :name => 'cs_list',
      :listmax => 100
    ),
    Mash.new(
      :name => 'cs_mode',
      :mlock => '+nt',
      :max => 32
    ),
    Mash.new(:name => 'cs_register'),
    Mash.new(
      :name => 'cs_seen',
      :simple => false,
      :purgetime => '1y',
      :expiretimeout => '1d'
    ),
    Mash.new(
      :name => 'cs_set',
      :defbantype => 1,
      :persist_lower_ts => true
    ),
    Mash.new(:name => 'cs_set_misc'),
    Mash.new(:name => 'cs_status'),
    Mash.new(
      :name => 'cs_suspend',
      :expire => '90d',
      :show => 'suspended, by, reason, on, expires'
    ),
    Mash.new(:name => 'cs_sync'),
    Mash.new(:name => 'cs_topic'),
    Mash.new(:name => 'cs_unban'),
    Mash.new(:name => 'cs_updown'),
    Mash.new(:name => 'cs_xop'),
    Mash.new(:name => 'cs_statusupdate'),
    Mash.new(
      :name => 'hostserv',
      :client => 'HostServ',
      :activate_on_set => true
    ),
    Mash.new(:name => 'hs_del'),
    Mash.new(:name => 'hs_group'),
    Mash.new(:name => 'hs_list'),
    Mash.new(:name => 'hs_off'),
    Mash.new(:name => 'hs_on'),
    Mash.new(
      :name => 'hs_request',
      :memouser => true,
      :memooper => true
    ),
    Mash.new(:name => 'hs_set'),
    Mash.new(
      :name => 'memoserv',
      :client => 'MemoServ',
      :senddelay => '2s'
    ),
    Mash.new(:name => 'ms_cancel'),
    Mash.new(:name => 'ms_check'),
    Mash.new(:name => 'ms_del'),
    Mash.new(:name => 'ms_ignore'),
    Mash.new(:name => 'ms_info'),
    Mash.new(:name => 'ms_list'),
    Mash.new(:name => 'ms_read'),
    Mash.new(:name => 'ms_rsend'),
    Mash.new(:name => 'ms_send'),
    Mash.new(:name => 'ms_sendall'),
    Mash.new(:name => 'ms_set'),
    Mash.new(:name => 'ms_staff'),
    Mash.new(
      :name => 'nickserv',
      :client => 'NickServ',
      :forceemail => true,
      :confirmemailchanges => true,
      :unregistered_notice => 'Your nickname is not registered. To register it, use: /msg NickServ REGISTER password email',
      :defaults => 'ns_secure ns_private hide_email hide_mask memo_signon memo_recieve autoop',
      :regdelay => '10s',
      :expire => '90d',
      :secureadmins => true,
      :modeonid => true,
      :modesonid => '+iR',
      :hidenetsplitquit => false,
      :enforceruser => 'god',
      :enforcerhost => node.fqdn,
      :releasetimeout => '30s',
      :guestnickprefix => 'Guest',
      :nonicknameownership => false,
      :passlen => 64
    ),
    Mash.new(
      :name => 'ns_access',
      :accessmax => 64,
      :addaccessonreg => true
    ),
    Mash.new(
      :name => 'ns_ajoin',
      :ajoinmax => 30
    ),
    Mash.new(:name => 'ns_alist'),
    Mash.new(
      :name => 'ns_cert',
      :max => 10
    ),
    Mash.new(:name => 'ns_drop'),
    Mash.new(:name => 'ns_getemail'),
    Mash.new(:name => 'ns_getpass'),
    Mash.new(
      :name => 'ns_group',
      :maxaliases => 16,
      :nogroupchange => true
    ),
    Mash.new(:name => 'ns_identify'),
    Mash.new(:name => 'ns_info'),
    Mash.new(
      :name => 'ns_list',
      :listmax => 50
    ),
    Mash.new(:name => 'ns_logout'),
    Mash.new(
      :name => 'ns_recover',
      :restoreonrecover => true
    ),
    Mash.new(
      :name => 'ns_register',
      :registration => 'email',
      :resenddelay => '90s',
      :nickregdelay => '30s',
      :unconfirmedexpire => '2h'
    ),
    Mash.new(:name => 'ns_resetpass'),
    Mash.new(
      :name => 'ns_set',
      :allowkillimmed => true
    ),
    Mash.new(:name => 'ns_set_misc'),
    Mash.new(:name => 'ns_status'),
    Mash.new(
      :name => 'ns_suspend',
      :suspendexpire => '90d',
      :show => 'suspended, by, reason, on, expires'
    ),
    Mash.new(:name => 'ns_update'),
    Mash.new(
      :name => 'ns_maxemail',
      :maxemails => 1
    )
  ],
  :command_group => [
    Mash.new(
      :name => 'chanserv/access',
      :description => 'Used to manage the list of privileged users'
    ),
    Mash.new(
      :name => 'chanserv/status',
      :description => 'Used to modify the channel status of you or other users'
    ),
    Mash.new(
      :name => 'chanserv/management',
      :description => 'Used to manage channels'
    ),
    Mash.new(
      :name => 'chanserv/admin',
      :description => 'Services Operator commands'
    ),
    Mash.new(
      :name => 'nickserv/admin',
      :description => 'Services Operator commands'
    )
  ],
  :command => [
    Mash.new(
      :service => 'Global',
      :name => 'GLOBAL',
      :command => 'global/global',
      :permission => 'global/global'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'AKILL',
      :command => 'operserv/akill',
      :permission => 'operserv/akill'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'CHANKILL',
      :command => 'operserv/chankill',
      :permission => 'operserv/chankill'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'CONFIG',
      :command => 'operserv/config',
      :permission => 'operserv/config'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'FORBID',
      :command => 'operserv/forbid',
      :permission => 'operserv/forbid'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'IGNORE',
      :command => 'operserv/ignore',
      :permission => 'operserv/ignore'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'INFO',
      :command => 'operserv/info',
      :permission => 'operserv/info'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'JUPE',
      :command => 'operserv/jupe',
      :permission => 'operserv/jupe'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'KICK',
      :command => 'operserv/kick',
      :permission => 'operserv/kick'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'KILL',
      :command => 'operserv/kill',
      :permission => 'operserv/kill'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'CHANLIST',
      :command => 'operserv/chanlist',
      :permission => 'operserv/chanlist'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'USERLIST',
      :command => 'operserv/userlist',
      :permission => 'operserv/userlist'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'LOGIN',
      :command => 'operserv/login',
      :permission => 'operserv/login'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'LOGOUT',
      :command => 'operserv/logout',
      :permission => 'operserv/logout'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'UMODE',
      :command => 'operserv/umode',
      :permission => 'operserv/umode'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'MODE',
      :command => 'operserv/mode',
      :permission => 'operserv/mode'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'MODINFO',
      :command => 'operserv/modinfo',
      :permission => 'operserv/modinfo'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'MODLOAD',
      :command => 'operserv/modload',
      :permission => 'operserv/modload'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'MODRELOAD',
      :command => 'operserv/modload',
      :permission => 'operserv/modload'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'MODUNLOAD',
      :command => 'operserv/modload',
      :permission => 'operserv/modload'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'NOOP',
      :command => 'operserv/noop',
      :permission => 'operserv/noop'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'OPER',
      :command => 'operserv/oper',
      :permission => 'operserv/oper'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'RELOAD',
      :command => 'operserv/reload',
      :permission => 'operserv/reload'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'EXCEPTION',
      :command => 'operserv/exception',
      :permission => 'operserv/exception'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SESSION',
      :command => 'operserv/session',
      :permission => 'operserv/session'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'QUIT',
      :command => 'operserv/quit',
      :permission => 'operserv/quit'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'RESTART',
      :command => 'operserv/restart',
      :permission => 'operserv/restart'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'STATS',
      :command => 'operserv/stats',
      :permission => 'operserv/stats'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SVSNICK',
      :command => 'operserv/svs',
      :permission => 'operserv/svs'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SVSJOIN',
      :command => 'operserv/svs',
      :permission => 'operserv/svs'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SVSJOIN',
      :command => 'operserv/svs',
      :permission => 'operserv/svs'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SNLINE',
      :command => 'operserv/snline',
      :permission => 'operserv/snline'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'SQLINE',
      :command => 'operserv/sqline',
      :permission => 'operserv/sqline'
    ),
    Mash.new(
      :service => 'OperServ',
      :name => 'UPDATE',
      :command => 'operserv/update',
      :permission => 'operserv/update'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'ASSIGN',
      :command => 'botserv/assign'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'UNASSIGN',
      :command => 'botserv/unassign'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET NOBOT',
      :command => 'botserv/set/nobot',
      :permission => 'botserv/set/nobot'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'BOT',
      :command => 'botserv/set/bot',
      :permission => 'botserv/bot'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'BOTLIST',
      :command => 'botserv/botlist'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'ACT',
      :command => 'botserv/act'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SAY',
      :command => 'botserv/say'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'INFO',
      :command => 'botserv/info'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'KICK',
      :command => 'botserv/kick'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'KICK ASMG',
      :command => 'botserv/kick/asmg'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'KICK FLOOD',
      :command => 'botserv/kick/flood'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'KICK REPEAT',
      :command => 'botserv/kick/repeat'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET DONTKICKOPS',
      :command => 'botserv/set/dontkickops'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET DONTKICKVOICES',
      :command => 'botserv/set/dontkickvoices'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET',
      :command => 'botserv/set'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET BANEXPIRE',
      :command => 'botserv/set/banexpire'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET PRIVATE',
      :command => 'botserv/set/private'
    ),
    Mash.new(
      :service => 'BotServ',
      :name => 'SET GREET',
      :command => 'botserv/set/greet'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET GREET',
      :command => 'nickserv/set/greet'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET GREET',
      :command => 'nickserv/saset/greet',
      :permission => 'nickserv/saset/greet'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'ACCESS',
      :command => 'chanserv/access',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'LEVELS',
      :command => 'chanserv/levels',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'AKICK',
      :command => 'chanserv/akick',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'BAN',
      :command => 'chanserv/ban'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'CLONE',
      :command => 'chanserv/clone',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DROP',
      :command => 'chanserv/drop'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'ENFORCE',
      :command => 'chanserv/enforce',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'ENTRYMSG',
      :command => 'chanserv/entrymsg',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'FLAGS',
      :command => 'chanserv/flags',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'GETKEY',
      :command => 'chanserv/getkey'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'INFO',
      :command => 'chanserv/INFO'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'INVITE',
      :command => 'chanserv/invite'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'KICK',
      :command => 'chanserv/kick'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'LIST',
      :command => 'chanserv/list'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET PRIVATE',
      :command => 'chanserv/set/private'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'MODE',
      :command => 'chanserv/mode',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'OWNER',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :set => 'OWNER'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DEOWNER',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :unset => 'OWNER'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'PROTECT',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :set => 'PROTECT'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DEPROTECT',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :unset => 'PROTECT'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'OP',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :set => 'OP'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DEOP',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :unset => 'OP'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'HALFOP',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :set => 'HALFOP'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DEHALFOP',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :unset => 'HALFOP'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'VOICE',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :set => 'VOICE'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DEVOICE',
      :command => 'chanserv/modes',
      :group => 'chanserv/status',
      :unset => 'VOICE'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'REGISTER',
      :command => 'chanserv/register'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SEEN',
      :command => 'operserv/seen',
      :permision => 'operserv/seen'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET',
      :command => 'chanserv/set',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET AUTOOP',
      :command => 'chanserv/set/autoop'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET BANTYPE',
      :command => 'chanserv/set/bantype'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET DESCRIPTION',
      :command => 'chanserv/set/description'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET DESC',
      :command => 'chanserv/set/description',
      :hide => true
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET FOUNDER',
      :command => 'chanserv/set/founder'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET KEEPMODES',
      :command => 'chanserv/set/keepmodes'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET PEACE',
      :command => 'chanserv/set/peace'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET PERSIST',
      :command => 'chanserv/set/persist'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET RESTRICTED',
      :command => 'chanserv/set/restricted'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET SECURE',
      :command => 'chanserv/set/secure'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET SECUREFOUNDER',
      :command => 'chanserv/set/securefounder'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET SECUREOPS',
      :command => 'chanserv/set/secureops'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET SIGNKICK',
      :command => 'chanserv/set/signkick'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET SUCCESSOR',
      :command => 'chanserv/set/successor'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET NOEXPIRE',
      :command => 'chanserv/saset/noexpire',
      :permission => 'chanserv/saset/noexpire'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET URL',
      :command => 'chanserv/set/misc',
      :misc_description => 'Associate a URL with the channel'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET EMAIL',
      :command => 'chanserv/set/misc',
      :misc_description => 'Associate an email with the channel'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'STATUS',
      :command => 'chanserv/status'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SUSPEND',
      :command => 'chanserv/suspend',
      :permission => 'chanserv/suspend',
      :group => 'chanserv/admin'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'UNSUSPEND',
      :command => 'chanserv/unsuspend',
      :permission => 'chanserv/suspend',
      :group => 'chanserv/admin'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SYNC',
      :command => 'chanserv/sync',
      :gorup => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'TOPIC',
      :command => 'chanserv/topic',
      :group => 'chanserv/management'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SET KEEPTOPIC',
      :command => 'chanserv/set/keeptopic'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'UNBAN',
      :command => 'chanserv/unban'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'DOWN',
      :command => 'chanserv/down',
      :group => 'chanserv/status'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'UP',
      :command => 'chanserv/up',
      :group => 'chanserv/status'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'QOP',
      :command => 'chanserv/xop',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'SOP',
      :command => 'chanserv/xop',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'AOP',
      :command => 'chanserv/xop',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'HOP',
      :command => 'chanserv/xop',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'ChanServ',
      :name => 'VOP',
      :command => 'chanserv/xop',
      :group => 'chanserv/access'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'DEL',
      :command => 'hostserv/del',
      :permission => 'hostserv/del'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'DELALL',
      :command => 'hostserv/delall',
      :permission => 'hostserv/del'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'GROUP',
      :command => 'hostserv/group'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'LIST',
      :command => 'hostserv/list',
      :permission => 'hostserv/list'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'OFF',
      :command => 'hostserv/off'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'ON',
      :command => 'hostserv/on'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'REQUEST',
      :command => 'hostserv/request'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'ACTIVATE',
      :command => 'hostserv/activate',
      :permission => 'hostserv/set'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'REJECT',
      :command => 'hostserv/reject',
      :permission => 'hostserv/set'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'WAITING',
      :command => 'hostserv/waiting',
      :permission => 'hostserv/set'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'SET',
      :command => 'hostserv/set',
      :permission => 'hostserv/set'
    ),
    Mash.new(
      :service => 'HostServ',
      :name => 'SETALL',
      :command => 'hostserv/setall',
      :permission => 'hostserv/set'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'CANCEL',
      :command => 'memoserv/cancel'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'CHECK',
      :command => 'memoserv/check'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'DEL',
      :command => 'memoserv/del'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'IGNORE',
      :command => 'memoserv/ignore'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'INFO',
      :command => 'memoserv/info'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'LIST',
      :command => 'memoserv/list'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'READ',
      :command => 'memoserv/read'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'RSEND',
      :command => 'memoserv/rsend'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'SEND',
      :command => 'memoserv/send'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'SENDALL',
      :command => 'memoserv/sendall',
      :permission => 'memoserv/sendall'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'SET',
      :command => 'memoserv/set'
    ),
    Mash.new(
      :service => 'MemoServ',
      :name => 'STAFF',
      :command => 'memoserv/staff',
      :permission => 'memoserv/staff'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'HELP',
      :command => 'generic/help'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'ACCESS',
      :command => 'nickserv/access'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'ACCESS',
      :command => 'nickserv/access'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'ACCESS',
      :command => 'nickserv/access'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'AJOIN',
      :command => 'nickserv/ajoin'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'ALIST',
      :command => 'nickserv/alist'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'CERT',
      :command => 'nickserv/cert'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'DROP',
      :command => 'nickserv/drop'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'GETEMAIL',
      :command => 'nickserv/getemail',
      :permission => 'nickserv/getemail',
      :group => 'nickserv/admin'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'GETPASS',
      :command => 'nickserv/getpass',
      :permission => 'nickserv/getpass'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'GLIST',
      :command => 'nickserv/glist'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'GROUP',
      :command => 'nickserv/group'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'UNGROUP',
      :command => 'nickserv/ungroup'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'ID',
      :command => 'nickserv/identify',
      :hide => true
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'IDENTIFY',
      :command => 'nickserv/identify'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'INFO',
      :command => 'nickserv/info'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET HIDE',
      :command => 'nickserv/set/hide'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET HIDE',
      :command => 'nickserv/saset/hide',
      :permission => 'nickserv/saset/hide'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'LIST',
      :command => 'nickserv/list'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET PRIVATE',
      :command => 'nickserv/set/private'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET PRIVATE',
      :command => 'nickserv/saset/private',
      :permission => 'nickserv/saset/private'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'LOGOUT',
      :command => 'nickserv/logout'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'RECOVER',
      :command => 'nickserv/recover'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'CONFIRM',
      :command => 'nickserv/confirm'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'REGISTER',
      :command => 'nickserv/register'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'RESEND',
      :command => 'nickserv/resend'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'RESETPASS',
      :command => 'nickserv/resetpass'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET',
      :command => 'nickserv/set'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET',
      :command => 'nickserv/saset',
      :permission => 'nickserv/saset/',
      :group => 'nickserv/admin'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET AUTOOP',
      :command => 'nickserv/set/autoop'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET AUTOOP',
      :command => 'nickserv/saset/autoop',
      :permission => 'nickserv/saset/autoop'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET DISPLAY',
      :command => 'nickserv/set/display'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET DISPLAY',
      :command => 'nickserv/saset/display',
      :permission => 'nickserv/saset/display'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET EMAIL',
      :command => 'nickserv/set/email'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET EMAIL',
      :command => 'nickserv/saset/email',
      :permission => 'nickserv/saset/email'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET KEEPMODES',
      :command => 'nickserv/set/keepmodes'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET KEEPMODES',
      :command => 'nickserv/saset/keepmodes',
      :permission => 'nickserv/saset/keepmodes'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET KILL',
      :command => 'nickserv/set/kill'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET KILL',
      :command => 'nickserv/saset/kill',
      :permission => 'nickserv/saset/kill'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET LANGUAGE',
      :command => 'nickserv/set/language'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET LANGUAGE',
      :command => 'nickserv/saset/language',
      :permission => 'nickserv/saset/language'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET MESSAGE',
      :command => 'nickserv/set/message'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET MESSAGE',
      :command => 'nickserv/saset/message',
      :permission => 'nickserv/saset/message'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET PASSWORD',
      :command => 'nickserv/set/password'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET PASSWORD',
      :command => 'nickserv/saset/password',
      :permission => 'nickserv/saset/password'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET SECURE',
      :command => 'nickserv/set/secure'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET SECURE',
      :command => 'nickserv/saset/secure',
      :permission => 'nickserv/saset/secure'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET NOEXPIRE',
      :command => 'nickserv/set/noexpire'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET NOEXPIRE',
      :command => 'nickserv/saset/noexpire',
      :permission => 'nickserv/saset/noexpire'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET URL',
      :command => 'nickserv/set/misc',
      :misc_description => 'Associate a URL with your account'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET URL',
      :command => 'nickserv/saset/misc',
      :permission => 'nickserv/saset/url',
      :group => 'nickserv/admin',
      :misc_description => 'Associate a URL with this account'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SET TWITTER',
      :command => 'nickserv/set/misc',
      :misc_description => 'Associate a Twitter account with your account'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SASET TWITTER',
      :command => 'nickserv/saset/misc',
      :permission => 'nickserv/saset/twitter',
      :group => 'nickserv/admin',
      :misc_description => 'Associate a URL with this account'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'STATUS',
      :command => 'nickserv/status'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'SUSPEND',
      :command => 'nickserv/suspend',
      :permission => 'nickserv/suspend',
      :group => 'nickserv/admin'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'UNSUSPEND',
      :command => 'nickserv/unsuspend',
      :permission => 'nickserv/suspend',
      :group => 'nickserv/admin'
    ),
    Mash.new(
      :service => 'NickServ',
      :name => 'UPDATE',
      :command => 'nickserv/update'
    )
  ],
  :fantasy => [
    Mash.new(
      :name => 'ACCESS',
      :command => 'chanserv/access'
    ),
    Mash.new(
      :name => 'AKICK',
      :command => 'chanserv/akick'
    ),
    Mash.new(
      :name => 'AOP',
      :command => 'chanserv/xop'
    ),
    Mash.new(
      :name => 'BAN',
      :command => 'chanserv/ban'
    ),
    Mash.new(
      :name => 'CLONE',
      :command => 'chanserv/clone'
    ),
    Mash.new(
      :name => 'DEHALFOP',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'DEOP',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'DEOWNER',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'DEPROTECT',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'DEVOICE',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'DOWN',
      :command => 'chanserv/down'
    ),
    Mash.new(
      :name => 'ENFORCE',
      :command => 'chanserv/enforce'
    ),
    Mash.new(
      :name => 'ENTRYMSG',
      :command => 'chanserv/entrymsg'
    ),
    Mash.new(
      :name => 'FLAGS',
      :command => 'chanserv/flags'
    ),
    Mash.new(
      :name => 'HALFOP',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'HELP',
      :command => 'generic/help',
      :prepend_channel => false
    ),
    Mash.new(
      :name => 'HOP',
      :command => 'chanserv/xop'
    ),
    Mash.new(
      :name => 'INFO',
      :command => 'chanserv/info',
      :prepend_channel => false
    ),
    Mash.new(
      :name => 'INVITE',
      :command => 'chanserv/invite'
    ),
    Mash.new(
      :name => 'K',
      :command => 'chanserv/kick'
    ),
    Mash.new(
      :name => 'KB',
      :command => 'chanserv/ban'
    ),
    Mash.new(
      :name => 'KICK',
      :command => 'chanserv/kick'
    ),
    Mash.new(
      :name => 'LEVELS',
      :command => 'chanserv/levels'
    ),
    Mash.new(
      :name => 'LIST',
      :command => 'chanserv/list',
      :prepend_channel => false
    ),
    Mash.new(
      :name => 'LOG',
      :command => 'chanserv/log'
    ),
    Mash.new(
      :name => 'MODE',
      :command => 'chanserv/mode'
    ),
    Mash.new(
      :name => 'MUTE',
      :command => 'chanserv/ban',
      :kick => false,
      :mode => 'QUIET'
    ),
    Mash.new(
      :name => 'OP',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'OWNER',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'PROTECT',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'QOP',
      :command => 'chanserv/xop'
    ),
    Mash.new(
      :name => 'SEEN',
      :command => 'chanserv/seen',
      :prepend_channel => false
    ),
    Mash.new(
      :name => 'SOP',
      :command => 'chanserv/xop'
    ),
    Mash.new(
      :name => 'STATUS',
      :command => 'chanserv/status'
    ),
    Mash.new(
      :name => 'SUSPEND',
      :command => 'chanserv/suspend',
      :permission => 'chanserv/suspend'
    ),
    Mash.new(
      :name => 'SYNC',
      :command => 'chanserv/sync'
    ),
    Mash.new(
      :name => 'TOPIC',
      :command => 'chanserv/topic'
    ),
    Mash.new(
      :name => 'UNBAN',
      :command => 'chanserv/unban'
    ),
    Mash.new(
      :name => 'UNSUSPEND',
      :command => 'chanserv/unsuspend',
      :permission => 'chanserv/suspend'
    ),
    Mash.new(
      :name => 'UP',
      :command => 'chanserv/up'
    ),
    Mash.new(
      :name => 'VOICE',
      :command => 'chanserv/modes'
    ),
    Mash.new(
      :name => 'VOP',
      :command => 'chanserv/xop'
    )
  ],
  :networkinfo => {
    :networkname => 'LocalNet',
    :nicklen => 31,
    :userlen => 10,
    :hostlen => 64,
    :chanlen => 32,
    :modelistsize => 100,
    :vhost_chars => "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-",
    :allow_undotted_vhosts => false,
    :disallow_start_or_end => '.-'
  },
  :options => {
    :casemap => 'rfc1459',
    :strictpasswords => true,
    :badpasslimit => 10,
    :badpasstimeout => '1h',
    :updatetimeout => '5m',
    :expiretimeout => '30m',
    :readtimeout => '5s',
    :warningtimeout => '4h',
    :timeoutcheck => '3s',
    :retrywait => '15s',
    :hideprivilegedcommands => true,
    :regexengine => 'regex/pcre'
  },
  :log => {
    :target => 'services.log',
    :bot => 'Global',
    :logage => 7,
    :admin => '*',
    :override => 'chanserv/* nickserv/* memoserv/set ~botserv/set botserv/*',
    :commands => '~operserv/* *',
    :servers => '*',
    :users => 'connect disconnect nick',
    :other => '*',
    :rawio => false,
    :debug => false
  },
  :opertype => [
    Mash.new(
      :name => 'Helper',
      :commands => 'hostserv/*'
    ),
    Mash.new(
      :name => 'Services Operator',
      :inherits => 'Helper',
      :commands => 'chanserv/list chanserv/suspend chanserv/topic memoserv/staff nickserv/list nickserv/suspend operserv/mode operserv/chankill operserv/akill operserv/session operserv/modinfo operserv/sqline operserv/oper operserv/kick operserv/ignore operserv/snline',
      :privs => 'chanserv/auspex chanserv/no-register-limit memoserv/* nickserv/auspex nickserv/confirm'
    ),
    Mash.new(
      :name => 'Services Administrator',
      :inherits => 'Services Operator',
      :commands => 'botserv/* chanserv/access/list chanserv/drop chanserv/getkey chanserv/saset/noexpire memoserv/sendall nickserv/saset/* nickserv/getemail operserv/news operserv/jupe operserv/svs operserv/stats operserv/oline operserv/noop operserv/forbid global/*',
      :privs => '*'
    ),
    Mash.new(
      :name => 'Services Root',
      :commands => '*',
      :privs => '*'
    )
  ],
  :oper => {
    :name => 'root',
    :type => 'Services Root',
    :require_oper => true
  },
  :privilege => [
    Mash.new(
      :name => 'GREET',
      :rank => 40,
      :level => 5,
      :flag => 'g',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'ACCESS_CHANGE',
      :rank => 0,
      :level => 10,
      :flag => 'f',
      :xop => 'SOP'
    ),
    Mash.new(
      :name => 'ACCESS_LIST',
      :rank => 10,
      :level => 3,
      :flag => 'f',
      :xop => 'VOP'
    ),
    Mash.new(
      :name => 'AKICK',
      :rank => 250,
      :level => 10,
      :flag => 'K',
      :xop => 'SOP'
    ),
    Mash.new(
      :name => 'ASSIGN',
      :rank => 270,
      :level => 'founder',
      :flag => 's',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'AUTOHALFOP',
      :rank => 100,
      :level => 4,
      :flag => 'H',
      :xop => 'HOP'
    ),
    Mash.new(
      :name => 'AUTOOP',
      :rank => 210,
      :level => 5,
      :flag => 'O',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'AUTOOWNER',
      :rank => 330,
      :level => 9999,
      :flag => 'Q',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'AUTOPROTECT',
      :rank => 240,
      :level => 10,
      :flag => 'A',
      :xop => 'SOP'
    ),
    Mash.new(
      :name => 'AUTOVOICE',
      :rank => 50,
      :level => 3,
      :flag => 'V',
      :xop => 'VOP'
    ),
    Mash.new(
      :name => 'BAN',
      :rank => 150,
      :level => 4,
      :flag => 'b',
      :xop => 'HOP'
    ),
    Mash.new(
      :name => 'FANTASIA',
      :rank => 30,
      :level => 3,
      :flag => 'c',
      :xop => 'VOP'
    ),
    Mash.new(
      :name => 'FOUNDER',
      :rank => 360,
      :level => 10000,
      :flag => 'F',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'GETKEY',
      :rank => 180,
      :level => 5,
      :flag => 'G',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'HALFOP',
      :rank => 120,
      :level => 5,
      :flag => 'h',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'INFO',
      :rank => 80,
      :level => 9999,
      :flag => 'I',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'INVITE',
      :rank => 190,
      :level => 5,
      :flag => 'i',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'KICK',
      :rank => 130,
      :level => 4,
      :flag => 'k',
      :xop => 'HOP'
    ),
    Mash.new(
      :name => 'MEMO',
      :rank => 280,
      :level => 10,
      :flag => 'm',
      :xop => 'SOP'
    ),
    Mash.new(
      :name => 'MODE',
      :rank => 170,
      :level => 9999,
      :flag => 's',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'NOKICK',
      :rank => 20,
      :level => 1,
      :flag => 'N',
      :xop => 'VOP'
    ),
    Mash.new(
      :name => 'OP',
      :rank => 230,
      :level => 5,
      :flag => 'o',
      :xop => 'SOP'
    ),
    Mash.new(
      :name => 'OPME',
      :rank => 220,
      :level => 5,
      :flag => 'o',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'OWNER',
      :rank => 350,
      :level => 'founder',
      :flag => 'q',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'OWNERME',
      :rank => 340,
      :level => 9999,
      :flag => 'q',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'PROTECT',
      :rank => 310,
      :level => 9999,
      :flag => 'a',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'PROTECTME',
      :rank => 310,
      :level => 9999,
      :flag => 'a',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'SAY',
      :rank => 90,
      :level => 5,
      :flag => 'B',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'SET',
      :rank => 320,
      :level => 9999,
      :flag => 's',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'SIGNKICK',
      :rank => 140,
      :level => 9999,
      :flag => 'K',
      :xop => 'QOP'
    ),
    Mash.new(
      :name => 'TOPIC',
      :rank => 160,
      :level => 5,
      :flag => 't',
      :xop => 'AOP'
    ),
    Mash.new(
      :name => 'UNBAN',
      :rank => 200,
      :level => 4,
      :flag => 'u',
      :xop => 'HOP'
    ),
    Mash.new(
      :name => 'VOICE',
      :rank => 70,
      :level => 4,
      :flag => 'v',
      :xop => 'HOP'
    ),
    Mash.new(
      :name => 'VOICEME',
      :rank => 60,
      :level => 3,
      :flag => 'v',
      :xop => 'VOP'
    )
  ],
  :service => [
    Mash.new(
      :nick => 'Global',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Global Noticer'
    ),
    Mash.new(
      :nick => 'OperServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Operator Service'
    ),
    Mash.new(
      :nick => 'BotServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Bot Service'
    ),
    Mash.new(
      :nick => 'ChanServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Channel Registration Service'
    ),
    Mash.new(
      :nick => 'HostServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'vHost Service'
    ),
    Mash.new(
      :nick => 'MemoServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Memo Service'
    ),
    Mash.new(
      :nick => 'NickServ',
      :user => 'services',
      :host => node.fqdn,
      :gecos => 'Nickname Registration Service'
    )
  ]
)
