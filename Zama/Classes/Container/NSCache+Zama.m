//
//  NSCache+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"

XXStaticHookClass(NSCache, ProtectCont, void, @selector(setObject:forKey:), (id)obj, (id)key) {
    if (obj && key) {
        XXHookOrgin(obj,key);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: key or value appear nil- key is %@, obj is %@",
                            [self class], NSStringFromSelector(@selector(setObject:forKey:)),key, obj];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}
XXStaticHookEnd

XXStaticHookClass(NSCache, ProtectCont, void, @selector(setObject:forKey:cost:), (id)obj, (id)key, (NSUInteger)g) {
    if (obj && key) {
        XXHookOrgin(obj,key,g);
    } else {
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: key or value appear nil- key is %@, obj is %@",
                            [self class], NSStringFromSelector(@selector(setObject:forKey:cost:)), key, obj];
        [ZMRecordCollection recordFatalWithReason:reason errorType:(ZMProtectTypeContainer)];
    }
}
XXStaticHookEnd

