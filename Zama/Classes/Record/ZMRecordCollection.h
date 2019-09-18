//
//  ZMRecordCollection.h
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <Zama/Zama.h>

@interface ZMRecordCollection : NSObject

/**
 注册异常日志处理者
 */
+ (void)registerRecordHandler:(nullable id<ZMExceptionRecordHandlerProtocol>)record;

/**
 汇报Crash

 @param reason Sting 原因
 */
+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(ZMProtectType)type;

@end
