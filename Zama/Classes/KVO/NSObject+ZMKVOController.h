/**
  Copyright (c) 2014-present, Facebook, Inc.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree. An additional grant
  of patent rights can be found in the PATENTS file in the same directory.

  2019-10-10
  https://github.com/facebook/KVOController
 */

#import <Foundation/Foundation.h>

#import "ZMKVOController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Category that adds built-in `KVOController` and `KVOControllerNonRetaining` on any instance of `NSObject`.

 This makes it convenient to simply create and forget a `ZMKVOController`, 
 and when this object gets dealloc'd, so will the associated controller and the observation info.
 */
@interface NSObject (ZMKVOController)

/**
 @abstract Lazy-loaded ZMKVOController for use with any object
 @return ZMKVOController associated with this object, creating one if necessary
 @discussion This makes it convenient to simply create and forget a ZMKVOController, and when this object gets dealloc'd, so will the associated controller and the observation info.
 */
@property (nonatomic, strong) ZMKVOController *zm_KVOController;

/**
 @abstract Lazy-loaded ZMKVOController for use with any object
 @return ZMKVOController associated with this object, creating one if necessary
 @discussion This makes it convenient to simply create and forget a ZMKVOController.
 Use this version when a strong reference between controller and observed object would create a retain cycle.
 When not retaining observed objects, special care must be taken to remove observation info prior to deallocation of the observed object.
 */
@property (nonatomic, strong) ZMKVOController *zm_KVOControllerNonRetaining;

@end

NS_ASSUME_NONNULL_END
