//
//  NSMutableArray+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"
@implementation NSMutableArray (Zama)
+ (void)zmStartProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class arrayMClass = NSClassFromString(@"__NSArrayM");

        //objectAtIndex: iOS 9-10
        zamazenta_exchange_instance_method(arrayMClass, @selector(objectAtIndex:), @selector(zm_objectAtIndex:));

        //objectAtIndexedSubscript: iOS 11+
        zamazenta_exchange_instance_method(arrayMClass, @selector(objectAtIndexedSubscript:), @selector(zm_objectAtIndexedSubscript:));

        //insertObject:atIndex:
        zamazenta_exchange_instance_method(arrayMClass, @selector(insertObject:atIndex:), @selector(zm_insertObject:atIndex:));

        //addObject:
        zamazenta_exchange_instance_method(arrayMClass, @selector(addObject:), @selector(zm_addObject:));

        //setObject:atIndexedSubscript:
        zamazenta_exchange_instance_method(arrayMClass, @selector(setObject:atIndexedSubscript:), @selector(zm_setObject:atIndexedSubscript:));

        //removeObjectAtIndex:
        zamazenta_exchange_instance_method(arrayMClass, @selector(removeObjectAtIndex:), @selector(zm_removeObjectAtIndex:));
    });
}

- (id)zm_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        return nil;
    }
    return [self zm_objectAtIndex:index];
}

- (id)zm_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(objectAtIndexedSubscript:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        return nil;
    }
    return [self zm_objectAtIndexedSubscript:index];
}

- (void)zm_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        [self zm_insertObject:anObject atIndex:index];
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object cannot be nil", [self class], NSStringFromSelector(@selector(insertObject:atIndex:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}

- (void)zm_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj) {
        if (idx > self.count) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(setObject:atIndexedSubscript:)), @(idx), @(self.count)];
            [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        } else {
            return [self zm_setObject:obj atIndexedSubscript:idx];
        }
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object appear nil", [self class], NSStringFromSelector(@selector(setObject:atIndexedSubscript:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}

- (void)zm_addObject:(id)anObject {
    if (anObject) {
        [self zm_addObject:anObject];
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object cannot be nil", [self class], NSStringFromSelector(@selector(addObject:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}

- (void)zm_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@] : index %@ beyond bounds [0 .. %@]", [self class], NSStringFromSelector(@selector(removeObjectAtIndex:)), @(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    } else {
        [self zm_removeObjectAtIndex:index];
    }
}
@end
