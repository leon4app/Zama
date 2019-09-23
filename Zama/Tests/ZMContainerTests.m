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
    NSArray *array;
    NSArray *valueArray;
    id value;

    // __NSSingleObjectArrayI
    // insert nil
    array = @[@"", _nilStr];
    // objectAtIndexedSubscript
    value = array[0];
    XCTAssertEqual(value, @"");
    value = array[9];
    XCTAssertNil(value);
    // objectAtIndex
    value = [array objectAtIndex:0];
    XCTAssertEqual(value, @"");
    value = [array objectAtIndex:9];
    XCTAssertNil(value);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 1);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);

    // __NSArrayI
    // insert nil
    array = @[@"1", @"2", @"3", _nilStr];
    value = array[0];
    XCTAssertEqual(value, @"1");
    value = array[9];
    XCTAssertNil(value);
    // objectAtIndex
    value = [array objectAtIndex:1];
    XCTAssertEqual(value, @"2");
    value = [array objectAtIndex:9];
    XCTAssertNil(value);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 2);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);

    // __NSArray0
    array = [NSArray array];
    // objectAtIndexedSubscript
    value = array[9];
    XCTAssertNil(value);
    // objectAtIndex
    value = [array objectAtIndex:9];
    XCTAssertNil(value);
    [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);
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
