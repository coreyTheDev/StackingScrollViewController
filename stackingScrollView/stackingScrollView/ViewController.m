//
//  ViewController.m
//  stackingScrollView
//
//  Created by CoreysMac on 2/6/14.
//  Copyright (c) 2014 Corey. All rights reserved.
//

#import "ViewController.h"
#import "StackingViewController.h"

#define STACKING_GATE_OFFSET 0.0
@interface ViewController ()
@property (nonatomic, strong) StackingViewController *stackingScrollViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];
    self.stackingScrollViewController = [[StackingViewController alloc]initWithFrame:self.view.frame stackingGate:STACKING_GATE_OFFSET];
    [self.view addSubview:self.stackingScrollViewController.view];
    [self addChildViewController:self.stackingScrollViewController];
    [self insertDummyViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)insertDummyViews
{
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500, 200)];
    [testView setBackgroundColor:[UIColor redColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 600, 500, 600)];
    [testView setBackgroundColor:[UIColor purpleColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1800, 500, 200)];
    [testView setBackgroundColor:[UIColor blueColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, 500, 600)];
    [testView setBackgroundColor:[UIColor yellowColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, 500, 200)];
    [testView setBackgroundColor:[UIColor redColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, 500, 1000)];
    [testView setBackgroundColor:[UIColor blackColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
}

@end
