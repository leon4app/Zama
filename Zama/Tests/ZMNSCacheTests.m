//
//  ZMNSCacheTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSCacheTests : XCTestCase
@property (nonatomic, copy) NSString *nilStr;
@end

@implementation ZMNSCacheTests

- (void)setUp {
    [Zama startProtect];
}

- (void)testSetObjectForKey {
    NSCache *cache = [[NSCache alloc] init];
    id value;

    [cache setObject:_nilStr forKey:@"aaa"];
    value = [cache objectForKey:@"aaa"];
    XCTAssertNil(value);

    [cache setObject:@"bbb" forKey:@"aaa"];
    value = [cache objectForKey:@"aaa"];
    XCTAssert([value isEqualToString:@"bbb"]);
}

- (void)testSetObjectForKeyCost {
    NSCache *cache = [[NSCache alloc] init];
    id value;

    [cache setObject:_nilStr forKey:@"aaa" cost:3];
    value = [cache objectForKey:@"aaa"];
    XCTAssertNil(value);

    [cache setObject:@"aaa" forKey:@"aaa" cost:3];
    value = [cache objectForKey:@"aaa"];
    XCTAssert([value isEqualToString:@"aaa"]);
}

@end
