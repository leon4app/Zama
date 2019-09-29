//
//  NSString+Zama.m
//  Zama
//
//  Created by Leon on 2019/9/24.
//

#import "NSString+Zama.h"
#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

@implementation NSString (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class stringClass = NSClassFromString(@"__NSCFConstantString");

        zamazenta_exchange_instance_method(stringClass, @selector(characterAtIndex:), @selector(zm_characterAtIndex:));

        // Substring
        zamazenta_exchange_instance_method(stringClass, @selector(substringFromIndex:), @selector(zm_substringFromIndex:));
        zamazenta_exchange_instance_method(stringClass, @selector(substringToIndex:), @selector(zm_substringToIndex:));
        zamazenta_exchange_instance_method(stringClass, @selector(substringWithRange:), @selector(zm_substringWithRange:));

        // Replace Occurences
        zamazenta_exchange_instance_method(stringClass, @selector(stringByReplacingOccurrencesOfString:withString:), @selector(zm_stringByReplacingOccurrencesOfString:withString:));
        zamazenta_exchange_instance_method(stringClass, @selector(stringByReplacingOccurrencesOfString:withString:options:range:), @selector(zm_stringByReplacingOccurrencesOfString:withString:options:range:));
// 对于这个方法, 其内部实现是 生成了 NSMutableString 并调用 replaceCharactersInRange:withString 方法, 在开起了 NSMutableString 保护之后, 这边的保护就会失效, 返回的是原字符串, 这与其它的保护操作不符, 故暂时不做保护
//        zamazenta_exchange_instance_method(stringClass, @selector(stringByReplacingCharactersInRange:withString:), @selector(zm_stringByReplacingCharactersInRange:withString:));
    });
}

- (unichar)zm_characterAtIndex:(NSUInteger)index {
    unichar character;
    @try {
        character = [self zm_characterAtIndex:index];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    } @finally {
        return character;
    }
}
#pragma mark - Substring
- (NSString *)zm_substringFromIndex:(NSUInteger)from {
    NSString *subString;
    @try {
        subString = [self zm_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return subString;
    }
}

- (NSString *)zm_substringToIndex:(NSUInteger)to {
    NSString *subString;
    @try {
        subString = [self zm_substringToIndex:to];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return subString;
    }
}

- (NSString *)zm_substringWithRange:(NSRange)range {
    NSString *subString;
    @try {
        subString = [self zm_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return subString;
    }
}

#pragma mark - Replace Occurrences
- (NSString *)zm_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    NSString *newStr;
    @try {
        newStr = [self zm_stringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return newStr;
    }
}

- (NSString *)zm_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    NSString *newStr;
    @try {
        newStr = [self zm_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return newStr;
    }
}

- (NSString *)zm_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    NSString *newStr;
    @try {
        newStr = [self zm_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeString];
    }
    @finally {
        return newStr;
    }
}
@end
