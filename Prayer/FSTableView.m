//
//  FSTableView.m
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSTableView.h"

@interface FSTableView() <UIScrollViewDelegate>
@property (nonatomic, assign) BOOL superVisible;
@property (nonatomic, assign) int headerSuperHeight;
@end

@implementation FSTableView

@synthesize superVisible = _superVisible;
@synthesize headerSuperHeight = _headerSuperHeight;
@dynamic tableHeaderSuperView;

#define kHeaderFishViewTag 45631
#define kHeaderSuperViewTag 45632

#pragma mark -
#pragma mark init

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Add Fish Symbol
        UILabel *fishSymbol = [[UILabel alloc] initWithFrame:CGRectMake(0, -100, 300, 30)];
        [fishSymbol setText:@"<><"];
        [fishSymbol setBackgroundColor:[UIColor clearColor]];
        [fishSymbol setTextAlignment:UITextAlignmentCenter];
        [self addSubview:fishSymbol];
    }
    
    return self;
}

#pragma mark -
#pragma mark SuperView

- (void) setTableHeaderSuperView:(FSTableHeaderSuperView *)tableHeaderSuperView
{
    // Hidden
    [tableHeaderSuperView setFrame:CGRectMake(0, - tableHeaderSuperView.frame.size.height, tableHeaderSuperView.frame.size.width, tableHeaderSuperView.frame.size.height)];
    // Tagged
    [tableHeaderSuperView setTag:kHeaderSuperViewTag];
    
    // Existing?
    if ([self viewWithTag:kHeaderSuperViewTag]) {
        [[self viewWithTag:kHeaderSuperViewTag] removeFromSuperview];
    }
    
    [self addSubview:tableHeaderSuperView];
    
    self.superVisible = NO;
    self.headerSuperHeight = tableHeaderSuperView.frame.size.height;
#warning Figure out this delegate junk
//    self.delegate = (id<UITableViewDelegate>)self;
}

- (FSTableHeaderSuperView*) tableHeaderSuperView
{
    return (FSTableHeaderSuperView*)[self viewWithTag:kHeaderSuperViewTag];
}

#pragma mark -
#pragma mark ScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if ((scrollView.contentOffset.y * -1) >= self.headerSuperHeight) {
        if (!self.superVisible) {
            self.superVisible = YES;
            [self.tableHeaderSuperView superViewIsVisible];
        }
    } else {
        if (self.superVisible) {
            self.superVisible = NO;
            [self.tableHeaderSuperView superViewIsNotVisible];
        }
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableHeaderSuperView tableViewIsReleased];
}

@end
