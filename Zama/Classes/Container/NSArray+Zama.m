//
//  NSArray+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"

/*
 不同的创建数组的方法导致不同的类簇:

 NSArray *arr1 = @[@"1",@"2"]; // _NSArrayI

 NSArray *arr1 = @[@"1"]; // __NSSingleObjectArrayI

 NSArray *arr2 = [[NSArray alloc] init]; // _NSArray0
 arr2 = [NSArray array];                 // _NSArray0
 
 NSArray *arr3 = [NSArray alloc]; // _NSPlaceHolderArray

 */

@implementation NSArray (Zama)

+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //=================
        //   class method
        //=================

        zamazenta_exchange_class_method([self class], @selector(arrayWithObjects:count:), @selector(zm_arrayWithObjects:count:));

        //====================
        //   instance method
        //====================

        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");

        zamazenta_exchange_instance_method(__NSPlaceholderArray, @selector(initWithObjects:count:), @selector(zm_NSPlaceholderArray_initWithObjects:count:));

        //objectAtIndex:
        zamazenta_exchange_instance_method(__NSArrayI, @selector(objectAtIndex:), @selector(zm_NSArrayI_objectAtIndex:));
        zamazenta_exchange_instance_method(__NSSingleObjectArrayI, @selector(objectAtIndex:), @selector(zm_NSSingleObjectArrayI_objectAtIndex:));
        zamazenta_exchange_instance_method(__NSArray0, @selector(objectAtIndex:), @selector(zm_NSArray0_objectAtIndex:));

        //objectAtIndexedSubscript:
        zamazenta_exchange_instance_method(__NSArrayI, @selector(objectAtIndexedSubscript:), @selector(zm_NSArrayI_objectAtIndexedSubscript:));

        //objectsAtIndexes:
        zamazenta_exchange_instance_method(__NSArray, @selector(objectsAtIndexes:), @selector(zm_objectsAtIndexes:));

        zamazenta_exchange_instance_method([self class], @selector(subarrayWithRange:), @selector(zm_subarrayWithRange:));
    });
}

- (instancetype)zm_NSPlaceholderArray_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    NSInteger newObjsIndex = 0;
    id _Nonnull __unsafe_unretained newObjects[cnt];
    for (int i = 0; i < cnt; i++) {
        id objc = objects[i];
        if (objc == nil) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: attempt to insert nil object from objects[%d]", [self class], NSStringFromSelector(@selector(arrayWithObjects:count:)), i];
            [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
            continue;
        }
        newObjects[newObjsIndex++] = objc;
    }
    return [self zm_NSPlaceholderArray_initWithObjects:newObjects count:newObjsIndex];
}

#pragma mark - hook @selector(arrayWithObjects:)
+ (instancetype)zm_arrayWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    NSInteger newObjsIndex = 0;
    id _Nonnull __unsafe_unretained newObjects[cnt];
    for (int i = 0; i < cnt; i++) {
        id objc = objects[i];
        if (objc == nil) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: attempt to insert nil object from objects[%d]", [self class], NSStringFromSelector(@selector(arrayWithObjects:count:)), i];
            [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
            continue;
        }
        newObjects[newObjsIndex++] = objc;
    }
    return [self zm_arrayWithObjects:newObjects count:newObjsIndex];
}

#pragma mark - hook @selector(objectAtIndex:)
- (id)zm_NSArray0_objectAtIndex:(NSUInteger)index {
    NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds for empty NSArray", [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index)];
    [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
    return nil;
}

- (id)zm_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
        return nil;
    }

    return [self zm_NSSingleObjectArrayI_objectAtIndex:index];
}

- (id)zm_NSArrayI_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
        return nil;
    }

    return [self zm_NSArrayI_objectAtIndex:index];
}

#pragma mark - hook @selector(objectAtIndexedSubscript:)
- (id)zm_NSArrayI_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectAtIndexedSubscript:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
        return nil;
    }

    return [self zm_NSArrayI_objectAtIndexedSubscript:index];
}

#pragma mark - hook @selector(objectsAtIndexes:)
- (NSArray *)zm_objectsAtIndexes:(NSIndexSet *)indexes {
    NSUInteger index = indexes.firstIndex;
    while (index != NSNotFound) {
        if (index >= self.count) {
            NSString *reason;
            if (self.count == 0) {
                reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds for empty NSArray", [self class], NSStringFromSelector(@selector(objectsAtIndexes:)), @(index)];
            } else {
                reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ in index set beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectsAtIndexes:)), @(index), @(self.count)];
            }
            [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
            return @[];
        }
        index = [indexes indexGreaterThanIndex:index];
    }
    return [self zm_objectsAtIndexes:indexes];
}

- (NSArray *)zm_subarrayWithRange:(NSRange)range {
    NSArray *subArray;
    @try {
        subArray = [self zm_subarrayWithRange:range];
    } @catch (NSException *exception) {
        [ZMRecordCollection recordFatalWithException:exception errorType:ZMProtectTypeContainer];
    } @finally {
        return subArray;
    }
}
@end
