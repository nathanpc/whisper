#!/usr/bin/perl -w

# SendToKindle.pm
#
# Send a file to Amazon's personal document service.

# TODO: Make this into a separate package (Amazon::) and upload to CPAN.

package Whisper::SendToKindle;

use strict;
use warnings;

use Net::SMTP::TLS;
use MIME::Lite;
use File::MimeInfo;

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
	$account = "$account\@kindle.com";

	# Detect the MIME type of the attachment.
	my $mime = mimetype($self->{file_name});
	if (!defined $mime) {
		$mime = File::MimeInfo->default($self->{file_name});
	}

	# Setup Net::SMTP.
	my $email = new Net::SMTP::TLS(
		$self->{smtp_server},
		Port => $self->{smtp_port},
		User => $self->{smtp_user},
		Password => $self->{smtp_password},
		Timeout => 60);
	$email->mail($self->{address});
	$email->to($account);
	$email->data();

	# Prepare the email subject.
	my $subject = "";
	if ($convert) {
		$subject = "convert";
	}

	# Setup MIME::Lite.
	my $msg = MIME::Lite->new(
        From    => $self->{address},
        To      => $account,
        Subject => $subject,
        Type    => "application/octet-stream",
        Path    => $self->{file_name});

	# Send email.
	$email->datasend($msg->as_string);
	$email->dataend();
	$email->quit();
}

1;
