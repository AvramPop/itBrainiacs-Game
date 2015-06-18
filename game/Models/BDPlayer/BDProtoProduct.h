//
//  BDProtoProduct.h
//  game
//
//  Created by Bogdan Sala on 27/02/15.
//  Copyright (c) 2015 Telenav. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ProtoProductTypeResource,
    ProtoProductTypeBuilding,
    ProtoProductTypeUnit,
    ProtoProductTypeUpgrade
} ProtoProductType;

@class BDProtoProduct;


@protocol BDProtoProduct <NSObject>

@optional

+ (BDProtoProduct *)protoProduct;
+ (BDProtoProduct *)upgradeProtoProduct;

- (void)didFinishCreatingProtoProduct:(BDProtoProduct *)protoProduct;
- (void)parse:(NSDictionary *)dictionary;

@end


@interface BDProtoProduct : NSObject <NSCoding>

@property (nonatomic, strong) NSDate                *timeStamp;
@property (nonatomic, strong) NSString              *protoProductName;
@property (nonatomic, assign) ProtoProductType      type;
@property (nonatomic, assign) id<BDProtoProduct>    delegate;

+ (instancetype)protoProductWithProtoProduct:(BDProtoProduct *)proto;

@end
