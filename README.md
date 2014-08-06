StackingScrollViewController
============================

StackingScrollViewController is a class that lets users insert multiple views into a scrollview and stack specified views on top of each other when the user scrolls. The usage is similar to the default behavior of an iOs UITableView header view which will remain fixed on top of the screen as long as that section of the tableview is on screen. Unlike a UITableView, this class gives users the ability to fix multiple views to the top of the screen when the user scrolls. 


Usage
============================

##Initializing the StackingScrollView
    self.stackingScrollViewController = [[StackingViewController alloc]initWithFrame:self.view.frame stackingGate:0];
    [self.view addSubview:self.stackingScrollViewController.view];
    [self addChildViewController:self.stackingScrollViewController];

The constructor for the stacking scrollview takes in 2 parameters, the frame for the scrollview (all of which will be scrollable) and the stacking Gate. The stacking gate is if you don't want views to remain fixed to the top of the scrollview but offset by a certain distance. 

##Inserting Views 

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    [testView setBackgroundColor:[UIColor redColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 600, screenWidth, 300)];
    [testView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1800, screenWidth, 50)];
    [testView setBackgroundColor:[UIColor blueColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 300)];
    [testView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 50)];
    [testView setBackgroundColor:[UIColor greenColor]];
    [self.stackingScrollViewController insertView:testView withStacking:YES];
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 1000)];
    [testView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:testView withStacking:NO];
    
    
