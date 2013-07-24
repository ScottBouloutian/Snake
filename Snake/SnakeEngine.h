//
//  SnakeEngine.h
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCell.h"

#define BOARD_SIZE 11

#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

@interface SnakeEngine : NSObject
-(void)resetGame;
-(GameCell*)createCellAtRow:(int)row column:(int)col;
-(void)updateCell:(GameCell*)cell;
-(bool)moveSnake:(int)direction;
@end
