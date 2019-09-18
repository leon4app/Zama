//
//  ZMAppDelegate.m
//  Zama
//
//  Created by leon4app on 09/17/2019.
//  Copyright (c) 2019 leon4app. All rights reserved.
//

#import "ZMAppDelegate.h"
@import Zama;

@interface ZMAppDelegate() <ZMExceptionRecordHandlerProtocol>

@end

@implementation ZMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Zama registerRecordHandler:self];
    return YES;
}

- (void)recordException:(ZMExceptionRecord *)record {
    NSLog(@"Record an exception: %@", record);
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Fatal Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:cancel];
//    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
