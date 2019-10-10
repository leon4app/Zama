//
//  ZMViewController.m
//  Zama
//
//  Created by leon4app on 09/17/2019.
//  Copyright (c) 2019 leon4app. All rights reserved.
//

#import "ZMViewController.h"
@import Zama;

@interface ZMAObservable : NSObject
@property NSString *name;
@end
@implementation ZMAObservable
@end

@interface ZMAObserver : NSObject
@end
@implementation ZMAObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", object);
}
@end

@interface ZMViewController ()
@property (nonatomic) ZMAObservable *observable;
@property (nonatomic) ZMAObserver *observer;
@end

@implementation ZMViewController

- (IBAction)startProtect:(id)sender {
    [Zama startProtect];
}

- (IBAction)onButtonTouch:(id)sender {
//    [self testContainerProtect];
    [self testKVOProtect];
}

- (void)testKVOProtect {
    self.observable = [ZMAObservable new];
    self.observer = [ZMAObserver new];
    
    // 观察者被释放
    [self.observable addObserver:self.observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.observer = nil;
    self.observable.name = @"Nick";

    // 多次移除观察者
    // 'NSRangeException', reason: 'Cannot remove an observer <ZMViewController 0x7fdc8a803dd0> for the key path "name" from <ZMAObject 0x6000022bcb40> because it is not registered as an observer.'
//    [self.observable removeObserver:self.observer forKeyPath:@"name"];
}

- (void)testContainerProtect {
    NSString *_nilStr;
    NSCache *cache;
    cache = [[NSCache alloc] init];

    [cache objectForKey:_nilStr];

    [cache setObject:_nilStr forKey:@"aaa"];

    [cache setObject:_nilStr forKey:@"aaa" cost:3];

    [cache setObject:@"aaa" forKey:_nilStr];

    [cache setObject:@"aaa" forKey:_nilStr cost:3];

    [cache removeObjectForKey:_nilStr];
}
@end
