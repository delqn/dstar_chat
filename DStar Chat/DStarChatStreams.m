//
//  DStarChatStreams.m
//  DStar Chat
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import "DStarChatStreams.h"

NSInputStream *inputStream;
NSOutputStream *outputStream;
NSMutableData *dataBuffer;

@implementation DStarChatStreams

@synthesize externalTextView;
@synthesize externalConnectButton;
@synthesize externalConnectionStatus;

- (void)connectToRemoteServer:(id)sender hostName:(NSTextField*)hostName portNumber:(NSTextField*)portNumber {
    
    if(!(externalTextView && externalConnectButton && externalConnectionStatus)){
        NSLog(@"Initialize everything first");
    }
    
    if([externalConnectButton.title isEqualToString:@"Disconnect"]){
        [self close];
        return;
    }
    NSHost *host = [NSHost hostWithName:hostName.stringValue];
    NSInputStream *is = inputStream;
    NSOutputStream *os = outputStream;
    NSLog(@"Host name: %@", hostName.stringValue);
    NSLog(@"Port number: %li", [portNumber.stringValue intValue]);
    [NSStream getStreamsToHost:host
                          port:[portNumber.stringValue intValue]
                   inputStream:&is
                  outputStream:&os];
    inputStream = is;
    outputStream = os;
    [self open];
    NSLog(@"Status of outputStream: %li", [outputStream streamStatus]);
    return;
}

- (void)toggleConnectButtonText:(NSButton*)connectButton title:(NSString*)stringTitle {
    if(![connectButton.title isEqualToString:stringTitle]) {
        connectButton.title = stringTitle ;
    }
}

- (void)open {
    NSLog(@"Opening streams.");
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    //[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    [self toggleConnectButtonText:externalConnectButton title:@"Disconnect"];
}

- (void)close {
    NSLog(@"Closing streams.");
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
    [self toggleConnectButtonText:externalConnectButton title:@"Connect"];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)streamEvent {
    NSString *statusText = @"";
    switch (streamEvent) {
        case NSStreamEventEndEncountered: {
            statusText = @"Bit Stream Ended";
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            statusText = @"More Bytes Available";
            break;
        }
        case NSStreamEventNone: {
            statusText = @"Weird! Nothing Really Happened";
            break;
        }
        case NSStreamEventErrorOccurred: {
            statusText = @"Error Occurred";
            break;
        }
        case NSStreamEventHasSpaceAvailable: {
            statusText = @"Has Space Available";
            break;
        }
        case NSStreamEventOpenCompleted: {
            statusText = @"Open Completed";
            break;
        }
        default: {
            statusText = @"Hm?";
            break;
        }
    }
    
    externalConnectionStatus.stringValue = statusText;
    
    switch(streamEvent) {
        case NSStreamEventEndEncountered: {
            [self toggleConnectButtonText:externalConnectButton title:@"Connect"];
            break;
        }
        case NSStreamEventHasSpaceAvailable: {
            if(stream == outputStream) {
                [self toggleConnectButtonText:externalConnectButton title:@"Disconnect"];
                NSLog(@"outputStream is ready.");
            }
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            if(stream == inputStream) {
                NSLog(@"inputStream is ready.");
                uint8_t buf[1024];
                unsigned int len = 0;
                len = [inputStream read:buf maxLength:1024];
                if(len > 0) {
                    NSMutableData* data=[[NSMutableData alloc] initWithLength:0];
                    [data appendBytes: (const void *)buf length:len];
                    NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    [self readIn:s];
                }
            }
            break;
        }
        default: {
            NSLog(@"Stream is sending an Event:%li", streamEvent);
            break;
        }
    }
}

- (void)readIn:(NSString *)s {
    NSLog(@"Reading in the following:");
    NSLog(@"%@", s);
    [externalTextView insertText:s];
}

- (void)writeOut:(NSString *)s {
    uint8_t *buf = (uint8_t *)[s UTF8String];
    [outputStream write:buf maxLength:strlen((char *)buf)];
    NSLog(@"Writing out the following:");
    NSLog(@"%@", s);
}
@end
