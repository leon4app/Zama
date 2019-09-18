//
//  NSArray+Zama.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <objc/runtime.h>
#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"

#define NSArrayObjectAtIndex if (self.count == 0) {\
\
    NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@] : index %@ beyond bounds for empty NSArray",\
                        [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index)];\
    [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];\
    return nil;\
}\
\
if (index >= self.count) {\
    NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@] : index %@ beyond bounds for array(count: %@)",\
                        [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];\
    [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];\
    return nil;\
}\
\
return XXHookOrgin(index);


#define NSArrayWithObjects NSInteger newObjsIndex = 0;\
id  _Nonnull __unsafe_unretained newObjects[cnt];\
for (int i = 0; i < cnt; i++) {\
\
    id objc = objects[i];\
    if (objc == nil) {\
        NSString *reason = [NSString stringWithFormat:@"*** -[%@ %@]: attempt to insert nil object from objects[%d]",\
                            [self class], NSStringFromSelector(@selector(arrayWithObjects:count:)), i];\
\
        [ZMRecordCollection recordFatalWithReason:reason errorType:ZMProtectTypeContainer];\
        continue;\
    }\
    newObjects[newObjsIndex++] = objc;\
\
}\
return XXHookOrgin(newObjects, newObjsIndex);

/**
 hook @selector(objectAtIndex:)

 @param 
 @param NSArray
 @param ProtectCont
 @param id
 @param objectAtIndex:
 @return safe
 */

XXStaticHookClass(NSArray, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSSingleObjectArrayI, NSArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArrayI, NSArray *, ProtectCont, id, @selector(objectAtIndexedSubscript:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArray0, NSArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

/**
 hook @selector(arrayWithObjects:count:),
 
 @param
 @param NSArray
 @param ProtectCont
 @param id
 @param objectAtIndex:
 @return safe
 */

XXStaticHookPrivateMetaClass(__NSSingleObjectArrayI, NSArray *, ProtectCont, NSArray *,
                             @selector(arrayWithObjects:count:), (const id *)objects, (NSUInteger)cnt) {
    NSArrayWithObjects
}
XXStaticHookEnd

XXStaticHookPrivateMetaClass(__NSArrayI, NSArray *, ProtectCont, NSArray *, @selector(arrayWithObjects:count:),
                             (const id *)objects, (NSUInteger)cnt) {
    NSArrayWithObjects
}
XXStaticHookEnd

XXStaticHookPrivateMetaClass(__NSArray0, NSArray *, ProtectCont, NSArray *, @selector(arrayWithObjects:count:),
                             (const id *)objects, (NSUInteger)cnt) {
    NSArrayWithObjects
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSPlaceholderArray, NSArray *, ProtectCont, NSArray *, @selector(initWithObjects:count:),
                             (const id *)objects, (NSUInteger)cnt) {
    NSArrayWithObjects
}
XXStaticHookEnd
