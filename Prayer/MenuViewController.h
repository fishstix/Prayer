//
//  MenuViewController.h
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
{
    UILabel *_versionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *versionLabel;

- (IBAction)thoughts:(id)sender;

@end
