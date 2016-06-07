//
//  NSData+AES256.h
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
