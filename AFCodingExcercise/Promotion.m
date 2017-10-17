//
//  Promotion.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import "Promotion.h"

@implementation Promotion

- (instancetype)initWithDictionary:(NSDictionary *)responseDictionary {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _imageURL = responseDictionary[@"image"];
    _title = responseDictionary[@"title"];
    _promotionDescription = responseDictionary[@"description"];
    _promotionFooterText = responseDictionary[@"footer"];
    
    [self setupPromotionsShopNowButtonModelFromDictionary:responseDictionary];
    
    return  self;
}

- (void)setupPromotionsShopNowButtonModelFromDictionary:(NSDictionary *)responseDictionary {
    
    id value = responseDictionary[@"button"];
    id response = nil;
    if ([self isArray:value]) {
        response = [(NSArray *)value firstObject];
    }
    else {
        response = value;
    }
    
    _promotionsShopNowButtonModel = [[PromotionsShopNowButtonModel alloc] initWithDictionary:response];
}

#pragma mark - Helper Methods

- (BOOL)isArray:(id)value {
    
    return [value isKindOfClass:[NSArray class]];
}

@end
