//
//  NSDictionary+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

@implementation NSDictionary (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_exchange_class_method(self, @selector(dictionaryWithObjects:forKeys:count:), @selector(zm_dictionaryWithObjects:forKeys:count:));

        zamazenta_exchange_instance_method([self class], @selector(initWithObjects:forKeys:), @selector(zm_initWithObjects:forKeys:));
    });
}
#warning [__NSPlaceholderDictionary initWithObjects:forKeys:]
- (instancetype)zm_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys {
    NSDictionary *dict;
    @try {
        dict = [self zm_initWithObjects:objects forKeys:keys];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    } @finally {
        return dict;
    }
}

+ (instancetype)zm_dictionaryWithObjects:(id _Nonnull const[])objects forKeys:(id<NSCopying> _Nonnull const[])keys count:(NSUInteger)cnt {
    NSUInteger index = 0;
    id _Nonnull __unsafe_unretained newObjects[cnt];
    id _Nonnull __unsafe_unretained newkeys[cnt];
    for (int i = 0; i < cnt; i++) {
        id tmpItem = objects[i];
        id tmpKey = keys[i];
        if (tmpItem == nil || tmpKey == nil) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: attempt to insert nil object from objects[%d]", [self class], NSStringFromSelector(@selector(dictionaryWithObjects:forKeys:count:)), i];
            [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
            continue;
        }
        newObjects[index] = objects[i];
        newkeys[index] = keys[i];
        index++;
    }

    return [self zm_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
}

@end
