//
//  NSMutableString+Zama.m
//  Zama
//
//  Created by Leon on 2019/9/24.
//

#import "NSMutableString+Zama.h"
#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

@implementation NSMutableString (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class stringClass = NSClassFromString(@"__NSCFString");
        zamazenta_exchange_instance_method(stringClass, @selector(replaceCharactersInRange:withString:), @selector(zm_replaceCharactersInRange:withString:));

        zamazenta_exchange_instance_method(stringClass, @selector(insertString:atIndex:), @selector(zm_insertString:atIndex:));

        zamazenta_exchange_instance_method(stringClass, @selector(deleteCharactersInRange:), @selector(zm_deleteCharactersInRange:));
    });
}

- (void)zm_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    @try {
        [self zm_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
}

- (void)zm_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    @try {
        [self zm_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
}

- (void)zm_deleteCharactersInRange:(NSRange)range {
    @try {
        [self zm_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
}

@end
