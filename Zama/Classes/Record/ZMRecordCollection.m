//
//  ZMRecordCollection.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"

@interface ZMExceptionRecord ()
@property (readwrite) ZMProtectType type;
@property (nullable, readwrite, copy) NSString *reason;
@property (readwrite, copy) NSExceptionName name;
@property (nullable, readwrite, copy) NSDictionary *userInfo;
@property (readwrite, copy) NSArray<NSNumber *> *callStackReturnAddresses;
@property (readwrite, copy) NSArray<NSString *> *callStackSymbols;
@end

@implementation ZMExceptionRecord
- (NSString *)typeDescription {
    switch (self.type) {
        case ZMProtectTypeUnrecognizedSelector: return @"ZMProtectTypeUnrecognizedSelector";
        case ZMProtectTypeContainer: return @"ZMProtectTypeContainer";
        case ZMProtectTypeNSNull: return @"ZMProtectTypeNSNull";
        case ZMProtectTypeKVO: return @"ZMProtectTypeKVO";
        case ZMProtectTypeKVC: return @"ZMProtectTypeKVC";
        case ZMProtectTypeTimer: return @"ZMProtectTypeTimer";
        case ZMProtectTypeDanglingPointer: return @"ZMProtectTypeDanglingPointer";
        case ZMProtectTypeString: return @"ZMProtectTypeString";
        case ZMProtectTypeExceptDanglingPointer: return [NSString stringWithFormat:@"%lu", (unsigned long)self.type];
        //        default: return [NSString stringWithFormat:@"%lu", (unsigned long)self.type];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"type: %@, reason: %@\n*** First throw call stack:\n%@", self.typeDescription, self.reason, self.callStackSymbols];
}
@end

@implementation ZMRecordCollection

__weak static id<ZMExceptionRecordHandlerProtocol> __recordHandler;

+ (void)registerRecordHandler:(id<ZMExceptionRecordHandlerProtocol>)recordHandler {
    __recordHandler = recordHandler;
}
+ (void)unregisterRecordHandler:(id<ZMExceptionRecordHandlerProtocol>)recordHandler {
    if ([__recordHandler isEqual:recordHandler]) {
        __recordHandler = nil;
    }
}

+ (void)recordFatalWithException:(NSException *)exception errorType:(ZMProtectType)type {
    ZMExceptionRecord *record = [ZMExceptionRecord new];
    record.type = type;
    record.reason = exception.reason.length ? exception.reason : @"未知原因";
    record.name = exception.name;
    record.userInfo = exception.userInfo;
    record.callStackSymbols = exception.callStackSymbols;
    record.callStackReturnAddresses = exception.callStackReturnAddresses;
    if ([__recordHandler respondsToSelector:@selector(recordException:)]) {
        [__recordHandler recordException:record];
    }
}

+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(ZMProtectType)type {
    ZMExceptionRecord *record = [ZMExceptionRecord new];
    record.type = type;
    record.name = @"";
    record.reason = reason.length ? reason : @"未知原因";
    record.callStackSymbols = NSThread.callStackSymbols;
    record.callStackReturnAddresses = NSThread.callStackReturnAddresses;
    if ([__recordHandler respondsToSelector:@selector(recordException:)]) {
        [__recordHandler recordException:record];
    }
}

@end
