use strict;
use warnings;

use Test::More;

use Git::Repository qw(File Test);
use Git::Repository::File;
use Path::Class qw();

# blacklist some methods because they require more nuanced testing
my @methods = grep {
    $_ ne 'opena'
    && $_ ne 'openr'
    && $_ ne 'openw'
    && $_ ne 'touch'
} Git::Repository::File::wrapped_methods();
plan tests => scalar(@methods);


for my $method (@methods) {
    subtest $method => sub {
        plan tests => 3;

        my $repo = Git::Repository->new_tmp_repo();

        my $gr_file = $repo->file($method);
        my $pc_file = Path::Class::file($repo->work_tree, $method);

        set_up($method, $pc_file);
        my @args = args($method, $pc_file);

        my $gr_result = $gr_file->$method(@args);
        my $pc_result = $pc_file->$method(@args);

        my $equivalent_types = (
            ref($gr_result) eq 'Git::Repository::File' && ref($pc_result) eq 'Path::Class::File'
            || ref($gr_result) eq ref($pc_result)
        );
        ok($equivalent_types, "types are equivalent in scalar context");

        is($gr_result, $pc_result, "value matched in scalar context");

        my @gr_results = $gr_file->$method(@args);
        my @pc_results = $pc_file->$method(@args);
        is_deeply(\@gr_results, \@pc_results, "values matched in list context");
    };
}

sub set_up {
    my ($method_name, $pc_file) = @_;

    if (grep { $method_name eq $_ } qw(copy_to resolve)) {
        $pc_file->touch;
    } elsif ($method_name eq 'slurp') {
        $pc_file->openw->say('hello');
    }
}

sub args {
    my ($method_name, $pc_file) = @_;

    if (grep { $method_name eq $_ } qw(copy_to move_to)) {
        return $pc_file->absolute . '_' . $method_name;
    } elsif ($method_name eq 'spew') {
        return 'hello';
    }

    return;
}
