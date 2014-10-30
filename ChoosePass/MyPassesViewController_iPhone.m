//
//  MyPassesViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/27/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "MyPassesViewController_iPhone.h"
#import "AppDelegate.h"
#import "ShowPassCustomCell.h"
#import "NSDictionary+userPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+SBJSON.h"
#import "XMLReader.h"


@interface MyPassesViewController_iPhone ()


@end

@implementation MyPassesViewController_iPhone



@synthesize showScreen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([showScreen isEqualToString:@"MyPasses"])
        topLabel.text=@"My Passes";
    else
        topLabel.text=@"Manage Passes";
    
    topLabel.textColor=[UIColor whiteColor];
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
    
    myPasses=[[NSMutableArray alloc]init];
    boolArray = [[NSMutableDictionary alloc] init];

     NSString *response=[[(appdelRef).myPassesDictionary valueForKey:@"site_response"]valueForKey:@"response"];
    NSArray *arr;
    arr=[(appdelRef).myPassesDictionary  valueForKey:@"merchant_passes"];

    
    NSString *string =arr[0];
    
    if([response isEqualToString:@"SUCCESS"])
    {
        if([string isKindOfClass:[NSString class]]==YES)
        {
            if([string isEqualToString:@"No Record Found."])
                [GlobalInstances showAlertMessage:response withMessage:string];
            table.hidden=true;
        }
        else
        {
            for(NSDictionary *dict in arr)
            {
                [myPasses  addObject:dict];
            }
            [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    }
    else
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:response message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myPasses count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ShowPassCustomCell *tableViewCell=(ShowPassCustomCell*)[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *array;
    if (tableViewCell == nil)
    {
        array=  [[NSBundle mainBundle] loadNibNamed:@"ShowPassCustomCell" owner:self options:nil];
        tableViewCell=[array objectAtIndex:0];
        tableViewCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dictionary;
    dictionary=myPasses[indexPath.row];
    
    tableViewCell.labelCell.text = [dictionary merchantName_user];
    tableViewCell.label2Cell.text = [dictionary szDescription_user];
    tableViewCell.label2Cell.frame=CGRectMake(127, 27, 160, 50);
    [tableViewCell.imageViewCell setImageWithURL:[NSURL URLWithString:[dictionary  szUploadImageName_user]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
    tableViewCell.buttonCell.hidden=TRUE;
    
    if ([tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView1 setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (indexPath.row % 2 == 0)
    {
        [tableViewCell setBackgroundColor:cell1_color];
    }
    else
    {
        [tableViewCell setBackgroundColor:cell2_color];
    }
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
