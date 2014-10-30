//
//  CreateNewPassesView.h
//  merchant
//
//  Created by Dottechnologies on 08/07/14.
//  Copyright (c) 2014 DotTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLReader.h"
#import "GlobalInstances.h"
#import "JSON.h"
//#import "YourListedPassesView.h"
@class YourListedPassesView;
@interface CreateNewPassesView : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    IBOutlet UIScrollView *scroll;
    NSMutableData *responsedata;
    NSURLConnection *categoryconn,*merchantconn,*saveconn;
    NSMutableArray *catarray,*merarray,*appendarray,*namearray,*catnamearray,*catappendarray,*array;
    IBOutlet UITableView *table,*table1,*table2,*table3;
    IBOutlet UIButton *catbtn,*merbtn,*actbtn;
    IBOutlet UIView *view1,*view2,*view3,*view4,*view5,*view6;
    int k;
    UIButton *btn,*btn1,*btn2;
    IBOutlet UITextField *titletext,*pmonthtext,*pyeartext,*limitationtext,*counttext,*usertext,*hightext,*destext,*sdestext,*imagetext;
    NSString *idcat,*idmer,*idname;
    IBOutlet UIButton *imagebtn,*monthbtn,*yearbtn,*promobtn;
    BOOL check,checkagain;
    NSMutableArray *array2;
    IBOutlet UIImageView *image1,*image2;
    IBOutlet UITextView *textview1,*textview2;
    int promotion,month,year;
    NSDictionary *dic;
    UIImagePickerController *imagePicker;
    NSData *imageData;
 IBOutlet   UIImageView *imgProfile;
    UIImage *getImage;
    NSString *imageDataAsString;
    IBOutlet UILabel *topLabel;
    CGFloat height;
    YourListedPassesView *pass;
    IBOutlet UILabel *prolbl,*monlbl,*yeralbl;
    IBOutlet UIImageView *passtypeimg,*packagecountimg,*packagepriceimg;
    IBOutlet UIButton *packagebtn;
    IBOutlet UITextField *packagepricetext,*packageactivetext;
    NSMutableArray *packagearray;
    IBOutlet UIImageView *couponimg;
    IBOutlet UITextField *coupontext;
}
-(IBAction)category:(id)sender;
-(IBAction)month:(id)sender;
-(IBAction)year:(id)sender;
//-(IBAction)image:(id)sender;
@property (strong,nonatomic)NSString *passmerchant;
@property(strong,nonatomic)NSString *update,*passid,*imagestr,*toplabel,*passpromo,*passtitle,*passcategory,*passoffer,*passshort,*passlong,*passuser,*passmonth,*passyear,*passmprice,*passyprice,*passlimitation,*passlimit,*passcountfinal;
@property(strong,nonatomic)NSString *passType,*couponNo, *Activationcount;
@end
