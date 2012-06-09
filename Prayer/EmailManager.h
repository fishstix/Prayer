//
//  EmailManager.h
//  Prayer
//
//  Created by Charles Fisher on 6/8/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailManager : NSObject

+ (EmailManager*) sharedEmailManager;

/**
 *  Launch 'Thoughts?' Email template
 */
- (void) thoughts;

@end
