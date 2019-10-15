//
//  ZMNSMutableStringTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSMutableStringTests : XCTestCase <ZMExceptionRecordHandlerProtocol>
@property (nonatomic, copy) NSString *nilStr;
@property (nonatomic, retain) NSMutableString *textStr;
@end

@implementation ZMNSMutableStringTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
    self.textStr = @"0123456789".mutableCopy;
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeString);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeString"]);
}

- (void)testReplaceCharactersInRangeWithString {
    [_textStr replaceCharactersInRange:NSMakeRange(0, 3) withString:@"aa"];
    XCTAssert([_textStr isEqualToString:@"aa3456789"]);

    [_textStr replaceCharactersInRange:NSMakeRange(20, 3) withString:@"aa"];
    XCTAssert([_textStr isEqualToString:@"aa3456789"]);
}

- (void)testInsertStringAtIndex {
    [_textStr insertString:@"aaa" atIndex:20];
    XCTAssert([_textStr isEqualToString:@"0123456789"]);
    [_textStr insertString:@"aaa" atIndex:2];
    XCTAssert([_textStr isEqualToString:@"01aaa23456789"]);
}

- (void)testDeleteCharactersInRange {
    [_textStr deleteCharactersInRange:NSMakeRange(0, 30)];
    XCTAssert([_textStr isEqualToString:@"0123456789"]);
    [_textStr deleteCharactersInRange:NSMakeRange(0, 3)];
    XCTAssert([_textStr isEqualToString:@"3456789"]);
}

@end
