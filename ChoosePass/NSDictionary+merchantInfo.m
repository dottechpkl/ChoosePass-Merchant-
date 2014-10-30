//
//  NSDictionary+merchantInfo.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/10/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "NSDictionary+merchantInfo.h"

@implementation NSDictionary (merchantInfo)


- (NSDictionary *)allInfo
{
    NSArray *arr=self[@"merchant_lists"];
    return arr[0];

}
-(NSArray*)arrCount
{
    NSArray *arr=self[@"merchant_lists"];
    return arr;
}

-(NSString*)Created;
{
    NSString *cc=self[@"dtCreated"];
    return cc;
}

-(NSString*)Active
{
    NSString *cc=self[@"iActive"];
    return cc;
}

-(NSString*)Order
{
    NSString *cc=self[@"iOrder"];
    return cc;
}

-(NSString *)Id
{
    NSString *cc=self[@"id"];
    return cc;
}

-(NSString*)Address1
{
    NSString *cc=self[@"szAddress1"];
    return cc;
}

-(NSString*)Address2
{
    NSString *cc=self[@"szAddress2"];
    return cc;
}

-(NSString*)city
{
    NSString *cc=self[@"szCity"];
    return cc;
}

-(NSString*)companyName
{
    NSString *cc=self[@"szCompanyName"];
    return cc;
}

-(NSString*)Description
{
    NSString *cc=self[@"szDescription"];
    return cc;
}

-(NSString*)Email
{
    NSString *cc=self[@"szEmail"];
    return cc;
}

-(NSString*)Filename
{
    NSString *cc=self[@"szFileName"];
    return cc;
}

-(NSString*)Firstname
{
    NSString *cc=self[@"szFirstName"];
    return cc;
}

-(NSString*)Lastname;
{
    NSString *cc=self[@"szLastName"];
    return cc;
}

-(NSString*)Latutide
{
    NSString *cc=self[@"szLatitude"];
    return cc;
}

-(NSString*)Longitude
{
    NSString *cc=self[@"szLongitude"];
    return cc;
}

-(NSString*)name
{
    NSString *cc=self[@"szName"];
    return cc;
}

-(NSString*)phoneNumber
{
    NSString *cc=self[@"szPhoneNumber"];
    return cc;
}

-(NSString*)shortDescription
{
    NSString *cc=self[@"szShortDescription"];
    return cc;
}
-(NSString*)state
{
    NSString *cc=self[@"szState"];
    return cc;
}
-(NSString*)uploadFilename;
{
    NSString *cc=self[@"szUploadFileName"];
    return cc;
}
-(NSString*)website
{
    NSString *cc=self[@"szWebsite"];
    return cc;
}
-(NSString*)zipCode
{
    NSString *cc=self[@"szZipCode"];
    return cc;
}

@end
