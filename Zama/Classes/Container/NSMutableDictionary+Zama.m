//
//  NSMutableDictionary+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

@implementation NSMutableDictionary (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryClass = NSClassFromString(@"__NSDictionaryM");
        zamazenta_exchange_instance_method(dictionaryClass, @selector(setObject:forKey:), @selector(zm_setObject:forKey:));
        zamazenta_exchange_instance_method(dictionaryClass, @selector(setObject:forKeyedSubscript:), @selector(zm_setObject:forKeyedSubscript:));

        zamazenta_exchange_instance_method(dictionaryClass, @selector(removeObjectForKey:), @selector(zm_removeObjectForKey:));
    });
}

- (void)zm_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self zm_setObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}

- (void)zm_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self zm_setObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}

- (void)zm_removeObjectForKey:(id)aKey {
    @try {
        [self zm_removeObjectForKey:aKey];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}
@end
