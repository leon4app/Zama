//
//  NSObject+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/30.
//

#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"
/**
 Can avoid crash method:
 - setValue:ForKey:
 - setValue:ForKeyPath:
 - setValuesForKeysWithDictionary:
 - valueForKey:

 @note 对于转发流程, 当key/keyPath 不正确时,会转而调用 `setValue:forUndefinedKey:` / `valueForUndefinedKey:`, 如果实现了这个方法,消息转发就到此结束, 意味着开发者已经自行处理了异常. 若开发者并未实现`setValue:forUndefinedKey:` / `valueForUndefinedKey:`, 则会抛出"NSUnknownKeyException", 并被 Zama 捕获.
*/
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Zama)

+ (void)zmStartProtectKVC;

@end

NS_ASSUME_NONNULL_END
