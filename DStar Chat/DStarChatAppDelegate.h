//
//  DStarChatAppDelegate.h
//  DStar Chat
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DStarChatStreams.h"

@interface DStarChatAppDelegate : NSObject <NSApplicationDelegate>{
    @private
    DStarChatStreams *streamsObject;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSTextField *hostName;
@property (assign) IBOutlet NSTextField *portNumber;
@property (assign) IBOutlet NSButton *connectButton;
@property (assign) IBOutlet NSTextField *connectionStatus;
@property (assign) IBOutlet NSTableColumn *column;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
    
- (IBAction)saveAction:(id)sender;

- (IBAction)connect:(id)sender;

@end
