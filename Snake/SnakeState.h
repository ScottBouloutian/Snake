//
//  SnakeState.h
//  Snake
//
//  Created by Scott Bouloutian on 8/7/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeLocation.h"
#import "GameCell.h"

#define BOARD_SIZE 11
#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

@interface SnakeState : NSObject
-(id)initWithState:(SnakeState*)state;
-(int)getValueAtRow:(int)row column:(int)col;
-(void)setValue:(int)val forRow:(int)row column:(int)col;
-(SnakeState*)stateByMovingSnakeInDirection:(int)direction;

//The first segment in the array is the tail of the snake
@property NSMutableArray *snakeBody; //Stores an array of snake segments that make up the snake body
@property SnakeLocation *snakeHead; //Stores the snake segment that makes up the snake head
@property int numEmpty; //Value indicating the number of empty cells in the board
@property SnakeLocation *foodLocation; //Value indicating the location of the food
@property SnakeState *parent;
@property int action;
@end
