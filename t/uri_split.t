use Test2;
use Test2::Bundle::Extended;
use URI::Split qw();
use URI::Fast qw(uri_split);

my @uris = (
  '/foo/bar/baz',
  'file:///foo/bar/baz',
  'http://www.test.com',
  'http://www.test.com?foo=bar',
  'http://www.test.com#bar',
  'http://www.test.com/some/path',
  'https://test.com/some/path?aaaa=bbbb&cccc=dddd&eeee=ffff',
  'https://user:pwd@192.168.0.1:8000/foo/bar?baz=bat&slack=fnord&asdf=the+quick%20brown+fox+%26+hound#foofrag',
  'https://user:pwd@www.test.com:8000/foo/bar?baz=bat&slack=fnord&asdf=the+quick%20brown+fox+%26+hound#foofrag',
);

# From URI::Split's test suite
subtest 'equivalence' => sub{
  is [uri_split('p')],           [U, U, 'p', U, U],          'p';
  is [uri_split('p?q')],         [U, U, 'p', 'q', U],        'p?q';
  is [uri_split('p?q/#f/?')],    [U, U, 'p', 'q/', 'f/?'],   'p?q/#f/?';
  is [uri_split('s://a/p?q#f')], ['s', 'a', '/p', 'q', 'f'], 's://a/p?q#f';
};

# Ensure identical output to URI::Split
subtest 'parity' => sub{
  foreach my $uri (@uris) {
    my $orig = [URI::Split::uri_split($uri)];
    my $xs   = [uri_split($uri)];
    is $xs, $orig, $uri, {orig => $orig, xs => $xs};
  }
};

done_testing;