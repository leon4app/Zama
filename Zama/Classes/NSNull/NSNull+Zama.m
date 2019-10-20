//
//  NSNull+Zama.m
//  Zama
//
//  Created by Leon on 09/19/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"

@implementation NSNull (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_exchange_instance_method([self class], @selector(methodSignatureForSelector:), @selector(zm_methodSignatureForSelector:));
        zamazenta_exchange_instance_method([self class], @selector(forwardInvocation:), @selector(zm_forwardInvocation:));
    });
}
// https://github.com/nicklockwood/NullSafe
- (NSMethodSignature *)zm_methodSignatureForSelector:(SEL)selector {
    NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: unrecognized selector sent to instance %p", [self class], NSStringFromSelector(selector), self];
    [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeNSNull)];
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];

    if (!signature) {
        for (Class someClass in @[
                 [NSMutableArray class],
                 [NSMutableDictionary class],
                 [NSMutableString class],
                 [NSNumber class],
                 [NSDate class],
                 [NSData class]
             ]) {
            @try {
                if ([someClass instancesRespondToSelector:selector]) {
                    signature = [someClass instanceMethodSignatureForSelector:selector];
                    break;
                }
            }
            @catch (__unused NSException *unused) {}
        }
    }
    return signature;
}

- (void)zm_forwardInvocation:(NSInvocation *)invocation {
    invocation.target = nil;
    [invocation invoke];
}

@end
