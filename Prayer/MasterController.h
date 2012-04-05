//
//  MasterController.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Prayer.h"

@interface MasterController : NSObject {
    UIViewController *_rootViewController;
    UINavigationController *_rootNavigationController;
}

- (id) initWithAppWindow:(UIWindow*)window;
+ (id) sharedMasterController;

- (void) pushController:(UIViewController*)controller;

- (void) presentPrayer:(Prayer*)prayer;

@end
