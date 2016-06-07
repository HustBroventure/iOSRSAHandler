//
//  HBKeyChainWrapper.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import "HBKeyChainWrapper.h"

@implementation HBKeyChainWrapper

+ (NSMutableDictionary*)getKeyChainItemDictionaryWithService:(NSString*)service
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        //要保存的password类型
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    if (service) {
        [dictionary setObject:service forKey:(__bridge id)kSecAttrService];
        [dictionary setObject:service forKey:(__bridge id)kSecAttrAccount];

    }
       return dictionary;
}

+ (BOOL)addData:(id)data forService:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeyChainItemDictionaryWithService:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    OSStatus status= SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    if (status == noErr) {
        return YES;
    }
    return NO;
}
+ (BOOL)updateData:(id)data forService:(NSString *)service
{
    NSMutableDictionary *searchDictionary = [self getKeyChainItemDictionaryWithService:service];
    
    if (!searchDictionary) {
        return NO;
    }
    
    NSMutableDictionary *updateDictionary = [NSMutableDictionary dictionary];
    [updateDictionary setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    OSStatus status = SecItemUpdate((CFDictionaryRef)searchDictionary,
                                    (CFDictionaryRef)updateDictionary);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
+ (BOOL)deleteDataWithService:(NSString *)service
{
    NSMutableDictionary *keyChainDictionary = [self getKeyChainItemDictionaryWithService:service];
    OSStatus status = SecItemDelete((CFDictionaryRef)keyChainDictionary);
    if (status == noErr) {
        return YES;
    }
    return NO;
}
+ (id)queryDataWithService:(NSString *)service
{
    id result;
    NSMutableDictionary *keyChainQuery = [self getKeyChainItemDictionaryWithService:service];
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            result = [NSKeyedUnarchiver  unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"不存在数据");
        }
        @finally {
            
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
    return result;
}
@end
