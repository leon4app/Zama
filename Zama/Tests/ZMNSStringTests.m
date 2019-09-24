//
//  ZMNSStringTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSStringTests : XCTestCase
@property(nonatomic, copy) NSString *nilStr;
@property(nonatomic, copy) NSString *textStr;
@end

@implementation ZMNSStringTests

- (void)setUp {
    [Zama startProtect];
    self.textStr = @"0123456789";
}

- (void)testCharacterAtIndex {
    unichar ch;
    ch = [_textStr characterAtIndex:20];
    XCTAssertEqual(ch, 0x000);
    ch = [_textStr characterAtIndex:0];
    XCTAssertEqual(ch, 0x0030);
    ch = [_textStr characterAtIndex:20];
    XCTAssertEqual(ch, 0x0030);
}

- (void)testSubstringFromIndex {
    NSString *subStr;
    subStr = [_textStr substringFromIndex:1];
    XCTAssert([subStr isEqualToString:@"123456789"]);
    subStr = [_textStr substringFromIndex:88];
    XCTAssert([subStr isEqualToString:@""]);
}

- (void)testSubstringToIndex {
    NSString *subStr;
    subStr = [_textStr substringToIndex:1];
    XCTAssert([subStr isEqualToString:@"0"]);

    subStr = [_textStr substringToIndex:88];
    XCTAssert([subStr isEqualToString:@""]);
}

- (void)testSubstringWithRange {
    NSString *subStr;
    subStr = [_textStr substringWithRange:NSMakeRange(0, 2)];
    XCTAssert([subStr isEqualToString:@"01"]);
    subStr = [_textStr substringWithRange:NSMakeRange(10, 2)];
    XCTAssert([subStr isEqualToString:@""]);
    subStr = [_textStr substringWithRange:NSMakeRange(0, 12)];
    XCTAssert([subStr isEqualToString:@""]);
}

- (void)testStringByReplacingOccurrencesOfStringWithString {
    NSString *newStr;
    newStr = [_textStr stringByReplacingOccurrencesOfString:_nilStr withString:@"aa"];
    XCTAssert([newStr isEqualToString:@""]);
    newStr = [_textStr stringByReplacingOccurrencesOfString:@"012" withString:@"aa"];
    XCTAssert([newStr isEqualToString:@"aa3456789"]);
}

- (void)testStringByReplacingOccurrencesOfStringWithStringOptionsRange {
    NSString *newStr;
    newStr = [_textStr stringByReplacingOccurrencesOfString:_nilStr withString:@"aa" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 20)];
    XCTAssert([newStr isEqualToString:@""]);

    newStr = [_textStr stringByReplacingOccurrencesOfString:@"0" withString:@"aa" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 20)];
    XCTAssert([newStr isEqualToString:@""]);

    newStr = [_textStr stringByReplacingOccurrencesOfString:@"0" withString:@"aa" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 10)];
    XCTAssert([newStr isEqualToString:@"aa123456789"]);
}

- (void)testStringByReplacingCharactersInRangeWithString {
    NSString *newStr;
    newStr = [_textStr stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"aa"];
    XCTAssert([newStr isEqualToString:@"aa23456789"]);

    newStr = [_textStr stringByReplacingCharactersInRange:NSMakeRange(0, 20) withString:@"aa"];
    XCTAssert([newStr isEqualToString:@""]);
}
@end
