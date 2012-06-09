//
//  MenuViewController.m
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

#import "EmailManager.h"

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

#pragma mark -
#pragma mark AppLogic

- (IBAction)thoughts:(id)sender
{
    [[EmailManager sharedEmailManager] thoughts];
}

@end
