//
//  ZMNSNullTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/20.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSNullTests : XCTestCase

@end

@implementation ZMNSNullTests

- (void)setUp {
    [Zama startProtect];
}

- (void)testNSNullProtect {
    NSArray *nullObj;
    id null = [NSNull null];
    nullObj = null;
    [nullObj objectAtIndex:3];
}

@end
