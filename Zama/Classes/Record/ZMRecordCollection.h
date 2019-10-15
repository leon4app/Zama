//
//  ZMRecordCollection.h
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <Zama/Zama.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMRecordCollection : NSObject

/**
 注册异常日志处理者
 */
+ (void)registerRecordHandler:(nullable id<ZMExceptionRecordHandlerProtocol>)recordHandler;
+ (void)unregisterRecordHandler:(nullable id<ZMExceptionRecordHandlerProtocol>)recordHandler;
/**
汇报Crash

@param exception 捕获到的异常
*/
+ (void)recordFatalWithException:(NSException *)exception errorType:(ZMProtectType)type;

/**
 汇报Crash

 @param reason Sting 原因
 */
+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(ZMProtectType)type;

@end

NS_ASSUME_NONNULL_END
