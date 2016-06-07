//
//  HBKeyChainWrapper.h
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBKeyChainWrapper : NSObject
+ (BOOL)addData:(id)data forService:(NSString *)service;
+ (BOOL)updateData:(id)data forService:(NSString *)service;
+ (BOOL)deleteDataWithService:(NSString *)service;
+ (id)queryDataWithService:(NSString *)service;
@end
