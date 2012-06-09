//
//  EmailManager.m
//  Prayer
//
//  Created by Charles Fisher on 6/8/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "EmailManager.h"

#import <MessageUI/MessageUI.h>

@interface EmailManager() <MFMailComposeViewControllerDelegate>
@end

@implementation EmailManager

static EmailManager *instance = NULL;

+ (EmailManager*) sharedEmailManager 
{
    @synchronized(self) {
        if (instance == NULL) {
            instance = [[EmailManager alloc] init];
        }
    }
    
    return instance;
}

- (void) thoughts 
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:@"fishstix@alum.mit.edu"]];
    [controller setSubject:@"Prayer App - Thoughts"];
    [controller setMessageBody:@"Hello Mr. Fish, here are my thoughts..." isHTML:NO]; 
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:controller animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissModalViewControllerAnimated:YES];
}

@end
