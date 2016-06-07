//
//  HBCodingObject.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import "HBCodingObject.h"
#import <objc/runtime.h>
@implementation HBCodingObject

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.passwd = [aDecoder decodeObjectForKey:@"passwd"];
    self.isAdmin = [aDecoder decodeBoolForKey:@"isAdmin"];
    self.counts = [aDecoder decodeIntegerForKey:@"counts"];
    self.dataDic = [aDecoder decodeObjectForKey:@"dataDic"];
    self.dataArray = [aDecoder decodeObjectForKey:@"dataArray"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.passwd forKey:@"passwd"];
    [aCoder encodeBool:self.isAdmin forKey:@"isAdmin"];
    [aCoder encodeInteger:self.counts forKey:@"counts"];
    [aCoder encodeObject:self.dataArray forKey:@"dataArray"];
    [aCoder encodeObject:self.dataDic forKey:@"dataDic"];
}

-(NSString *)description
{
    NSMutableString* text = [NSMutableString stringWithFormat:@"\n<%@> \n", [self class]];
    NSArray* properties = [self filterPropertys];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* key = (NSString*)obj;
        id value = [self valueForKey:key];
        NSString* valueDescription = (value)?[value description]:@"(null)";
        
        if ( ![value respondsToSelector:@selector(count)] && [valueDescription length]>60  ) {
            valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:59]];
        }
        valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n   "];
        [text appendFormat:@"   [%@]: %@\n", key, valueDescription];
    }];
    [text appendFormat:@"</%@>", [self class]];;
    return text;
    
}
#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
            //        NSLog(@"name:%s",property_getName(property));
            //        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}
@end
