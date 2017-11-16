//
//  XPC_Helper.h
//  XPC Helper
//
//  Created by Fan's iMac  on 2017/11/16.
//  Copyright © 2017年 Fan's iMac . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPC_HelperProtocol.h"
#import "ClientProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPC_Helper : NSObject <XPC_HelperProtocol>

@property (nonatomic,strong) NSObject<ClientProtocol> *hostObject;

@end
