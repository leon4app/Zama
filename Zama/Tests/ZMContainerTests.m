//
//  ZMContainerTests.m
//  Pods
//
//  Created by Leon on 2019/9/18.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMContainerTests : XCTestCase
@property(nonatomic, copy) NSString *nilStr;
@end

@implementation ZMContainerTests

- (void)setUp {
    [Zama startProtect];
}

- (void)testNSArray {
    NSArray *array = [NSArray array];
    // insert nil
    array = @[@"", _nilStr];
    // objectAtIndexedSubscript
    id value = array[2];
    // objectAtIndex
    value = [array objectAtIndex:2];
}

- (void)testNSMutableArray {
    // insert nil
    NSMutableArray *mutableArray = @[@"", _nilStr].mutableCopy;
    // objectAtIndexedSubscript
    (void)mutableArray[2];
    // objectAtIndex
    [mutableArray objectAtIndex:4];
    // addObject
    [mutableArray addObject:_nilStr];
    // insertObject:atIndex
    [mutableArray insertObject:_nilStr atIndex:2];
    // removeObjectAtIndex
    [mutableArray removeObjectAtIndex:4];
}

- (void)testNSDictionary {
    NSDictionary *dict = @{_nilStr: @""};

    dict = @{@"aaa": _nilStr};
}

- (void)testNSMutableDictionary {
    NSMutableDictionary *dict;
    dict = [NSMutableDictionary dictionary];

    (void)dict[_nilStr];

    [dict objectForKey:_nilStr];

    dict[_nilStr] = @"aaa";

    dict[@"aaa"] = _nilStr;

    [dict setValue:_nilStr forKey:@"aaa"];

    [dict setValue:@"aaa" forKey:_nilStr];

    [dict setObject:_nilStr forKey:@"aaa"];

    [dict setObject:@"aaa" forKey:_nilStr];

    [dict removeObjectForKey:_nilStr];
}

- (void)testNSCache {
    NSCache *cache = [[NSCache alloc] init];

    [cache objectForKey:_nilStr];

    [cache setObject:_nilStr forKey:@"aaa"];

    [cache setObject:_nilStr forKey:@"aaa" cost:3];

    [cache setObject:@"aaa" forKey:_nilStr];

    [cache setObject:@"aaa" forKey:_nilStr cost:3];

    [cache removeObjectForKey:_nilStr];
}
@end
