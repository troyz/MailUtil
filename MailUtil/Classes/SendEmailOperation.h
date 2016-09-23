//
//  SendEmailOperation.h
//  CrashLogTest
//
//  Created by xdzhangm on 16/9/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConcurrentOperation.h"

@interface SendEmailOperation : ConcurrentOperation
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *path;

// 是否在邮件发送成功后删除path对应的文件，默认为NO
@property (nonatomic, assign) BOOL deleteFileOnCompleted;

// 如果没有设置，则用全局的。
@property (nonatomic, copy) NSString *mailServer;
@property (nonatomic, copy) NSString *fromEmail;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *password;

# pragma mark 初始化配置信息
+ (void)setupDefaultConfig;

+ (void)setupConfigWithServer:(NSString *)server
                     withFrom:(NSString *)from
                    withLogin:(NSString *)login
                 withPassword:(NSString *)password;

# pragma mark 发送邮件
+ (void)sendEmail:(SendEmailOperation *)operation;

# pragma mark init
- (instancetype)initWithTo:(NSString *)to
                   subject:(NSString *)subject
                      body:(NSString *)body;
- (instancetype)initWithTo:(NSString *)to
                   subject:(NSString *)subject
                      body:(NSString *)body
                      path:(NSString *)path;
- (instancetype)initWithTo:(NSString *)to
                   subject:(NSString *)subject
                      body:(NSString *)body
                      path:(NSString *)path
     deleteFileOnCompleted:(BOOL)del;
@end
