//
//  NSObject+ZamaKVO.h
//  Zama
//
//  Created by Leon on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/*
 Can avoid crash method:
 - 被观察者 dealloc 未移除监听
 - 移除监听次数 > 添加监听次数

 重复添加观察者并不会 crash, 但是容易出现添加移除次数不一致, 这会导致 crash
 */
@interface NSObject (ZamaKVO)
+ (void)zmStartProtectKVO;




// 供 ZMKVOController 调用的原始方法.
- (void)zm_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)zm_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
@end

NS_ASSUME_NONNULL_END
