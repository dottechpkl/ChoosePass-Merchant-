//
//  InfoViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/3/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledPageControl.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface InfoViewController_iPhone : UIViewController<UIScrollViewDelegate>
{
    ASIFormDataRequest *request;
    IBOutlet UIScrollView *scrollView;
    BOOL pageControlBeingUsed;
    NSMutableData *responseData;
    NSMutableArray *arrayforImages;
    UIPageControl* pageControl;

}
@property (nonatomic) StyledPageControl *pageControl;
- (IBAction)changePage;
- (IBAction)loginAction:(id)sender;

@end

