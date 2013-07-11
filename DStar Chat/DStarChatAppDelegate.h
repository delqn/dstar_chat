//
//  DStarChatAppDelegate.h
//  DStar Chat
//
//  Created by Delyan Raychev on 7/11/13.
//  Copyright (c) 2013 Delyan Raychev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DStarChatStreams.h"

@interface DStarChatAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property DStarChatStreams *stream;

    
- (IBAction)saveAction:(id)sender;

- (IBAction)connect:(id)sender;


@end
