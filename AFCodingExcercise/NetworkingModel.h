//
//  NetworkingModel.h
//  A&FCodingExcercise
//
//  Created by Mounika Ankam on 5/27/16.
//  Copyright © 2016 Mounika Ankam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingModel : NSObject

+ (instancetype)sharedInstance;

- (void)getPromotionsFromURL:(NSString *)urlString
                successBlock:(void(^)(NSArray *promotions))successBlock
                failureBlock:(void(^)(NSError *error))failureBlock;
@end
