//
//  ZMRecordCollection.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"

@interface ZMExceptionRecord()
@property (readwrite) ZMProtectType type;
@property (nullable, readwrite, copy) NSString *reason;
@property (readwrite, copy) NSArray<NSNumber *> *callStackReturnAddresses;
@property (readwrite, copy) NSArray<NSString *> *callStackSymbols;
@end

@implementation ZMExceptionRecord
- (NSString *)descriptionForType:(ZMProtectType)type {
    switch (type) {
        case ZMProtectTypeUnrecognizedSelector: return @"ZMProtectTypeUnrecognizedSelector";
        case ZMProtectTypeContainer: return @"ZMProtectTypeContainer";
        case ZMProtectTypeNSNull: return @"ZMProtectTypeNSNull";
        case ZMProtectTypeKVO: return @"ZMProtectTypeKVO";
        case ZMProtectTypeNotification: return @"ZMProtectTypeNotification";
        case ZMProtectTypeTimer: return @"ZMProtectTypeTimer";
        case ZMProtectTypeDanglingPointer: return @"ZMProtectTypeDanglingPointer";
        default: return [NSString stringWithFormat:@"%lu", type];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"type: %@, reason: %@\n*** First throw call stack:\n%@", [self descriptionForType:self.type], self.reason, self.callStackSymbols];
}
@end

@implementation ZMRecordCollection

static id<ZMExceptionRecordHandlerProtocol> __record;

+ (void)registerRecordHandler:(id<ZMExceptionRecordHandlerProtocol>)record {
    __record = record;
}

+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(ZMProtectType)type {
    ZMExceptionRecord *record = [ZMExceptionRecord new];
    record.type = type;
    record.reason = reason.length ? reason : @"未知原因";
    record.callStackSymbols = NSThread.callStackSymbols;
    record.callStackReturnAddresses = NSThread.callStackReturnAddresses;
    if ([__record respondsToSelector:@selector(recordException:)]) {
        [__record recordException:record];
    }
}

@end