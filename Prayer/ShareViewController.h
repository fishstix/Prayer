//
//  ShareViewController.h
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"

#import "Prayer.h"

@interface ShareViewController : AppViewController
{
    UITextView *_prayerTextView;
    
    UIButton *_fbSharing;
    UIButton *_twitterSharing;
    UILabel *_ios6;
    
    UIBarButtonItem *_shareButton;
    
    Prayer *_prayer;
}

@property (nonatomic, retain) IBOutlet UITextView *prayerTextView;
@property (nonatomic, retain) IBOutlet UIButton *fbSharing;
@property (nonatomic, retain) IBOutlet UIButton *twitterSharing;
@property (nonatomic, retain) IBOutlet UILabel *ios6;

@property (nonatomic, retain) UIBarButtonItem *shareButton;

@property (nonatomic, retain) Prayer *prayer;

- (IBAction)toggleFBSharing:(id)sender;
- (IBAction)toggleTwitterSharing:(id)sender;

@end
