//
//  ZMNSArrayTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/10/11.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSArrayTests : XCTestCase {
    NSArray *array;
}
@property (nonatomic, copy) NSString *nilStr;
@end

@implementation ZMNSArrayTests

- (void)setUp {
    [Zama startProtect];
}

- (void)testInsertNil {
    // __NSSingleObjectArrayI
    array = @[@"", _nilStr];
    XCTAssert(array.count == 1);
    array = @[@""];
    XCTAssert(array.count == 1);
    // __NSArrayI
    array = @[@"1", @"2", @"3", _nilStr];
    XCTAssert(array.count == 3);
    array = @[@"1", @"2"];
    XCTAssert(array.count == 2);
}

- (void)testObjectAtIndexedSubscript {
    id value;
    // __NSSingleObjectArrayI
    array = @[@""];
    value = array[0];
    XCTAssertEqual(value, @"");
    value = array[9];
    XCTAssertNil(value);

    // __NSArrayI
    array = @[@"1", @"2", @"3"];
    value = array[0];
    XCTAssertEqual(value, @"1");
    value = array[9];
    XCTAssertNil(value);

    // __NSArray0
    array = [NSArray array];
    value = array[9];
    XCTAssertNil(value);
}

- (void)testObjectAtIndex {
    id value;
    // __NSSingleObjectArrayI
    array = @[@""];
    value = [array objectAtIndex:0];
    XCTAssertEqual(value, @"");
    value = [array objectAtIndex:9];
    XCTAssertNil(value);

    // __NSArrayI
    array = @[@"1", @"2", @"3"];
    value = [array objectAtIndex:1];
    XCTAssertEqual(value, @"2");
    value = [array objectAtIndex:9];
    XCTAssertNil(value);

    // __NSArray0
    array = [NSArray array];
    value = [array objectAtIndex:9];
    XCTAssertNil(value);
}

- (void)testObjectsAtIndexes {
    NSArray *valueArray;
    // __NSSingleObjectArrayI
    array = @[@""];
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 1);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);

    // __NSArrayI
    array = @[@"1", @"2", @"3"];
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 2);
    valueArray = [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);

    // __NSArray0
    array = [NSArray array];
    [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 8)]];
    XCTAssertNotNil(valueArray);
    XCTAssert(valueArray.count == 0);
}
@end
