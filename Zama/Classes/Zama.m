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

#import "NSObject+ZamaKVO.h"
@interface Zama ()

@end

@implementation Zama

+ (void)startProtect {
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
        [NSObject zmStartProtectKVO];
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
