//
//  ZMSwizzling.m
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#include "ZMSwizzling.h"
#import <objc/runtime.h>
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>

BOOL defaultSwizzlingOCMethod(Class self, SEL origSel_, SEL altSel_) {
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
    
}

void* zamazenta_hook_imp_function(Class clazz,
                               SEL   sel,
                               void  *newFunction) {
    Method oldMethod = class_getInstanceMethod(clazz, sel);
    BOOL succeed = class_addMethod(clazz,
                                   sel,
                                   (IMP)newFunction,
                                   method_getTypeEncoding(oldMethod));
    if (succeed) {
        return nil;
    } else {
        return method_setImplementation(oldMethod, (IMP)newFunction);
    }
}

BOOL zamazenta_hook_check_block(Class objectClass, Class hookClass,void* associatedKey) {
    while (objectClass && objectClass != hookClass) {
        if (objc_getAssociatedObject(objectClass, associatedKey)) {
            return NO;
        }
        objectClass = class_getSuperclass(objectClass);
    }
    return YES;
}

Class zamazenta_hook_getClassFromObject(id object) {
    // 如果不是class
    if (!object_isClass(object)) {
        return object_getClass(object);
    } else {
        return object;
    }
}

#ifndef __LP64__

#define mach_header_ mach_header

#else

#define mach_header_ mach_header_64

#endif

void zamazenta_hook_load_group(NSString *groupName) {
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count ; i ++) {
        const struct mach_header_* header = (void*)_dyld_get_image_header(i);
        NSString *string = [NSString stringWithFormat:@"__sh%@",groupName];
        unsigned long size = 0;
        uint8_t *data = getsectiondata(header, "__DATA", [string UTF8String],&size);
        if (data && size > 0) {
            void **pointers = (void**)data;
            uint32_t count = (uint32_t)(size / sizeof(void*));
            for (uint32_t i = 0 ; i < count ; i ++) {
                void(*pointer)(void) = pointers[i];
                pointer();
            }
            break;
        }
    }
}
