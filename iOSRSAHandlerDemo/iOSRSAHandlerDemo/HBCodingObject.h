//
//  HBCodingObject.h
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCodingObject : NSObject<NSCoding>

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* passwd;
@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, assign) NSInteger  counts;
@property (nonatomic, strong) NSArray* dataArray;
@property (nonatomic, strong) NSDictionary* dataDic;






@end
