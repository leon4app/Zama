//
//  ZMNSCacheTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSCacheTests : XCTestCase <ZMExceptionRecordHandlerProtocol>
@property (nonatomic, copy) NSString *nilStr;
@end

@implementation ZMNSCacheTests

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
