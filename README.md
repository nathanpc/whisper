# Whisper

A simple and awesome utility written in Perl to send documents to a Kindle.


## Setup

Before you start using **Whisper** you have to rename the `config_template.yml` to `config.yml` and edit the required fields to setup your email.


## Main features

These are the main features **Whisper** provides:

  - Command-line interface for daily usage
  - Web interface for sending documents remotely
  - Multiple accounts


## "Sent to Kindle" module

For this project I wrote [Amazon::SendToKindle](http://search.cpan.org/~nathanpc/Amazon-SendToKindle-0.2/lib/Amazon/SendToKindle.pm), so if you want to add the "Send to Kindle" functionality to your project too, you can.


## Requiremets

Special thanks to these awesome projects for making **Whisper** possible:

  - [SQLite](http://www.sqlite.org)
  - [Net::SMTP::TLS](http://search.cpan.org/~awestholm/Net-SMTP-TLS-0.12/lib/Net/SMTP/TLS.pm)
  - [MIME::Lite](http://search.cpan.org/~rjbs/MIME-Lite-3.029/lib/MIME/Lite.pm)
  - [File::MimeInfo](http://search.cpan.org/~michielb/File-MimeInfo-0.17/lib/File/MimeInfo.pm)
  - [Try::Tiny](http://search.cpan.org/~doy/Try-Tiny-0.16/lib/Try/Tiny.pm)
  - [Amazon::SendToKindle](http://search.cpan.org/~nathanpc/Amazon-SendToKindle-0.2/lib/Amazon/SendToKindle.pm)
