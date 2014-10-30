//
//  NSDictionary+passesInfo.h
//  ChoosePass
//
//  Created by Dottechnologies on 6/11/14.
//  Copyright (c) 2014 Dottechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (passesInfo)

-(NSArray*)categories_arr;
-(NSArray*)categoriesbyId_arr;
- (NSDictionary *)allPasses;
-(NSArray*)arr;
-(NSString*)dateCreated;
-(NSString*)Price;
-(NSString*)yearlyPrice;
-(NSString*)Active;
-(NSString*)LimitionCount;
-(NSString *)Limitions;
-(NSString*)Order;
-(NSString*)Period;
-(NSString*)Promotional;
-(NSString*)YearlyPeriod;
-(NSString*)Id;
-(NSString*)idCategory;
-(NSString*)idMerchant;
-(NSString*)CleanTitle;
-(NSString*)Description;
-(NSString*)FileName;
-(NSString*)MerchantName;
-(NSString*)OfferHighlight;
-(NSString*)ShortDescription;
-(NSString*)Tilte;
-(NSString*)UploadImageName;
-(NSString*)Website;


@end
