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
@property (nonatomic, strong) UIView *contentView;
@end

@implementation StackingViewController
{
    
    CGRect boundingRect;
    NSInteger stackingGate;
    
    UIView *nextViewToStack;//get from array
    NSInteger indexOfNextViewToStack;
    UIView *lastViewInserted;//only kept to easily adjust the content size of the scrollview
    UIView *lastViewStacked;
    CGRect nextFrame;//get from array
    CGRect previousFrame;
    NSMutableArray *verticalOriginsOfStackingViews;
    NSMutableArray *stackedGhostViews;
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
    [_scrollView setShowsHorizontalScrollIndicator:YES];
    [_scrollView setScrollEnabled:YES];
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc]initWithFrame:self.view.frame];
    [_contentView setUserInteractionEnabled:NO];
    [[self view] addSubview:_contentView];
    
    stackedGhostViews = [[NSMutableArray alloc]init];
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
    if (stacking)
    {
        if (!nextViewToStack)
        {
            nextViewToStack = view;
        }
        nextFrame = nextViewToStack.frame;
        [_stackingViews addObject:view];
        UIView *ghostView = [[UIView alloc]initWithFrame:view.frame];
        [stackedGhostViews addObject:ghostView];
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
//on scroll view did scroll we need to check the gate against two views at any given time:
//the next view to stack and the last view stacked
//we know if the last view stacked is lower than the gate we change him to the next view to stack and give him his original frame back
//similarly if the nextviewtostack is higher than the gate we change him to last view stacked and get the next view to stack.
//Issue.... I don't know if I can do
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //check next stacking view
    
    if ((scrollView.contentOffset.y + stackingGate > nextFrame.origin.y) && nextViewToStack)
    {
        //freeze view
        //remove view from scrollview and place in contentview at 0,gate
        //[nextViewToStack setFrame:CGRectMake(nextViewToStack.frame.origin.x, scrollView.contentOffset.y + stackingGate, nextViewToStack.frame.size.width, nextViewToStack.frame.size.height)];
        [nextViewToStack removeFromSuperview];
        previousFrame = nextViewToStack.frame;
        [nextViewToStack setFrame:CGRectMake(0, stackingGate, nextViewToStack.frame.size.width, nextViewToStack.frame.size.height)];
        [_contentView addSubview:nextViewToStack];
        indexOfNextViewToStack++;
        stackingGate += nextViewToStack.frame.size.height;
        //now.... we need to grab the next view to stack to test
        lastViewStacked = nextViewToStack;
        if (!(indexOfNextViewToStack >= _stackingViews.count))
        {
            nextViewToStack = (UIView *)[_stackingViews objectAtIndex:indexOfNextViewToStack];
            nextFrame = nextViewToStack.frame;
            
        } else
        {
            nextViewToStack = nil;
        }
        //bring view to front
        //[self.scrollView bringSubviewToFront:nextViewToStack];
        //adjust nextView
        
    }
    else if (indexOfNextViewToStack != 0)
    {
        if ((scrollView.contentOffset.y + stackingGate - previousFrame.size.height < previousFrame.origin.y) && (![[_scrollView subviews]containsObject:lastViewStacked]))
        {
            [lastViewStacked removeFromSuperview];
            [lastViewStacked setFrame:previousFrame];
            [_scrollView addSubview:lastViewStacked];
            //reset Next View to stack
            nextViewToStack = lastViewStacked;
            nextFrame = previousFrame;
            stackingGate -= previousFrame.size.height;
            indexOfNextViewToStack --;
            if (indexOfNextViewToStack == 0)
            {
                lastViewStacked = nil;
            }
            else {
                lastViewStacked = [_stackingViews objectAtIndex:indexOfNextViewToStack -1];
                UIView *ghostView = (UIView *)[stackedGhostViews objectAtIndex:indexOfNextViewToStack -1];
                previousFrame = ghostView.frame;
            }
        }
    }
}
@end
