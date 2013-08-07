#!/usr/bin/perl -w

# SendToKindle.pm
#
# Send a file to Amazon's personal document service.

# TODO: Make this into a separate package (Amazon::) and upload to CPAN.

package Whisper::SendToKindle;

use strict;
use warnings;
use Data::Dumper;

use Net::SMTP::TLS;
use MIME::Lite;
use File::MimeInfo;
use Log;

# Constructor.
sub new {
	my ($class) = @_;
	my $self = {
		file_name => $_[1],
		address => $_[2],
		smtp_server => $_[3],
		smtp_port => $_[4],
		smtp_user => $_[5],
		smtp_password => $_[6]
	};

	bless $self, $class;
	return $self;
}

# Sends the document.
sub send {
	my ($self, $account, $convert) = @_;

	# Detect the MIME type of the attachment.
	my $mime = mimetype($self->{file_name});
	if (!defined $mime) {
		$mime = File::MimeInfo->default($self->{file_name});
	}

	my $email = new Net::SMTP::TLS(
		$mh,
		Port => $pt,
		User => $un,
		Password => $pw,
		Timeout => 60) or die "Cannot create a TLS mailer instance!\n";

	# Setup and send email.
	my $email = MIME::Lite->new(
        From    => $self->{address},
        To      => $account,
        Subject => "", # TODO: The convert thingy.
        Type    => $mime,
        Path    => $self->{file_name});
	$email->send("smtp", $self->{smtp_server},
				 Port => 587,
				 Auth => "LOGIN",
				 AuthUser => $self->{smtp_user},
				 AuthPass => $self->{smtp_password},
				 Debug => 1);

	# Setup Mail:Sender
	#my $sender = new Mail::Sender({
	#	from => $self->{address}
	#});

	# Start a multipart email.
	#$sender->OpenMultipart({
	#	to => $account,
	#	subject => "",
	#});
	#$sender->Body;
	#$sender->SendLine("");

	# Add an attachment.
	#$sender->SendFile({
	#	description => 'Raw Data File',
	#	encoding => '7BIT',
	#	file => $tempfile,
	#});

	# Clean up the mess.
	#$sender->Close;

	# TODO: Get sent status (Sent or failed) and log.
	# Log the action.
	my $log = new Whisper::Log();
	$log->send($self->{file_name}, $account, $convert, "Testing");
}

1;
