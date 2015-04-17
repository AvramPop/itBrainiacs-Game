//
//  BDProtoProduct.h
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDProtoProduct;


@protocol BDProtoProduct <NSObject>

@optional
+ (BDProtoProduct *)protoProduct;

@optional
- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct;
- (void)parse:(NSDictionary *)dictionary;

@end


@interface BDProtoProduct : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *timeStamp;

@property (nonatomic, strong) NSString *protoProductName;

@property (nonatomic, assign) BOOL isResource;

@property (nonatomic, assign) id<BDProtoProduct> delegate;

@end
