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

#import "NSObject+Zama.h"
@interface Zama ()

@end

@implementation Zama

+ (void)startProtect {
    [self registerStabilityWithAbility:(ZMProtectTypeExceptDanglingPointer)];
}

+ (void)registerStabilityWithAbility:(ZMProtectType)ability {
    if (ability & ZMProtectTypeUnrecognizedSelector) {
        [self protectUnrecognizedSelector];
    }
    if (ability & ZMProtectTypeContainer) {
        [self protectContainer];
    }
    if (ability & ZMProtectTypeNSNull) {
        [self protectNSNull];
    }
    if (ability & ZMProtectTypeKVO) {
        [self protectKVO];
    }
    if (ability & ZMProtectTypeKVC) {
        [self protectKVC];
    }
    if (ability & ZMProtectTypeTimer) {
        [self protectTimer];
    }
    if (ability & ZMProtectTypeString) {
        [self protectString];
    }
}

+ (void)protectNSNull {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNull zmStartProtect];
    });
}

+ (void)protectContainer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSArray zmStartProtect];
        [NSMutableArray zmStartProtect];
        [NSDictionary zmStartProtect];
        [NSMutableDictionary zmStartProtect];
        [NSCache zmStartProtect];
    });
}

+ (void)protectUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
}

+ (void)protectKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}

+ (void)protectKVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject zmStartProtectKVC];
    });
}

+ (void)protectTimer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}

+ (void)protectString {
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
