//
//  ShareViewController.m
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController.h"

#import "FSSocial.h"
#import "FSFacebook.h"
#import "FSTwitter.h"

@interface ShareViewController ()
- (void) share;
- (void) refreshUI;
@end

@implementation ShareViewController

@synthesize prayerTextView = _prayerTextView;
@synthesize fbSharing = _fbSharing;
@synthesize twitterSharing = _twitterSharing;
@synthesize ios6 = _ios6;
@synthesize shareButton = _shareButton;

@synthesize prayer = _prayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Share Button
    self.shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = self.shareButton;
    
    // Set Prayer Text
    self.prayerTextView.text = self.prayer.title;
    
    // Edit
    [self.prayerTextView becomeFirstResponder];
    
    [self refreshUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI_) name:PrayerTwitterSharingDidChange object:nil];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Sharing

- (void) share
{
    [[FSSocial sharedSocialManager] share:self.prayerTextView.text];
    
#warning TODO - network screen
}

- (IBAction)toggleFBSharing:(id)sender
{
    
    [self refreshUI];
}

- (IBAction)toggleTwitterSharing:(id)sender
{
    [[FSTwitter sharedTwitterManager] setSharing:![[FSTwitter sharedTwitterManager] sharing]];
    
    [self refreshUI];
}

- (void) refreshUI_
{
    [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:NO];
}

- (void) refreshUI
{
    // Share
    [self.shareButton setEnabled:[[FSTwitter sharedTwitterManager] sharing]];
    
    // Twitter
    [self.twitterSharing setBackgroundColor:[[FSTwitter sharedTwitterManager] sharing] ? [UIColor blueColor] : [UIColor grayColor]];
    
    // Facebook
    [self.fbSharing setEnabled:!SYSTEM_VERSION_LESS_THAN(@"6.0")];
    [self.ios6 setHidden:!SYSTEM_VERSION_LESS_THAN(@"6.0")];
}

@end
