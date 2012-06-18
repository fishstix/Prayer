//
//  FSSocial.h
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSSocial : NSObject

+ (FSSocial*) sharedSocialManager;

/**
 *  Share text on Twitter and Facebook
 */
- (void) share:(NSString*) tweetOrStatusUpdate;

@end
