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
    ZMProtectTypeUnrecognizedSelector = 1 << 1,// Future feature
    ZMProtectTypeContainer = 1 << 2,
    ZMProtectTypeNSNull = 1 << 3,
    ZMProtectTypeKVO = 1 << 4,
    ZMProtectTypeKVC = 1 << 5,
    ZMProtectTypeTimer = 1 << 6,// Future feature
    ZMProtectTypeDanglingPointer = 1 << 7,// Future feature
    ZMProtectTypeString = 1 << 8,
    ZMProtectTypeExceptDanglingPointer = NSUIntegerMax ^ ZMProtectTypeDanglingPointer
};

@interface ZMExceptionRecord : NSObject

@property (readonly) ZMProtectType type;///< 异常类型
@property (readonly, copy) NSExceptionName name;
@property (nullable, readonly, copy) NSDictionary *userInfo;
@property (nullable, readonly, copy) NSString *reason;///< 异常原因
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

