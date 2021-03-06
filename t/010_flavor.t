use strict;
use warnings;
use Test::More;
use File::Which;

unless ( which('git') ) {
    plan skip_all => 'A setup flavor "Git" requires "git" command';
}
if ($^O eq 'MSWin32') {
    plan skip_all => 'Git flavor test is skipped in Windows';
}

use Nephia::Setup;
use Capture::Tiny 'capture';
use File::Temp 'tempdir';
use Plack::Test;
use Guard;
use Cwd;

my $pwd = getcwd;

my $dir = tempdir(CLEANUP => 1);
chdir $dir;

my $guard = guard { chdir $pwd };

my $setup = Nephia::Setup->new(
    appname => 'Verdure::Memory',
    flavor  => ['Git'],
);

isa_ok $setup, 'Nephia::Setup::Base';
can_ok $setup, 'create';

subtest create => sub {
    my($out, $err, @res) = capture {
        $setup->create;
    };

    is $err, '', 'setup error';
    chomp(my $expect = join('',(<DATA>)));
    if ($^O eq 'MSWin32') {
        $expect =~ s/\//\\/g;
    }
    like $out, qr/^$expect/, 'setup step';
};

undef($guard);

done_testing;
__DATA__
create path Verdure-Memory
create path Verdure-Memory/lib
create path Verdure-Memory/etc
create path Verdure-Memory/etc/conf
create path Verdure-Memory/view
create path Verdure-Memory/root
create path Verdure-Memory/root/static
create path Verdure-Memory/t
spew into file Verdure-Memory/Changes
spew into file Verdure-Memory/app.psgi
create path Verdure-Memory/lib/Verdure
spew into file Verdure-Memory/lib/Verdure/Memory.pm
spew into file Verdure-Memory/view/index.html
spew into file Verdure-Memory/root/static/style.css
spew into file Verdure-Memory/cpanfile
spew into file Verdure-Memory/t/001_basic.t
spew into file Verdure-Memory/etc/conf/common.pl
spew into file Verdure-Memory/etc/conf/development.pl
spew into file Verdure-Memory/etc/conf/staging.pl
spew into file Verdure-Memory/etc/conf/production.pl
spew into file Verdure-Memory/.gitignore
Initialized empty Git repository in
