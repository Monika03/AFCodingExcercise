//
//  ViewController.m
//  AFCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import "PromotionsController.h"
#import "NetworkingModel.h"
#import "PromotionsCell.h"
#import "Promotion.h"
#import "PromotionDetailViewController.h"

@interface PromotionsController () <UITableViewDataSource>
@property(nonatomic, strong) NSArray *promotions;
@end

static NSString *const cellIdentifier = @"PromotionsCell";

@implementation PromotionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkingModel *model = [NetworkingModel sharedInstance];
    __weak typeof(self) weakSelf = self;
    [model getPromotionsFromURL:@"https://www.abercrombie.com/anf/nativeapp/Feeds/promotions.json"
                   successBlock:^(NSArray *promotions) {
                       __strong typeof(self)strongSelf = weakSelf;
                       strongSelf.promotions = promotions;
                       [strongSelf.tableView reloadData];
                   } failureBlock:^(NSError *error) {
        
                       __strong typeof(self)strongSelf = weakSelf;
                       [strongSelf presentAlertForError:error];
                   }
     ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.promotions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PromotionsCell *cell = (PromotionsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Promotion *promotion = self.promotions[indexPath.row];
    [cell configureCellWithPromotion:promotion];
    return cell;
}

#pragma mark - UINavigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    PromotionsCell *cell = (PromotionsCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Promotion *selectedPromotion = self.promotions[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"PromotionDetail"]) {
        
        PromotionDetailViewController *detailVC = (PromotionDetailViewController *)segue.destinationViewController;
        detailVC.promotion = selectedPromotion;
    }
}

#pragma mark - Alerts

- (void)presentAlertForError:(NSError *)error {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
