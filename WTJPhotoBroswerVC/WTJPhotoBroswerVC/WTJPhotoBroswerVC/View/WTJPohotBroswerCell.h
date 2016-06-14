//
//  WTJPohotBroswerCell.h
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemView.h"
#define WTJPhotoBroswerCellKey @"WTJPhotoBroswerCellKey"

@interface WTJPohotBroswerCell : UICollectionViewCell
@property (weak,nonatomic) PhotoItemView *currentItemView;
/** 单击 */
@property (nonatomic,copy) void (^ItemViewSingleTapBlock)();
@end
