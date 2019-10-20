//
//  NSMutableSet+Zama.m
//  Zama
//
//  Created by Leon on 2019/10/14.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

@implementation NSMutableSet (Zama)
+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class setMClass = NSClassFromString(@"__NSSetM");
        zamazenta_exchange_instance_method(setMClass, @selector(addObject:), @selector(zm_addObject:));
        zamazenta_exchange_instance_method(setMClass, @selector(removeObject:), @selector(zm_removeObject:));
    });
}

- (void)zm_addObject:(id)object {
    @try {
        [self zm_addObject:object];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}

- (void)zm_removeObject:(id)object {
    @try {
        [self zm_removeObject:object];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    }
}
@end
