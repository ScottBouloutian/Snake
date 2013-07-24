//
//  SnakeSegment.h
//  Snake
//
//  Created by Scott Bouloutian on 7/24/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnakeSegment : NSObject
@property int row;
@property int col;
+(id)segmentWithRow:(int)row column:(int)col;
@end
