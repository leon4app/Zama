//
//  NSArray+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/23.
//
#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

/**
 Can avoid crash method:
 1. @[nil]//这种创建方式其实调用的是2中的方法
 2. arrayWithObjects:count:
 3. objectAtIndex:
 4. objectsAtIndexes:
 
 // TODO:
*  5. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 [NSArray alloc] -> _NSPlaceHolderArray 暂不处理
*/
@interface NSArray (Zama) <ZamaProtectProtocol>

@end
