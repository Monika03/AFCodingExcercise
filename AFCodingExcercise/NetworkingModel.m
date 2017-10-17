//
//  NetworkingModel.m
//  A&FCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import "NetworkingModel.h"
#import "Promotion.h"

@interface NetworkingModel()
@property (nonatomic, copy) void(^successBlock)(NSArray *promotions);
@end

@implementation NetworkingModel

+ (instancetype)sharedInstance {
    
    static NetworkingModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[NetworkingModel alloc] init];
    });
    return _sharedInstance;
}

- (void)getPromotionsFromURL:(NSString *)urlString
                successBlock:(void (^)(NSArray *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock {
    
    self.successBlock = successBlock;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data,
                                                                NSURLResponse *response,
                                                                NSError *error) {
                                                
                                                
                                                if (!error) {
                                                    
                                                    NSError *serializationError = nil;
                                                    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                       options:NSJSONReadingAllowFragments
                                                                                                                         error:&error];
                                                    if (!serializationError) {
                                                        __strong typeof(self)strongSelf = weakSelf;
                                                        [strongSelf buildPromotionsFromResponse:responseDictionary];
                                                    }
                                                }
                                                else {
                                                    failureBlock(error);
                                                }
                                            }];
    [task resume];
}

- (void)buildPromotionsFromResponse:(NSDictionary *)response {
    
    NSMutableArray *promotions = [NSMutableArray array];
    NSArray *rawPromotions = response[@"promotions"];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSDictionary *dictionary in rawPromotions) {
            Promotion *promotion = [[Promotion alloc] initWithDictionary:dictionary];
            [promotions addObject:promotion];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
         __strong typeof(self)strongSelf = weakSelf;
            strongSelf.successBlock(promotions);
        });
    });
}

@end
