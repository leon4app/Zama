//
//  Zama.h
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, ZMProtectType) {
    ZMProtectTypeUnrecognizedSelector = 1 << 1,
    ZMProtectTypeContainer = 1 << 2,
    ZMProtectTypeNSNull = 1 << 3,
    ZMProtectTypeKVO = 1 << 4,
    ZMProtectTypeNotification = 1 << 5,
    ZMProtectTypeTimer = 1 << 6,
    ZMProtectTypeDanglingPointer = 1 << 7,
    ZMProtectTypeString = 1 << 8,
    ZMProtectTypeExceptDanglingPointer = (ZMProtectTypeUnrecognizedSelector | ZMProtectTypeContainer |
                                          ZMProtectTypeNSNull| ZMProtectTypeKVO |
                                          ZMProtectTypeNotification | ZMProtectTypeTimer | ZMProtectTypeString)
};

@interface ZMExceptionRecord : NSObject
/// 异常类型
@property (readonly) ZMProtectType type;
/// 异常原因
@property (nullable, readonly, copy) NSString *reason;
@property (readonly, copy) NSArray<NSNumber *> *callStackReturnAddresses;
@property (readonly, copy) NSArray<NSString *> *callStackSymbols;
@end

@protocol ZMExceptionRecordHandlerProtocol <NSObject>

- (void)recordException:(ZMExceptionRecord *)record;

@end

@interface Zama : NSObject

/**
 注册异常日志处理者
 
 @param handler 异常日志处理者
 */
+ (void)registerRecordHandler:(id<ZMExceptionRecordHandlerProtocol>)handler;

+ (void)startProtect;

@end

NS_ASSUME_NONNULL_END

