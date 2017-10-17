//
//  Promotion.h
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionsShopNowButtonModel.h"

@interface Promotion : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *promotionImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *promotionDescription;
@property (nonatomic, strong) NSString *promotionFooterText;
@property (nonatomic, strong) PromotionsShopNowButtonModel *promotionsShopNowButtonModel;

- (instancetype)initWithDictionary:(NSDictionary *)responseDictionary;

@end
