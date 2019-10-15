//
//  ZMNSDictionaryTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSDictionaryTests : XCTestCase <ZMExceptionRecordHandlerProtocol>
@property (nonatomic, copy) NSString *nilStr;
@end

@implementation ZMNSDictionaryTests

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

- (void)testNSDictionary {
    NSDictionary *dict;
    dict = @{_nilStr: @""};
    XCTAssert(dict.count == 0);

    dict = @{@"aaa": _nilStr};
    XCTAssert(dict.count == 0);

    dict = @{_nilStr: @"", @"aaa": @"bbb"};
    XCTAssert(dict.count == 1);
}

@end
