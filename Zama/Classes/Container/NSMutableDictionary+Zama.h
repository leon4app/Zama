//
//  NSMutableDictionary+Zama.h
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
*  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
*  2. - (void)setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey
*  2. - (void)removeObjectForKey:(id)aKey
*
*/
@interface NSMutableDictionary (Zama)<ZamaProtectProtocol>

@end

NS_ASSUME_NONNULL_END
