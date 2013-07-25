//
//  SnakeEngine.m
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeEngine.h"
#import "SnakeSegment.h"

#define NUM_CELLS BOARD_SIZE*BOARD_SIZE

@interface SnakeEngine()
-(void)addFood;
-(SnakeSegment*)canMoveInDirection:(int)direction;
@end

@implementation SnakeEngine{
    int board[BOARD_SIZE][BOARD_SIZE]; //Array describing the current game state
    int numEmpty; //Value indicating the number of empty cells in the board
    NSMutableArray *snakeBody; //Stores an array of snake segments that make up the snake body
                                //The first segment in the array is the tail of the snake
    SnakeSegment *snakeHead; //Stores the snake segment that makes up the snake head
}

-(id)init{
    if(self=[super init]){
        [self resetGame];
    }
    return self;
}

-(void)resetGame{
    //Clear the board
    for(int row=0;row<BOARD_SIZE;row++){
        for(int col=0;col<BOARD_SIZE;col++){
            board[row][col]=EMPTY;
        }
    }
    numEmpty=NUM_CELLS;

    //Add snake head
    board[0][0]=SNAKE_HEAD;
    snakeHead=[SnakeSegment segmentWithRow:0 column:0];
    numEmpty--;
    
    //Add snake body
    snakeBody=[[NSMutableArray alloc]init];
    
    //Add food to a random empty location
    [self addFood];
    
}

-(GameCell*)createCellAtRow:(int)row column:(int)col{
    if(row>=0 && row<BOARD_SIZE && col>=0 && col<BOARD_SIZE){
        return [GameCell CellForRow:row column:col value:board[row][col]];
    }
    return nil;
}

-(void)updateCell:(GameCell *)cell{
    [cell updateValue:board[cell.row][cell.col]];
}

-(void)addFood{
    int random=arc4random()%numEmpty;
    int i=0;
    for(int row=0;row<BOARD_SIZE;row++){
        for(int col=0;col<BOARD_SIZE;col++){
            if(board[row][col]==EMPTY){
                if(random==i){
                    board[row][col]=FOOD;
                    numEmpty--;
                    return;
                }
                i++;
            }
        }
    }
}

-(bool)moveSnake:(int)direction{
    //Get position of new head
    SnakeSegment *newHead=[self canMoveInDirection:direction];
    
    //Check to snake can move in the direction
    if(!newHead){
        return NO;
    }
    
    //If the snake is eating food
    if(board[newHead.row][newHead.col]==FOOD){
        
        //Grow the snake
        [snakeBody addObject:[SnakeSegment segmentWithSegment:snakeHead]];
        board[snakeHead.row][snakeHead.col]=SNAKE_BODY;
        [self addFood];
        
    }else{

        //Move the snake body
        if(snakeBody.count!=0){
            SnakeSegment *tail=snakeBody.firstObject;
            [snakeBody removeObjectAtIndex:0];
            board[tail.row][tail.col]=EMPTY;
            [snakeBody addObject:[SnakeSegment segmentWithSegment:snakeHead]];
            board[snakeHead.row][snakeHead.col]=SNAKE_BODY;
        }else{
            board[snakeHead.row][snakeHead.col]=EMPTY;
        }

    }
    
    //Move the snake head
    snakeHead=newHead;
    board[snakeHead.row][snakeHead.col]=SNAKE_HEAD;
    
    return YES;
}

-(SnakeSegment*)canMoveInDirection:(int)direction{
    SnakeSegment *newHead=[SnakeSegment segmentWithSegment:snakeHead];
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

@end
