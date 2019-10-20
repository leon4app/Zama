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
 - arrayWithObjects:count:
 - objectAtIndex:
 - objectsAtIndexes:
 - objectAtIndexedSubscript
 - subarrayWithRange:
 - initWithObjects:count:
*/
@interface NSArray (Zama) <ZamaProtectProtocol>

@end
