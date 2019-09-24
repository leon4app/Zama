//
//  NSMutableArray+Zama.h
//  Zama
//
//  Created by Leon on 2019/9/23.
//
#import <Foundation/Foundation.h>
#import "ZamaProtectProtocol.h"

/**
 Can avoid crash method:
 1. objectAtIndex:
 2. objectAtIndexedSubscript:
 3. insertObject:atIndex:
 4. setObject:atIndexedSubscript:
 5. removeObjectAtIndex:

 // TODO:
*  4. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
*/
@interface NSMutableArray (Zama)<ZamaProtectProtocol>

@end
