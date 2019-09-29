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
#import "NSDictionary+Zama.h"
#import "NSMutableDictionary+Zama.h"
#import "NSCache+Zama.h"

#import "NSString+Zama.h"
#import "NSMutableString+Zama.h"
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
    if (ability & ZMProtectTypeTimer) {
        [self registerTimer];
    }
    if (ability & ZMProtectTypeString) {
        // 保护方式存疑,暂不开启
        [self registerString];
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
        [NSArray zmStartProtect];
        [NSMutableArray zmStartProtect];
        [NSDictionary zmStartProtect];
        [NSMutableDictionary zmStartProtect];
        [NSCache zmStartProtect];
    });
}

+ (void)registerUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
}

+ (void)registerKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}

+ (void)registerTimer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}

+ (void)registerString {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSString zmStartProtect];
        [NSMutableString zmStartProtect];
    });
}

+ (void)registerRecordHandler:(nonnull id<ZMExceptionRecordHandlerProtocol>)handler { 
    [ZMRecordCollection registerRecordHandler:handler];
}

@end
