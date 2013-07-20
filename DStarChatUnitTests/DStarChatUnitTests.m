//
//  DStarChatUnitTests.m
//  DStarChatUnitTests
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import "DStarChatUnitTests.h"
#import "DStarChatStreams.h"
#import "DStarChatMessageParser.h"


@implementation DStarChatUnitTests

//DStarChatStreams *testStreamsObject;

- (void)setUp
{
    [super setUp];
    /*
    testStreamsObject = [[DStarChatStreams alloc] init];
    testStreamsObject.externalTextView = [[NSTextView alloc] init];
    testStreamsObject.externalConnectButton = [[NSButton alloc] init];
    testStreamsObject.externalConnectionStatus = [[NSTextField alloc] init];
    id sender = nil;
    [testStreamsObject connectToRemoteServer:sender];
*/
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/*
- (void)testUpdateStatusLabel {
    NSStreamEvent event = NSStreamEventEndEncountered;
    [testStreamsObject updateStatusLabel:event];
    STAssertTrue([testStreamsObject.externalConnectionStatus.stringValue isEqualToString:@"Bit Stream Ended"], @"The Status Label did not match!");
}
*/
- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in DStarChatUnitTests");
}

- (void)testMessageParsing
{
    NSString* const stringReceived = @"100 Authentication not required\n"
        "$GPGGA,002442,4003.726,N,7505.448,W,1,3,0,0,M,0,M,,*76\n"
        "[SOB]\"=@=@=@n=@YN0DEC~~~CQCQCQ~~[QST] Sheboygan, (WI) Weather Info & Ratflector - Network, host: 59.54.54.53, port 8801[EOB]"
        "[SOB]\xdd=@=@=@n=@YN0DEC~~~CQCQCQx\x9c\xab\xab\x8b\x0e\x0c\x0e\x89U\x08\xceHM\xca\xafLO\xcc\xd3Q\xd0\x08\xf7\xd4T\x08OM,\xc9H-R\xf0\xccK\xcbWPS\x08J,I\xcbIM.\xc9/R\xd0U\xf0K-)\xcf/\xca\xd6Q\xc8\xc8/.\xb1R0\xb5\xd435\x01#c\x1d\x85\x82\xfc\xa2\x12\x05\x0b\x0b\x03C\x00)\xea\x1b\xb1[EOB]";

    DStarChatMessageParser *mp = [[DStarChatMessageParser alloc] init];
    NSArray *parsedMessages = [mp parseBuffer:stringReceived];
    NSMutableArray *expectedMessages = [[NSMutableArray alloc] init];
    
    [expectedMessages addObject:@"$GPGGA,002442,4003.726,N,7505.448,W,1,3,0,0,M,0,M,,*76"];
    NSNumber *magic_number = [[NSNumber alloc] initWithInt: 34];
    NSNumber *check_sum = [[NSNumber alloc] initWithInt: 15680];
    NSNumber *length = [[NSNumber alloc] initWithInt: 28221];
    NSNumber *session = [[NSNumber alloc] initWithInt: 61];
    NSNumber *message_type = [[NSNumber alloc] initWithInt: 64];
    
    NSMutableDictionary *anotherMessage = [[NSDictionary alloc] initWithObjectsAndKeys:
        magic_number, @"magic_number",
        check_sum, @"sequence",
        check_sum, @"checksum",
        @"~~CQCQCQ", @"destination",
        false, @"is_compressed",
        length, @"length",
        session, @"session",
        @"@YN0DEC~", @"source",
        @"~~[QST] Sheboygan, (WI) Weather Info & Ratflector - Network, host: 59.54.54.53, port 8801", @"data",
        message_type, @"message_type",
    nil];

    [expectedMessages addObject:anotherMessage];
    STAssertEqualObjects(parsedMessages, expectedMessages, @"Message parsing did not work quite as expected...");
}
@end
