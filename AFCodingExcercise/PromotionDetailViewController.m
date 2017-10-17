//
//  PromotionDetailViewController.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import "PromotionDetailViewController.h"
#import "PromotionsWebViewController.h"

@interface PromotionDetailViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *promotionImage;
@property (weak, nonatomic) IBOutlet UILabel *promotionTitle;
@property (weak, nonatomic) IBOutlet UILabel *promotionDescription;
@property (weak, nonatomic) IBOutlet UITextView *promotionFooterView;
@property (weak, nonatomic) IBOutlet UIButton *shopNowButton;

@end

@implementation PromotionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.promotion.title;
    [self displayPromotion];
}

- (void)displayPromotion {
    
    self.promotionImage.image = self.promotion.promotionImage;
    self.promotionTitle.text = self.promotion.title;
    self.promotionDescription.text = self.promotion.promotionDescription;
    
    [self setupFooter];
    [self setupShopNowButton];
}

- (void)setupFooter {
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.promotion.promotionFooterText dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                         documentAttributes:nil
                                                                      error:nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attrStr];
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrStr.length)];
    self.promotionFooterView.attributedText = attributedString;
}

- (void)setupShopNowButton {
    
    NSString *title = self.promotion.promotionsShopNowButtonModel.buttonTitle;
    [self.shopNowButton setTitle:title forState:UIControlStateNormal];
}

#pragma UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    return YES;
}

#pragma mark - UINavigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowNowSegue"]) {
        
        PromotionsWebViewController *webViewController = (PromotionsWebViewController *)segue.destinationViewController;
        webViewController.promotionsURL = self.promotion.promotionsShopNowButtonModel.buttonTargetURL;
    }
}

@end
