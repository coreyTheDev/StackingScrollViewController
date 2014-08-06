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
To insert views into the view controller you simply call *insertView:(UIView*)view withStacking:(BOOL)val* on the stackingViewController instance. The code below shows how you'd insert three header views that you wanted to remain fixed to the top of the screen and 3 body views that you wanted to move off the screen. 

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    [headerView setBackgroundColor:[UIColor redColor]];
    [self.stackingScrollViewController insertView:headerView withStacking:YES];
    
    UIView *bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 600, screenWidth, 300)];
    [bodyView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:bodyView withStacking:NO];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 1800, screenWidth, 50)];
    [headerView setBackgroundColor:[UIColor blueColor]];
    [self.stackingScrollViewController insertView:headerView withStacking:YES];
    
    bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 300)];
    [bodyView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:bodyView withStacking:NO];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 50)];
    [headerView setBackgroundColor:[UIColor greenColor]];
    [self.stackingScrollViewController insertView:headerView withStacking:YES];
    
    bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 1200, screenWidth, 1000)];
    [bodyView setBackgroundColor:[UIColor grayColor]];
    [self.stackingScrollViewController insertView:bodyView withStacking:NO];
    
    
