//
//  Prayer.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Prayer : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * remind_at;
@property (nonatomic, assign) double recure;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, assign) BOOL answered;

@end
