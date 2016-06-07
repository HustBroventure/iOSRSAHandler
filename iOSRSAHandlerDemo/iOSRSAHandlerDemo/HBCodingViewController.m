//
//  HBCodingViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import "HBCodingViewController.h"
#import "HBCodingObject.h"
#import "NSData+AES256.h"
@interface HBCodingViewController ()

@end

@implementation HBCodingViewController
#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HBCodingObject* obj = [HBCodingObject new];
    obj.name = @"wangfeng";
    obj.passwd = @"123456";
    obj.isAdmin = YES;
    obj.counts = 10011;
    obj.dataArray = @[@"v1",@"v2"];
    obj.dataDic = @{@"k1":@"v1",@"k2":@"v2"};
    
   NSData*data =  [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSLog(@"%@",data);
    
    NSData* enData = [data aes256_encrypt:@"123456"];
    NSData* deData = [enData aes256_decrypt:@"123456"];
    
    
    HBCodingObject* codingObj = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    NSLog(@"%@",codingObj);
    
    NSData* stringData = [@"wangfeng" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* enData1 = [stringData aes256_encrypt:@"123456"];
    NSData* deData1 = [enData1 aes256_decrypt:@"123456"];
    NSString* result = [[NSString alloc]initWithData:deData1 encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - public methords

#pragma mark - private-tools methords
- (void)initData
{
    
}

#pragma mark - event methords

#pragma mark - delegate methords

#pragma mark - property-setter-getter


@end
