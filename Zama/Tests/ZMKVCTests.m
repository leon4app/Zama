//
//  ZMKVCTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/9/30.
//

#import <XCTest/XCTest.h>
@import Zama;

@interface TestObject : NSObject
@property (nonatomic) TestObject *anotherObject;
@property (nonatomic, copy) NSString *username;
@end

@implementation TestObject
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"\n\n\nsetValue: %@ forUndefinedKey: %@", value, key);
//}
@end

@interface ZMKVCTests : XCTestCase <ZMExceptionRecordHandlerProtocol>

@end

@implementation ZMKVCTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeKVC);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeKVC"]);
}

- (void)testValueForKey {
    TestObject *obj = [TestObject new];
    XCTAssertNil([obj valueForKey:@"aaa"]);
}

- (void)testSetValueForKey {
    TestObject *obj = [TestObject new];
    [obj setValue:@"aaa" forKey:@"aaa"];
    XCTAssertNil([obj valueForKey:@"aaa"]);
    [obj setValue:@"aaa" forKey:@"username"];
    XCTAssert([obj.username isEqualToString:@"aaa"]);
}

- (void)testSetValueForKeyPath {
    TestObject *obj = [TestObject new];
    TestObject *obj2 = [TestObject new];
    obj.anotherObject = obj2;
    [obj setValue:@"aaa" forKeyPath:@"anotherObject.aaa"];
    XCTAssertNil(obj.anotherObject.username);
    [obj setValue:@"aaa" forKeyPath:@"anotherObject.username"];
    XCTAssert([obj.anotherObject.username isEqualToString:@"aaa"]);
}

- (void)testSetValuesForKeysWithDictionary {
    NSDictionary *dict;
    TestObject *obj = [TestObject new];

    dict = @{@"aaa": @"aaa"};
    [obj setValuesForKeysWithDictionary:dict];
    XCTAssertNil([obj valueForKey:@"aaa"]);

    dict = @{@"username": @"aaa"};
    [obj setValuesForKeysWithDictionary:dict];
    XCTAssert([obj.username isEqualToString:@"aaa"]);
}
@end
