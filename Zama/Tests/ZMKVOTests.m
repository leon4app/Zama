//
//  ZMKVOTests.m
//  Zama-Unit-Tests
//
//  Created by Leon on 2019/10/9.
//

#import <XCTest/XCTest.h>
@import Zama;

@interface ZMAObservable : NSObject
@property NSString *name;
@end
@implementation ZMAObservable
@end

@interface ZMAObserver : NSObject
@property (nonatomic) NSString *context;
@property (nonatomic) void (^observeValueCallback)(void);
@end
@implementation ZMAObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if (self.context == context || !context) {
        self.observeValueCallback();
    }
}
@end

@interface ZMKVOTests : XCTestCase <ZMExceptionRecordHandlerProtocol>
@property (nonatomic) ZMAObservable *observable;
@property (nonatomic) ZMAObserver *observer;
@end

@implementation ZMKVOTests

- (void)setUp {
    [Zama registerRecordHandler:self];
    [Zama startProtect];
    self.observable = [ZMAObservable new];
    self.observer = [ZMAObserver new];
}

- (void)tearDown {
    [Zama unregisterRecordHandler:self];
}

- (void)recordException:(ZMExceptionRecord *)record {
    XCTAssert(record.type == ZMProtectTypeKVO);
    XCTAssert([record.typeDescription isEqualToString: @"ZMProtectTypeKVO"]);
}

// 正常情况
- (void)testNotifyNomally {
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    XCTestExpectation *expect = [self expectationWithDescription:@"Test KVO normal callback."];
    self.observer.observeValueCallback = ^{
        [expect fulfill];
    };
    self.observable.name = @"Hank";
    [self waitForExpectations:@[expect] timeout:2];
}

- (void)testNotifyNomallyWithContext {
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"aaa"];
    XCTestExpectation *expect = [self expectationWithDescription:@"Test KVO normal callback."];
    self.observer.context = @"aaa";
    self.observer.observeValueCallback = ^{
        [expect fulfill];
    };
    self.observable.name = @"Hank";
    [self waitForExpectations:@[expect] timeout:2];
}

- (void)testRemoveObserver {
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    XCTestExpectation *expect = [self expectationWithDescription:@"Test KVO normal callback."];
    self.observer.observeValueCallback = ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        XCTFail(@"移除观察者后不应收到通知");
#pragma clang diagnostic pop
    };
    [self.observable removeObserver:self.observer forKeyPath:@"name"];
    self.observable.name = @"Hank";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expect fulfill];
    });
    [self waitForExpectations:@[expect] timeout:2];
}

- (void)testRemoveObserverWithContext {
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"aaa"];
    XCTestExpectation *expect = [self expectationWithDescription:@"Test KVO normal callback."];
    self.observer.observeValueCallback = ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        XCTFail(@"移除观察者后不应收到通知");
#pragma clang diagnostic pop
    };
    [self.observable removeObserver:self.observer forKeyPath:@"name" context:@"aaa"];
    self.observable.name = @"Hank";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expect fulfill];
    });
    [self waitForExpectations:@[expect] timeout:2];
}

- (void)testRemoveUnregisteredObserver {
    // 多次移除观察者
    // 'NSRangeException', reason: 'Cannot remove an observer <ZMViewController 0x7fdc8a803dd0> for the key path "name" from <ZMAObject 0x6000022bcb40> because it is not registered as an observer.'
    [self.observable removeObserver:self forKeyPath:@"name"];
}

- (void)testNotifyReleasedObserver {
    // 观察者被释放
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.observer = nil;
    self.observable.name = @"Nick";
}

@end
