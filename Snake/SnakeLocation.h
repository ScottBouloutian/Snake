//
//  SnakeSegment.h
//  Snake
//
//  Created by Scott Bouloutian on 7/24/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnakeLocation : NSObject
@property int row;
@property int col;
+(SnakeLocation*)locationWithRow:(int)row column:(int)col;
+(SnakeLocation*)locationWithLocation:(SnakeLocation*)location;
@end
