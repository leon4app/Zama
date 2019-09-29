//
//  NSString+Zama.h
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
*  1. - (unichar)characterAtIndex:(NSUInteger)index
*  2. - (NSString *)substringFromIndex:(NSUInteger)from
*  3. - (NSString *)substringToIndex:(NSUInteger)to {
*  4. - (NSString *)substringWithRange:(NSRange)range {
*  5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
*  6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange


 //TODO:
*  7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement 对于这个方法, 其内部实现是 生成了 NSMutableString 并调用 replaceCharactersInRange:withString 方法, 在开起了 NSMutableString 保护之后, 这边的保护就会失效, 返回的是原字符串, 这与其它的保护操作不符, 故暂时不做保护
*
 @note 当发生异常时的默认值, 这里返回的是nil
 @note 关于是否要把越界情况转换为截取到安全边界, 我认为不宜如此操作, Zama 应该只做保守操作, 不过未来也许可以做成可配置项目
 //TODO: 实现默认操作可配置
*/
@interface NSString (Zama)<ZamaProtectProtocol>

@end

NS_ASSUME_NONNULL_END
