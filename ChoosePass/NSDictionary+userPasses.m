//
//  NSDictionary+userPasses.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/26/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "NSDictionary+userPasses.h"

@implementation NSDictionary (userPasses)
-(NSArray*)arr_userPasses
{
    NSArray *arr=self[@"user_passes"];
    return arr;
}
-(NSString*)profileId_user
{
    NSString *cc=self[@"PROFILEID"];
    return cc;
}
-(NSString*)profileStatus_user
{
    NSString *cc=self[@"PROFILESTATUS"];
    return cc;
}
-(NSString*)dtAvailable_user
{
    NSString *cc=self[@"dtAvailable"];
    return cc;
}
-(NSString*)dtCancelled_user
{
    NSString *cc=self[@"dtCancelled"];
    return cc;
}
-(NSString*)dtExpiry_user
{
    NSString *cc=self[@"dtExpiry"];
    return cc;
}
-(NSString *)dtPurchased_user
{
    NSString *cc=self[@"dtPurchased"];
    return cc;
}
-(NSString*)dtUsed_user
{
    NSString *cc=self[@"dtUsed"];
    return cc;
}
-(NSString*)fPaidAmount_user
{
    NSString *cc=self[@"fPaidAmount"];
    return cc;
}
-(NSString*)fPrice_user
{
    NSString *cc=self[@"fPrice"];
    return cc;
}
-(NSString*)fSubscriptionAmount_user
{
    NSString *cc=self[@"fSubscriptionAmount"];
    return cc;
}
-(NSString*)fYearlyPrice_user
{
    NSString *cc=self[@"fYearlyPrice"];
    return cc;
}
-(NSString*)iCancelled_user
{
    NSString *cc=self[@"iCancelled"];
    return cc;
}
-(NSString*)iLimitions_user
{
    NSString *cc=self[@"iLimitions"];
    return cc;
}
-(NSString*)iLimitionsCount_user
{
    NSString *cc=self[@"iLimitionCount"];
    return cc;
}
-(NSString*)iPeriod_user
{
    NSString *cc=self[@"iPeriod"];
    return cc;
}
-(NSString*)iPromotional_user
{
    NSString *cc=self[@"iPromotional"];
    return cc;
}
-(NSString*)iTotalPaymentCount_user
{
    NSString *cc=self[@"iTotalPaymentCount"];
    return cc;
}
-(NSString*)iTotalUsedCount_user
{
    NSString *cc=self[@"iTotalUsedCount"];
    return cc;
}
-(NSString*)iYearlyPeriod_user
{
    NSString *cc=self[@"iYearlyPeriod"];
    return cc;
}
-(NSString*)id_user
{
    NSString *cc=self[@"id"];
    return cc;
}
-(NSString*)idMerchant_user
{
    NSString *cc=self[@"idMerchant"];
    return cc;
}
-(NSString*)idSubscription_user
{
    NSString *cc=self[@"idSubscription"];
    return cc;
}
-(NSString*)idUser_user
{
    NSString *cc=self[@"idUser"];
    return cc;
}
-(NSString*)merchantDescription_user
{
    NSString *cc=self[@"merchantDescription"];
    return cc;
}
-(NSString*)merchantImageName_user
{
    NSString *cc=self[@"merchantImageName"];
    return cc;
}
-(NSString*)merchantName_user
{
    NSString *cc=self[@"merchantName"];
    return cc;
}
-(NSString*)szAddress1_user
{
    NSString *cc=self[@"szAddress1"];
    return cc;
}
-(NSString*)szAddress2_user
{
    NSString *cc=self[@"szAddress2"];
    return cc;
}
-(NSString*)szCity_user
{
    NSString *cc=self[@"szCity "];
    return cc;
}
-(NSString*)szDescription_user
{
    NSString *cc=self[@"szDescription"];
    return cc;
}
-(NSString*)szEmail_user
{
    NSString *cc=self[@"szEmail"];
    return cc;
}
-(NSString*)szFirstName_user
{
    NSString *cc=self[@"szFirstName"];
    return cc;
}
-(NSString*)szLastName_user
{
    NSString *cc=self[@"szLastName"];
    return cc;
}
-(NSString*)szPaymentType_user
{
    NSString *cc=self[@"szPaymentType"];
    return cc;
}
-(NSString*)szPhoneNumber_user
{
    NSString *cc=self[@"szPhoneNumber"];
    return cc;
}
-(NSString*)szState_user
{
    NSString *cc=self[@"szState"];
    return cc;
}
-(NSString*)szSubscriptionPeriod_user
{
    NSString *cc=self[@"szSubscriptionPeriod"];
    return cc;
}
-(NSString*)szTitle_user
{
    NSString *cc=self[@"szTilte"];
    return cc;
}
-(NSString*)szShortDesc_user
{
    NSString *cc=self[@"szShortDescription"];
    return cc;
}
-(NSString*)szOfferHighlight
{
    NSString *cc=self[@"szOfferHighlight"];
    return cc;
}
-(NSString*)szUploadImageName_user
{
    NSString *cc=self[@"szUploadImageName"];
    return cc;
}
-(NSString*)szZipCode_user
{
    NSString *cc=self[@"szZipCode"];
    return cc;
}
@end
