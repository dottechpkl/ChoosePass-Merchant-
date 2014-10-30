//
//  InfoViewController_iPhone.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/3/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "InfoViewController_iPhone.h"
#import "LoginViewController_iPhone.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+SBJSON.h"
#import "XMLReader.h"
#import "AppDelegate.h"

@interface InfoViewController_iPhone ()

@end

@implementation InfoViewController_iPhone
@synthesize pageControl=_pageControl;

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
  //  [self performSelectorInBackground:@selector(getImages) withObject:nil];
}

-(void)getImages
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
        
        NSString* xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><app_three_images xmlns=\"urn:passwebservices\"></app_three_images></soap:Body></soap:Envelope>"];
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
    
    arrayforImages=[[NSMutableArray alloc]initWithCapacity:0];
    
    NSDictionary *dict = [XMLReader dictionaryForXMLString:request1.responseString error:nil];
    
    NSDictionary* json_string = [[[[dict objectForKey:@"SOAP-ENV:Envelope"] objectForKey:@"SOAP-ENV:Body"] objectForKey:@"ns1:app_three_imagesResponse"]objectForKey:@"return"];
    NSString *str=[json_string valueForKey:@"text"];
    
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:r withString:@""];

    
    NSDictionary *responseDictionary =
    [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSISOLatin1StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
    NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
    NSArray *getImagesArray=[responseDictionary valueForKey:@"app_image_list"];
    NSString *string =getImagesArray[0];
    
    if([response isEqualToString:@"SUCCESS"])
    {
        if([string isKindOfClass:[NSString class]]==YES)
        {
            if([string isEqualToString:@"No Record Found."])
            {
                [arrayforImages addObject:[UIImage imageNamed:@"frame1.png"]];
                [arrayforImages addObject:[UIImage imageNamed:@"frame1.png"]];
                [arrayforImages addObject:[UIImage imageNamed:@"frame1.png"]];
                [appdelRef hideProgress];
                self.view.userInteractionEnabled = YES;
                
                [self performSelectorOnMainThread:@selector(showImages) withObject:nil waitUntilDone:YES];

            }
        }
        else
        {
            for(NSDictionary *dict in getImagesArray)
            {
                NSString *str=[dict valueForKey:@"szFileName"];
                UIImage *image =[UIImage imageWithData:
                                 [NSData dataWithContentsOfURL:
                                  [NSURL URLWithString:str]]];
                [arrayforImages addObject:image];
            }
            [appdelRef hideProgress];
            self.view.userInteractionEnabled = YES;

            [self performSelectorOnMainThread:@selector(showImages) withObject:nil waitUntilDone:YES];
        }
    }
    else
    {
        [appdelRef hideProgress];
        self.view.userInteractionEnabled = YES;

        [GlobalInstances showAlertMessage:response withMessage:@"Images not found."];
    }
}

-(void)showImages
{
    _pageControl = [[StyledPageControl alloc] init];
    if(IS_IPHONE_5)
        _pageControl.frame=CGRectMake(127, 465, 66, 32);
    else
    _pageControl.frame=CGRectMake(127, 395, 66, 32);
    [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_pageControl setPageControlStyle:PageControlStyleThumb];
    [_pageControl setThumbImage:[UIImage imageNamed:@"disableDot.png"]];
    [_pageControl setSelectedThumbImage:[UIImage imageNamed:@"enableDot.png"]];
    [_pageControl setUserInteractionEnabled:FALSE];
    [self.view addSubview:_pageControl];
    
    pageControlBeingUsed = NO;
    
    for (int i = 0; i < arrayforImages.count; i++)
    {
		CGRect frame;
		frame.origin.x = scrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = scrollView.frame.size;
		
		UIView *subview = [[UIView alloc] initWithFrame:frame];
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[arrayforImages objectAtIndex:i]];
        
        if(IS_IPHONE_5)
           imageView.frame=CGRectMake(0,0,298,366);
        else
           imageView.frame=CGRectMake(0,0,298,302);
        
        [subview addSubview:imageView];
    
		[scrollView addSubview:subview];
	}
    
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * arrayforImages.count, scrollView.frame.size.height);
	
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = (int)arrayforImages.count;
}

#pragma mark -----------Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

#pragma mark -----------Change Page
- (IBAction)changePage {
	// Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = scrollView.frame.size;
	[scrollView scrollRectToVisible:frame animated:YES];
	
	pageControlBeingUsed = YES;
}

- (IBAction)loginAction:(id)sender
{
    LoginViewController_iPhone *login=[[LoginViewController_iPhone alloc]initWithNibName:[GlobalInstances xibNameForName:@"LoginViewController"] bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
