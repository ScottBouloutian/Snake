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
@end

@implementation SnakeEngine{
    int board[BOARD_SIZE][BOARD_SIZE]; //Array describing the current game state
    int numEmpty; //Value indicating the number of empty cells in the board
    NSArray *snake; //Stores an array of snake segments
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
    snake=[[NSArray alloc]initWithObjects:[SnakeSegment segmentWithRow:0 column:0], nil];
    numEmpty--;
    
    //Add food to a random empty location
    [self addFood];
    numEmpty--;
    
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
                    return;
                }
                i++;
            }
        }
    }
    NSLog(@"There are %i cells.",NUM_CELLS);
}

-(bool)moveSnake:(int)direction{
    bool result=NO;
    SnakeSegment *head=snake.firstObject;
    board[head.row][head.col]=EMPTY;
    switch (direction) {
        case UP:
            if(head.row+1<BOARD_SIZE){
                head.row=head.row+1;
                result=YES;
            }
            break;
        case DOWN:
            if(head.row-1>=0){
                head.row=head.row-1;
                result=YES;
            }
            break;
        case LEFT:
            if(head.col-1>=0){
                head.col=head.col-1;
                result=YES;
            }
            break;
        case RIGHT:
            if(head.col+1<BOARD_SIZE){
                head.col=head.col+1;
                result=YES;
            }
            break;
        default:
            break;
    }
    board[head.row][head.col]=SNAKE_HEAD;
    return result;
}

@end
