//
//  NSObject+ZamaKVO.m
//  Zama
//
//  Created by Leon on 2019/10/9.
//

#import "ZMSwizzling.h"
#import "ZMRecordCollection.h"
#import "NSObject+ZMKVOController.h"

@implementation NSObject (ZamaKVO)
+ (void)zmStartProtectKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zamazenta_exchange_instance_method([self class], @selector(addObserver:forKeyPath:options:context:), @selector(zm_addObserver:forKeyPath:options:context:));
        zamazenta_exchange_instance_method([self class], @selector(removeObserver:forKeyPath:), @selector(zm_removeObserver:forKeyPath:));
    });
}

- (void)zm_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    [observer.zm_KVOController observe:self keyPath:keyPath options:options context:context];
}

- (void)zm_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [observer.zm_KVOController unobserve:self keyPath:keyPath];
}

@end
