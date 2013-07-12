//
//  DStarChatStreams.h
//  DStar Chat
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DStarChatStreams: NSObject <NSStreamDelegate> /*{
    @private NSTextView *externalTextView;
}*/

@property NSTextView *externalTextView;
@property NSButton *externalConnectButton;
@property NSTextField *externalConnectionStatus;
@property NSString *hostName;
@property long portNumber;

- (void)open;
- (void)close;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
- (void)readIn:(NSString *)s;
- (void)writeOut:(NSString *)s;
- (void)connectToRemoteServer:(id)sender;
- (void)updateStatusLabel:(NSStreamEvent)streamEvent;
@end
