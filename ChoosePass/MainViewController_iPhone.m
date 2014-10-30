//
//  MainViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 5/29/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "MainViewController_iPhone.h"
#import "PassShopViewController_iPhone.h"
#import "PassShopViewController_iPhone.h"
#import "EditMerchantViewController_iPhone.h"


@interface MainViewController_iPhone ()

@end

@implementation MainViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [firstBtn setTitle: @"Account" forState: UIControlStateNormal];
    firstBtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    
    [secondBtn setTitle: @"Your Listed Passes" forState: UIControlStateNormal];
    secondBtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    
    [thirdBtn setTitle: @"New" forState: UIControlStateNormal];
    thirdBtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self removeChildVeiwController];
    second=[[SecondViewController_iPhone alloc]initWithNibName:@"SecondViewController_iPhone" bundle:nil];
    if(IS_IPHONE_5)
        second.view.frame = CGRectMake(self.view.frame.origin.x+0, self.view.frame.origin.y+64,320, 504);
    else
        second.view.frame = CGRectMake(self.view.frame.origin.x+0, self.view.frame.origin.y+64,320, 416);
    [self addChildViewController:second];
    [self.view addSubview:second.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)removeChildVeiwController
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    vc=nil;
}

-(IBAction)firstBtnAction:(id)sender
{
    EditMerchantViewController_iPhone* edit=[[EditMerchantViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"EditMerchantViewController"] bundle:nil];
    [self.navigationController pushViewController:edit animated:YES];
}

-(IBAction)secondBtnAction:(id)sender
{
//    [self removeChildVeiwController];
//    second=[[SecondViewController_iPhone alloc]initWithNibName:@"SecondViewController_iPhone" bundle:nil];
//    [self addChildViewController:second];
//    if(IS_IPHONE_5)
//    second.view.frame = CGRectMake(self.view.frame.origin.x+0, self.view.frame.origin.y+64,320, 504);
//    else
//    second.view.frame = CGRectMake(self.view.frame.origin.x+0, self.view.frame.origin.y+64,320, 416);
//    [self.view addSubview:second.view];
}

- (IBAction)thirdBtnAction:(id)sender
{
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    if(height==568)
    {
        CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView" bundle:nil];
            create.update=@"No";
            create.toplabel=@"Add Pass";
           [self.navigationController pushViewController:create animated:YES];
    }
    else
    {
        CreateNewPassesView *create=[[CreateNewPassesView alloc]initWithNibName:@"CreateNewPassesView4" bundle:nil];
        create.update=@"No";
        create.toplabel=@"Add Pass";
        [self.navigationController pushViewController:create animated:YES];
    }
}

@end
