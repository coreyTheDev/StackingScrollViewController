//
//  StackingViewController.h
//  stackingScrollView
//
//  Created by CoreysMac on 2/6/14.
//  Copyright (c) 2014 Corey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackingViewController : UIViewController

-(id)initWithFrame:(CGRect)frame stackingGate:(NSInteger)gate;
-(void)insertView:(UIView *) view withStacking:(BOOL)stacking;
@end
