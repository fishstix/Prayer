//
//  MenuViewController.m
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

#import "MasterController.h"
#import "EmailManager.h"


@implementation MenuViewController

@synthesize versionLabel = _versionLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.versionLabel setText:[NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]];
}

#pragma mark -
#pragma mark AppLogic

-(IBAction)categories:(id)sender
{
    [[MasterController sharedMasterController] presentCategories];
}

- (IBAction)thoughts:(id)sender
{
    [[EmailManager sharedEmailManager] thoughts];
}

@end
