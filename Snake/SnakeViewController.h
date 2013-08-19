//
//  SnakeViewController.h
//  Snake
//

//  Copyright (c) 2013 Scott Bouloutian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface SnakeViewController : UIViewController
- (IBAction)upTouched;
- (IBAction)downTouched;
- (IBAction)leftTouched;
- (IBAction)rightTouched;
- (IBAction)startAI;

@end
