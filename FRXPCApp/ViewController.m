//
//  ViewController.m
//  FRXPCApp
//
//  Created by Fan's iMac  on 2017/11/16.
//  Copyright © 2017年 Fan's iMac . All rights reserved.
//

#import "ViewController.h"
#import "XPC_HelperProtocol.h"
#import "XPC_Helper.h"

@interface ViewController() {
    XPC_Helper *helper;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSButton *connectXPCBtn = [[NSButton alloc] initWithFrame:NSMakeRect(50, 50, 150, 100)];
    [connectXPCBtn setTitle:@"Connect XPC Service"];
    connectXPCBtn.target = self;
    connectXPCBtn.action = @selector(connectXPC:);
    [connectXPCBtn setKeyEquivalent:@"\e"];  //按 esc 键会自动触发 action.
    [self.view addSubview:connectXPCBtn];


}

- (void)connectXPC:(id)sender {
    NSXPCInterface *myCookieInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPC_HelperProtocol)];
    NSXPCConnection *myConnection = [[NSXPCConnection alloc] initWithServiceName:@"com.frank.xpchelper"];
    myConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ClientProtocol)];
    myConnection.exportedObject = self;
    myConnection.remoteObjectInterface = myCookieInterface;
    helper = [myConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    [myConnection resume];
    //
    NSButton *downloadBtn = [[NSButton alloc] initWithFrame:NSMakeRect(250, 50, 150, 100)];
    [downloadBtn setTitle:@"Down laod something"];
    downloadBtn.target = self;
    downloadBtn.action = @selector(download:);
    [downloadBtn setKeyEquivalent:@"\e"];  //按 esc 键会自动触发 action.
    [self.view addSubview:downloadBtn];
}

- (void)download:(id)sender {
    [helper downloadWithURL:@"http://www.bing.com" endBlk:^(NSString *statusCode) {
        NSLog(@"status = %@",statusCode);
    }];
}

#pragma mark - ClientProtocol Methods

- (void)timerlog {
    NSLog(@"TIMER LOG From XPC Services");
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}


@end
