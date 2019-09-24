//
//  NSCache+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"
@implementation NSCache (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_exchange_instance_method([self class], @selector(setObject:forKey:), @selector(zm_setObject:forKey:));
        zamazenta_exchange_instance_method([self class], @selector(setObject:forKey:cost:), @selector(zm_setObject:forKey:cost:));
    });
}

- (void)zm_setObject:(id)obj forKey:(id)key {
    @try {
        [self zm_setObject:obj forKey:key];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}

- (void)zm_setObject:(id)obj forKey:(id)key cost:(NSUInteger)cost {
    @try {
        [self zm_setObject:obj forKey:key cost:cost];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}
@end
