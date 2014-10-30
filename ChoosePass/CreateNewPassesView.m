//
//  CreateNewPassesView.m
//  merchant
//
//  Created by Dottechnologies on 08/07/14.
//  Copyright (c) 2014 DotTechnologies. All rights reserved.
//

#import "CreateNewPassesView.h"
#import "MainViewController_iPhone.h"
#import "AppDelegate.h"

@interface CreateNewPassesView ()
{
    BOOL keyboardIsShown;
}
@end

@implementation CreateNewPassesView
@synthesize update,passid,imagestr,toplabel,passpromo,passtitle,passuser,passlong,passshort,passoffer,passcategory,passcountfinal,passlimit,passlimitation,passmonth,passmprice,passyear,passyprice;
@synthesize passmerchant;
@synthesize passType, couponNo, Activationcount;
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
    
    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:self.view.window];
//    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:self.view.window];
    keyboardIsShown = NO;
    [self donetoolbar];
    if ([update isEqualToString:@"Yes"])
    {
        
    }
    else
    {
        if ([textview1.text isEqualToString:@""])
        {
            textview1.text=@"Short description";
            textview1.textColor=[UIColor grayColor];
        }
        if ([textview2.text isEqualToString:@""])
        {
            textview2.text=@"Long description";
            textview2.textColor=[UIColor grayColor];
        }
    }
    coupontext.hidden=YES;
    couponimg.hidden=YES;
    
    couponimg.frame=CGRectMake(10, 363, 300, 35);
    coupontext.frame=CGRectMake(10, 365, 300, 30);
    
    
    titletext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    hightext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    textview1.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    textview2.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    usertext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    pmonthtext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    pyeartext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    catbtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    actbtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    prolbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
   monlbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
   yeralbl.font=[UIFont fontWithName:@"Brisko Sans" size:14];
   usertext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
   limitationtext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    counttext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    imagebtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    packagebtn.titleLabel.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    packageactivetext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    coupontext.font=[UIFont fontWithName:@"Brisko Sans" size:14];
    
    height=[UIScreen mainScreen].bounds.size.height;
    topLabel.text=toplabel;
    topLabel.textColor=[UIColor whiteColor];
    topLabel.font=[UIFont fontWithName:@"Brisko Sans" size:16];
      btn.tag=0;
    btn1.tag=0;
    btn2.tag=0;
    view2.hidden=YES;
    view3.hidden=YES;
    view4.frame=CGRectMake(0, 97,300 , 128);
    table.frame=CGRectMake(10, 84,290, 0);
    if (height==568)
    {
    scroll.contentSize=CGSizeMake(0, 990);
    }
    else
    {
        scroll.contentSize=CGSizeMake(0, 1020);
    }
    table2.frame=CGRectMake(0,35,300, 0);
    table2.hidden=YES;
    table2.backgroundColor=[UIColor whiteColor];
    table2.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
    table2.layer.borderWidth = 1;
    table2.layer.cornerRadius = 8.0;
    //table.backgroundColor=[UIColor whiteColor];
    table.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
    table.layer.borderWidth = 1;
    table.layer.cornerRadius = 8.0;
    table.hidden=YES;
    table1.frame=CGRectMake(161, 174, 149, 0);
    table1.hidden=YES;
    table1.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
    table1.layer.borderWidth = 1;
    table1.layer.cornerRadius = 8.0;
    namearray=[[NSMutableArray alloc]init];
    array=[[NSMutableArray alloc]init];
    [array addObject:@"Daily"];
    [array addObject:@"Weekly"];
    [array addObject:@"Monthly"];
    [array addObject:@"Unlimited"];
    [array addObject:@"Activation Number"];
    packagearray=[[NSMutableArray alloc]init];
    [packagearray addObject:@"package pass"];
    [packagearray addObject:@"subscription pass"];

    [packagebtn setTitle:@"subscription pass" forState:UIControlStateNormal];
    packageactivetext.hidden=YES;
    packagecountimg.hidden=YES;
    packagepriceimg.hidden=YES;
    packagepricetext.hidden=YES;
    
    view1.frame=CGRectMake(10, 400, 300, 277);
     table3.frame=CGRectMake(12, 398, 294,0);
    table3.hidden=YES;
    [actbtn setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
   idname=[array objectAtIndex:0];
    counttext.hidden=YES;
    limitationtext.hidden=YES;
    image1.hidden=YES;
    image2.hidden=YES;
    catarray=[[NSMutableArray alloc]init];
    merarray=[[NSMutableArray alloc]init];
    appendarray=[[NSMutableArray alloc]init];
    catnamearray=[[NSMutableArray alloc]initWithCapacity:0];
    catappendarray=[[NSMutableArray alloc]initWithCapacity:0];
    NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_all_category_list xmlns=\"urn:passwebservices\"></get_all_category_list></soap:Body></soap:Envelope>"];
     NSString *xml1=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><get_all_merchant_data xmlns=\"urn:passwebservices\"></get_all_merchant_data></soap:Body></soap:Envelope>"];
    NSURL *url=[NSURL URLWithString:@"http://www.chooseyourpass.com/dev/webservice/passwebservices.php"];
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc]initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    categoryconn=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    [categoryconn start];
    NSMutableURLRequest *req1=[[NSMutableURLRequest alloc]initWithURL:url];
    [req1 setHTTPMethod:@"POST"];
    [req1 setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [req1 setHTTPBody:[xml1 dataUsingEncoding:NSUTF8StringEncoding]];
    merchantconn=[[NSURLConnection alloc]initWithRequest:req1 delegate:self];
    responsedata=[NSMutableData data];
    [merchantconn start];
    
    if (imagestr)
    {
        imgProfile.image=[UIImage imageWithData:
                          [NSData dataWithContentsOfURL:
                           [NSURL URLWithString:imagestr]]];
        getImage=[self imageWithImage:imgProfile.image scaledToSize:CGSizeMake(320, 340)];
        imageData = UIImageJPEGRepresentation(getImage,0.1);
        imageDataAsString=[imageData base64EncodedStringWithOptions:0];
    }
    else
    {
        UIImage *image=[UIImage imageNamed:@"frame1.png"];
        imgProfile.image=image;
        getImage=[self imageWithImage:image scaledToSize:CGSizeMake(150, 150)];
        imageData = UIImageJPEGRepresentation(getImage,0.1);
        imageDataAsString=[imageData base64EncodedStringWithOptions:0];
    }
    if ([passpromo isEqualToString:@"1"])
    {
    [promobtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        titletext.text=passtitle;
        hightext.text=passoffer;
        usertext.text=passuser;
        textview1.text=passshort;
        textview2.text=passlong;
        view1.hidden=YES;
        promobtn.tag=1;
        promotion=1;
        packagebtn.hidden=YES;
        passtypeimg.hidden=YES;
        packageactivetext.hidden=YES;
        packagecountimg.hidden=YES;
        packagepriceimg.hidden=YES;
        packagepricetext.hidden=YES;
        coupontext.hidden=NO;
        couponimg.hidden=NO;
        coupontext.text=couponNo;

        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 500);
        }
        else
        {
            scroll.contentSize=CGSizeMake(0, 500);
        }

    }
    if ([passpromo isEqualToString:@"0"])
    {
        [packagebtn setTitle:passType forState:UIControlStateNormal];

        promotion=0;
        titletext.text=passtitle;
        hightext.text=passoffer;
        usertext.text=passuser;
        textview1.text=passshort;
        textview2.text=passlong;
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 900);
        }
        else
        {
            scroll.contentSize=CGSizeMake(0, 850);
        }

        if ([passyear isEqualToString:@"Yearly"]&&[passmonth isEqualToString:@"Monthly"])
        {
        [monthbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [yearbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            view4.frame=CGRectMake(0, 167, 300, 128);
            view2.hidden=NO;
            view3.hidden=NO;
            pmonthtext.text=passmprice;
            pyeartext.text=passyprice;
            monthbtn.tag=1;
            yearbtn.tag=1;
            checkagain=YES;
            check=YES;
            month=1;
            year=1;
                 }
        if (![passyear isEqualToString:@"Yearly"]&&[passmonth isEqualToString:@"Monthly"])
        {
            [monthbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [yearbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
          view2.frame=CGRectMake(0, 97, 300, 35);
            view4.frame=CGRectMake(0, 132, 300, 128);
            view2.hidden=NO;
            view3.hidden=YES;
            pmonthtext.text=passmprice;
            pyeartext.text=@"";
            monthbtn.tag=1;
            yearbtn.tag=0;
            check=YES;
            checkagain=NO;
            year=0;
            month=1;
        }
        if ([passyear isEqualToString:@"Yearly"]&&![passmonth isEqualToString:@"Monthly"])
        {
            [monthbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [yearbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
              view3.frame=CGRectMake(0, 97, 300, 35);
            view4.frame=CGRectMake(0, 132, 300, 128);
            view2.hidden=YES;
            view3.hidden=NO;
            pmonthtext.text=@"";
            pyeartext.text=passyprice;
            monthbtn.tag=0;
            yearbtn.tag=1;
            check=NO;
            checkagain=YES;
            month=0;
            year=1;
        }
        if (![passyear isEqualToString:@"Yearly"]&&![passmonth isEqualToString:@"Monthly"])
        {
            [monthbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [yearbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            view4.frame=CGRectMake(0, 97, 300, 128);
            view2.hidden=YES;
            view3.hidden=YES;
            pmonthtext.text=@"";
            pyeartext.text=@"";
            monthbtn.tag=0;
            yearbtn.tag=0;
            month=0;
            year=0;
  
            packageactivetext.hidden=NO;
            packagecountimg.hidden=NO;
            packagepriceimg.hidden=NO;
            packagepricetext.hidden=NO;
            view1.hidden=YES;
            packagepricetext.text=passmprice;
             packageactivetext.text=Activationcount;
        }
    }
    if ([passpromo isEqualToString:@"0"])
    {
        if (![passyear isEqualToString:@"Yearly"]&&![passmonth isEqualToString:@"Monthly"])
        {
            [actbtn setTitle:@"Daily" forState:UIControlStateNormal];
        }

    if ([passlimitation isEqualToString:[array objectAtIndex:4]])
    {
        [actbtn setTitle:passlimitation forState:UIControlStateNormal];
        image1.hidden=NO;
        image2.hidden=NO;
        limitationtext.hidden=NO;
        counttext.hidden=NO;
        limitationtext.text=passlimit;
        counttext.text=passcountfinal;
    }
    else
    {
        [actbtn setTitle:passlimitation forState:UIControlStateNormal];
        image1.hidden=YES;
        image2.hidden=YES;
        limitationtext.hidden=YES;
        counttext.hidden=YES;
        limitationtext.text=@"";
        counttext.text=@"";
    }
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responsedata setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responsedata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;

    if (connection==categoryconn)
    {
        NSString *str=[[NSString alloc]initWithData:responsedata encoding:NSUTF8StringEncoding];
        NSDictionary *dic1=[XMLReader dictionaryForXMLString:str error:nil];
        NSDictionary *json=[[[[dic1 objectForKey:@"SOAP-ENV:Envelope"]objectForKey:@"SOAP-ENV:Body"]objectForKey:@"ns1:get_all_category_listResponse"]objectForKey:@"return"];
        NSString *textstr=[json valueForKey:@"text"];
            NSRange r;
        while ((r = [textstr rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        {
            textstr = [textstr stringByReplacingCharactersInRange:r withString:@""];
        }
    NSDictionary *responseDictionary =
    [NSJSONSerialization JSONObjectWithData: [textstr dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
    NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
    NSString *message=[[responseDictionary valueForKey:@"site_message"]valueForKey:@"message"];
  NSArray *categorylist=[responseDictionary objectForKey:@"category_list"];
    if ([response isEqualToString:@"SUCCESS"])
    {
    for (NSDictionary *dic1 in categorylist)
    {
        NSString *categoryid=[dic1 objectForKey:@"id"];
        NSString *categoryname=[dic1 objectForKey:@"szName"];
        NSString *append1=[[[categoryname stringByAppendingString:@"("]stringByAppendingString:categoryid]stringByAppendingString:@")"];
        [catnamearray addObject:categoryname];
        [catappendarray addObject:append1];
        [catarray addObject:categoryid];
    }
         [table reloadData];
        if ([update isEqualToString:@"Yes"])
        {  int num=[passcategory intValue];
            [catbtn setTitle:[catnamearray objectAtIndex:num-1] forState:UIControlStateNormal];
            idcat=[catarray objectAtIndex:num-1];
        }
        else
        {
            [catbtn setTitle:[catnamearray objectAtIndex:0] forState:UIControlStateNormal];
        idcat=[catarray objectAtIndex:0];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [alert show];
    }
    }
    if (connection==merchantconn)
    {
        NSString *str=[[NSString alloc]initWithData:responsedata encoding:NSUTF8StringEncoding];
        NSDictionary *dic1=[XMLReader dictionaryForXMLString:str error:nil];
        NSString *json=[[[[dic1 objectForKey:@"SOAP-ENV:Envelope"]objectForKey:@"SOAP-ENV:Body"]objectForKey:@"ns1:get_all_merchant_dataResponse"]objectForKey:@"return"];
        NSString *textstr=[json valueForKey:@"text"];
        
        NSDictionary *responseDictionary =
        [NSJSONSerialization JSONObjectWithData: [textstr dataUsingEncoding:NSISOLatin1StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
          NSString *message=[[responseDictionary valueForKey:@"site_message"]valueForKey:@"message"];
        NSArray *merchantlist=[responseDictionary objectForKey:@"merchant_lists"];
        if ([response isEqualToString:@"SUCCESS"])
        {
        for (NSDictionary *dic1 in merchantlist)
        {
            NSString *merchantid=[dic1 objectForKey:@"id"];
            NSString *merchantname=[dic1 objectForKey:@"szName"];
            NSString *append=[[[merchantname stringByAppendingString:@"("]stringByAppendingString:merchantid]stringByAppendingString:@")"];
            [namearray addObject:merchantname];
            [appendarray addObject:append];
            [merarray addObject:merchantid];
        }
            [table1 reloadData];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            [alert show];
        }
    }
    if (connection==saveconn)
    {
            NSString *str=[[NSString alloc]initWithData:responsedata encoding:NSUTF8StringEncoding];
            NSDictionary *dic1=[XMLReader dictionaryForXMLString:str error:nil];
            NSString *json=[[[[dic1 objectForKey:@"SOAP-ENV:Envelope"]objectForKey:@"SOAP-ENV:Body"]objectForKey:@"ns1:add_edit_passes_by_adminResponse"]objectForKey:@"return"];
            NSString *textstr=[json valueForKey:@"text"];
        
            NSDictionary *responseDictionary =
            [NSJSONSerialization JSONObjectWithData: [textstr dataUsingEncoding:NSISOLatin1StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
     NSString *response=[[responseDictionary valueForKey:@"site_response"]valueForKey:@"response"];
        NSString *message=[[responseDictionary valueForKey:@"site_message"]valueForKey:@"message"];
        if ([response isEqualToString:@"SUCCESS"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            alert.tag=1;
             [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:response message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            [alert show];
            if ([packagebtn.currentTitle isEqualToString:@""])
            {
                   [packagebtn setTitle:@"PassType" forState:UIControlStateNormal];
            }
         
            
            if ([textview1.text isEqualToString:@""])
            {
                textview1.text=@"Short description";
                textview1.textColor=[UIColor grayColor];
            }
            if ([textview2.text isEqualToString:@""])
            {
                textview2.text=@"Long description";
                textview2.textColor=[UIColor grayColor];
            }

        }
        //   NSString *response=[[responseDictionary valueForKey:@"0"]valueForKey:@"response"];
    }
  }


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [appdelRef hideProgress];
    self.view.userInteractionEnabled = YES;

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Please try again" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
        return catarray.count;
    if (tableView.tag==2)
        return merarray.count;
    if (tableView.tag==3) {
        return array.count;
    }
    if (tableView.tag==4) {
        return packagearray.count;
    }

    
    return 0;
  }
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
     if(cell == nil)
     {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
     if (tableView.tag==1)
     {
    cell.textLabel.text=[catnamearray objectAtIndex:indexPath.row];
     }
     if (tableView.tag==2)
     {
         cell.textLabel.text=[appendarray objectAtIndex:indexPath.row];
     }
     if (tableView.tag==3)
     {
          cell.textLabel.text=[array objectAtIndex:indexPath.row];
     }
     if (tableView.tag==4)
     {
          cell.textLabel.text=[packagearray objectAtIndex:indexPath.row];
     }
     cell.backgroundColor=[UIColor whiteColor];
      return cell;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        [catbtn setTitle:[catnamearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        idcat=[catarray objectAtIndex:indexPath.row];
        table.hidden=YES;
         table.frame=CGRectMake(10, 84,290, 0);
        
    }
    if (tableView.tag==2)
    {
        [merbtn setTitle:[namearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        idmer=[merarray objectAtIndex:indexPath.row];
         table1.hidden=YES;
         table1.frame=CGRectMake(161, 174, 149, 0);
    }
    if (tableView.tag==3)
    {
       [actbtn setTitle:[array objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        idname=[array objectAtIndex:indexPath.row];
        table2.hidden=YES;
          table2.frame=CGRectMake(0, 35, 300, 0);
//        if (height==568)
//        {
//            scroll.contentSize=CGSizeMake(0, 950);
//        }
//        else
//        {
//            scroll.contentSize=CGSizeMake(0, 1200);
//        }
    if ([actbtn.currentTitle isEqual:[array objectAtIndex:4]])
        {
            image1.hidden=NO;
            image2.hidden=NO;
            counttext.hidden=NO;
            limitationtext.hidden=NO;
            if (height==568)
            {
                scroll.contentSize=CGSizeMake(0, 1070);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 1100);
            }
        }
        else
        {
            counttext.hidden=YES;
            limitationtext.hidden=YES;
            image1.hidden=YES;
            image2.hidden=YES;
            if (height==568)
            {
                scroll.contentSize=CGSizeMake(0, 1000);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 1030);
            }
        }
    }
    if (tableView.tag==4)
    {
    [packagebtn setTitle:[packagearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        if ([[packagearray objectAtIndex:indexPath.row]isEqualToString:@"package pass"])
        {
            packageactivetext.hidden=NO;
            packagecountimg.hidden=NO;
            packagepriceimg.hidden=NO;
            packagepricetext.hidden=NO;
            view1.hidden=YES;
            view1.frame=CGRectMake(10, 474, 300, 277);
            scroll.contentSize=CGSizeMake(0, 1000);
        }
        else
        {
             packageactivetext.hidden=YES;
             packagecountimg.hidden=YES;
             packagepriceimg.hidden=YES;
            packagepricetext.hidden=YES;
            
            view1.hidden=NO;
            view1.frame=CGRectMake(10, 400, 300, 277);
         scroll.contentSize=CGSizeMake(0, 1070);
        }
     table3.hidden=YES;
     table3.frame=CGRectMake(12, 398, 294,0);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(IBAction)category:(id)sender
{
   // table1.hidden=YES;
    table.hidden=NO;
    [self.view bringSubviewToFront:table];
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
    {
       // view5.backgroundColor=[UIColor clearColor];
       table.hidden=NO;
       table.frame=CGRectMake(10, 84,290,90);
////        view6.frame=CGRectMake(0, 200, 320, 350);
////        view2.frame=CGRectMake(0, 500, 320, 359);
    }
        completion:^(BOOL finished)
    {
    }];
}
-(IBAction)merchant:(id)sender
{
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         table1.hidden=NO;
         table1.frame=CGRectMake(161, 174, 149, 146);
         
     }
                     completion:^(BOOL finished)
     {
         table.frame=CGRectMake(161, 140, 149, 0);
     }];
}
-(IBAction)promotion:(id)sender
{
    btn=sender;
    switch (btn.tag)
    {
        case 0:
        {
            [promobtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
            {
                view1.hidden=YES;
                packagebtn.hidden=YES;
                passtypeimg.hidden=YES;
                packageactivetext.hidden=YES;
                packagecountimg.hidden=YES;
                packagepriceimg.hidden=YES;
                packagepricetext.hidden=YES;
                coupontext.hidden=NO;
                couponimg.hidden=NO;
                table3.hidden=YES;
            }
                            completion:^(BOOL finished)
             {
                 btn.tag=1;
             }];
            if (height==568)
            {
                scroll.contentSize=CGSizeMake(0, 500);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 500);
            }
            if ([packagebtn.currentTitle isEqualToString:@"package pass"])
            {
                view1.frame=CGRectMake(10, 474, 300, 277);
//                packageactivetext.hidden=NO;
//                packagecountimg.hidden=NO;
//                packagepriceimg.hidden=NO;
//                packagepricetext.hidden=NO;
            }
            else
            {
                view1.frame=CGRectMake(10, 400, 300, 277);
//                packageactivetext.hidden=YES;
//                packagecountimg.hidden=YES;
//                packagepriceimg.hidden=YES;
//                packagepricetext.hidden=YES;


            }
            
            promotion=1;
                  break;
        }
             case 1:
        {
            [promobtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
            {
                view1.hidden=NO;
                packagebtn.hidden=NO;
                passtypeimg.hidden=NO;
                coupontext.hidden=YES;
                couponimg.hidden=YES;
               
                }
            completion:^(BOOL finished)
             {
                 btn.tag=0;
             }];
            if (height==568)
            {
                scroll.contentSize=CGSizeMake(0, 1070);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 1100);
            }
            if ([packagebtn.currentTitle isEqualToString:@"package pass"])
            {
                view1.hidden=YES;
                view1.frame=CGRectMake(10, 474, 300, 277);
                packageactivetext.hidden=NO;
                packagecountimg.hidden=NO;
                packagepriceimg.hidden=NO;
               packagepricetext.hidden=NO;
            }
            else
            {
                if ([packagebtn.currentTitle isEqualToString:@"PassType"])
                {
                    view1.hidden=NO;
                    view1.frame=CGRectMake(10, 474, 300, 277);
                    
                    packageactivetext.hidden=NO;
                    packagecountimg.hidden=NO;
                    packagepriceimg.hidden=NO;
                    packagepricetext.hidden=NO;

                }
                else
                {
                    view1.frame=CGRectMake(10, 400, 300, 277);
                    packageactivetext.hidden=YES;
                    packagecountimg.hidden=YES;
                    packagepriceimg.hidden=YES;
                    packagepricetext.hidden=YES;
                }
             
    
            }

            promotion=0;
            break;
        }
        }
   }
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)activation:(id)sender
{
  
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
           table2.hidden=NO;
        table2.frame=CGRectMake(0, 35, 300, 90);
    
    }
                     completion:^(BOOL finished)
     {
         
     }];
    
    if (check==YES&&checkagain==YES)
    {
        if (height==568)
        {
          scroll.contentSize=CGSizeMake(0, 1070);
        }
        else
        {
          scroll.contentSize=CGSizeMake(0, 1100);
        }
    }
    else
    {
        if (height==568)
        {
               scroll.contentSize=CGSizeMake(0, 1050);
        }
        else
        {
     scroll.contentSize=CGSizeMake(0, 1080);
        }
    }
   
}
-(IBAction)back:(id)sender
{
       [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)save:(id)sender
{
    [appdelRef showProgress:@"Please wait..."];
    self.view.userInteractionEnabled = NO;
      NSString *merchantid=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"merchant_Id"];
      NSString *mobilekey=[[GlobalInstances sharedInstance]getValueFromUserDefaults:@"MobileKey"];
      NSString *promostr=[NSString stringWithFormat:@"%d",promotion];
      NSString *monthstr=[NSString stringWithFormat:@"%d",month];
      NSString *yearstr=[NSString stringWithFormat:@"%d",year];
if (promotion==1)
{
         pmonthtext.text=@"";
         pyeartext.text=@"";
         idname=@"";
         limitationtext.text=@"";
         counttext.text=@"";
        packageactivetext.text=@"";
         packagepricetext.text=@"";
}
    if (promotion==0)
    {
        coupontext.text=@"";
        if (month==0&&year==0)
        {
           monthstr=@"0";
            yearstr=@"0";
            pmonthtext.text=@"";
            pyeartext.text=@"";
        }
    if (month==1&&year==0)
    {
        monthstr=@"1";
        yearstr=@"0";
        pyeartext.text=@"";
    }
    if (month==0&&year==1)
        {
            monthstr=@"0";
            yearstr=@"1";
            pmonthtext.text=@"";
        }
if (month==1&&year==1)
        {
            monthstr=@"1";
            yearstr=@"1";
        }
        if ([textview1.text isEqualToString:@"Short description"])
        {
            textview1.text=@"";
        }
        if ([textview2.text isEqualToString:@"Long description"])
        {
            textview2.text=@"";
        }
    if ([packagebtn.currentTitle isEqualToString:@"package pass"])
    {
      
       idname=@"";
        limitationtext.text=@"";
        counttext.text=@"";
    }
    if ([packagebtn.currentTitle isEqualToString:@"subscription pass"])
    {
        packageactivetext.text=@"";
        packagepricetext.text=@"";
    }
    if ([packagebtn.currentTitle isEqualToString:@"PassType"])
    {
        [packagebtn setTitle:@"" forState:UIControlStateNormal];
        packageactivetext.text=@"";
        packagepricetext.text=@"";
        NSLog(@"in");
    }
}
if ([update isEqualToString:@"No"])
{
dic=@{@"szMobileKey":mobilekey,@"szFlag":@"Merchant",@"szTitle":titletext.text,@"idCategory":idcat,@"idMerchant":merchantid,@"iPromotional":promostr,@"szPeriodMonthly":monthstr,@"szPeriodYearly":yearstr,@"fMonthlyPrice":pmonthtext.text,@"fYearlyPrice":pyeartext.text,@"iActivationLimit":idname,@"iLimitionsCount":limitationtext.text,@"iCountFinalExpiry":counttext.text,@"iUserLimit":usertext.text,@"szShortDescription":textview1.text,@"szOfferHighlight":hightext.text,@"szDescription":textview2.text,@"szImage":imageDataAsString,@"passType":packagebtn.currentTitle,@"packageActivationCount":packageactivetext.text,@"pacakagePassPrice":packagepricetext.text,@"iCouponCode":coupontext.text};
}
 else
    {
dic=@{@"szMobileKey":mobilekey,@"szFlag":@"Merchant",@"szTitle":titletext.text,@"idCategory":idcat,@"idMerchant":merchantid,@"iPromotional":promostr,@"szPeriodMonthly":monthstr,@"szPeriodYearly":yearstr,@"fMonthlyPrice":pmonthtext.text,@"fYearlyPrice":pyeartext.text,@"iActivationLimit":idname,@"iLimitionsCount":limitationtext.text,@"iCountFinalExpiry":counttext.text,@"iUserLimit":usertext.text,@"szShortDescription":textview1.text,@"szOfferHighlight":hightext.text,@"szDescription":textview2.text,@"szImage":imageDataAsString,@"idPass":passid,@"passType":packagebtn.currentTitle,@"packageActivationCount":packageactivetext.text,@"pacakagePassPrice":packagepricetext.text,@"iCouponCode":coupontext.text};
}
    NSString *str=[dic JSONRepresentation];
    NSString *xml=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><add_edit_passes_by_admin xmlns=\"urn:passwebservices\"><data>%@</data></add_edit_passes_by_admin></soap:Body></soap:Envelope>",str];
    NSURL *url=[NSURL URLWithString:@"http://www.chooseyourpass.com/webservice/passwebservices.php"];
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc]initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    saveconn=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    responsedata=[NSMutableData data];
    [saveconn start];
}
-(IBAction)month:(id)sender
{
    btn1=sender;
    switch (btn1.tag)
    {
        case 0:
        {
            
            [monthbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                 if (checkagain==YES)
                 {
                     view2.hidden=NO;
                     view3.frame=CGRectMake(0, 132, 300, 35);
                     view4.frame=CGRectMake(0, 167, 300, 128);
//                     if (height==568)
//                     {
//                         scroll.contentSize=CGSizeMake(0, 1120);
//                     }
//                     else
//                     {
//                         scroll.contentSize=CGSizeMake(0, 1200);
//                     }
//                     

                 }
                 else
                 {
                     view2.hidden=NO;
                     view4.frame=CGRectMake(0, 132, 300, 128);
//                     if (height==568)
//                     {
//                         scroll.contentSize=CGSizeMake(0, 1100);
//                     }
//                     else
//                     {
//                         scroll.contentSize=CGSizeMake(0, 1200);
//                     }
                     

                 }
                 check=YES;
             }
                             completion:^(BOOL finished)
             {
                 btn1.tag=1;
             }];
                     month=1;
            break;
        }
        case 1:
        {
            [monthbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                 
                if (checkagain==YES)
                 {
                     view2.hidden=YES;
                     view3.frame=CGRectMake(0, 97, 300, 35);
                     view4.frame=CGRectMake(0, 132, 300, 128);
                 }
                 else
                 {
                     view2.hidden=YES;
                     view4.frame=CGRectMake(0, 97, 300, 128);
                 }
                 
            check=NO;
             }
                             completion:^(BOOL finished)
             {
                 btn1.tag=0;
             }];
//            if (height==568)
//            {
//                scroll.contentSize=CGSizeMake(0, 950);
//            }
//            else
//            {
//                scroll.contentSize=CGSizeMake(0, 1000);
//            }
            month=0;
            break;
        }
    }

}
-(IBAction)year:(id)sender
{
    btn2=sender;
    switch (btn2.tag)
    {
        case 0:
        {
            [yearbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                
                if (check==YES)
                 {
                     view3.hidden=NO;
                     view3.frame=CGRectMake(0, 132, 300, 35);
                     view4.frame=CGRectMake(0, 167, 300, 128);
                 }
                 else
                 {
                     view3.hidden=NO;
                     view3.frame=CGRectMake(0, 97, 300, 35);
                     view4.frame=CGRectMake(0, 132, 300, 128);
                 }
                 checkagain=YES;
                }
             completion:^(BOOL finished)
             {
                 btn2.tag=1;
             }];
            year=1;
//            if (height==568)
//            {
//                scroll.contentSize=CGSizeMake(0, 1120);
//            }
//            else
//            {
//                scroll.contentSize=CGSizeMake(0, 1230);
//            }

            
            break;
        }
        case 1:
        {
                       [yearbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
             {
              
                
                 if (check==YES)
                 {
                     view3.hidden=YES;
                     view4.frame=CGRectMake(0, 132, 300, 128);
                 }
                 else
                 {
                     view3.hidden=YES;
                     view4.frame=CGRectMake(0, 97, 300, 128);
                 }
              checkagain=NO;
             }
            completion:^(BOOL finished)
             {
                 btn2.tag=0;
             }];
            year=0;
//            if (height==568)
//            {
//                scroll.contentSize=CGSizeMake(0, 950);
//            }
//            else
//            {
//                scroll.contentSize=CGSizeMake(0, 1000);
//            }
            break;
        }
    }

}
-(void)donetoolbar
{
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar1 sizeToFit];
    usertext.inputAccessoryView = numberToolbar1;
    UIToolbar* numberToolbar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar2.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar2.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar2 sizeToFit];
    pmonthtext.inputAccessoryView = numberToolbar1;
    UIToolbar* numberToolbar3 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar3.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar3.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar1 sizeToFit];
    pyeartext.inputAccessoryView = numberToolbar3;
    UIToolbar* numberToolbar4 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar4.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar4.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar4 sizeToFit];
    textview1.inputAccessoryView = numberToolbar1;
    UIToolbar* numberToolbar5 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar5.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar5.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar5 sizeToFit];
    textview2.inputAccessoryView = numberToolbar5;
}
-(void)doneWithNumberPad
{
    [usertext resignFirstResponder];
    [pmonthtext resignFirstResponder];
    [pyeartext resignFirstResponder];
    [textview1 resignFirstResponder];
    [textview2 resignFirstResponder];
}
-(IBAction)btnuploadMathodImage:(id)sender
{
    
    NSString *actionSheetTitle = @"Change Profile Picture"; //Action Sheet Title
    NSString *destructiveTitle = @"Take Photo"; //Action Sheet Button Titles
    NSString *other1 = @"Choose Photo";
    // NSString *other2 = @"Choose Photo";
    NSString *cancelTitle = @"Cancel";
    //destructiveButtonTitle:destructiveTitle
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:other1, nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex== 0)
    {
        [self TakePicture];
        
    }
    else if(buttonIndex == 1)
    {
        [self ChoosePicture];
    }
}
-(void)TakePicture
{
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self ;
    //imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[self presentModalViewController:imagePicker animated:YES];
    }
}
-(void)ChoosePicture
{
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if([image isMemberOfClass:[NSNull class]])
    {
        imgProfile.image = [UIImage imageNamed:@"Default.jpg"];
    }
    else
    {
        imgProfile.image = image;
    }
    getImage=[self imageWithImage:image scaledToSize:CGSizeMake(320, 340)];
    imageData = UIImageJPEGRepresentation(getImage,0.1);
   imageDataAsString=[imageData base64EncodedStringWithOptions:0];
    [[GlobalInstances sharedInstance]saveValueToUserDefaults:imageDataAsString forKey:@"ProfileImage"];
    [picker dismissModalViewControllerAnimated:YES];
    
}
-(UIImage*)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = scroll.frame;
    viewFrame.size.height += keyboardSize.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scroll setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (keyboardIsShown)
    {
        return;
    }
    NSDictionary* userInfo = [n userInfo];
   
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = scroll.frame;
    viewFrame.size.height -= keyboardSize.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scroll setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillHideNotification];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==coupontext)
    {
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 930);
        }
        else
        {
           scroll.contentSize=CGSizeMake(0, 980);
        }
    }
    if (textField==packagepricetext)
    {
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 1000);
        }
        else
        {
          scroll.contentSize=CGSizeMake(0, 1090);
        }

    }
    if (textField==packageactivetext)
    {
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 1000);
        }
        else
        {
              scroll.contentSize=CGSizeMake(0, 1050);
        }
    }
    
    if (textField==pmonthtext)
    {
        if (height==568)
        {
              scroll.contentSize=CGSizeMake(0, 1185);
        }
        else
        {
             scroll.contentSize=CGSizeMake(0, 1215);
        }
    }
    if (textField==usertext)
    {
        if (height==568)
        {
           scroll.contentSize=CGSizeMake(0, 900);
        }
        else
        {
            scroll.contentSize=CGSizeMake(0, 930);
        }
    }
    if (textField==pyeartext)
    {
        if (height==568)
        {
           scroll.contentSize=CGSizeMake(0, 1220);
        }
        else
        {
           scroll.contentSize=CGSizeMake(0, 1250);
        }
    }
    if (textField==counttext)
    {
        if (height==568)
        {
            if (checkagain==YES&&check==YES)
            {
             scroll.contentSize=CGSizeMake(0, 1280);
            }
            else
            {
               scroll.contentSize=CGSizeMake(0, 1250);
            }
        }
        else
        {
            if (checkagain==YES&&check==YES)
            {
             scroll.contentSize=CGSizeMake(0, 1280);
            }
            else
            {
                 scroll.contentSize=CGSizeMake(0, 1280);
            }
        }
    }
    if (textField==limitationtext)
    {
        if (height==568)
        {
            if (checkagain==YES&&check==YES)
            {
                scroll.contentSize=CGSizeMake(0, 1240);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 1200);
            }
        }
        else
        {
            if (checkagain==YES&&check==YES)
            {
            scroll.contentSize=CGSizeMake(0, 1270);
            }
            else
            {
                scroll.contentSize=CGSizeMake(0, 1200);
            }
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==pmonthtext)
    {
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 1070);
        }
        else
        {
           scroll.contentSize=CGSizeMake(0, 1070);

        }
        
    }
    if (textField==usertext)
    {
        if (height==568)
        {
            scroll.contentSize=CGSizeMake(0, 900);
        }
        else
        {
            scroll.contentSize=CGSizeMake(0, 900);
        }
    }
    if (textField==pyeartext)
    {
        if (height==568)
        {
             scroll.contentSize=CGSizeMake(0, 1070);
        }
        else
        {
           scroll.contentSize=CGSizeMake(0, 1070);
        }
    }
    if (textField==counttext)
    {
        if (height==568)
        {
          scroll.contentSize=CGSizeMake(0, 1070);
        }
        else
        {
          scroll.contentSize=CGSizeMake(0, 1070);
        }
    }
    if (textField==limitationtext)
    {
        if (height==568)
        {
             scroll.contentSize=CGSizeMake(0, 1070);
        }
        else
        {
          scroll.contentSize=CGSizeMake(0, 1070);
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            if ([update isEqualToString:@"Yes"])
            {
                for (id collection in [self.navigationController viewControllers])
                {
                    if ([collection isKindOfClass:[MainViewController_iPhone class]])
                    {
                        [self.navigationController popToViewController:collection animated:YES];
                    }
                }
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag==1)
    {
        if ([textView.text isEqualToString:@""]||[textView.text isEqualToString:@"Short description"])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
    if (textView.tag==2)
    {
        if ([textView.text isEqualToString:@""]||[textView.text isEqualToString:@"Long description"])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag==1)
    {
        if ([textView.text isEqualToString:@""])
        {
            textView.text=@"Short description";
            textView.textColor=[UIColor grayColor];
        }
    }
    if (textView.tag==2)
    {
        if ([textView.text isEqualToString:@""])
        {
            textView.text=@"Long description";
            textView.textColor=[UIColor grayColor];
        }
    }
}
-(IBAction)packagebtn:(id)sender
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         table3.hidden=NO;
         table3.frame=CGRectMake(12, 398, 294,88);
     }
        completion:^(BOOL finished)
     {
         //table.frame=CGRectMake(161, 140, 149, 0);
     }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
