//
//  NSMutableArray+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

#pragma mark - Subscript
XXStaticHookPrivateClass(__NSArrayM, NSMutableArray *, ProtectCont, id, @selector(objectAtIndexedSubscript:), (NSUInteger)index) {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]",
                            [self class], NSStringFromSelector(@selector(objectAtIndexedSubscript:)),@(index), @(self.count)];
        NSString *callStackSymbols = [NSThread.callStackSymbols componentsJoinedByString:@"\n"];
        NSLog(@"callStackSymbols: \n%@",callStackSymbols);
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        return nil;
    }
    
    return XXHookOrgin(index);
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArrayM, NSMutableArray *, ProtectCont, void, @selector(setObject:atIndexedSubscript:), (id) obj, (NSUInteger) idx) {
    if (obj) {
        if (idx > self.count) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@] : index %@ beyond bounds [0 .. %@]",
                                [self class], NSStringFromSelector(@selector(setObject:atIndexedSubscript:)) ,@(idx), @(self.count)];
            [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        } else {
            XXHookOrgin(obj, idx);
        }
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object appear nil obj is %@",
                            [self class], NSStringFromSelector(@selector(setObject:atIndexedSubscript:)), obj];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}
XXStaticHookEnd

#pragma mark - Getter
XXStaticHookPrivateClass(__NSArrayM, NSMutableArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: index %@ beyond bounds [0 .. %@]",
                            [self class], NSStringFromSelector(@selector(objectAtIndex:)),@(index), @(self.count)];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
        return nil;
    }

    return XXHookOrgin(index);
}
XXStaticHookEnd

#pragma mark - Setter
XXStaticHookPrivateClass(__NSArrayM, NSMutableArray *, ProtectCont, void, @selector(addObject:), (id)anObject ) {
    if (anObject) {
        XXHookOrgin(anObject);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object cannot be nil",
                            [self class], NSStringFromSelector(@selector(addObject:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArrayM, NSMutableArray *, ProtectCont, void, @selector(insertObject:atIndex:), (id)anObject, (NSUInteger)index) {
    if (anObject) {
        XXHookOrgin(anObject, index);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: object cannot be nil",
                            [self class], NSStringFromSelector(@selector(insertObject:atIndex:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArrayM,NSMutableArray *, ProtectCont, void, @selector(removeObjectAtIndex:), (NSUInteger)index) {
    if (index >= self.count) {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@] : index %@ beyond bounds [0 .. %@]",
                            [self class], NSStringFromSelector(@selector(removeObjectAtIndex:)) ,@(index), @(self.count)];
        
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    } else {
        XXHookOrgin(index);
    }
}
XXStaticHookEnd
