//
//  WTJPhotoBrosweerVC.h
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTJPhotoModel.h"
typedef NS_ENUM(NSInteger,PhotoTopBarItemType) {
    Normal,
    Delete,
};
typedef void(^EventHandler)(id sender);

@interface WTJPhotoBrosweerVC : UIViewController
@property (nonatomic,copy)   EventHandler       retHandler;
/** 当前索引 */
@property (assign,nonatomic) NSUInteger currentImageIndex;

@property (nonatomic,strong) NSArray * photoModels;
-(instancetype)initPhotoTopBarItemType:(PhotoTopBarItemType)type;

+(void)show:(UIViewController *)handleVC Index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock;
@end
