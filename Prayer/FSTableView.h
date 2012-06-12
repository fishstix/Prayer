//
//  FSTableView.h
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTableView : UITableView

/**
 *  Hidden View, visible after scroll
 */
@property (nonatomic, retain) UIView* tableHeaderSuperView;

@end
