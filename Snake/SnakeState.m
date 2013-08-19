//
//  SnakeState.m
//  Snake
//
//  Created by Scott Bouloutian on 8/7/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeState.h"

#define NUM_CELLS BOARD_SIZE*BOARD_SIZE

@interface SnakeState()
-(SnakeLocation*)canMoveInDirection:(int)direction;
-(void)addFood;
@end

@implementation SnakeState{
    int board[BOARD_SIZE][BOARD_SIZE]; //Array describing the current game state
}

@synthesize snakeBody,snakeHead,numEmpty,foodLocation,parent,action;

-(id)init{
    if(self=[super init]){

        //Clear the board
        for(int row=0;row<BOARD_SIZE;row++){
            for(int col=0;col<BOARD_SIZE;col++){
                board[row][col]=EMPTY;
            }
        }
        numEmpty=NUM_CELLS;
        parent=nil;
        action=-1;
        
        //Add snake head
        board[0][0]=SNAKE_HEAD;
        snakeHead=[SnakeLocation locationWithRow:0 column:0];
        numEmpty--;
        
        //Add snake body
        snakeBody=[[NSMutableArray alloc]init];
        
        //Add food to a random empty location
        [self addFood];

    }
    return self;
}

-(id)initWithState:(SnakeState *)state{
    if(self=[super init]){
        //Set the board values
        for(int row=0;row<BOARD_SIZE;row++){
            for(int col=0;col<BOARD_SIZE;col++){
                board[row][col]=[state getValueAtRow:row column:col];
            }
        }
        
        //Set the body values
        snakeBody=[NSMutableArray arrayWithArray:state.snakeBody];
        
        //Set the head value
        snakeHead=[SnakeLocation locationWithLocation:state.snakeHead];
        
        //Set the num empty value
        numEmpty=state.numEmpty;
        
        //Set the parent
        parent=state.parent;
        action=state.action;
        
        //Set the food location
        foodLocation=state.foodLocation;
    }
    return self;
}

-(void)addFood{
    int random=arc4random()%numEmpty;
    int i=0;
    for(int row=0;row<BOARD_SIZE;row++){
        for(int col=0;col<BOARD_SIZE;col++){
            if(board[row][col]==EMPTY){
                if(random==i){
                    board[row][col]=FOOD;
                    foodLocation=[SnakeLocation locationWithRow:row column:col];
                    numEmpty--;
                    return;
                }
                i++;
            }
        }
    }
}

-(SnakeState*)stateByMovingSnakeInDirection:(int)direction{
    SnakeState *result=[[SnakeState alloc]initWithState:self];

    //Get position of new head
    SnakeLocation *newHead=[result canMoveInDirection:direction];
    
    //Check to snake can move in the direction
    if(!newHead){
        return nil;
    }
    
    //If the snake is eating food
    if(board[newHead.row][newHead.col]==FOOD){
        
        //Grow the snake
        [result.snakeBody addObject:[SnakeLocation locationWithLocation:result.snakeHead]];
        [result setValue:SNAKE_BODY forRow:result.snakeHead.row column:result.snakeHead.col];
        [result addFood];
        
    }else{
        
        //Move the snake body
        if(result.snakeBody.count!=0){
            SnakeLocation *tail=result.snakeBody.firstObject;
            [result.snakeBody removeObjectAtIndex:0];
            [result setValue:EMPTY forRow:tail.row column:tail.col];
            [result.snakeBody addObject:[SnakeLocation locationWithLocation:result.snakeHead]];
            [result setValue:SNAKE_BODY forRow:result.snakeHead.row column:result.snakeHead.col];
        }else{
            [result setValue:EMPTY forRow:result.snakeHead.row column:result.snakeHead.col];
        }
        
    }
    
    //Move the snake head
    result.snakeHead=newHead;
    [result setValue:SNAKE_HEAD forRow:result.snakeHead.row column:result.snakeHead.col];
    
    //Set the parent
    result.parent=self;
    result.action=direction;
    
    return result;
}

-(SnakeLocation*)canMoveInDirection:(int)direction{
    SnakeLocation *newHead=[SnakeLocation locationWithLocation:snakeHead];
    switch (direction) {
        case UP:
            if(snakeHead.row+1<BOARD_SIZE){
                newHead.row++;
            }else{
                return nil;
            }
            break;
        case DOWN:
            if(snakeHead.row-1>=0){
                newHead.row--;
            }else{
                return nil;
            }
            break;
        case LEFT:
            if(snakeHead.col-1>=0){
                newHead.col--;
            }else{
                return nil;
            }
            break;
        case RIGHT:
            if(snakeHead.col+1<BOARD_SIZE){
                newHead.col++;
            }else{
                return nil;
            }
            break;
        default:
            return nil;
            break;
    }
    
    if(board[newHead.row][newHead.col]==SNAKE_BODY){
        return nil;
    }
    
    return newHead;
}

-(int)getValueAtRow:(int)row column:(int)col{
    return board[row][col];
}

-(void)setValue:(int)val forRow:(int)row column:(int)col{
    board[row][col]=val;
}


@end
