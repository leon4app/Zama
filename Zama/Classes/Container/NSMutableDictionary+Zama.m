//
//  NSMutableDictionary+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

XXStaticHookPrivateClass(__NSDictionaryM, NSMutableDictionary *, ProtectCont, void, @selector(setObject:forKey:), (id)anObject, (id<NSCopying>)aKey ) {
    if (anObject && aKey) {
        XXHookOrgin(anObject,aKey);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: key or value appear nil- key is %@, obj is %@",
                            [self class], NSStringFromSelector(@selector(setObject:forKey:)),aKey, anObject];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
    }
    
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSDictionaryM, NSMutableDictionary *, ProtectCont, void, @selector(setObject:forKeyedSubscript:), (id)anObject, (id<NSCopying>)aKey ) {
    if (anObject && aKey) {
        XXHookOrgin(anObject,aKey);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: key or value appear nil- key is %@, obj is %@",
                            [self class], NSStringFromSelector(@selector(setObject:forKeyedSubscript:)),aKey, anObject];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
    }
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSDictionaryM, NSMutableDictionary *, ProtectCont, void, @selector(removeObjectForKey:), (id<NSCopying>)aKey ) {
    if (aKey) {
        XXHookOrgin(aKey);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: key cannot be nil",
                            [self class], NSStringFromSelector(@selector(setObject:forKey:))];
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
    }
    
}
XXStaticHookEnd
