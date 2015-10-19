//
//  ViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/17.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "ViewController.h"
#import "HBRSAHandler.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.pem" ofType:nil];
    
    NSString *privateKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key.pem" ofType:nil];
    
    HBRSAHandler* handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
    [handler importKeyWithType:KeyTypePrivate andPath:privateKeyFilePath];
    
    NSString* sig = [handler signString:@"wangfeng"];
    NSString* sigMd5 = [handler signMD5String:@"wangfeng"];
    NSLog(@"%@      %@",sig,sigMd5);
    
    BOOL isMatch = [handler verifyString:@"wangfeng" withSign:sig];
    BOOL isMatchMd5 = [handler verifyMD5String:@"wangfeng" withSign:sigMd5];
    
    NSLog(@"%d      %d",isMatch,isMatchMd5);

    NSString* enString = [handler encryptByRsa:@"wangfeng" withKeyType:KeyTypePublic];
    NSString* deString = [handler decryptByRsa:enString withKeyType:KeyTypePrivate];
    NSLog(@"%@",deString);
    

    
    
}



@end
