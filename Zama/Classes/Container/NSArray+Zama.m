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

/**
 初始化时插入 nil 会导致崩溃
 数组越界时会导致崩溃
 Can avoid crash method:
 1、@[nil]//这种创建方式其实调用的是2中的方法
 2、arrayWithObjects:count:
 3、objectAtIndex:

 // TODO:
*  4. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 [NSArray alloc] -> _NSPlaceHolderArray 暂不处理
*/

/*
 但是不同的创建数组的方法导致不同的类簇（其实也就是不同的指针），下面我们就看

 NSArray *arr1 = @[@"1",@"2"]; // _NSArrayI

 NSArray *arr1 = @[@"1"]; // __NSSingleObjectArrayI

 NSArray *arr2 = [[NSArray alloc] init]; // _NSArray0
 arr2 = [NSArray array];                 // _NSArray0
 
 NSArray *arr3 = [NSArray alloc]; // _NSPlaceHolderArray

 */
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

#pragma mark - hook @selector(objectAtIndex:)

XXStaticHookPrivateClass(__NSArray0, NSArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSSingleObjectArrayI, NSArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

XXStaticHookPrivateClass(__NSArrayI, NSArray *, ProtectCont, id, @selector(objectAtIndex:), (NSUInteger)index) {
    NSArrayObjectAtIndex
}
XXStaticHookEnd

#pragma mark - hook @selector(objectAtIndexedSubscript:)
XXStaticHookPrivateClass(__NSArrayI, NSArray *, ProtectCont, id, @selector(objectAtIndexedSubscript:), (NSUInteger)index) {
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
