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

/** 单击 */
@property (nonatomic,copy) void (^ItemViewSingleTapBlock)();

/** 相册模型 */
@property (nonatomic,strong) PhotoModel *photoModel;
@end
