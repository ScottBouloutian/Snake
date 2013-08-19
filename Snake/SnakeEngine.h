//
//  SnakeEngine.h
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeState.h"

@interface SnakeEngine : NSObject
-(void)resetGame;
-(GameCell*)createCellAtRow:(int)row column:(int)col;
-(void)updateCell:(GameCell*)cell;
-(bool)moveSnake:(int)direction;
-(NSMutableArray*)executeAI;
@end
