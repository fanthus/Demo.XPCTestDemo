//
//  main.m
//  XPC Helper
//
//  Created by Fan's iMac  on 2017/11/16.
//  Copyright © 2017年 Fan's iMac . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPC_Helper.h"
#import "ViewController.h"

@interface ServiceDelegate : NSObject <NSXPCListenerDelegate> {
    
}

@end

@implementation ServiceDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    // This method is where the NSXPCListener configures, accepts, and resumes a new incoming NSXPCConnection.
    
    // Configure the connection.
    // First, set the interface that the exported object implements.
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPC_HelperProtocol)];
    newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ClientProtocol)];
    // Next, set the object that the connection exports. All messages sent on the connection to this service will be sent to the exported object to handle. The connection retains the exported object.
    XPC_Helper *exportedObject = [XPC_Helper new];
    newConnection.exportedObject = exportedObject;
    exportedObject.hostObject = [newConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        NSLog(@" xpc service remote obj error = %@",error);
    }];
    [newConnection resume];

    // Returning YES from this method tells the system that you have accepted this connection. If you want to reject the connection for some reason, call -invalidate on the connection and return NO.
    return YES;
}

@end

int main(int argc, const char *argv[])
{
    // Create the delegate for the service.
    ServiceDelegate *delegate = [ServiceDelegate new];

    NSLog(@"delegate = %@",delegate);
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
    return 0;
}
