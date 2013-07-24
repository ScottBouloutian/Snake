//
//  GameCell.m
//  Snake
//
//  Created by Scott Bouloutian on 7/23/13.
//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import "GameCell.h"

#define CELL_SIZE 27

@implementation GameCell
@synthesize row,col;

+(id)CellForRow:(int)row column:(int)col value:(int)val{
    GameCell *cell=[[GameCell alloc]init];
    cell.size=CGSizeMake(CELL_SIZE, CELL_SIZE);
    cell.position=CGPointMake(col*CELL_SIZE, row*CELL_SIZE);
    cell.anchorPoint=CGPointMake(0, 0);
    cell.row=row;
    cell.col=col;
    switch (val) {
        case EMPTY:
            cell.color=[UIColor lightGrayColor];
            break;
        case SNAKE_HEAD:
            cell.color=[UIColor redColor];
            break;
        case SNAKE_BODY:
            cell.color=[UIColor blueColor];
            break;
        case FOOD:
            cell.color=[UIColor greenColor];
            break;
        default:
            break;
    }
    return cell;
}

-(void)updateValue:(int)val{
    switch (val) {
        case EMPTY:
            self.color=[UIColor lightGrayColor];
            break;
        case SNAKE_HEAD:
            self.color=[UIColor redColor];
            break;
        case SNAKE_BODY:
            self.color=[UIColor blueColor];
            break;
        case FOOD:
            self.color=[UIColor greenColor];
            break;
        default:
            break;
    }
}

@end
