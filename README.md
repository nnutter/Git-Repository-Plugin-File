# NAME

Git::Repository::Plugin::File - Add a file() method to Git::Repository

# VERSION

version 0.002

# SYNOPSIS

    use Git::Repository qw(File);

    my $repo = Git::Repository->new();
    my $file = $repo->file('lib', 'Git', 'Repository', 'Plugin', 'File.pm');

# DESCRIPTION

Adds a `file` method to the Git::Repository object
that returns a [Git::Repository::File](https://metacpan.org/pod/Git::Repository::File) object.

# METHODS

[Git::Repository::Plugin::File](https://metacpan.org/pod/Git::Repository::Plugin::File) adds the
following method:

## file(<dir1>, <dir2>, ..., <file>)

Returns a [Git::Repository::File](https://metacpan.org/pod/Git::Repository::File) object which behavies
like a [Path::Class::File](https://metacpan.org/pod/Path::Class::File) with a few additional methods;

# SEE ALSO

[Git::Repository](https://metacpan.org/pod/Git::Repository),
[Git::Repository::File](https://metacpan.org/pod/Git::Repository::File),
[Path::Class::File](https://metacpan.org/pod/Path::Class::File)

# AUTHOR

Nathaniel G. Nutter <nnutter@cpan.org>

# COPYRIGHT

Copyright 2013 - Nathaniel G. Nutter

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
