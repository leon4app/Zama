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
#import "NSMutableSet+Zama.h"

#import "NSString+Zama.h"
#import "NSMutableString+Zama.h"

#import "NSObject+Zama.h"

#import "NSObject+ZamaKVO.h"
@interface Zama ()

@end

static ZMProtectType _enabledType = 0;

@implementation Zama

+ (void)startProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeExceptDanglingPointer;
    });
    [self startProtectWithType:(ZMProtectTypeExceptDanglingPointer)];
}

+ (void)startProtectWithType:(ZMProtectType)type {
    if (type & ZMProtectTypeUnrecognizedSelector) {
        [self protectUnrecognizedSelector];
    }
    if (type & ZMProtectTypeContainer) {
        [self protectContainer];
    }
    if (type & ZMProtectTypeNSNull) {
        [self protectNSNull];
    }
    if (type & ZMProtectTypeKVO) {
        [self protectKVO];
    }
    if (type & ZMProtectTypeKVC) {
        [self protectKVC];
    }
    if (type & ZMProtectTypeTimer) {
        [self protectTimer];
    }
    if (type & ZMProtectTypeString) {
        [self protectString];
    }
    if (type & ZMProtectTypeDanglingPointer) {
        [self protectDanglingPointer];
    }
}

+ (ZMProtectType)enabledType {
    return _enabledType;
}

+ (void)protectNSNull {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeNSNull;
        [NSNull zmStartProtect];
    });
}

+ (void)protectContainer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeContainer;
        [NSArray zmStartProtect];
        [NSMutableArray zmStartProtect];
        [NSDictionary zmStartProtect];
        [NSMutableDictionary zmStartProtect];
        [NSCache zmStartProtect];
        [NSMutableSet zmStartProtect];
    });
}

+ (void)protectUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeUnrecognizedSelector;
    });
}

+ (void)protectKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeKVO;
        [NSObject zmStartProtectKVO];
    });
}

+ (void)protectKVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeKVC;
        [NSObject zmStartProtectKVC];
    });
}

+ (void)protectTimer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeTimer;
    });
}

+ (void)protectString {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeString;
        [NSString zmStartProtect];
        [NSMutableString zmStartProtect];
    });
}

+ (void)protectDanglingPointer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enabledType = _enabledType | ZMProtectTypeDanglingPointer;
    });
}

+ (void)registerRecordHandler:(nonnull id<ZMExceptionRecordHandlerProtocol>)handler {
    [ZMRecordCollection registerRecordHandler:handler];
}

+ (void)unregisterRecordHandler:(id<ZMExceptionRecordHandlerProtocol>)handler {
    [ZMRecordCollection unregisterRecordHandler:handler];
}
@end
