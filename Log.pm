#!/usr/bin/perl -w

# Log.pm
#
# Talk to the database.

package Whisper::Log;

use strict;
use warnings;
use Data::Dumper;

# Constructor.
sub new {
	my ($class) = @_;
	my $self = {};

	bless $self, $class;
	return $self;
}

# Sends the document.
sub send {
	my ($self, $file, $account, $convert, $status) = @_;
	# TODO: Get time.
	# TODO: Log to db.
}

1;
