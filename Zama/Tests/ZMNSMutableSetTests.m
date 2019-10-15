//
//  ZMNSMutableSetTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/10/14.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSMutableSetTests : XCTestCase <ZMExceptionRecordHandlerProtocol>

@end

@implementation ZMNSMutableSetTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeContainer);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeContainer"]);
}

- (void)testAddObject {
    NSMutableSet *set = [NSMutableSet set];
    NSString *nilStr;

    [set addObject:nilStr];
    XCTAssert(set.count == 0);
    [set addObject:@""];
    XCTAssert(set.count == 1);
}

- (void)testRemoveObject {
    NSMutableSet *set = [NSMutableSet setWithObjects:@"1", @"2", nil];
    NSString *nilStr;

    [set removeObject:nilStr];
    XCTAssert(set.count == 2);
    [set removeObject:@"2"];
    XCTAssert(set.count == 1);
}

@end
