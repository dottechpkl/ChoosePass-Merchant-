//
//  LocationDetailViewController_iPhone.h
//  ChoosePass
//
//  Created by Dottechnologies on 7/21/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface LocationDetailViewController_iPhone : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    IBOutlet UILabel *topLabel;
    NSMutableData *responsedata;
    NSURLConnection *conn,*conn1;
    IBOutlet UITextField *locnicktext,*phonetext,*add1text,*add2text,*citytext,*statetext,*ziptext,*pointtext;
    NSDictionary *dic;
    UIImage *getImage;
    NSString *imageDataAsString, *strimage;
    UIImagePickerController *imagePicker;
    NSData *imageData;
    IBOutlet   UIImageView *imgProfile;
    IBOutlet UIButton *button_image;
    ASIFormDataRequest *request;
}
@property(strong,nonatomic)NSString *passlocid,*passzipcode,*passlocnickname,*update;
@property (strong,nonatomic)NSString *checkWebservce;
@property(strong,nonatomic)NSString *merchantId_locationdetail;

@end
