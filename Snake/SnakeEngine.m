//
//  SnakeEngine.m
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeEngine.h"

#define FOUND -1

@interface SnakeEngine()
-(BOOL)ida_star:(SnakeState*)root;
-(int)search:(SnakeState*)node :(int)g :(int)bound;
-(int)heuristic:(SnakeState*)state;
-(BOOL)is_goal:(SnakeState*)state;
-(NSArray*)successors:(SnakeState*)state;
@end

@implementation SnakeEngine{
    SnakeState *gameState;
    int foodRow;
    int foodCol;
}

-(id)init{
    if(self=[super init]){
        [self resetGame];
    }
    return self;
}

-(void)resetGame{
    gameState=[[SnakeState alloc]init];
}

-(GameCell*)createCellAtRow:(int)row column:(int)col{
    if(row>=0 && row<BOARD_SIZE && col>=0 && col<BOARD_SIZE){
        return [GameCell CellForRow:row column:col value:[gameState getValueAtRow:row column:col]];
    }
    return nil;
}

-(void)updateCell:(GameCell *)cell{
    [cell updateValue:[gameState getValueAtRow:cell.row column:cell.col]];
}

-(bool)moveSnake:(int)direction{
    SnakeState *newState=[gameState stateByMovingSnakeInDirection:direction];
    if(newState){
        gameState=newState;
        return YES;
    }
    return NO;
}

-(void)executeAI{
    
}

-(BOOL)ida_star:(SnakeState *)root{
    foodRow=root.foodRow;
    foodRow=root.foodCol;
    int bound=[self heuristic:root];
    int t;
    while (YES) {
        t=[self search:root :0 :bound];
        if (t== FOUND){
            return YES;
        }
        if(t==INFINITY){
            return NO;
        }
        bound=t;
    }
}

-(int)search:(SnakeState *)node :(int)g :(int)bound{
    int f=g+[self heuristic:node];
    if(f>bound){
        return f;
    }
    if ([self is_goal:node]){
        return FOUND;
    }
    int min=INFINITY;
    for(SnakeState *succ in [self successors:node]){
        int t=[self search:succ :g+1 :bound];
        if(t==FOUND){
            return FOUND;
        }
        if(t<min){
            min=t;
        }
    }
    return min;
}

-(int)heuristic:(SnakeState *)state{
    return 0;
}

-(BOOL)is_goal:(SnakeState *)state{
    return NO;
}

-(NSArray*)successors:(SnakeState *)state{
    NSMutableArray *result;
    for(int i=0;i<4;i++){
        SnakeState *newState=[state stateByMovingSnakeInDirection:i];
        if(newState){
            [result addObject:newState];
        }
    }
    return [NSArray arrayWithArray:result];
}

@end
