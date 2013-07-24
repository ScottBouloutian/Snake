//
//  SnakeSegment.m
//  Snake
//
//  Created by Scott Bouloutian on 7/24/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeSegment.h"

@implementation SnakeSegment
@synthesize row,col;

+(id)segmentWithRow:(int)row column:(int)col{
    SnakeSegment *segment=[[SnakeSegment alloc]init];
    segment.row=row;
    segment.col=col;
    return segment;
}

@end
