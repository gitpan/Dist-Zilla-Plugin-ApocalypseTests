#
# This file is part of Dist-Zilla-Plugin-ApocalypseTests
#
# This software is copyright (c) 2011 by Apocalypse.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use strict; use warnings;
package Dist::Zilla::Plugin::ApocalypseTests;
BEGIN {
  $Dist::Zilla::Plugin::ApocalypseTests::VERSION = '1.001';
}
BEGIN {
  $Dist::Zilla::Plugin::ApocalypseTests::AUTHORITY = 'cpan:APOCAL';
}

# ABSTRACT: Creates the Test::Apocalypse testfile for Dist::Zilla

use Moose 1.03;

extends 'Dist::Zilla::Plugin::InlineFiles' => { -version => '2.101170' };
with 'Dist::Zilla::Role::FileMunger' => { -version => '2.101170' };

# TODO how do I fix this in pod-weaver? I think it's the __DATA__ section that screws it up?
# Perl::Critic found these violations in "blib/lib/Dist/Zilla/Plugin/ApocalypseTests.pm":
# [Documentation::RequirePodAtEnd] POD before __END__ at line 69, column 1.  (Severity: 1)
## no critic ( RequirePodAtEnd )


has allow => (
	is => 'ro',
	isa => 'Str',
	predicate => '_has_allow',
);


has deny => (
	is => 'ro',
	isa => 'Str',
	predicate => '_has_deny',
);

sub munge_file {
	my ($self, $file) = @_;

	return unless $file->name eq 't/apocalypse.t';

	# replace strings in the file
	my $content = $file->content;
	my( $allow, $deny );
	if ( $self->_has_allow ) {
		$allow = "allow => '" . $self->allow . "',\n";
	} else {
		$allow = '';
	}
	$content =~ s/ALLOW/$allow/;

	if ( $self->_has_deny ) {
		$deny = "deny => '" . $self->deny . "',\n";
	} else {
		$deny = '';
	}
	$content =~ s/DENY/$deny/;

	$file->content( $content );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;




=pod

=for Pod::Coverage munge_file

=for stopwords dist

=head1 NAME

Dist::Zilla::Plugin::ApocalypseTests - Creates the Test::Apocalypse testfile for Dist::Zilla

=head1 VERSION

  This document describes v1.001 of Dist::Zilla::Plugin::ApocalypseTests - released March 05, 2011 as part of Dist-Zilla-Plugin-ApocalypseTests.

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing
the following files:

=over 4

=item * t/apocalypse.t - Runs the dist through Test::Apocalypse

For more information on what the test does, please look at L<Test::Apocalypse>.

	# In your dist.ini:
	[ApocalypseTests]

=back

=head1 ATTRIBUTES

=head2 allow

This option will be passed directly to L<Test::Apocalypse> to control which sub-tests you want to run.

The default is nothing.

=head2 deny

This option will be passed directly to L<Test::Apocalypse> to control which sub-tests you want to run.

The default is nothing.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Dist::Zilla|Dist::Zilla>

=item *

L<Test::Apocalypse|Test::Apocalypse>

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Dist::Zilla::Plugin::ApocalypseTests

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

L<http://search.cpan.org/dist/Dist-Zilla-Plugin-ApocalypseTests>

=item *

RT: CPAN's Bug Tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Plugin-ApocalypseTests>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dist-Zilla-Plugin-ApocalypseTests>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/Dist-Zilla-Plugin-ApocalypseTests>

=item *

CPAN Forum

L<http://cpanforum.com/dist/Dist-Zilla-Plugin-ApocalypseTests>

=item *

CPANTS Kwalitee

L<http://cpants.perl.org/dist/overview/Dist-Zilla-Plugin-ApocalypseTests>

=item *

CPAN Testers Results

L<http://cpantesters.org/distro/D/Dist-Zilla-Plugin-ApocalypseTests.html>

=item *

CPAN Testers Matrix

L<http://matrix.cpantesters.org/?dist=Dist-Zilla-Plugin-ApocalypseTests>

=back

=head2 Email

You can email the author of this module at C<APOCAL at cpan.org> asking for help with any problems you have.

=head2 Internet Relay Chat

You can get live help by using IRC ( Internet Relay Chat ). If you don't know what IRC is,
please read this excellent guide: L<http://en.wikipedia.org/wiki/Internet_Relay_Chat>. Please
be courteous and patient when talking to us, as we might be busy or sleeping! You can join
those networks/channels and get help:

=over 4

=item *

irc.perl.org

You can connect to the server at 'irc.perl.org' and join this channel: #perl-help then talk to this person for help: Apocalypse.

=item *

irc.freenode.net

You can connect to the server at 'irc.freenode.net' and join this channel: #perl then talk to this person for help: Apocal.

=item *

irc.efnet.org

You can connect to the server at 'irc.efnet.org' and join this channel: #perl then talk to this person for help: Ap0cal.

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-dist-zilla-plugin-apocalypsetests at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-Plugin-ApocalypseTests>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<http://github.com/apocalypse/perl-dist-zilla-plugin-apocalypsetests>

  git clone git://github.com/apocalypse/perl-dist-zilla-plugin-apocalypsetests.git

=head1 AUTHOR

Apocalypse <APOCAL@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Apocalypse.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

The full text of the license can be found in the LICENSE file included with this distribution.

=cut


__DATA__
___[ t/apocalypse.t ]___
#!perl
use strict; use warnings;

use Test::More;
eval "use Test::Apocalypse 1.000";
if ( $@ ) {
	plan skip_all => 'Test::Apocalypse required for validating the distribution';
} else {
	# hack for Kwalitee ( zany require format so DZP::AutoPrereq will not pick it up )
	require 'Test/NoWarnings.pm'; require 'Test/Pod.pm'; require 'Test/Pod/Coverage.pm';

	is_apocalypse_here( {
		ALLOWDENY
	} );
}
