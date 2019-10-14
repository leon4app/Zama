//
//  NSCache+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/24.
//
#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 Can avoid crash method:
 - setObject:forKey:
 - setObject:forKey:cost:
 */
@interface NSCache (Zama) <ZamaProtectProtocol>

@end

NS_ASSUME_NONNULL_END
