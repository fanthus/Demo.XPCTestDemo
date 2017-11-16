//
//  XPC_HelperProtocol.h
//  XPC Helper
//
//  Created by Fan's iMac  on 2017/11/16.
//  Copyright © 2017年 Fan's iMac . All rights reserved.
//

#import <Foundation/Foundation.h>

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol XPC_HelperProtocol

- (void)downloadWithURL:(NSString *)tURL endBlk:(void (^)(NSString *))reply;
    
@end

