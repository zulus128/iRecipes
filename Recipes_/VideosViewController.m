//
//  VideosViewController.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideosViewController.h"
#import "OnePackViewController.h"
#import "OneRecipeViewController.h"

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@implementation VideosViewController
@synthesize main, nc;
-(void)renderView{
    //adding main scrolling view
    main.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    main.backgroundColor=[UIColor clearColor];
    [self.view addSubview:main];
    //
//    UIImageView *main_back=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"oproekte.png"]];
    UIImageView *main_back=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320)
        main_back.frame=CGRectMake(0, 0, main_back.image.size.width/2, main_back.image.size.height/2);
    else
        main_back.frame=CGRectMake(0, 0, main_back.image.size.width/2, main_back.image.size.height/2);
    [main addSubview:main_back];
    //adding text
    /*CGFloat x=30;
    CGFloat y=20;
    CGSize size=[[NSString stringWithString:@"Рецепты от Изекелле Барбуто"] sizeWithFont:[UIFont fontWithName:BASE_FONT_BOLD size:15.0f]];
    UILabel *mainLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
    mainLabel.numberOfLines=1;
    mainLabel.backgroundColor=[UIColor clearColor];
    mainLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:15.0f];
    mainLabel.text=@"Рецепты от Изекелле Барбуто";
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.textAlignment=UITextAlignmentLeft;
    [main_back addSubview:mainLabel];
    y+=mainLabel.frame.size.height;
    UITextView *mainText=[[UITextView alloc] initWithFrame:CGRectMake(x-5, y, main_back.frame.size.width-50, 100)];
    mainText.text=@"Интерес к полезной, вкусной, а главное, домашней пище сейчас растет не только в Европе, но и в России. Приготовим вместе с вами вкусный ужим просто и быстро по моим 7 шагам! Добро пожаловать на вашу кухню!";
    mainText.backgroundColor=[UIColor clearColor];
    mainText.font=[UIFont fontWithName:BASE_FONT size:12.0f];
    mainText.frame=CGRectMake(x-5, y, main_back.frame.size.width-50, mainText.contentSize.height);
    mainText.frame=CGRectMake(x-5, y, main_back.frame.size.width-50, mainText.contentSize.height);
    mainText.userInteractionEnabled=NO;
    [main_back addSubview:mainText];*/

//    //adding e-mail
//    UITextView *mail=[[UITextView alloc] initWithFrame:CGRectMake(0, main_back.frame.size.height+10, self.view.frame.size.width, 40)];
//    mail.text=@"Info@7stepsmeal.com";
//    mail.backgroundColor=[UIColor clearColor];
//    mail.textColor=[UIColor whiteColor];
//    mail.editable=NO;
//    mail.font=[UIFont fontWithName:BASE_FONT size:20];
//    mail.dataDetectorTypes=UIDataDetectorTypeAll;
//    mail.textAlignment=UITextAlignmentCenter;
//    [self.main addSubview:mail];
//    [mail release];
//    //setting content size
//    main.contentSize=CGSizeMake(main_back.frame.size.width, mail.frame.origin.y+mail.frame.size.height+5);
    //releasing
    [main_back release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andNC:(UINavigationController *)navCtl
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.nc=navCtl;
        self.navigationController.title=NSLocalizedString(@"О проекте", @"О проекте");
        self.nc.title=NSLocalizedString(@"О проекте", @"О проекте");
        self.title=NSLocalizedString(@"О проекте", @"О проекте");
        self.tabBarItem.title=NSLocalizedString(@"О проекте", @"О проекте");
        if ([OneRecipeViewController physycalSizeOfScreen:[UIScreen mainScreen]].width==320)
//            self.tabBarItem.image=[UIImage imageNamed:@"About_project.png"];
                self.tabBarItem.image=[UIImage imageNamed:@"spisok.png"];
        else{
//            self.tabBarItem.image=[UIImage imageNamed:@"About_project_big.png"];
            self.tabBarItem.image=[UIImage imageNamed:@"spisok_big.png"];
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

- (void)showDialog {

    UIAlertView* dialog = [[UIAlertView alloc] init];
    dialog.delegate = self;
    [dialog setTitle:@"Внимание!"];
    [dialog setMessage:@"Вы можете обменяться впечатлениями в известных соц. сетях:"];
    [dialog addButtonWithTitle:@"В Контакте"];
    [dialog addButtonWithTitle:@"Facebook"];
    [dialog addButtonWithTitle:@"Отзыв в AppStore"];
    [dialog addButtonWithTitle:@"Отмена"];
    [dialog show];
    [dialog release];
}

- (void)viewDidAppear:(BOOL)animated {

    [self showDialog];
}

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
    self.title=NSLocalizedString(@"О проекте", @"О проекте");
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.nc.navigationBar.barStyle=UIBarStyleBlack;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self renderView];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    [self showDialog];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0){
        
//        NSLog(@"Ok");
        [self showDialog];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://vkontakte.ru/feed#/club34152049"]];

    }
    else
    if (buttonIndex == 1){
        
        //        NSLog(@"Ok");
        [self showDialog];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/pages/7stepsmeal/311972852176788"]];

    }
    else
        if (buttonIndex == 2){
            
            //        NSLog(@"Ok");
            [self showDialog];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/ru/app//id483076445?mt=8"]];
            
        }
    else {
        
        self.tabBarController.selectedIndex = 1;
    }
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
