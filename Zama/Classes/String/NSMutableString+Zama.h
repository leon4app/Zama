//
//  NSMutableString+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/24.
//

#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
*  Can avoid crash method
*
*  1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了
*  2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
*  3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc
*  4. - (void)deleteCharactersInRange:(NSRange)range
*
 @note 当发生异常时, 不会继续替换
*/

@interface NSMutableString (Zama)

@end

NS_ASSUME_NONNULL_END
