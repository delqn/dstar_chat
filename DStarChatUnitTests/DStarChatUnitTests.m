//
//  DStarChatUnitTests.m
//  DStarChatUnitTests
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import "DStarChatUnitTests.h"
#import "DStarChatStreams.h"

@implementation DStarChatUnitTests

DStarChatStreams *testStreamsObject;

- (void)setUp
{
    [super setUp];
    testStreamsObject = [[DStarChatStreams alloc] init];
    testStreamsObject.externalTextView = [[NSTextView alloc] init];
    testStreamsObject.externalConnectButton = [[NSButton alloc] init];
    testStreamsObject.externalConnectionStatus = [[NSTextField alloc] init];
    id sender = nil;
    [testStreamsObject connectToRemoteServer:sender];

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testUpdateStatusLabel {
    NSStreamEvent event = NSStreamEventEndEncountered;
    [testStreamsObject updateStatusLabel:event];
    STAssertTrue([testStreamsObject.externalConnectionStatus.stringValue isEqualToString:@"Bit Stream Ended"], @"The Status Label did not match!");
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in DStarChatUnitTests");
}

@end
