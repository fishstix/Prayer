//
//  FSSocial.m
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSSocial.h"

#import "FSTwitter.h"

@implementation FSSocial

static FSSocial *instance = NULL;

+ (FSSocial*) sharedSocialManager
{
    @synchronized(self) 
    {
        if (instance == NULL) {
            instance = [[FSSocial alloc] init];
        }
    }
    return instance;
}

#pragma mark -
#pragma mark Share

- (void) share:(NSString *)tweetOrStatusUpdate
{
    [FSTwitter tweet:tweetOrStatusUpdate];
    // Facebook
}

@end
