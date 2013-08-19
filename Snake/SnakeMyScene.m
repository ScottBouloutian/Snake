//
//  SnakeMyScene.m
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "SnakeMyScene.h"
#import "GameCell.h"

@interface SnakeMyScene()
-(void)updateBoard;
@end

@implementation SnakeMyScene{
    SnakeEngine *engine;
    SKNode *gameBoard;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //Create the snake engine
        engine=[[SnakeEngine alloc]init];
        
        //Make the background white
        self.backgroundColor = [UIColor whiteColor];

        //Setup the game board
        gameBoard=[[SKNode alloc]init];
        for(int row=0;row<BOARD_SIZE;row++){
            for(int col=0;col<BOARD_SIZE;col++){
                [gameBoard addChild:[engine createCellAtRow:row column:col]];
            }
        }
        [self addChild:gameBoard];
        [self updateBoard];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)updateBoard{
    for(GameCell *cell in gameBoard.children){
        [engine updateCell:cell];
    }
}

-(void)moveSnake:(int)direction{
    [engine moveSnake:direction];
    [self updateBoard];
}

-(void)startAI{
    NSMutableArray *moves=[engine executeAI];
    if(moves){
        while(moves.count!=0){
            NSNumber *move=[moves lastObject];
            [moves removeLastObject];
            [self moveSnake:move.intValue];
        }
    }
}
@end
