# MailUtil

[![CI Status](http://img.shields.io/travis/Troy Zhang/MailUtil.svg?style=flat)](https://travis-ci.org/Troy Zhang/MailUtil)
[![Version](https://img.shields.io/cocoapods/v/MailUtil.svg?style=flat)](http://cocoapods.org/pods/MailUtil)
[![License](https://img.shields.io/cocoapods/l/MailUtil.svg?style=flat)](http://cocoapods.org/pods/MailUtil)
[![Platform](https://img.shields.io/cocoapods/p/MailUtil.svg?style=flat)](http://cocoapods.org/pods/MailUtil)

## Introduction
As you known, [`skpsmtpmessage`](https://github.com/jetseven/skpsmtpmessage) could not send email in concurrent order. `MailUtil` is a tool that wrap `skpsmtpmessage` to send emails in serial order. Thanks for the article [Sending Mails in Serial Order using GCD](http://stackoverflow.com/questions/25426392/sending-mails-in-serial-order-using-gcd).

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
`iOS7+`

## Installation

MailUtil is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MailUtil", :git => 'https://github.com/troyz/MailUtil.git', :tag => '0.1.0'
```

## Useage
``` oc
// please correct it.
[SendEmailOperation setupConfigWithServer:@"smtp.163.com" withFrom:@"java-koma@163.com" withLogin:@"java-koma@163.com" withPassword:@"**********"];

// the attachment file path
NSString *path = [[NSBundle mainBundle] pathForResource:@"ticket@2x.png" ofType:nil];

// a message that will be sent
SendEmailOperation *operation = [[SendEmailOperation alloc] initWithTo:@"java-koma@163.com" subject:@"Hello" body:@"World" path:path];

// send the message
[SendEmailOperation sendEmail:operation];
```

## Author

Troy Zhang, java.koma@gmail.com

## License

MailUtil is available under the MIT license. See the LICENSE file for more info.
