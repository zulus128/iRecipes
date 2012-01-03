//
//  Recipes_ViewController.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Recipes_AppDelegate.h"
#import "Recipes_ViewController.h"
#import "Pack.h"
#import "OnePackViewController.h"
#import "OneRecipeViewController.h"
#import "MyNavController.h"

@implementation Recipes_ViewController
@synthesize packs, mainView, splashScreenView, nc;

-(void)performTransitionFromSplash{
    NSLog(@"Fading splash screen");
    CATransition *transition=[CATransition animation];
    transition.duration=0.5f;
    transition.type=kCATransitionFade;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.delegate=self;
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
    [self.splashScreenView.layer addAnimation:transition forKey:nil];
    self.splashScreenView.hidden=YES;
    //enabling interaction
    [self.view setUserInteractionEnabled:YES];
}

-(void)sortPacks{
    Pack *aPack;
    BOOL cont=TRUE;
    while (cont) {
        cont=FALSE;
        for (NSUInteger i=0;i<[packs count]-1;i++){
            if ([[[packs objectAtIndex:i] ident] unsignedIntegerValue]>[[[packs objectAtIndex:i+1] ident] unsignedIntegerValue]){
                aPack=[[Pack alloc] initWithPack:[packs objectAtIndex:i+1]];
                [packs replaceObjectAtIndex:i+1 withObject:[packs objectAtIndex:i]];
                [packs replaceObjectAtIndex:i withObject:aPack];
                cont=TRUE;
                [aPack release];
            }
        }
    }
}

-(void)packClicked:(id)sender{
    NSLog(@"Click!!!!");
    NSInteger packNum=[sender tag];
    Pack *aPack=[packs objectAtIndex:packNum-1];
    OnePackViewController *nextVC=[[OnePackViewController alloc] initWithPack:aPack reciped:aPack.reciped];
    [self.nc pushViewController:nextVC animated:YES];
    [nextVC release];
}

-(void)renderView{
    mainView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    mainView.backgroundColor=[UIColor clearColor];
    //setting background
    self.mainView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:mainView];
    //setting UIView with UILabel with good font to navTitle
    UIView *navTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-160, self.navigationController.navigationBar.frame.size.height)];
    navTitleView.backgroundColor=[UIColor clearColor];
    navTitleView.clipsToBounds=YES;
    UILabel *navTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, navTitleView.frame.size.width, navTitleView.frame.size.height-5)];
    navTitleLabel.backgroundColor=[UIColor clearColor];
    navTitleLabel.textColor=[UIColor whiteColor];
    navTitleLabel.textAlignment=UITextAlignmentCenter;
    navTitleLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:16];
    navTitleLabel.text=@"Блюдо за 7 шагов";
    [navTitleView addSubview:navTitleLabel];
    self.navigationItem.titleView=navTitleView;
    [navTitleLabel release];
    [navTitleView release];
    //
    CGFloat x=0;//нач коорд
    CGFloat y=10;//нач коорд
    Pack *eachPack;
    for (eachPack in packs){
        //setting course text
        /*UILabel *courseLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 280, 40)];
        courseLabel.backgroundColor=[UIColor clearColor];
        courseLabel.font=[UIFont fontWithName:BASE_FONT size:22];
        courseLabel.text=eachPack.name;
        courseLabel.textColor=[UIColor whiteColor];
        courseLabel.textAlignment=UITextAlignmentCenter;
        [mainView addSubview:courseLabel];
        y+=courseLabel.frame.size.height+5;*/
        //setting image
        UIImageView *imgView=[[UIImageView alloc] initWithImage:eachPack.img];
        if ([UIScreen mainScreen].applicationFrame.size.width==320){
            imgView.frame=CGRectMake(x, y, eachPack.img.size.width/2, eachPack.img.size.height/2);
        }
        else{
            imgView.frame=CGRectMake(x, y, eachPack.img.size.width, eachPack.img.size.height);
        }
        [mainView addSubview:imgView];
        y+=imgView.frame.size.height+20;
        //adding button over the img to controll clicks
        UIButton *imgButton=[UIButton buttonWithType:UIButtonTypeCustom];
        imgButton.tag=[eachPack.ident intValue];
        imgButton.frame=imgView.frame;
        imgButton.backgroundColor=[UIColor clearColor];
        [imgButton addTarget:self action:@selector(packClicked:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:imgButton];
        //adding number of recipes
        /*UILabel *recipesCount=[[UILabel alloc] initWithFrame:CGRectMake(x, y, imgView.frame.size.width*(0.25), 21)];
        recipesCount.text=[NSString stringWithFormat:@"%i ", [eachPack.recipes count]];
        if ([eachPack.recipes count]==1){
            recipesCount.text=[recipesCount.text stringByAppendingString:@"рецепт"];
        }
        else if ([eachPack.recipes count]<5 && [eachPack.recipes count]>1)
            recipesCount.text=[recipesCount.text stringByAppendingString:@"рецепта"];
        else if (([eachPack.recipes count]>4 && [eachPack.recipes count]<11)||([eachPack.recipes count]==0))
            recipesCount.text=[recipesCount.text stringByAppendingString:@"рецептов"];
        CGSize labelSize=[recipesCount.text sizeWithFont:[UIFont fontWithName:BASE_FONT size:17]];
        recipesCount.font=[UIFont fontWithName:BASE_FONT size:17];
        recipesCount.frame=CGRectMake(x, y, labelSize.width, 21);
        [mainView addSubview:recipesCount];
        y+=imgView.frame.size.height*(0.35)+10;*/
        //setting content size to make scrolling
        mainView.contentSize=CGSizeMake(mainView.frame.size.width, y+10);
        //releasing
        [imgView release];
    }
}

-(void)createCourses{
    NSString *groupsPath=[[NSBundle mainBundle] pathForResource:@"groups" ofType:@"plist"];
    NSMutableDictionary *groupsDict=[NSMutableDictionary dictionaryWithContentsOfFile:groupsPath];
    NSArray *groupsKeys=[groupsDict allKeys];
    NSString *eachKey;
    for (eachKey in groupsKeys){
        NSMutableDictionary *packDict=[groupsDict objectForKey:eachKey];
        Pack *aPack=[[Pack alloc] initWithDict:packDict withName:eachKey];
        [packs addObject:aPack];
        [aPack release];
    }
    [self sortPacks];
    NSLog(@"Packs count - %i", [packs count]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //setting tabbaritem image
        if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320){
            self.tabBarItem.image=[UIImage imageNamed:@"Recipes.png"];
        }
        else
        {
            self.tabBarItem.image=[UIImage imageNamed:@"Recipes_big.png"];
            CGImageRef imgRef=self.tabBarItem.image.CGImage;
            self.tabBarItem.image=[UIImage imageWithCGImage:imgRef scale:2.0f orientation:UIImageOrientationUp];
        }
        UIBarButtonItem *newBackButton=[[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:newBackButton];
        [newBackButton release];
    }
    return self;
}

- (void)dealloc
{
    [nc release];
    [splashScreenView release];
    [mainView release];
    [packs release];
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
    nc=self.navigationController;
    //setting splash screen and disabling user interaction while screen is fading
    [self.view setUserInteractionEnabled:NO];
    splashScreenView.image=[UIImage imageNamed:@"Default.png"];
    if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width!=320)
        splashScreenView.image=[UIImage imageNamed:@"Default@2x.png"];
    splashScreenView.frame=CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, splashScreenView.image.size.width/2, splashScreenView.image.size.height/2 - [UIApplication sharedApplication].statusBarFrame.size.height);
    if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width!=320)
        splashScreenView.frame=CGRectMake(0, 0, splashScreenView.image.size.width/2, splashScreenView.image.size.height/2);
    [self.tabBarController.view addSubview:splashScreenView];
    NSLog(@"Two seconds before fading splash...");
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(performTransitionFromSplash) userInfo:nil repeats:NO];
    //
    self.title=@"Рецепты";
    //читаем нужные курсы и кладем в packs;
    packs=[[NSMutableArray alloc] init];
    [self createCourses];
    //rendering the view
    [self renderView];
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [(MyTabBarController *)self.tabBarController cleanSubviews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border color:(CGColorRef)color{
    CALayer *layer=[view layer];
    layer.masksToBounds=YES;
    layer.cornerRadius=radius;
    layer.borderWidth=border;
    layer.borderColor=color;
}

@end
