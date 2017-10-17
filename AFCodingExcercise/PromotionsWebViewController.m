//
//  PromotionsWebViewController.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/29/16.
//  Copyright © 2016 Mounika. All rights reserved.
//

#import "PromotionsWebViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface PromotionsWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *promotionsWebView;
@end

@implementation PromotionsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadURL];
}

- (void)loadURL {
    
    [self showHUD];
    NSURL *url = [NSURL URLWithString:self.promotionsURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.promotionsWebView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self hideHUD];
}

#pragma mark - MBProgressHUD

- (void)showHUD {
    
    [MBProgressHUD showHUDAddedTo:self.promotionsWebView
                         animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.promotionsWebView
                         animated:YES];
}

@end
