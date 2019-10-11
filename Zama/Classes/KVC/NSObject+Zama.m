//
//  NSObject+Zama.m
//  Zama
//
//  Created by Leon on 2019/9/30.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"

@implementation NSObject (Zama)
+ (void)zmStartProtectKVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_exchange_instance_method([self class], @selector(valueForKey:), @selector(zm_valueForKey:));
        zamazenta_exchange_instance_method([self class], @selector(setValue:forKey:), @selector(zm_setValue:forKey:));
        zamazenta_exchange_instance_method([self class], @selector(setValue:forKeyPath:), @selector(zm_setValue:forKeyPath:));
        zamazenta_exchange_instance_method([self class], @selector(setValuesForKeysWithDictionary:), @selector(zm_setValuesForKeysWithDictionary:));
    });
}

- (id)zm_valueForKey:(NSString *)key {
    id value = nil;
    @try {
        value = [self zm_valueForKey:key];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeKVC];
    } @finally {
        return value;
    }
}

- (void)zm_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self zm_setValue:value forKey:key];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeKVC];
    }
}

- (void)zm_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self zm_setValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeKVC];
    }
}

- (void)zm_setValuesForKeysWithDictionary:(NSDictionary *)dict {
    @try {
        [self zm_setValuesForKeysWithDictionary:dict];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeKVC];
    }
}
@end
