//
//  OneRecipeViewController.m
//  Recipes_
//
//  Created by Ravis on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OneRecipeViewController.h"
#import "MyNavController.h"

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@implementation OneRecipeViewController
@synthesize curRecipe, mainView, rotatedView, dotControl, ingredientsPhoto, hideBtn, allowedToRotate, allowedToSpinBack;

-(void)checkLabel:(UILabel *)label{
    UIFont *font=label.font;
    CGSize size=[label.text sizeWithFont:font constrainedToSize:CGSizeMake(1000, 20)];
    NSLog(@"%f,%f", size.width, size.height);
    NSLog(@"%f,%f", label.frame.size.width, label.frame.size.height);
    while (size.width>label.frame.size.width){
        font=[UIFont fontWithName:BASE_FONT size:font.pointSize-1];
        size=[label.text sizeWithFont:font constrainedToSize:CGSizeMake(1000, 20)];
    }
    label.font=font;
}

-(NSString *)getIngredientNameFromId:(NSNumber *)ident{
    NSString *ingredsPath=[[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"];
    NSDictionary *ingredDict=[[[NSDictionary alloc] initWithContentsOfFile:ingredsPath] autorelease];
    return [ingredDict objectForKey:[NSString stringWithFormat:@"%i", [ident intValue]]];
    [ingredDict release];
}

-(void)spawnIngredPhoto{
    NSLog(@"Spawning ingred photo...");
    //starting rotation if needed to
    if (spinOrNot){
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.tabBarController.view.transform=CGAffineTransformIdentity;
        self.tabBarController.view.transform=CGAffineTransformMakeRotation(M_PI * 90 / 180);
        self.tabBarController.view.bounds=CGRectMake(0, 0, 480, 320);
        self.tabBarController.view.center=CGPointMake(160, 240);
        [UIView commitAnimations];
    }
    //starting spawn animation
    CATransition *transition=[CATransition animation];
    transition.duration=0.5f;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionFade;
    transition.delegate=self;
    [ingredientsPhoto.layer addAnimation:transition forKey:nil];
    [ingredientsPhoto setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self.tabBarController.tabBar.layer addAnimation:transition forKey:nil];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar.layer addAnimation:transition forKey:nil];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
    //
    allowedToRotate=NO;
    self.mainView.userInteractionEnabled=NO;
    self.tabBarController.tabBar.userInteractionEnabled=NO;
    self.hideBtn.enabled=YES;
    self.hideBtn.hidden=NO;
}

-(IBAction)hideIngredPhoto{
    NSLog(@"Hiding ingred photo...");
    //starting rotation if needed to
    if (spinOrNot){
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.tabBarController.view.transform=CGAffineTransformIdentity;
        self.tabBarController.view.transform=CGAffineTransformMakeRotation(M_PI * 0/ 180);
        self.tabBarController.view.bounds=CGRectMake(0, 0, 320, 480);
        self.tabBarController.view.center=CGPointMake(160, 240);
        [UIView commitAnimations];
    }
    //starting spawn animation
    CATransition *transition=[CATransition animation];
    transition.duration=0.5f;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionFade;
    transition.delegate=self;
    [ingredientsPhoto.layer addAnimation:transition forKey:nil];
    [ingredientsPhoto setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.tabBarController.tabBar.layer addAnimation:transition forKey:nil];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar.layer addAnimation:transition forKey:nil];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
    //
    allowedToRotate=YES;
    self.mainView.userInteractionEnabled=YES;
    self.tabBarController.tabBar.userInteractionEnabled=YES;
    [hideBtn.layer addAnimation:transition forKey:nil];
    self.hideBtn.enabled=NO;
    self.hideBtn.hidden=YES;
}

-(void)turnOffWorking{
    currentlyWorking=NO;
}

-(IBAction)dotControlValueChange:(id)sender{
    if (currentlyWorking){
        dotControl.currentPage=prevValueOfDotController;
        return;
    }
    currentlyWorking=YES;
    if ([sender currentPage]<prevValueOfDotController)
        [rotatedView setContentOffset:CGPointMake(rotatedView.contentOffset.x-rotatedView.frame.size.width, rotatedView.contentOffset.y) animated:YES];
    else if ([sender currentPage]>prevValueOfDotController)
        [rotatedView setContentOffset:CGPointMake(rotatedView.contentOffset.x+rotatedView.frame.size.width, rotatedView.contentOffset.y) animated:YES];
    prevValueOfDotController=[sender currentPage];
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(turnOffWorking) userInfo:nil repeats:NO];
}

-(void)transitToRotatedViewWithSender:(id)sender andInterfaceRotation:(UIInterfaceOrientation)interfaceRotation{
    if ([sender isKindOfClass:[UIButton class]]||![[sender description] compare:@"UIButton"])
    {
        if (!allowedToSpinBack) return;
        self.allowedToSpinBack=NO;
        NSLog(@"Button clicked and rotating 90");
        NSUInteger tag=0;
        if ([[sender description] compare:@"UIButton"])
            tag=[sender tag]+1;
        //starting rotation
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.tabBarController.view.transform=CGAffineTransformIdentity;
        if ((interfaceRotation!=UIInterfaceOrientationLandscapeLeft)||(interfaceRotation==UIInterfaceOrientationLandscapeRight))
            self.tabBarController.view.transform=CGAffineTransformMakeRotation(M_PI * 90 / 180);
        else if (interfaceRotation==UIInterfaceOrientationLandscapeLeft)
            self.tabBarController.view.transform=CGAffineTransformMakeRotation(M_PI * (-90)/180);
        self.tabBarController.view.bounds=CGRectMake(0, 0, 480, 320);
        self.tabBarController.view.center=CGPointMake(160, 240);
        [UIView commitAnimations];
        [self performTransitionToInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
        //moving to chosen step
        CGPoint moveToPoint=CGPointMake(480*tag, 0);
        [rotatedView setContentOffset:moveToPoint animated:NO];
        [self scrollViewDidEndDecelerating:rotatedView];
    }
    else if ([sender isKindOfClass:[UITapGestureRecognizer class]]||![[sender description] compare:@"UITapGestureRecognizer"]){
        allowedToSpinBack=YES;
        NSLog(@"Gesture clicked and rotating -90");
        //starting rotation
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.tabBarController.view.transform=CGAffineTransformIdentity;
        self.tabBarController.view.transform=CGAffineTransformMakeRotation(M_PI * 0 / 180);
        self.tabBarController.view.bounds=CGRectMake(0, 0, 320, 480);
        self.tabBarController.view.center=CGPointMake(160, 240);
        [UIView commitAnimations];
        [self performTransitionToInterfaceOrientation:UIInterfaceOrientationPortrait];
        //
    }
}

-(void)layoutScrollImages{
    NSArray *sub=[rotatedView subviews];
    UIImageView *eachImg=nil;
    CGFloat x=0;
    NSUInteger goodCounter=0;
    for (eachImg in sub){
        if ([eachImg isKindOfClass:[UIImageView class]]&&(eachImg.tag>0)){
            eachImg.frame=CGRectMake(x, 0, rotatedView.frame.size.width, rotatedView.frame.size.height);
            x+=rotatedView.frame.size.width;
            goodCounter+=1;
        }
    }
    //set content size
    rotatedView.contentSize=CGSizeMake(rotatedView.frame.size.width * (goodCounter-1), rotatedView.frame.size.height);
}

+(CGSize)physycalSizeOfScreen:(UIScreen *)scr{
    CGSize res=scr.bounds.size;
    if ([scr respondsToSelector:@selector(scale)]){
        CGFloat scale = scr.scale;
        res=CGSizeMake(res.width * scale, res.height * scale);
    }
    
    return res;
}

-(void)performTransitionToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation{
    if (firstLoad) return;
    CATransition *transition=[CATransition animation];
    transition.duration=0.5f;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionFade;
    transition.delegate=self;
    if (interfaceOrientation==UIInterfaceOrientationPortrait){
        [self.view.layer addAnimation:transition forKey:nil];
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController.navigationBar.layer addAnimation:transition forKey:nil];
        [self.tabBarController.tabBar.layer addAnimation:transition forKey:nil];
        mainView.hidden=NO;
        rotatedView.hidden=YES;
        dotControl.hidden=YES;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        self.tabBarController.tabBar.hidden=NO;
        self.navigationController.navigationBar.hidden=NO;

    }
    else{
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        [self.view.layer addAnimation:transition forKey:nil];
        [self.navigationController.navigationBar.layer addAnimation:transition forKey:nil];
        [self.tabBarController.tabBar.layer addAnimation:transition forKey:nil];
        mainView.hidden=YES;
        rotatedView.hidden=NO;
        dotControl.hidden=NO;
        rotatedView.frame=CGRectMake(0, 0, 480, 320);
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [rotatedView flashScrollIndicators];
        self.tabBarController.tabBar.hidden=YES;
        self.navigationController.navigationBar.hidden=YES;
    }
}

-(void)crossUp:(id)sender{
    if (currentCrossView.frame.size.width==currentCrossBtn.frame.size.width-15){
        [sender invalidate];
        currentCrossView=nil;
        currentCrossBtn=nil;
        return;
    }
    CGFloat curWidth=currentCrossView.frame.size.width;
    curWidth+=1;
    currentCrossView.frame=CGRectMake(currentCrossView.frame.origin.x, currentCrossView.frame.origin.y, curWidth, currentCrossView.frame.size.height);
}
-(void)crossDown:(id)sender{
    if (currentCrossView.frame.size.width==0){
        [sender invalidate];
        currentCrossView=nil;
        currentCrossBtn=nil;
        return;
    }
    CGFloat curWidth=currentCrossView.frame.size.width;
    curWidth-=1;
    currentCrossView.frame=CGRectMake(currentCrossView.frame.origin.x, currentCrossView.frame.origin.y, curWidth, currentCrossView.frame.size.height);
}

-(void)crossIngredient:(id) sender{
    if (currentCrossView!=nil){
        NSLog(@"Oops! Not finished yet!");
        return;
    }
    currentCrossBtn=sender;
    currentCrossView=[currentCrossBtn getViewToCross];
    NSTimer *crossTimer;
    if (currentCrossView.frame.size.width!=0){
        crossTimer=[NSTimer timerWithTimeInterval:0.002 target:self selector:@selector(crossDown:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:crossTimer forMode:NSRunLoopCommonModes];
    }
    else{
        crossTimer=[NSTimer timerWithTimeInterval:0.002 target:self selector:@selector(crossUp:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:crossTimer forMode:NSRunLoopCommonModes];
    }
}

-(void)renderView{
    //test
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    //setting scroll view size to fit screen
    mainView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.origin.y-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    mainView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:mainView];
    CGFloat x=0;
    CGFloat y=0;
    //setting UIView with UILabel with good font to navTitle
    UIView *navTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width-160, self.navigationController.navigationBar.frame.size.height)];
    navTitleView.backgroundColor=[UIColor clearColor];
    navTitleView.clipsToBounds=YES;
    UILabel *navTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, navTitleView.frame.size.width, navTitleView.frame.size.height-5)];
    navTitleLabel.backgroundColor=[UIColor clearColor];
    navTitleLabel.textColor=[UIColor whiteColor];
    navTitleLabel.textAlignment=UITextAlignmentCenter;
    navTitleLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:18];
    navTitleLabel.text=@"Блюдо";
    [navTitleView addSubview:navTitleLabel];
    self.navigationItem.titleView=navTitleView;
    [navTitleLabel release];
    [navTitleView release];
    //
    //adding image view
    UIImage *mainImg=[UIImage imageNamed:[curRecipe.imgs objectAtIndex:0]];
    if (mainImg==nil) mainImg=[UIImage imageNamed:@"test_image.png"];
    UIImageView *imgView;
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, mainImg.size.width/3 , mainImg.size.height/3)];
    else
        imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, mainImg.size.width/3 , mainImg.size.height/3)];
    imgView.image=mainImg;
    [mainView addSubview:imgView];
    //incresing y and x
    y+=imgView.frame.size.height + 5;
    //вставляем графику
    UIImageView *top_back=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top-back-center.png"]];
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        top_back.frame=CGRectMake(0, y, top_back.image.size.width/2, top_back.image.size.height/2);
    else
        top_back.frame=CGRectMake(0, y, top_back.image.size.width, top_back.image.size.height);
    [self.mainView addSubview:top_back];
    //increasing y
    y+=top_back.frame.size.height;
    //adding main back view
    UIImageView *main_back=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-center.png"]];
    main_back.clipsToBounds=YES;
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        main_back.frame=CGRectMake(0, y, main_back.frame.size.width/2, main_back.frame.size.height);
    else
        main_back.frame=CGRectMake(0, y, main_back.frame.size.width, main_back.frame.size.height);
    [self.mainView addSubview:main_back];    
    //adding recipes name
    x=20;
    y=0;
    CGSize nameSize=[[curRecipe.name stringByAppendingFormat:@" %@", curRecipe.persons] sizeWithFont:[UIFont fontWithName:BASE_FONT_BOLD size:14] constrainedToSize:CGSizeMake(main_back.frame.size.width-84, 400) lineBreakMode:UILineBreakModeClip];
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(x+22, y, main_back.frame.size.width-84, nameSize.height)];
    nameLabel.textAlignment=UITextAlignmentLeft;
    nameLabel.numberOfLines=0;
    nameLabel.lineBreakMode=UILineBreakModeClip;
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:14];
    nameLabel.text=curRecipe.name;
    nameLabel.text=[nameLabel.text stringByAppendingFormat:@" %@", curRecipe.persons];
    [main_back addSubview:nameLabel];
    //increasing y
    y+=nameLabel.frame.origin.y + nameLabel.frame.size.height + 8;
    //adding line
    UIImageView *lineView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        lineView.frame=CGRectMake(x, y, lineView.image.size.width/2 + 5, lineView.image.size.height);
    else
        lineView.frame=CGRectMake(x, y, lineView.image.size.width + 10, lineView.image.size.height);
    lineView.alpha=0.2f;
    [main_back addSubview:lineView];
    [lineView release];
    //increasing y
    y+=lineView.frame.size.height + 5;
    //adding ingreds and ingreds photo imgs
    UIImageView *ingredsImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ingred.png"]];
    ingredsImg.frame=CGRectMake(22, y, ingredsImg.image.size.width/2, ingredsImg.image.size.height*0.6);
    [main_back addSubview:ingredsImg];
    UIImageView *ingredPhotoView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ingred_photo.png"]];
    ingredPhotoView.frame=CGRectMake(main_back.frame.size.width - ingredPhotoView.image.size.width*1.2, y-ingredPhotoView.image.size.height/6, ingredPhotoView.image.size.width/1.5, ingredPhotoView.image.size.height/1.5);
    [main_back addSubview:ingredPhotoView];
    [ingredsImg release];
    [ingredPhotoView release];
    //adding ingredphoto button
    UIButton *ingredBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ingredBtn.frame=CGRectMake(ingredPhotoView.frame.origin.x, ingredPhotoView.frame.origin.y+main_back.frame.origin.y+5, ingredPhotoView.frame.size.width, ingredPhotoView.frame.size.height-5);
    [ingredBtn addTarget:self action:@selector(spawnIngredPhoto) forControlEvents:UIControlEventTouchUpInside];
    [ingredBtn setShowsTouchWhenHighlighted:YES];
    [ingredBtn setBackgroundColor:[UIColor clearColor]];
    [mainView addSubview:ingredBtn];
    //increase y
    y+=ingredsImg.frame.size.height + 5;
    //rendering ingredients
    CGFloat nameWidth;
    CGFloat nameHeight;
    NSArray *keyArray=[curRecipe.ingreds allKeys];
    NSArray *orderArray=curRecipe.ingredsOrder;
    NSUInteger orderCounter=0;//for right order of ingredients
    NSString *eachKey;
    for (eachKey in keyArray){
        eachKey=[self getIngredientNameFromId:[orderArray objectAtIndex:orderCounter]];
        NSString *finalString=[NSString stringWithString:@"• "];
        finalString=[finalString stringByAppendingString:eachKey];
        finalString=[finalString stringByAppendingString:@" - "];
        finalString=[finalString stringByAppendingString:[curRecipe.ingreds objectForKey:eachKey]];
        UILabel *ingredientLabel=[[UILabel alloc] initWithFrame:CGRectMake(floor(x+21.5), floor(y), floor(main_back.frame.size.width-x-43), floor(26))];
        ingredientLabel.backgroundColor=[UIColor clearColor];
        ingredientLabel.text=finalString;
        ingredientLabel.textColor=[UIColor colorWithRed:0.4f green:0.1f blue:0.1f alpha:1];
        ingredientLabel.font=[UIFont fontWithName:BASE_FONT size:14];
        [self checkLabel:ingredientLabel];
        nameSize=[finalString sizeWithFont:ingredientLabel.font];
        nameWidth=nameSize.width+7;
        nameHeight=nameSize.height;
        //adding view and button for crossing the ingredient
        UIView *crossView=[[UIView alloc] initWithFrame:CGRectMake(ingredientLabel.frame.origin.x+5, ingredientLabel.frame.origin.y+ingredientLabel.frame.size.height/2, 0, 1)];
        crossView.backgroundColor=[UIColor colorWithWhite:0.2f alpha:1.0f];
        crossView.clipsToBounds=YES;
        [main_back addSubview:crossView];
        //making invisible button
        CrossButton *crossBtn=[[CrossButton alloc] initWithFrame:CGRectMake(ingredientLabel.frame.origin.x, ingredientLabel.frame.origin.y, nameWidth, nameHeight) andViewToCross:crossView];
        crossBtn.frame=CGRectMake(x+21.5, y+main_back.frame.origin.y, crossBtn.frame.size.width, crossBtn.frame.size.height);
        [crossBtn addTarget:self action:@selector(crossIngredient:) forControlEvents:UIControlEventTouchUpInside];
        crossBtn.backgroundColor=[UIColor clearColor];
        [mainView addSubview:crossBtn];
        //releasing
        [crossBtn release];
        [crossView release];
        [main_back addSubview:ingredientLabel];
        [ingredientLabel release];
        //increase y
        y+=ingredientLabel.frame.size.height;
        //increasing ordercounter, counter made for right order of ingredients
        orderCounter++;
    }
    //increasing y
    y+=15;
    //adding steps top and label
    UIImageView *stepsTop=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-steps.png"]];
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        stepsTop.frame=CGRectMake(0, y, stepsTop.image.size.width/2, stepsTop.image.size.height*0.6);
    else
        stepsTop.frame=CGRectMake(0, y, stepsTop.image.size.width, stepsTop.image.size.height);
    [main_back addSubview:stepsTop];
    [stepsTop release];
    UILabel *stepsLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, stepsTop.frame.size.height/10, stepsTop.frame.size.width, stepsTop.frame.size.height)];
    stepsLabel.backgroundColor=[UIColor clearColor];
    stepsLabel.textAlignment=UITextAlignmentCenter;
    stepsLabel.font=[UIFont fontWithName:BASE_FONT_BOLD size:16];
    stepsLabel.text=@"Шаги";
    stepsLabel.textColor=[UIColor colorWithRed:0.8f green:0.2f blue:0.2f alpha:1];
    [stepsTop addSubview:stepsLabel];
    [stepsLabel release];
    //increasing y
    y+=stepsTop.frame.size.height-5;
    //rendering steps
    NSString *eachStep;
    UIImage *eachImg;
    for (NSUInteger i=0;i<[curRecipe.steps count];i++){
        eachStep=[curRecipe.steps objectAtIndex:i];
        eachImg=[UIImage imageNamed:[curRecipe.imgs objectAtIndex:i+1]]; //MUST BE UNCOMMENTED AFTER MAKING PATHS TO REAL IMGS
        //adding image
        UIImageView *stepImgView=[[UIImageView alloc] initWithImage:eachImg];
        stepImgView.frame=CGRectMake(x+21.5, y, eachImg.size.width/2, eachImg.size.height/2);
        [main_back addSubview:stepImgView];
        [stepImgView release];
        //adding button
        UIButton *ingredButton=[UIButton buttonWithType:UIButtonTypeCustom];
        ingredButton.backgroundColor=[UIColor clearColor];
        ingredButton.frame=CGRectMake(stepImgView.frame.origin.x, stepImgView.frame.origin.y+main_back.frame.origin.y, stepImgView.frame.size.width, stepImgView.frame.size.height);
        ingredButton.tag=i;
        [ingredButton addTarget:self action:@selector(transitToRotatedViewWithSender:andInterfaceRotation:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:ingredButton];
        //increasing y
        y+=stepImgView.frame.size.height+1;
        //adding text
        UITextView *stepText=[[UITextView alloc] init];
        stepText.userInteractionEnabled=NO;
        stepText.text=[NSString stringWithFormat:@"%i. %@", i+1, eachStep];
        stepText.font=[UIFont fontWithName:@"Arial-ItalicMT" size:15];
        stepText.frame=CGRectMake(x, y, stepImgView.frame.size.width, stepText.contentSize.height);
        stepText.frame=CGRectMake(x+19, y, stepImgView.frame.size.width, stepText.contentSize.height);
        stepText.backgroundColor=[UIColor clearColor];
        [main_back addSubview:stepText];
        [stepText release];
        //increasing y
        y+=stepText.frame.size.height+15;
    }
    //changing main back height
    main_back.frame=CGRectMake(main_back.frame.origin.x, main_back.frame.origin.y, main_back.frame.size.width, y);
    //adding bottom back
    UIImageView *back_bottom=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom-back-center.png"]];
    if ([UIScreen mainScreen].applicationFrame.size.width==320)
        back_bottom.frame=CGRectMake(0, main_back.frame.origin.y + main_back.frame.size.height, back_bottom.image.size.width/2, back_bottom.image.size.height/2);
    else
        back_bottom.frame=CGRectMake(0, main_back.frame.origin.y + main_back.frame.size.height, back_bottom.image.size.width, back_bottom.image.size.height);
    [mainView addSubview:back_bottom];
    //setting content size
    mainView.contentSize=CGSizeMake(mainView.frame.size.width, back_bottom.frame.origin.y + back_bottom.frame.size.height + 5);
    //adding hideBtn above all layers
    [self.view addSubview:hideBtn];
    //releasing
    [imgView release];
    [nameLabel release];
    [top_back release];
    [main_back release];
    [back_bottom release];
}

-(id)initWithRecipe:(Recipe *)chosenRecipe{
    if(self=[super init]){
        self.curRecipe=chosenRecipe;
        firstLoad=YES;
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
    [hideBtn release];
    [ingredientsPhoto release];
    [dotControl release];
    [rotatedView release];
    [mainView release];
    [curRecipe release];
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
    self.allowedToRotate=YES;
    self.allowedToSpinBack=YES;
    //setting ingredients photo
    if (curRecipe.ingredsPhoto==nil)
        curRecipe.ingredsPhoto=[UIImage imageNamed:@"test_image.png"];
    ingredientsPhoto.image=curRecipe.ingredsPhoto;
    ingredientsPhoto.frame=CGRectMake(0, 0, ingredientsPhoto.image.size.width/2, ingredientsPhoto.image.size.height/2);
    [ingredientsPhoto setHidden:YES];
    [self.tabBarController.view addSubview:ingredientsPhoto];
    if (ingredientsPhoto.image.size.width==640)
        spinOrNot=NO;
    else
        spinOrNot=YES;
    hideBtn.frame=CGRectMake(-500, -500, 1000, 1000);
    hideBtn.backgroundColor=[UIColor blackColor];
    hideBtn.hidden=YES;
    hideBtn.enabled=NO;
    //setting rotated view
    rotatedView.frame=CGRectMake(0, 0, 480, 320);
    [rotatedView setBounces:NO];
    [rotatedView setBackgroundColor:[UIColor blackColor]];
    [rotatedView setCanCancelContentTouches:YES];
    [rotatedView setClipsToBounds:YES];
    [rotatedView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    [rotatedView setScrollEnabled:YES];
    [rotatedView setPagingEnabled:YES];
    [rotatedView setDelegate:self];
    [rotatedView setScrollIndicatorInsets:UIEdgeInsetsMake(-100, -100, -100, -100)];
    [rotatedView setTag:1993];
    [rotatedView setHidden:YES];
    //adding button on rotatedView
    UITapGestureRecognizer *recogn=[[UITapGestureRecognizer alloc] init];
    [recogn setDelegate:self];
    [recogn setNumberOfTapsRequired:1];
    [recogn setNumberOfTouchesRequired:1];
    [recogn addTarget:self action:@selector(transitToRotatedViewWithSender:andInterfaceRotation:)];
    [rotatedView addGestureRecognizer:recogn];
    [recogn release];
    NSLog(@"%i",[rotatedView.gestureRecognizers count]);
    //load all images
    for (NSUInteger i=0;i<[curRecipe.imgs count]-1;i++){
        UIImage *curImg=[UIImage imageNamed:[curRecipe.imgs objectAtIndex:i]];
        UIImageView *curView=[[UIImageView alloc] initWithImage:curImg];
        curView.frame=rotatedView.frame;
        curView.tag=i+1;
        [rotatedView addSubview:curView];
        [curView release];
    }
    [self layoutScrollImages];
    //adding page control with dots
    dotControl.frame=CGRectMake(rotatedView.frame.origin.x, rotatedView.frame.size.height-30, rotatedView.frame.size.width, 30);
    dotControl.numberOfPages=[rotatedView.subviews count]-3;
    dotControl.currentPage=0;
    dotControl.backgroundColor=[UIColor clearColor];
    [dotControl setTag:1993];
    [dotControl setHidden:YES];
    //adding them
    [[[self tabBarController] view]addSubview:rotatedView];
    [[[self tabBarController] view]addSubview:dotControl];
    //for crossing ingreds
    currentCrossView=nil;
    //getting ingredient names instead of numbers
    [curRecipe getIngrNames];
    self.title=curRecipe.name;
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
    if (!allowedToRotate)
        return (interfaceOrientation==UIInterfaceOrientationPortrait);
    NSLog(@"Should...");
    if (interfaceOrientation==UIInterfaceOrientationPortrait){
        [self transitToRotatedViewWithSender:[UITapGestureRecognizer class] andInterfaceRotation:interfaceOrientation];
    }
    else{
        [self transitToRotatedViewWithSender:[UIButton class] andInterfaceRotation:interfaceOrientation];
    }
    firstLoad=NO;
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border color:(CGColorRef)color{
    CALayer *layer=[view layer];
    layer.masksToBounds=YES;
    layer.cornerRadius=radius;
    layer.borderWidth=border;
    layer.borderColor=color;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    dotControl.currentPage=((NSUInteger)scrollView.contentOffset.x) / (scrollView.frame.size.width);
    prevValueOfDotController=dotControl.currentPage;
}

@end
