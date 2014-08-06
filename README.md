StackingScrollViewController
============================

StackingScrollViewController is a class that lets users insert multiple views into a scrollview and stack specified views on top of each other when the user scrolls. The usage is similar to the default behavior of an iOs UITableView header view which will remain fixed on top of the screen as long as that section of the tableview is on screen. Unlike a UITableView, this class gives users the ability to fix multiple views to the top of the screen when the user scrolls. 


Usage
============================

##Initializing the StackingScrollView
    self.stackingScrollViewController = [[StackingViewController alloc]initWithFrame:self.view.frame stackingGate:STACKING_GATE_OFFSET];
    [self.view addSubview:self.stackingScrollViewController.view];
    [self addChildViewController:self.stackingScrollViewController];
    
    
