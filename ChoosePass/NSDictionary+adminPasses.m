//
//  NSDictionary+adminPasses.m
//  ChoosePass
//
//  Created by Dottechnologies on 7/3/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "NSDictionary+adminPasses.h"

@implementation NSDictionary (adminPasses)
-(NSArray*)arr_adminPasses
{
    NSArray *arr=self[@"pass_list"];
    return arr;
}
-(NSString*)dtCreated_admin
{
    NSString *cc=self[@"dtCreated"];
    return cc;
}
-(NSString*)fPrice_admin
{
    NSString *cc=self[@"fPrice"];
    return cc;
}
-(NSString*)fYearlyPrice_admin
{
    NSString *cc=self[@"fYearlyPrice"];
    return cc;
}
-(NSString*)iActive_admin
{
    NSString *cc=self[@"iActive"];
    return cc;
}
-(NSString*)iCountFinalExpiry_admin
{
    NSString *cc=self[@"iCountFinalExpiry"];
    return cc;
}
-(NSString*)iLimitionCount_admin
{
    NSString *cc=self[@"iLimitionCount"];
    return cc;
}
-(NSString *)iLimitions_admin
{
    NSString *cc=self[@"iLimitions"];
    return cc;
}
-(NSString*)iOrder_admin
{
    NSString *cc=self[@"iOrder"];
    return cc;
}
-(NSString*)iPeriod_admin
{
    NSString *cc=self[@"iPeriod"];
    return cc;
}
-(NSString*)iPromotional_admin
{
    NSString *cc=self[@"iPromotional"];
    return cc;
}
-(NSString*)iUserLimit_admin
{
    NSString *cc=self[@"iUserLimit"];
    return cc;
}
-(NSString*)iYearlyPeriod_admin
{
    NSString *cc=self[@"iYearlyPeriod"];
    return cc;
}
-(NSString*)id_admin
{
    NSString *cc=self[@"id"];
    return cc;
}
-(NSString*)idCategory_admin
{
    NSString *cc=self[@"idCategory"];
    return cc;
}
-(NSString*)idMerchant_admin
{
    NSString *cc=self[@"idMerchant"];
    return cc;
}
-(NSString*)szCleanTitle_admin
{
    NSString *cc=self[@"szCleanTitle"];
    return cc;
}
-(NSString*)szDescription_admin
{
    NSString *cc=self[@"szDescription"];
    return cc;
}
-(NSString*)szFileName_admin
{
    NSString *cc=self[@"szFileName"];
    return cc;
}
-(NSString*)szMerchantName_admin
{
    NSString *cc=self[@"szMerchantName"];
    return cc;
}
-(NSString*)szOfferHighlight_admin
{
    NSString *cc=self[@"szOfferHighlight"];
    return cc;
}
-(NSString*)szShortDescription_admin
{
    NSString *cc=self[@"szShortDescription"];
    return cc;
}
-(NSString*)szTilte_admin
{
    NSString *cc=self[@"szTilte"];
    return cc;
}
-(NSString*)szUploadImageName_admin
{
    NSString *cc=self[@"szUploadImageName"];
    return cc;
}
-(NSString*)szWebsite_admin
{
    NSString *cc=self[@"szWebsite"];
    return cc;
}
@end
