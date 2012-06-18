//
//  FSFacebook.m
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "FSFacebook.h"

@interface FSFacebook()
//@property (nonatomic, retain) Facebook *facebook;
@end

@implementation FSFacebook

//@synthesize facebook = _facebook;

static FSFacebook *instance = NULL;

+ (FSFacebook*) sharedFacebook
{
    @synchronized(self) {
        if (instance == NULL) {
            instance = [[FSFacebook alloc] init];
        }
    }
    return instance;
}

- (id) init
{
    self = [super init];
    
    if (self) {
//        self.facebook = [[Facebook alloc] init];
    }
    
    return self;
}

@end
