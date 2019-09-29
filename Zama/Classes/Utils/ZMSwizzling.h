//
//  ZMSwizzling.h
//  Zama
//
//  Created by Leon on 09/17/2019.
//  Copyright (c) 2019 Zama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// 私有 请不要手动调用
void * zamazenta_hook_imp_function(Class clazz, SEL sel, void  *newFunction);

BOOL zamazenta_hook_check_block(Class objectClass, Class hookClass,void* associatedKey);

Class zamazenta_hook_getClassFromObject(id object);

void zamazenta_exchange_class_method(Class anClass, SEL orginalMethodSel, SEL newMethodSel);
void zamazenta_exchange_instance_method(Class anClass, SEL orginalMethodSel, SEL newMethodSel);
