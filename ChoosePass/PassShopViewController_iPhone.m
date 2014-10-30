//
//  PassShopViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "PassShopViewController_iPhone.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "NSDictionary+merchantInfo.h"
#import "AllMerchantCustomCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MerchantPassViewController_iPhone.h"
#import "OverlayViewController.h"
#import <objc/runtime.h>
#import "MerchantAccountViewController_iPhone.h"
#import "EditMerchantViewController_iPhone.h"

@interface PassShopViewController_iPhone ()

@end


@implementation PassShopViewController_iPhone
@synthesize responseDictionary;
const char MyConstantKey;

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
    UIButton *addNewMerchant = [UIButton buttonWithType:UIButtonTypeCustom ];
    [addNewMerchant addTarget:self
                       action:@selector(addNewMerchant:)
             forControlEvents:UIControlEventTouchDown];
    [addNewMerchant setImage:[UIImage imageNamed:@"add_new_merchant.png"] forState:UIControlStateNormal];
    [self.view addSubview:addNewMerchant];
    
    if(IS_IPHONE_5)
    {
        table.frame=CGRectMake(0, 108, 320, 415);
        addNewMerchant.frame = CGRectMake(0, 520, 320, 53);
    }
    else
    {
        table.frame=CGRectMake(0, 108, 321, 320);
        addNewMerchant.frame = CGRectMake(0, 430, 320, 53);
    }
}

-(IBAction)addNewMerchant:(id)sender
{
    MerchantAccountViewController_iPhone *merchantAccount=[[MerchantAccountViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"MerchantAccountViewController"] bundle:nil];
    [self.navigationController pushViewController:merchantAccount animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self performSelectorInBackground:@selector(getmerchantDetail) withObject:nil];

    searchArray=[[NSMutableArray alloc]init];
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = (id)self;
    _searchBar.placeholder=@"Search by zip,city or keyword";
    [_searchBar setBarTintColor:COLOR_ORANGE];
    _searchBar.frame=CGRectMake(0,64, 320, 44);
    [self.view addSubview:_searchBar];

    _searchBar.text = @"";
	[_searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
    [ovController.view removeFromSuperview];
	ovController = nil;
    [table reloadData];
}

#pragma mark - WebService for getting data
-(void)getmerchantDetail
{
    if([GlobalInstances checkNetwork]==FALSE)
    {
        UIAlertView *networkAlert = [[UIAlertView alloc]initWithTitle:nil message:@"There was a problem connecting to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [networkAlert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [appdelRef showProgress:@"Please wait.."];
        self.view.userInteractionEnabled = NO;
        
        NSString* xml;
        xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_all_merchant_admin xmlns=\"urn:passwebservices\"></get_all_merchant_admin></soap:Body></soap:Envelope>"];
        [self webServiceCallWithHeadder:xml];
    }
}

-(void)webServiceCallWithHeadder:(NSString*)xml
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlWebService]];
    
    request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    request.delegate = self;
    
    [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    
    [request appendPostData: [xml dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [request setDidFinishSelector:@selector(requestDidFinish:)];
    
    [request setDidFailSelector:@selector(requestDidFail:)];
    
    [request startAsynchronous];
}

-(void)requestDidFail:(ASIHTTPRequest*)request
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;
    [GlobalInstances showAlertMessage:@"Connection Failed." withMessage:@"Please try again"];
    return;
}

-(void)requestDidFinish:(ASIHTTPRequest*)request1
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;
    
    NSDictionary *dict1 = [XMLReader dictionaryForXMLString:request1.responseString error:nil];        NSDictionary* json_string= [[[[dict1 objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:get_all_merchant_adminResponse"]objectForKey:@"return"] ;
        NSString *str=[json_string valueForKey:@"text"];
        
        NSRange r;
        while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            str = [str stringByReplacingCharactersInRange:r withString:@""];
    
        str=[str stringByReplacingOccurrencesOfString:@"&#92;" withString:@""];

        responseDictionary=
        [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];

      NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
    
    if([response isEqualToString:@"SUCCESS"])
    {
        [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
    else
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:response message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(searching)
    {
        return [searchArray count];
    }
    
   else
   {
        NSArray *getArr=[responseDictionary arrCount];
        return [getArr count];
   }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AllMerchantCustomCell *tableViewCell=(AllMerchantCustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *array;
    if (tableViewCell == nil)
    {
        array=  [[NSBundle mainBundle] loadNibNamed:@"AllMerchantCustomCell" owner:self options:nil];
        tableViewCell=[array objectAtIndex:0];
    }
    NSDictionary *dictionary = nil;
    if(searching)
    {
        dictionary=searchArray[indexPath.row];
    }
    else
    {
        NSArray *arr=[responseDictionary arrCount];
        dictionary=arr[indexPath.row];
    }
    tableViewCell.merchantName.text=[dictionary companyName];
    tableViewCell.merchantCompany.text=[dictionary valueForKey:@"szHighlight"];

//    tableViewCell.merchantCompany.text=[NSString stringWithFormat:@"%@, %@, %@",[dictionary Address1],[dictionary city],[dictionary state]];
    [tableViewCell.merchantImage setImageWithURL:[NSURL URLWithString:[dictionary  uploadFilename]] placeholderImage:[UIImage imageNamed:@"frame1.png"]];
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    tableViewCell.delegate=self;
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
    [self selectRow:indexPath.row];
}

-(void)useButtonTapped:(id)sender
{
    NSIndexPath *indexPath=[table indexPathForCell:sender];
    [self selectRow:indexPath.row];
    
}

//Select Row Method
-(void)selectRow:(NSInteger)indexPath
{
    theAlertView=[[UIAlertView alloc]initWithTitle:@"What do you want?" message:@"What would you like to do?" delegate:self cancelButtonTitle:@"View Info" otherButtonTitles:@"View Passes",nil];
    [theAlertView show];
    theAlertView.delegate=self;
    theAlertView.tag=1;
    objc_setAssociatedObject(theAlertView, &MyConstantKey, [NSNumber numberWithInt:indexPath], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark-----alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag==1)
    {
        NSNumber *indexPath = objc_getAssociatedObject(alertView, &MyConstantKey);
        if([title isEqualToString:@"View Info"])
        {
            EditMerchantViewController_iPhone *merchantEdit=[[EditMerchantViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"EditMerchantViewController"] bundle:nil];
            NSArray *arr=[responseDictionary arrCount];
            NSDictionary *dict=nil;
            
            if(searching)
                dict=searchArray[[indexPath intValue]];
            else
                dict=arr[[indexPath intValue]];
        
            merchantEdit.getUserDetail=dict;
            [self.navigationController pushViewController:merchantEdit animated:YES];

        }
        else if([title isEqualToString:@"View Passes"])
        {
            MerchantPassViewController_iPhone *merchantPass=[[MerchantPassViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"MerchantPassViewController"] bundle:nil];
            NSArray *arr=[responseDictionary arrCount];
            NSDictionary *dict=nil;
            
            if(searching)
                dict=searchArray[[indexPath intValue]];
            else
                dict=arr[[indexPath intValue]];
            
            merchantPass.getId=[dict Id];
            NSString *str=[NSString stringWithFormat:@"%@",[dict companyName]];
            merchantPass.merchantName=str;
            merchantPass.getDictionary=dict;
            [self.navigationController pushViewController:merchantPass animated:YES];
        }
    }
}

#pragma mark Search Bar
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[_searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar
{
	if(searching)
		return;
    
	//Add the overlay view.
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
	
    //CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0,0, width, height);
	ovController.view.frame = frame;
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.Controller = self;
	
	[table insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = NO;
	letUserSelectRow = NO;
	table.scrollEnabled = NO;
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self action:@selector(doneSearching_Clicked:)];
}

-(void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    
	//Remove all objects first.
	[searchArray removeAllObjects];
	if([searchText length] > 0)
    {
		[ovController.view removeFromSuperview];
		searching = YES;
        letUserSelectRow = YES;
		table.scrollEnabled = YES;
		[self searchTableView];
	}
	else
    {
		[table insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		searching = NO;
		letUserSelectRow = NO;
		table.scrollEnabled = NO;
	}
    [table reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)searchTableView
{
	NSString *searchText = _searchBar.text;
    
    NSMutableArray *array1 =[[NSMutableArray alloc]init];
    [array1 addObjectsFromArray:[responseDictionary arrCount]];
    
     for (NSDictionary *sDict in array1)
    {
        NSString *sTemp1 = [sDict Firstname];
        NSString *sTemp2 = [sDict Lastname];
        NSString *sTemp3 = [sDict companyName];
        NSString *sTemp4=[sDict zipCode];
        
        NSRange titleResultsRange1 = [sTemp1 rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange titleResultsRange2= [sTemp2 rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange titleResultsRange3= [sTemp3 rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange titleResultsRange4= [sTemp4 rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (titleResultsRange1.length > 0 || titleResultsRange2.length > 0 || titleResultsRange3.length > 0 || titleResultsRange4.length > 0)
            [searchArray addObject:sDict];
    }
}

- (void) doneSearching_Clicked:(id)sender
{
    _searchBar.text = @"";
	[_searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	table.scrollEnabled = YES;
    [ovController.view removeFromSuperview];
	ovController = nil;
	
	[table reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
