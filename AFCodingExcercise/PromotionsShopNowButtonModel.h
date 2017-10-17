//
//  PromotionsShopNowButtonModel.h
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/29/16.
//  Copyright © 2016 Mounika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionsShopNowButtonModel : NSObject

@property (strong, nonatomic) NSString *buttonTitle;
@property (strong, nonatomic) NSString *buttonTargetURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
