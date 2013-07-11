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

- (id)initWithTextView:(NSTextView*)textView{
    self = [super init];
    externalTextView = textView;
    return self;
}

- (IBAction)connectToRemoteServer:(id)sender {
    NSHost *host = [NSHost hostWithName:@"ref.d-rats.com"];
    NSInputStream *is = inputStream;
    NSOutputStream *os = outputStream;
    [NSStream getStreamsToHost:host
                          port:9000
                   inputStream:&is
                  outputStream:&os];
    inputStream = is;
    outputStream = os;
    [self open];
    NSLog(@"Status of outputStream: %li", [outputStream streamStatus]);
    return;
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
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)streamEvent {
    switch(streamEvent) {
        case NSStreamEventHasSpaceAvailable: {
            if(stream == outputStream) {
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
