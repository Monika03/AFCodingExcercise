//
//  PromotionsShopNowButtonModel.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/29/16.
//  Copyright © 2016 Mounika. All rights reserved.
//

#import "PromotionsShopNowButtonModel.h"

@implementation PromotionsShopNowButtonModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    _buttonTitle = dictionary[@"title"];
    _buttonTargetURL = dictionary[@"target"];
    
    return self;
}

@end
