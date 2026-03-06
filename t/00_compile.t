use v5.42.0;
use Test2::V0 '!subtest';
use Test2::Util::Importer 'Test2::Tools::Subtest' => ( subtest_streamed => { -as => 'subtest' } );
use lib 'lib', '../lib', 'blib/lib', '../blib/lib';
use Protocol::Noise;
#
ok $Protocol::Noise::VERSION, 'Protocol::Noise::VERSION';
#
done_testing;
