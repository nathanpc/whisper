#!/usr/bin/perl -w

# whisper.pl
#
# A simple and awesome utility to send documents to a Kindle.

package Whisper;

use strict;
use warnings;
use Data::Dumper;

use Getopt::Long;
use YAML::Tiny;
use Try::Tiny;

use Log;
use Amazon::SendToKindle;

# Prints the help message.
sub HelpMessage {
	print "whisper [options] file\n";
}

# Prints the version message.
sub VersionMessage {
	print "Whisper v0.1\n";
}

# Setup Getopt.
my ($convert, $account, $file);
GetOptions("convert|c" => \$convert,
		   "account|a=s" => \$account,
		   "file|f=s" => \$file);

# Read the config fie.
my $config = YAML::Tiny->new();
$config = YAML::Tiny->read("config.yml");
my $email = $config->[0]->{email};

# Setup the Kindle and send.
my $kindle = Amazon::SendToKindle->new(
	$file,
	$email->{address},
	$email->{smtp_server},
	$email->{port},
	$email->{username},
	$email->{password});

# Setup logging.
my $log = new Whisper::Log();

# Send the document.
try {
	$kindle->send($account, $convert);

	# Log the action.
	$log->send($file, $account, $convert, "Sent");
} catch {
	# Log the error.
	$log->send($file, $account, $convert, "Failed");
	print "There was an error while trying to send the document: $_";
};
