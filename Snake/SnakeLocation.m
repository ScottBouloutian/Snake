//
//  SnakeSegment.m
//  Snake
//
//  Created by Scott Bouloutian on 7/24/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeLocation.h"

@implementation SnakeLocation
@synthesize row,col;

+(SnakeLocation*)locationWithRow:(int)row column:(int)col{
    SnakeLocation *location=[[SnakeLocation alloc]init];
    location.row=row;
    location.col=col;
    return location;
}

+(SnakeLocation*)locationWithLocation:(SnakeLocation*)location{
    return [SnakeLocation locationWithRow:location.row column:location.col];
}

@end
