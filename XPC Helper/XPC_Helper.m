//
//  XPC_Helper.m
//  XPC Helper
//
//  Created by Fan's iMac  on 2017/11/16.
//  Copyright © 2017年 Fan's iMac . All rights reserved.
//

#import "XPC_Helper.h"

@interface XPC_Helper () {
    NSTimer *timer;
}

@end

@implementation XPC_Helper

- (void)downloadWithURL:(NSString *)tURL endBlk:(void (^)(NSString *))reply {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session downloadTaskWithURL:[NSURL URLWithString:tURL]
                                        completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            reply([NSString stringWithFormat:@"%ld",(long)((NSHTTPURLResponse *)response).statusCode]);
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                if (self.hostObject) {
                                                    [self.hostObject timerlog];
                                                }
                                            });
                                        }];
    [task resume];
}


@end
