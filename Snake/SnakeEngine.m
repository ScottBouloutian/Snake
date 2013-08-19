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
-(NSMutableArray*)unwindSolution;
@end

@implementation SnakeEngine{
    SnakeState *gameState;
    SnakeLocation *goalLocation;
    int explored;
    SnakeState *solution;
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

-(NSMutableArray*)executeAI{
    if([self ida_star:gameState]){
        return [self unwindSolution];
    }
    return nil;
}

-(BOOL)ida_star:(SnakeState *)root{
    goalLocation=root.foodLocation;
    gameState.parent=nil;
    explored=0;
    int bound=[self heuristic:root];
    int t;
    while (YES) {
        NSLog(@"Next Iteration - Bound: %i",bound);
        t=[self search:root :0 :bound];
        if (t == FOUND){
            NSLog(@"Solution Found");
            return YES;
        }
        if(t >= 999){
            NSLog(@"Solution Not Found");
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
        solution=node;
        NSLog(@"Solution was Set");
        return FOUND;
    }
    int min = 999;
    SnakeState *child;
    for(int d=0;d<4;d++){
        child=[node stateByMovingSnakeInDirection:d];
        if(child){
            explored++;
            int t=[self search:child :g+1 :bound];
            if(t==FOUND){
                return FOUND;
            }
            if(t<min){
                min=t;
            }
        }
    }
    return min;
}

-(NSMutableArray*)unwindSolution{
    NSMutableArray *result=[[NSMutableArray alloc]init];
    
    //Add the actions to the result array
    while(solution.parent!=nil){
        [result addObject:[NSNumber numberWithInt:solution.action]];
        solution=solution.parent;
    }
    solution=nil;

    return result;;
}

-(int)heuristic:(SnakeState *)state{
    return abs(state.snakeHead.row-goalLocation.row)+abs(state.snakeHead.col-goalLocation.col);
}

-(BOOL)is_goal:(SnakeState *)state{
    return [state.snakeHead equals:goalLocation];
}

@end
