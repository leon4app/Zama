//
//  ZMNSMutableDictionaryTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/24.
//

#import <XCTest/XCTest.h>
@import Zama;
@interface ZMNSMutableDictionaryTests : XCTestCase <ZMExceptionRecordHandlerProtocol>
@property (nonatomic, copy) NSString *nilStr;
@property (nonatomic, retain) NSMutableDictionary *dict;
@end

@implementation ZMNSMutableDictionaryTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
    _dict = [NSMutableDictionary dictionary];
    [_dict setObject:@"111" forKey:@"222"];
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeContainer);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeContainer"]);
}

- (void)testSetObjectForKey {
    [_dict setObject:_nilStr forKey:@"aaa"];
    XCTAssert(_dict.count == 1);
    [_dict setObject:@"aaa" forKey:_nilStr];
    XCTAssert(_dict.count == 1);

    [_dict setObject:@"222" forKeyedSubscript:@"333"];
    XCTAssert(_dict.count == 2);
    XCTAssert([_dict[@"222"] isEqualToString:@"111"]);
    XCTAssert([_dict[@"333"] isEqualToString:@"222"]);
}

- (void)testSetObjectForKeyedSubscript {
    _dict[_nilStr] = @"aaa";
    XCTAssert(_dict.count == 1);
    _dict[@"aaa"] = _nilStr;
    XCTAssert(_dict.count == 1);

    _dict[@"333"] = @"222";
    XCTAssert(_dict.count == 2);
    XCTAssert([_dict[@"222"] isEqualToString:@"111"]);
    XCTAssert([_dict[@"333"] isEqualToString:@"222"]);
}

- (void)testRemoveObjectForKey {
    [_dict removeObjectForKey:_nilStr];
    XCTAssert(_dict.count == 1);
    XCTAssert([_dict[@"222"] isEqualToString:@"111"]);

    [_dict removeObjectForKey:@"222"];
    XCTAssert(_dict.count == 0);
}
@end
