//
//  NSNull+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/20.
//
#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

/*
 向 NSNull 的实例发送任何消息都会导致 unrecognized selector 崩溃.
 保护方案: 将消息转发给 nil

 */
@interface NSNull (Zama)<ZamaProtectProtocol>

@end
