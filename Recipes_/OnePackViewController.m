//
//  OnePackViewController.m
//  Recipes_
//
//  Created by Ravis on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnePackViewController.h"
#import "OneRecipeViewController.h"
#import "MyNavController.h"

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@implementation OnePackViewController
@synthesize curPack, mainView;

-(void)recipeClicked:(id)sender{
    NSLog(@"Click! tag(id)=%i", [sender tag]);
    Recipe *chosenRecipe;
    for (chosenRecipe in curPack.recipes){
        if ([chosenRecipe.ident intValue]==[sender tag])
            break;
    }
    NSLog(@"chosen recipe name - %@", chosenRecipe.name);
    OneRecipeViewController *recipeVC=[[OneRecipeViewController alloc] initWithRecipe:chosenRecipe];
    [self.navigationController pushViewController:recipeVC animated:YES];
    [recipeVC release];
}

-(void)renderView{
    //
    mainView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    //setting background
    self.mainView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];    
    //setting UIView with UILabel with good font to navTitle
    UIView *navTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-160, self.navigationController.navigationBar.frame.size.height)];
    navTitleView.backgroundColor=[UIColor clearColor];
    navTitleView.clipsToBounds=YES;
    UILabel *navTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, navTitleView.frame.size.width, navTitleView.frame.size.height-5)];
    navTitleLabel.backgroundColor=[UIColor clearColor];
    navTitleLabel.textColor=[UIColor whiteColor];
    navTitleLabel.textAlignment=UITextAlignmentCenter;
    navTitleLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:18];
    navTitleLabel.text=NSLocalizedString(@"Рецепты", @"Рецепты");
    [navTitleView addSubview:navTitleLabel];
    self.navigationItem.titleView=navTitleView;
    [navTitleLabel release];
    [navTitleView release];
    //
    [self.view addSubview:mainView];
    //setting 2nd background for recipes
    UIImageView *secBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back2.png"]];
    secBg.frame=CGRectMake(0, -1, secBg.image.size.width/2, secBg.image.size.height/2);
    [self.mainView addSubview:secBg];
    //setting margins, +15 или +30 из-за отступа bg, 
    CGFloat x=7+15;
    if ([UIScreen mainScreen].applicationFrame.size.width!=320)
        x+=15;
    CGFloat y=7;
    NSUInteger counter=0;
    Recipe *eachRecipe;
    for (eachRecipe in curPack.recipes){
        NSLog(@"Recipe!Rendering it out...%@", eachRecipe.name);
        //setting image view
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed: [eachRecipe.imgs objectAtIndex:[eachRecipe.imgs count]-1]]];
        if (imgView.image==nil) imgView.image=[UIImage imageNamed:@"test_image.png"];

        imgView.frame=CGRectMake(x, y, imgView.image.size.width/2, imgView.image.size.height/2);
        [secBg addSubview:imgView];
        //setting recipe title label
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(floor(x+3+imgView.frame.size.width), floor(y), floor(secBg.frame.size.width - imgView.frame.size.width - 50), floor(imgView.frame.size.height))];
        titleLabel.textAlignment=UITextAlignmentLeft;
        titleLabel.numberOfLines=0;
        titleLabel.lineBreakMode=UILineBreakModeWordWrap;
        titleLabel.font=[UIFont fontWithName:BASE_FONT size:12];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.text=eachRecipe.name;
        titleLabel.textColor=[UIColor blackColor];
//        titleLabel.center=CGPointMake(floor(titleLabel.center.x), floor(titleLabel.center.y));
        [secBg addSubview:titleLabel];
        //setting recipe manufacturer label
//        textSize=[eachRecipe.manufacturer sizeWithFont:[UIFont fontWithName:BASE_FONT size:17]];
//        CGFloat textWidth=textSize.width;
//        UILabel *manufLabel=[[UILabel alloc] initWithFrame:CGRectMake(x+imgView.frame.size.width-textWidth, y+imgView.frame.size.height-30, textWidth, 20)];
//        manufLabel.textAlignment=UITextAlignmentCenter;
//        manufLabel.font=[UIFont fontWithName:BASE_FONT size:16];
//        manufLabel.backgroundColor=[UIColor clearColor];
//        manufLabel.textColor=[UIColor blackColor];
//        manufLabel.text=eachRecipe.manufacturer;
//        [mainView addSubview:manufLabel];
        //making text underlined(by adding views with 1px height)
//        UIView *firstLine=[[UIView alloc] initWithFrame:CGRectMake(x+imgView.frame.size.width-textWidth, manufLabel.frame.origin.y+manufLabel.frame.size.height, manufLabel.frame.size.width, 2)];
//        firstLine.backgroundColor=[UIColor blackColor];
//        [mainView addSubview:firstLine];
//        [firstLine release];
        //adding button
        UIButton *imgButton=[UIButton buttonWithType:UIButtonTypeCustom];
        imgButton.frame=imgView.frame;
        imgButton.frame=CGRectMake(imgButton.frame.origin.x, imgButton.frame.origin.y, secBg.frame.size.width-2*x, imgButton.frame.size.height);
        imgButton.backgroundColor=[UIColor clearColor];
        imgButton.tag=[eachRecipe.ident intValue];
        [imgButton addTarget:self action:@selector(recipeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:imgButton];
        //adding line
        if (counter!=3)
        {
            UIImageView *lineView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
            lineView.frame=CGRectMake(x, y+imgView.frame.size.height+3, secBg.frame.size.   width-2*x, 1);
            lineView.alpha=0.1f;
            [secBg addSubview:lineView];
            [lineView release];
        }
        //increasing y for next recipe
        y+=imgView.frame.size.height+3+3;
        //setting content size
        mainView.contentSize=CGSizeMake(mainView.frame.size.width, y+5);
        //releasing
        [imgView release];
        [titleLabel release];
        //[manufLabel release];
        counter++;
    }
    mainView.contentSize=CGSizeMake(mainView.frame.size.width, secBg.frame.size.height);
    mainView.scrollEnabled=YES;
    [secBg release];
}

-(id)initWithPack:(Pack *)aPack reciped:(BOOL)idsOrNot{
    if (self=[super init])
    {
    self=[self initWithNibName:@"OnePackViewController" bundle:nil];
    self.curPack=aPack;
    //====replacing recipe ids with recipes(Recipe class object)
    if (!curPack.reciped){
        NSLog(@"total recipe ids - %i", [curPack.recipes count]);
        for (NSUInteger i=0;i<[curPack.recipes count];i++){
            NSNumber *eachId=[curPack.recipes objectAtIndex:i];
            NSLog(@"ID %i replacing with recipe", [eachId intValue]);
            NSString *recipesPath=[[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
            NSMutableDictionary *rootDict=[NSMutableDictionary dictionaryWithContentsOfFile:recipesPath];
            NSString *recipeKey=[NSString stringWithFormat:@"%i", [eachId intValue]];
            NSMutableDictionary *recipeDict=[rootDict objectForKey:recipeKey];
            Recipe *aRecipe=[[Recipe alloc] initWithDict:recipeDict withNumberId:eachId];
            [curPack.recipes replaceObjectAtIndex:i withObject:aRecipe];
            [aRecipe release];
        }
        curPack.reciped=YES;
    }
    NSLog(@"total recipes - %i", [curPack.recipes count]);
    //====
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [mainView release];
    [curPack release];
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
    //==rendering the view
    [self renderView];
    //==
    self.title=curPack.name;
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
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
    return interfaceOrientation==UIInterfaceOrientationPortrait;
}

-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border color:(CGColorRef)color{
    CALayer *layer=[view layer];
    layer.masksToBounds=YES;
    layer.cornerRadius=radius;
    layer.borderWidth=border;
    layer.borderColor=color;
}

@end
