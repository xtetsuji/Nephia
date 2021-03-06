use strict;
use warnings;
use utf8;
use Test::More;

use Nephia::Core;
pass 'Nephia::Core loaded';

can_ok __PACKAGE__, qw/
   get post put del path 
   req res param path_param nip 
   run config app 
   nephia_plugins base_dir 
   cookie set_cookie
/;

is Nephia::Core::_normalize_plugin_name('Hoge'), 'Nephia::Plugin::Hoge';
is Nephia::Core::_normalize_plugin_name('+Piyo::Piyo'), 'Piyo::Piyo';

done_testing;
