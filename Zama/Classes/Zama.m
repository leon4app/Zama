//
//  Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "Zama.h"
#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"
#import "ZamaProtectProtocol.h"

#import "NSNull+Zama.h"

#import "NSArray+Zama.h"
#import "NSMutableArray+Zama.h"

#import "NSString+Zama.h"
@interface Zama ()

@end

@implementation Zama

+ (void)startProtect {
    [self registerStabilityWithAbility:(ZMProtectTypeExceptDanglingPointer)];
}

+ (void)registerStabilityWithAbility:(ZMProtectType)ability {
    if (ability & ZMProtectTypeUnrecognizedSelector) {
        [self registerUnrecognizedSelector];
    }
    if (ability & ZMProtectTypeContainer) {
        [self registerContainer];
    }
    if (ability & ZMProtectTypeNSNull) {
        [self registerNSNull];
    }
    if (ability & ZMProtectTypeKVO) {
        [self registerKVO];
    }
    if (ability & ZMProtectTypeNotification) {
        [self registerNotification];
    }
    if (ability & ZMProtectTypeTimer) {
        [self registerTimer];
    }
    if (ability & ZMProtectTypeNSString) {
        [self registerNSString];
    }
}

+ (void)registerNSNull {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNull zmStartProtect];
    });
}

+ (void)registerContainer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_hook_load_group(XXForOCString(ProtectCont));
        [NSArray zmStartProtect];
        [NSMutableArray zmStartProtect];
    });
}

+ (void)registerUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_hook_load_group(XXForOCString(ProtectFW));
    });
}

+ (void)registerKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_hook_load_group(XXForOCString(ProtectKVO));
    });
}

+ (void)registerNotification {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BOOL ABOVE_IOS8  = (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO);
        if (!ABOVE_IOS8) {
            zamazenta_hook_load_group(XXForOCString(ProtectNoti));
        }
    });
}

+ (void)registerTimer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_hook_load_group(XXForOCString(ProtectTimer));
    });
}

+ (void)registerNSString {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSString zmStartProtect];
    });
}

+ (void)registerRecordHandler:(nonnull id<ZMExceptionRecordHandlerProtocol>)handler { 
    [ZMRecordCollection registerRecordHandler:handler];
}

@end
