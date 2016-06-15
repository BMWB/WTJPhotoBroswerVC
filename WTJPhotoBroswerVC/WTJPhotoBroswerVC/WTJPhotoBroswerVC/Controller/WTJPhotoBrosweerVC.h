//
//  WTJPhotoBrosweerVC.h
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface WTJPhotoBrosweerVC : UIViewController

+(void)show:(UIViewController *)handleVC Index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock;
@end
