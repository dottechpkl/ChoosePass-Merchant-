//
//  NSDictionary+passesInfo.m
//  ChoosePass
//
//  Created by Dottechnologies on 6/11/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import "NSDictionary+passesInfo.h"

@implementation NSDictionary (passesInfo)
- (NSDictionary *)allPasses
{
    NSArray *arr=self[@"merchant_passes"];
    return arr[0];

}
-(NSArray*)arr;
{
    NSArray *arr=self[@"merchant_passes"];
    return arr;

}
-(NSArray*)categories_arr;
{
    NSArray *arr=self[@"category_list"];
    return arr;
    
}
-(NSArray*)categoriesbyId_arr
{
    NSArray *arr=self[@"pass_list"];
    return arr;
    
}
-(NSString*)dateCreated
{
    NSString *cc=self[@"dtCreated"];
    return cc;
}
-(NSString*)Price
{
    NSString *cc=self[@"fPrice"];
    return cc;
}
-(NSString*)yearlyPrice
{
    NSString *cc=self[@"fYearlyPrice"];
    return cc;
}
-(NSString*)Active
{
    NSString *cc=self[@"iActive"];
    return cc;
}
-(NSString*)LimitionCount
{
    NSString *cc=self[@"iLimitionCount"];
    return cc;
}
-(NSString *)Limitions
{
    NSString *cc=self[@"iLimitions"];
    return cc;
}
-(NSString*)Order
{
    NSString *cc=self[@"iOrder"];
    return cc;
}
-(NSString*)Period
{
    NSString *cc=self[@"iPeriod"];
    return cc;
}
-(NSString*)Promotional
{
    NSString *cc=self[@"iPromotional"];
    return cc;
}
-(NSString*)YearlyPeriod
{
    NSString *cc=self[@"iYearlyPeriod"];
    return cc;
}
-(NSString*)Id
{
    NSString *cc=self[@"id"];
    return cc;
}
-(NSString*)idCategory
{
    NSString *cc=self[@"idCategory"];
    return cc;
}
-(NSString*)idMerchant
{
    NSString *cc=self[@"idMerchant"];
    return cc;
}
-(NSString*)CleanTitle
{
    NSString *cc=self[@"szCleanTitle"];
    return cc;
}
-(NSString*)Description
{
    NSString *cc=self[@"szDescription"];
    return cc;
}
-(NSString*)FileName
{
    NSString *cc=self[@"szFileName"];
    return cc;
}
-(NSString*)MerchantName
{
    NSString *cc=self[@"szMerchantName"];
    return cc;
}
-(NSString*)OfferHighlight
{
    NSString *cc=self[@"szOfferHighlight"];
    return cc;
}
-(NSString*)ShortDescription
{
    NSString *cc=self[@"szShortDescription"];
    return cc;
}
-(NSString*)Tilte
{
    NSString *cc=self[@"szTilte"];
    return cc;
}
-(NSString*)UploadImageName
{
    NSString *cc=self[@"szUploadImageName"];
    return cc;
}
-(NSString*)Website
{
    NSString *cc=self[@"szWebsite"];
    return cc;
}

@end
