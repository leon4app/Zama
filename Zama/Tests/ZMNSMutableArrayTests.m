//
//  ZMNSMutableArrayTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/10/11.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSMutableArrayTests : XCTestCase <ZMExceptionRecordHandlerProtocol> {
    NSMutableArray *mutableArray;
}
@property (nonatomic, copy) NSString *nilStr;
@end

@implementation ZMNSMutableArrayTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
    mutableArray = @[@""].mutableCopy;
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeContainer);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeContainer"]);
}

- (void)testInsertNil {
    mutableArray = @[@"", _nilStr].mutableCopy;
    XCTAssert(mutableArray.count == 1);
}

- (void)testObjectAtIndexedSubscript {
    id value;
    value = mutableArray[0];
    XCTAssertEqual(value, @"");
    value = mutableArray[2];
    XCTAssertNil(value);
}

- (void)testObjectAtIndex {
    id value;
    value = [mutableArray objectAtIndex:0];
    XCTAssertEqual(value, @"");
    value = [mutableArray objectAtIndex:4];
    XCTAssertNil(value);
}

- (void)testAddObject {
    [mutableArray addObject:_nilStr];
    XCTAssert(mutableArray.count == 1);
    [mutableArray addObject:@"a"];
    XCTAssert(mutableArray.count == 2);
}

- (void)testInsertObjectAtIndex {
    [mutableArray insertObject:_nilStr atIndex:3];
    XCTAssert(mutableArray.count == 1);
    [mutableArray insertObject:@"b" atIndex:1];
    XCTAssert(mutableArray.count == 2);
    XCTAssertEqual(mutableArray[1], @"b");
}

- (void)testRemoveObjectAtIndex {
    [mutableArray removeObjectAtIndex:4];
    XCTAssert(mutableArray.count == 1);
    [mutableArray removeObjectAtIndex:0];
    XCTAssert(mutableArray.count == 0);
}

- (void)testSetObjectAtIndexedSubscript {
    mutableArray[1] = @"aa";
    XCTAssert(mutableArray.count == 2);
    mutableArray[1] = _nilStr;
    mutableArray[2] = @"aa";
    XCTAssert(mutableArray.count == 3);
    mutableArray[4] = @"aa";
    XCTAssert(mutableArray.count == 3);
}
@end
