//
//  ZMViewController.m
//  Zama
//
//  Created by leon4app on 09/17/2019.
//  Copyright (c) 2019 leon4app. All rights reserved.
//

#import "ZMViewController.h"
@import Zama;
@interface ZMViewController ()

@end

@implementation ZMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startProtect:(id)sender {
    [Zama startProtect];
}

- (IBAction)onButtonTouch:(id)sender {
    [self testContainerProtect];
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
