//
//  StackingViewController.m
//  stackingScrollView
//
//  Created by CoreysMac on 2/6/14.
//  Copyright (c) 2014 Corey. All rights reserved.
//

#import "StackingViewController.h"

@interface StackingViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *stackingViews;
@end

@implementation StackingViewController
{
    CGRect boundingRect;
    NSInteger stackingGate;
    
    UIView *nextViewToStack;
    NSInteger indexOfNextView;
    UIView *lastViewInserted;//only kept to easily adjust the content size of the scrollview
    CGRect originalFrame;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _stackingViews = [[NSMutableArray alloc]init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame stackingGate:(NSInteger)gate
{
    self = [super init];
    if(self)
    {
        boundingRect = frame;
        stackingGate = gate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setFrame:boundingRect];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [_scrollView setDelegate:self];
    [_scrollView setUserInteractionEnabled:YES];
    [_scrollView setScrollEnabled:YES];
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
    insertView will insert the supplied view into the scrollview at the bottom and adjust the scrollview's content offset accordingly
 
    view: the view to insert into the scrollview as a subview
    stacking: determines whether to stop the view once it passes the threshold to stack views from.
 */
-(void)insertView:(UIView *)view withStacking:(BOOL)stacking
{
    /*
        Algorithm: 
            insert view as scrollview subview
            add to stackingViews if its a stackable view
            adjust scrollview offset
     */
    [_scrollView addSubview:view];
    [view setFrame:CGRectMake(0, _scrollView.contentSize.height, view.frame.size.width, view.frame.size.height)];
    if (stacking && !nextViewToStack)
    {
        nextViewToStack = view;
        originalFrame = nextViewToStack.frame;
        [_stackingViews addObject:view];
    }
    //TODO:
    lastViewInserted = view;
    [self adjustScrollviewContentOffset];
}

#pragma Internal Methods
-(void)adjustScrollviewContentOffset
{
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, lastViewInserted.frame.origin.y + lastViewInserted.frame.size.height)];
}

#pragma mark - ScrollView delegate methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //check next stacking view
    if (scrollView.contentOffset.y + stackingGate >= originalFrame.origin.y)
    {
        //freeze view
        [nextViewToStack setFrame:CGRectMake(nextViewToStack.frame.origin.x, scrollView.contentOffset.y + stackingGate, nextViewToStack.frame.size.width, nextViewToStack.frame.size.height)];
        //bring view to front
        [self.scrollView bringSubviewToFront:nextViewToStack];
        //adjust nextView
        
    }
    else if (scrollView.contentOffset.y + stackingGate < originalFrame.origin.y)
    {
        [nextViewToStack setFrame:originalFrame];
    }
}
@end
