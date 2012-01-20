//
//  MoreViewController.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "OnePackViewController.h"
#import "OneRecipeViewController.h"

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@implementation MoreViewController
@synthesize main, nc;
-(void)renderView{
    //adding main scrolling view
    main.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    main.backgroundColor=[UIColor clearColor];
    [self.view addSubview:main];
    //
    UIImageView *main_back=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ourthanks.png"]];
    if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320)
        main_back.frame=CGRectMake(0, 0, main_back.image.size.width/2, main_back.image.size.height/2);
    else
        main_back.frame=CGRectMake(0, 0, main_back.image.size.width/2, main_back.image.size.height/2);
    [main addSubview:main_back];
    //adding text
    
    
        UITextView *delgusto=[[UITextView alloc] initWithFrame:CGRectMake(70, 275, self.view.frame.size.width, 40)];
        delgusto.text=@"http://delgusto.ru";
        delgusto.backgroundColor=[UIColor clearColor];
        delgusto.textColor=[UIColor whiteColor];
        delgusto.editable=NO;
        delgusto.font=[UIFont fontWithName:BASE_FONT size:16];
        delgusto.dataDetectorTypes=UIDataDetectorTypeAll;
        delgusto.scrollEnabled = NO;
//        delgusto.textAlignment=UITextAlignmentCenter;
        [main addSubview:delgusto];
        [delgusto release];
    
    UITextView *delgusto1=[[UITextView alloc] initWithFrame:CGRectMake(75, 1300, self.view.frame.size.width, 40)];
    delgusto1.text=@"http://moslight.com";
    delgusto1.backgroundColor=[UIColor clearColor];
    delgusto1.textColor=[UIColor whiteColor];
    delgusto1.editable=NO;
    delgusto1.font=[UIFont fontWithName:BASE_FONT size:16];
    delgusto1.dataDetectorTypes=UIDataDetectorTypeAll;
    delgusto1.scrollEnabled = NO;
    //        delgusto.textAlignment=UITextAlignmentCenter;
    [main addSubview:delgusto1];
    [delgusto1 release];

    //setting content size
    main.contentSize=CGSizeMake(main_back.frame.size.width, main_back.frame.size.height);
    //releasing
    [main_back release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andNC:(UINavigationController *)navCtl
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.nc=navCtl;
        self.navigationController.title=NSLocalizedString(@"Our thanks", @"Our thanks");
        self.nc.title=NSLocalizedString(@"Our thanks", @"Our thanks");
        self.title=NSLocalizedString(@"Our thanks", @"Our thanks");
        if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320)
            self.tabBarItem.image=[UIImage imageNamed:@"Our_thanks.png"];
        else{
            self.tabBarItem.image=[UIImage imageNamed:@"Our_thanks_big.png"];
            CGImageRef imgRef=self.tabBarItem.image.CGImage;
            self.tabBarItem.image=[UIImage imageWithCGImage:imgRef scale:2.0f orientation:UIImageOrientationUp];
        }
    }
    return self;
}

- (void)dealloc
{
    [nc release];
    [main release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //setting UIView with UILabel with good font to navTitle
    UIView *navTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-160, self.navigationController.navigationBar.frame.size.height)];
    navTitleView.backgroundColor=[UIColor clearColor];
    navTitleView.clipsToBounds=YES;
    UILabel *navTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, navTitleView.frame.size.width, navTitleView.frame.size.height-5)];
    navTitleLabel.backgroundColor=[UIColor clearColor];
    navTitleLabel.textColor=[UIColor whiteColor];
    navTitleLabel.textAlignment=UITextAlignmentCenter;
    navTitleLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:18];
    navTitleLabel.text=self.title;
    [navTitleView addSubview:navTitleLabel];
    self.navigationItem.titleView=navTitleView;
    [navTitleLabel release];
    [navTitleView release];
    //
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.nc.navigationBar.barStyle=UIBarStyleBlack;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self renderView];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

@end
