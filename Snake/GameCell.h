//
//  GameCell.h
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define EMPTY 0
#define SNAKE_HEAD 1
#define SNAKE_BODY 2
#define FOOD 3

@interface GameCell : SKSpriteNode
@property int row;
@property int col;
+(id)CellForRow:(int)row column:(int)col value:(int)val;
-(void)updateValue:(int)val;
@end
