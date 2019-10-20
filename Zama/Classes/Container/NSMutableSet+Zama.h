//
//  NSMutableSet+Zama.h
//  Zama
//
//  Created by Leon on 2019/10/14.
//

#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 Can avoid crash method:
 - addObject:
 - removeObject:
 */
@interface NSMutableSet (Zama) <ZamaProtectProtocol>

@end

NS_ASSUME_NONNULL_END
