//
//  NSDictionary+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMRecordCollection.h"
#import "ZMSwizzling.h"

XXStaticHookMetaClass(NSDictionary, ProtectCont, NSDictionary *, @selector(dictionaryWithObjects:forKeys:count:),
                      (const id *) objects, (const id<NSCopying> *) keys, (NSUInteger)cnt) {
    NSUInteger index = 0;
    id  _Nonnull __unsafe_unretained newObjects[cnt];
    id  _Nonnull __unsafe_unretained newkeys[cnt];
    for (int i = 0; i < cnt; i++) {
        id tmpItem = objects[i];
        id tmpKey = keys[i];
        if (tmpItem == nil || tmpKey == nil) {
            NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: attempt to insert nil object from objects[%d]",
                                [self class], NSStringFromSelector(@selector(dictionaryWithObjects:forKeys:count:)), i];
            [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];
            continue;
        }
        newObjects[index] = objects[i];
        newkeys[index] = keys[i];
        index++;
    }
    
    return XXHookOrgin(newObjects, newkeys,index);
}
XXStaticHookEnd

