//
//  ZMProtectTypeTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/12/3.
//

#import <XCTest/XCTest.h>
@import Zama;

@interface ZMProtectTypeTests : XCTestCase

@end

@implementation ZMProtectTypeTests

- (void)testEnabledType {
    ZMProtectType type;
    type = [Zama enabledType];
    [Zama startProtectWithType:ZMProtectTypeUnrecognizedSelector];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeUnrecognizedSelector);
    // FIXME: App doesn't restart for each case, so this type are already open in other test cases.
//    XCTAssertFalse(type & ZMProtectTypeContainer);
//    XCTAssertFalse(type & ZMProtectTypeNSNull);
//    XCTAssertFalse(type & ZMProtectTypeKVO);
//    XCTAssertFalse(type & ZMProtectTypeKVC);
//    XCTAssertFalse(type & ZMProtectTypeTimer);
//    XCTAssertFalse(type & ZMProtectTypeString);
//    XCTAssertFalse(type == ZMProtectTypeExceptDanglingPointer);
//    XCTAssertFalse(type & ZMProtectTypeDanglingPointer);

    // Open twice
    [Zama startProtectWithType:ZMProtectTypeUnrecognizedSelector];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeUnrecognizedSelector);
//    XCTAssertFalse(type & ZMProtectTypeContainer);
//    XCTAssertFalse(type & ZMProtectTypeNSNull);
//    XCTAssertFalse(type & ZMProtectTypeKVO);
//    XCTAssertFalse(type & ZMProtectTypeKVC);
//    XCTAssertFalse(type & ZMProtectTypeTimer);
//    XCTAssertFalse(type & ZMProtectTypeString);
//    XCTAssertFalse(type == ZMProtectTypeExceptDanglingPointer);
//    XCTAssertFalse(type & ZMProtectTypeDanglingPointer);

    // Open another type
    [Zama startProtectWithType:ZMProtectTypeContainer];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeUnrecognizedSelector);
    XCTAssert(type & ZMProtectTypeContainer);
//    XCTAssertFalse(type & ZMProtectTypeNSNull);
//    XCTAssertFalse(type & ZMProtectTypeKVO);
//    XCTAssertFalse(type & ZMProtectTypeKVC);
//    XCTAssertFalse(type & ZMProtectTypeTimer);
//    XCTAssertFalse(type & ZMProtectTypeString);
//    XCTAssertFalse(type == ZMProtectTypeExceptDanglingPointer);
//    XCTAssertFalse(type & ZMProtectTypeDanglingPointer);

    [Zama startProtectWithType:ZMProtectTypeNSNull];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeNSNull);
    [Zama startProtectWithType:ZMProtectTypeKVO];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeKVO);
    [Zama startProtectWithType:ZMProtectTypeKVC];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeKVC);
    [Zama startProtectWithType:ZMProtectTypeTimer];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeTimer);
    [Zama startProtectWithType:ZMProtectTypeString];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeString);

    [Zama startProtect];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeUnrecognizedSelector);
    XCTAssert(type & ZMProtectTypeContainer);
    XCTAssert(type & ZMProtectTypeNSNull);
    XCTAssert(type & ZMProtectTypeKVO);
    XCTAssert(type & ZMProtectTypeKVC);
    XCTAssert(type & ZMProtectTypeTimer);
    XCTAssert(type & ZMProtectTypeString);
    XCTAssert(type == ZMProtectTypeExceptDanglingPointer);
    XCTAssertFalse(type & ZMProtectTypeDanglingPointer);

    [Zama startProtectWithType:ZMProtectTypeDanglingPointer];
    type = [Zama enabledType];
    XCTAssert(type & ZMProtectTypeDanglingPointer);
    XCTAssertFalse(type == ZMProtectTypeExceptDanglingPointer);
}

@end
