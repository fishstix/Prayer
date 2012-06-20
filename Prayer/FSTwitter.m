//
//  FSTwitter.m
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSTwitter.h"

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@implementation FSTwitter

@dynamic sharing;

#define kTwitterSharingKey @"kTwitterSharingKey"

- (void) setSharing:(BOOL)sharing
{
    [[NSUserDefaults standardUserDefaults] setBool:sharing forKey:kTwitterSharingKey];
    
    if (sharing) {
        // Create an account store object.
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        // Create an account type that ensures Twitter accounts are retrieved.
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
            if(!granted) {
                [self setSharing:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:PrayerTwitterSharingDidChange object:nil];
            }
        }];
    }
}

- (BOOL) sharing
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kTwitterSharingKey];
}

static FSTwitter *instance = NULL;

+ (FSTwitter*) sharedTwitterManager
{
    @synchronized(self)
    {
        if (instance == NULL) {
            instance = [[FSTwitter alloc] init];
        }
    }
    
    return instance;
}

- (void) tweet:(NSString *)tweety
{
    if (!self.sharing) {
        return;
    }
    
    // Create an account store object.
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	
	// Create an account type that ensures Twitter accounts are retrieved.
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	
	// Request access from the user to use their Twitter accounts.
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted) {
			// Get the list of Twitter accounts.
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
			
			// For the sake of brevity, we'll assume there is only one Twitter account present.
			// You would ideally ask the user which account they want to tweet from, if there is more than one Twitter account present.
			if ([accountsArray count] > 0) {
				// Grab the initial Twitter account to tweet from.
				ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
				
				// Create a request, which in this example, posts a tweet to the user's timeline.
				// This example uses version 1 of the Twitter API.
				// This may need to be changed to whichever version is currently appropriate.
				TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] parameters:[NSDictionary dictionaryWithObject:tweety forKey:@"status"] requestMethod:TWRequestMethodPOST];
				
				// Set the account used to post the tweet.
				[postRequest setAccount:twitterAccount];
				
				// Perform the request created above and create a handler block to handle the response.
				[postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
					NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
//					[self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
				}];
			}
        }
	}];
}

@end
