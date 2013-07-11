//
//  DStarChatStreams.h
//  DStar Chat
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DStarChatStreams : NSObject <NSStreamDelegate>
- (void)open;
- (void)close;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
- (void)readIn:(NSString *)s;
- (void)writeOut:(NSString *)s;
- (IBAction)connectToRemoteServer:(id)sender;
@end
