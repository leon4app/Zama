//
//  ZMNSNullTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/20.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSNullTests : XCTestCase <ZMExceptionRecordHandlerProtocol>

@end

@implementation ZMNSNullTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeNSNull);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeNSNull"]);
}

- (void)testNSNullProtect {
    NSArray *nullObj;
    id null = [NSNull null];
    nullObj = null;
    [nullObj objectAtIndex:3];
}

@end
