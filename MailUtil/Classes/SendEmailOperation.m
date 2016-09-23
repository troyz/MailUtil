//
//  SendEmailOperation.m
//  CrashLogTest
//
//  Created by xdzhangm on 16/9/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "SendEmailOperation.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

#define DEFAULT_MAIL_SERVER     @"smtp.163.com"
#define DEFAULT_FROM_EMAIL      @"java-koma@163.com"
#define DEFAULT_USER_LOGIN      @"java-koma@163.com"
#define DEFAULT_USER_PWD        @"**********"           // please correct it

static NSString *globalMailServer;
static NSString *globalFromEmail;
static NSString *globalLogin;
static NSString *globalPassword;

@interface SendEmailOperation () <SKPSMTPMessageDelegate>
{
    NSString *mailServer;
    NSString *fromEmail;
    NSString *login;
    NSString *password;
}
@end

@implementation SendEmailOperation
+ (void)load
{
    [self setupDefaultConfig];
}

+ (void)setupDefaultConfig
{
    globalMailServer = DEFAULT_MAIL_SERVER;
    globalFromEmail = DEFAULT_FROM_EMAIL;
    globalLogin = DEFAULT_USER_LOGIN;
    globalPassword = DEFAULT_USER_PWD;
}

+ (void)setupConfigWithServer:(NSString *)server
                     withFrom:(NSString *)from
                    withLogin:(NSString *)login
                 withPassword:(NSString *)password
{
    globalMailServer = server;
    globalFromEmail = from;
    globalLogin = login;
    globalPassword = password;
}

+ (NSOperationQueue *)sharedMailQueue
{
    static NSOperationQueue *_mailQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mailQueue = [NSOperationQueue mainQueue];//[[NSOperationQueue alloc] init];
        _mailQueue.maxConcurrentOperationCount = 1;
    });
    return _mailQueue;
}

+ (void)sendEmail:(SendEmailOperation *)operation
{
    if(operation)
    {
        [[self sharedMailQueue] addOperation:operation];
    }
}

- (instancetype)initWithTo:(NSString *)to
                   subject:(NSString *)subject
                      body:(NSString *)body
{
    return [self initWithTo:to subject:subject body:body path:nil];
}

- (instancetype)initWithTo:(NSString *)to subject:(NSString *)subject body:(NSString *)body path:(NSString *)path
{
    self = [super init];
    if (self)
    {
        self.mailServer = globalMailServer;
        self.fromEmail = globalFromEmail;
        self.login = globalLogin;
        self.password = globalPassword;
        
        self.to = to;
        self.subject = subject;
        self.body = body;
        self.path = path;
    }
    return self;
}

- (void)main
{
    SKPSMTPMessage *message = [self createMessage]; // configure your message like you are now
    message.delegate = self;
    [message send];
}

- (SKPSMTPMessage *)createMessage
{
    if([self.password isEqualToString:DEFAULT_USER_PWD])
    {
        NSLog(@"#############Please check if your mail password is correct!!!#############");
    }
    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = self.fromEmail;
    testMsg.toEmail = self.to;
    testMsg.relayHost = self.mailServer;
    testMsg.requiresAuth = YES;
    testMsg.login = self.login;
    testMsg.pass = self.password;
    
    testMsg.subject = _subject;
    testMsg.wantsSecure = YES;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               _body,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(self.path && [fileManager fileExistsAtPath:self.path])
    {
        NSString *fileName = [self.path lastPathComponent];
        
        NSData *vcfData = [NSData dataWithContentsOfFile:self.path];
        
        NSString *contentType = [NSString stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"%@\"", fileName];
        NSString *attachment = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"%@\"", fileName];
        
        NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:contentType,kSKPSMTPPartContentTypeKey,
                                 attachment,kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
        
        testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
        
        [fileManager removeItemAtPath:self.path error:nil];
    }
    else
    {
        testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    }
    return testMsg;
}

#pragma mark - SKPSMTPMessageDelegate

-(void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"mail sent");
    [self completeOperation];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"send mail error: %s: %@", __PRETTY_FUNCTION__, error);
    if([self.password isEqualToString:DEFAULT_USER_PWD])
    {
        NSLog(@"#############Please check if your mail password is correct!!!#############");
    }
    [self completeOperation];
}

@end
