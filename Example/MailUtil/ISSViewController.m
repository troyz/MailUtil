//
//  ISSViewController.m
//  MailUtil
//
//  Created by Troy Zhang on 09/22/2016.
//  Copyright (c) 2016 Troy Zhang. All rights reserved.
//

#import "ISSViewController.h"
#import "MailUtil.h"

#define CRASH_FOLDER                            [NSString stringWithFormat:@"%@/crash", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]]

@interface ISSViewController ()

@end

@implementation ISSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:CRASH_FOLDER])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:CRASH_FOLDER withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSDictionary *dict = @{@"userName": @"Troy Zhang", @"age": @(20)};
    
    NSString *path = [CRASH_FOLDER stringByAppendingPathComponent:@"user.txt"];
    [dict writeToFile:path atomically:YES];
    
    // please correct it.
    [SendEmailOperation setupConfigWithServer:@"smtp.163.com" withFrom:@"java-koma@163.com" withLogin:@"java-koma@163.com" withPassword:@"**********"];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"我的附件.html" ofType:nil];
//    path = nil;
    SendEmailOperation *operation = [[SendEmailOperation alloc] initWithTo:@"java-koma@163.com" subject:@"你好" body:@"你好" path:path];
    operation.attachmentUseAsMailContent = YES;
    operation.deleteFileOnCompleted = YES;
    [SendEmailOperation sendEmail:operation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
