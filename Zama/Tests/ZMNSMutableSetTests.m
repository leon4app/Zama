//
//  ZMNSMutableSetTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/10/14.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSMutableSetTests : XCTestCase

@end

@implementation ZMNSMutableSetTests

- (void)setUp {
    [Zama startProtect];
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
