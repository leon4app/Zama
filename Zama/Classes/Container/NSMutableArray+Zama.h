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
 - objectAtIndex:
 - objectAtIndexedSubscript:
 - insertObject:atIndex:
 - addObject
 - setObject:atIndexedSubscript:
 - removeObjectAtIndex:
*/
@interface NSMutableArray (Zama)<ZamaProtectProtocol>

@end
