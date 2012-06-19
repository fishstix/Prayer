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

@synthesize prayer = _prayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Share Button
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    // Set Prayer Text
    self.prayerTextView.text = self.prayer.title;
    
    // Edit
    [self.prayerTextView becomeFirstResponder];
    
    [self refreshUI];
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

- (void) refreshUI
{
    [self.twitterSharing setBackgroundColor:[[FSTwitter sharedTwitterManager] sharing] ? [UIColor blueColor] : [UIColor grayColor]];
}

@end
