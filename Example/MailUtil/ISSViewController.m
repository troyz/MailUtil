//
//  ISSViewController.m
//  MailUtil
//
//  Created by Troy Zhang on 09/22/2016.
//  Copyright (c) 2016 Troy Zhang. All rights reserved.
//

#import "ISSViewController.h"
#import "MailUtil.h"

@interface ISSViewController ()

@end

@implementation ISSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // please correct it.
    [SendEmailOperation setupConfigWithServer:@"smtp.163.com" withFrom:@"java-koma@163.com" withLogin:@"java-koma@163.com" withPassword:@"**********"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"我的附件.html" ofType:nil];
//    path = nil;
    [SendEmailOperation sendEmail:[[SendEmailOperation alloc] initWithTo:@"java-koma@163.com" subject:@"你好" body:@"你好" path:path]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
