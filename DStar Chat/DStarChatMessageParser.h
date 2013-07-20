//
//  DStarChatMessageParser.h
//  DStar Chat
//
//  Created by Delyan Raychev on 7/19/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString* const STRUCT_FORMAT;

@interface DStarChatMessageParser : NSObject


- (NSArray*)parseBuffer:(NSString*)messagesString;

@end
