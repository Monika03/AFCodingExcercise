//
//  PromotionsCell.h
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promotion.h"

@interface PromotionsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *promotionImage;
@property (weak, nonatomic) IBOutlet UILabel *promotionTitle;

- (void)configureCellWithPromotion:(Promotion *)promotion;

@end
