//
//  PromotionsCell.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import "PromotionsCell.h"

@implementation PromotionsCell

- (void)configureCellWithPromotion:(Promotion *)promotion {
    
    self.promotionTitle.text = promotion.title;
    [self setupPromotionImageForPromoiton:promotion];
}

- (void)setupPromotionImageForPromoiton:(Promotion *)promotion {
    
    NSURL *url = [NSURL URLWithString:promotion.imageURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        promotion.promotionImage = image;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.promotionImage.image = image;
        });
    });
}

@end
