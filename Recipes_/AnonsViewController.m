//
//  AnonsViewController.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnonsViewController.h"
#import "OnePackViewController.h"
#import "OneRecipeViewController.h"

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@implementation AnonsViewController
@synthesize mainView, nc;

-(void)checkLabel:(UILabel *)label{
    UIFont *font=label.font;
    CGSize size=[label.text sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
    while (size.height>label.frame.size.height){
        font=[UIFont fontWithName:BASE_FONT size:font.pointSize-1];
        size=[label.text sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
    }
    label.font=font;
}

-(void)renderView{
    //==
    self.mainView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.origin.y-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    //==
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
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
    //==
    //adding all content
    CGFloat x=30;
    CGFloat y=20;
    UIImageView *topBack=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top-back-center.png"]];
    topBack.frame=CGRectMake(0, y, topBack.image.size.width/2, topBack.image.size.height/2);
    [mainView addSubview:topBack];
    //
    y+=topBack.frame.size.height;
    [topBack release];
    //
    UIImageView *centerBack=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-center.png"]];
    centerBack.frame=CGRectMake(0, y, centerBack.image.size.width/2, centerBack.image.size.height/2);
    [mainView addSubview:centerBack];
    y=5;
    //filling centerBack
    NSString *rootPath=[[NSBundle mainBundle] pathForResource:@"anons" ofType:@"plist"];
    NSArray *rootArray=[[NSArray alloc] initWithContentsOfFile:rootPath];
    for (NSUInteger i=0;i<[rootArray count];i++){
        NSDictionary *curDict=[rootArray objectAtIndex:i];
        UIImage *curImg=[UIImage imageNamed:[curDict objectForKey:@"image"]];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, curImg.size.width/2, curImg.size.height/2)];
        imgView.image=curImg;
        NSString *name=[curDict objectForKey:@"name"];
        NSLog(@"%@", name);
        UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(centerBack.frame.size.width/2, y, (centerBack.frame.size.width-40)/2, curImg.size.height/2)];
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.text=name;
        nameLabel.numberOfLines=0;
        nameLabel.textAlignment=UITextAlignmentLeft;
        nameLabel.textColor=[UIColor blackColor];
        nameLabel.font=[UIFont fontWithName:BASE_FONT size:15];
        nameLabel.lineBreakMode=UILineBreakModeWordWrap;
        [self checkLabel:nameLabel];
        y+=imgView.frame.size.height+10;
        UIImageView *line=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        line.frame=CGRectMake(x-7.5, y, line.image.size.width/2, 1);
        if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width!=320)
            line.frame=CGRectMake(x-7.5, y, line.image.size.width/2, 0.5);
        line.alpha=0.3f;
        line.center=CGPointMake(floor(line.center.x), floor(line.center.y));
        
        [centerBack addSubview:imgView];
        [centerBack addSubview:nameLabel];
        [centerBack addSubview:line];
        
        y+=line.frame.size.height+10;
        
        [imgView release];
        [nameLabel release];
        [line release];
    }
    y-=13;
    centerBack.frame=CGRectMake(centerBack.frame.origin.x, centerBack.frame.origin.y, centerBack.frame.size.width, y);
    //
    y=centerBack.frame.size.height+centerBack.frame.origin.y;
    UIImageView *bottomBack=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom-back-center.png"]];
    bottomBack.frame=CGRectMake(0, y, bottomBack.image.size.width/2, bottomBack.image.size.height/2);
    [mainView addSubview:bottomBack];
    [bottomBack release];
    y+=bottomBack.frame.size.height+10;
    //
    mainView.contentSize=CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, y+10);
    //
    [centerBack release];
    [rootArray release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andNC:(UINavigationController *)navCtl
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.nc=navCtl;
        self.navigationController.title=NSLocalizedString(@"Анонс", @"Анонс");
        self.nc.title=NSLocalizedString(@"Анонс", @"Анонс");
        self.title=NSLocalizedString(@"Анонс", @"Анонс");
        if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320)
            self.tabBarItem.image=[UIImage imageNamed:@"Anons.png"];
        else{
            self.tabBarItem.image=[UIImage imageNamed:@"Anons_big.png"];
            CGImageRef imgRef=self.tabBarItem.image.CGImage;
            self.tabBarItem.image=[UIImage imageWithCGImage:imgRef scale:2.0f orientation:UIImageOrientationUp];
        }
    }
    return self;
}

- (void)dealloc
{
    [nc release];
    [mainView release];
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
    //view rendering function
    [self renderView];
    //
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.nc.navigationBar.barStyle=UIBarStyleBlack;
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
