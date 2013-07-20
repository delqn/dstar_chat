//
//  DStarChatMessageParser.m
//  DStar Chat
//
//  Created by Delyan Raychev on 7/19/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import "DStarChatMessageParser.h"

NSString* const STRUCT_FORMAT = @"!BHBBHH8s8s";

@implementation DStarChatMessageParser

- (id)init
{
    // what?
}

- (NSArray*)parseBuffer:(NSString*)messagesString
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    [returnArray addObject:@"message"];
    return returnArray;
}
@end
