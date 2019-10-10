/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "NSObject+ZMKVOController.h"

#import <objc/message.h>

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Convert your project to ARC or specify the -fobjc-arc flag.
#endif

#pragma mark NSObject Category -

NS_ASSUME_NONNULL_BEGIN

static void *NSObjectZMKVOControllerKey = &NSObjectZMKVOControllerKey;
static void *NSObjectZMKVOControllerNonRetainingKey = &NSObjectZMKVOControllerNonRetainingKey;

@implementation NSObject (ZMKVOController)

- (ZMKVOController *)zm_KVOController
{
  id controller = objc_getAssociatedObject(self, NSObjectZMKVOControllerKey);
  
  // lazily create the KVOController
  if (nil == controller) {
    controller = [ZMKVOController controllerWithObserver:self];
    self.zm_KVOController = controller;
  }
  
  return controller;
}

- (void)setZm_KVOController:(ZMKVOController *)KVOController
{
  objc_setAssociatedObject(self, NSObjectZMKVOControllerKey, KVOController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZMKVOController *)zm_KVOControllerNonRetaining
{
  id controller = objc_getAssociatedObject(self, NSObjectZMKVOControllerNonRetainingKey);
  
  if (nil == controller) {
    controller = [[ZMKVOController alloc] initWithObserver:self retainObserved:NO];
    self.zm_KVOControllerNonRetaining = controller;
  }
  
  return controller;
}

- (void)setZm_KVOControllerNonRetaining:(ZMKVOController *)KVOControllerNonRetaining
{
  objc_setAssociatedObject(self, NSObjectZMKVOControllerNonRetainingKey, KVOControllerNonRetaining, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


NS_ASSUME_NONNULL_END
