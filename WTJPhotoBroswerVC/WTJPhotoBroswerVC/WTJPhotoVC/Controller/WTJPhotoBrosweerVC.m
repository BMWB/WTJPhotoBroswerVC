//
//  WTJPhotoBrosweerVC.m
//  WTJPhotoBroswerVC
//
//  Created by wtj on 16/6/14.
//  Copyright © 2016年 com.yibei.renrenmeishu. All rights reserved.
//

#import "WTJPhotoBrosweerVC.h"
#import "WTJPohotBroswerCell.h"
#import "WTJTopBarView.h"
#import "WTJTopBarDeleteView.h"
#define kAPPWidth [UIScreen mainScreen].bounds.size.width
#define kAppHeight [UIScreen mainScreen].bounds.size.height

//是否支持横屏
#define shouldSupportLandscape NO
// browser消失的动画时长
#define kPhotoBrowserHideDuration 0.4f
//topBar的高度
#define kTopBarViewHeight  60

@interface WTJPhotoBrosweerVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 外部操作控制器 */
@property (nonatomic,weak) UIViewController *handleVC;

/** collectionView */
@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/** 纯净顶部工具条 */
@property (strong, nonatomic) WTJTopBarView *topBarView;
/**带删除按钮顶部条*/
@property (strong, nonatomic) WTJTopBarDeleteView *deleteTopBarView;

@property (assign,nonatomic) PhotoTopBarItemType itemType;
@end

@implementation WTJPhotoBrosweerVC
+(void)show:(UIViewController *)handleVC Index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock{
    
    //取出相册数组
    NSArray *photoModels = photoModelBlock();
    
    WTJPhotoBrosweerVC *pbVC = [[self alloc] initPhotoTopBarItemType:Normal];
    pbVC.photoModels = photoModels;
    pbVC.handleVC = handleVC;
    pbVC.currentImageIndex = index;
    [pbVC show];
}

-(instancetype)initPhotoTopBarItemType:(PhotoTopBarItemType)type{
    
    self = [super init];
    if (self) {
        
        _itemType = type;
    }
    
    return self;
}

#pragma mark - lefe cycle
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    
    switch (self.itemType) {
        case Delete:
            [self.view addSubview:self.deleteTopBarView];
            break;
            
        default:
            [self.view addSubview:self.topBarView];
            break;
    }
    
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentImageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark -priteMth
//单击
-(void)singleTap{
    
    //    __weak typeof(self) weakSelf=self;
    //    CGFloat topBarY;
    //
    //    topBarY =  (weakSelf.topBarView.frame.origin.y == 0)? (-kTopBarViewHeight):0;
    //
    //    [UIView animateWithDuration:kPhotoBrowserHideDuration animations:^{
    //
    //        weakSelf.topBarView.frame= CGRectMake(weakSelf.topBarView.frame.origin.x, topBarY, weakSelf.topBarView.frame.size.width, weakSelf.topBarView.frame.size.height);
    //    }];
}

//当前cell
-(void)currentPhotoBroswerCell:(WTJPohotBroswerCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf=self;
    
    WTJPhotoModel *pbModel = self.photoModels[indexPath.row];
    cell.photoModel = pbModel;
    
    cell.ItemViewSingleTapBlock = ^(){
        
        [weakSelf singleTap];
        
    };
    
}

//show
-(void)show{
    self.hidesBottomBarWhenPushed =YES;
//    [self.handleVC.navigationController pushViewController:self animated:YES];
    [self.handleVC presentViewController:self animated:YES completion:nil];
}

//dismiss

-(void)dismiss{
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)deleteImage{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:self.photoModels];
    
    NSInteger index = 0;
    if (self.topBarView.currentPhotoIndex >=self.photoModels.count) {
        index = self.photoModels.count -1;
    }else{
        
        index = self.topBarView.currentPhotoIndex;
    }
    
    [tempArray removeObjectAtIndex:index];
    
    self.deleteTopBarView.photos =tempArray;
    self.photoModels = tempArray;
    
    
    if (tempArray.count<=0) {
        
        [self resolveModel:nil];
        [self dismiss];
    }else{
        
        [self resolveModel:tempArray];
        [self.mainView reloadData];
    }
    
}

-(void)resolveModel:(NSMutableArray *)modelArray{
    
    if (modelArray &&modelArray.count <= 0) {
//        BlockCallWithOneArg(self.retHandler, nil);
    }else{
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        
        [modelArray enumerateObjectsUsingBlock:^(WTJPhotoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [tempArray addObject:obj.image];
        }];

//        BlockCallWithOneArg(self.retHandler, tempArray);
    }
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WTJPohotBroswerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WTJPhotoBroswerCellKey forIndexPath:indexPath];
    [self currentPhotoBroswerCell:cell AtIndexPath:indexPath];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //改变当前索引
    
    NSIndexPath *path = collectionView.indexPathsForVisibleItems.lastObject;
    
    NSUInteger index = path.item >= self.photoModels.count? (self.photoModels.count -1):path.item;

    switch (self.itemType) {
        case Delete:
            self.deleteTopBarView.currentPhotoIndex = index;
            break;
            
        default:
            self.topBarView.currentPhotoIndex = index;
            break;
    }
    
    
    
}

#pragma mark - setter and getter

-(UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [_flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height)];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _flowLayout;
}


-(UICollectionView *)mainView{
    
    if (!_mainView) {
        
        _mainView= [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _mainView.backgroundColor = [UIColor blackColor];
        _mainView.pagingEnabled = YES;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        [_mainView registerClass:[WTJPohotBroswerCell class] forCellWithReuseIdentifier:WTJPhotoBroswerCellKey];
        _mainView.dataSource = self;
        _mainView.delegate = self;
        
    }
    
    return _mainView;
}

-(WTJTopBarView *)topBarView{
    
    if (!_topBarView) {
        
        __weak typeof(self) weakSelf=self;
        
        _topBarView = [[WTJTopBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kTopBarViewHeight)];
        _topBarView.photos =_photoModels;
        _topBarView.currentPhotoIndex = _currentImageIndex;
        _topBarView.WTJTopBarViewBlock = ^(WTJTopBarType type){
            
            switch (type) {
                case SaveImage:{
                    
                }break;
                    
                case BackMth:{
                    [weakSelf dismiss];
                }break;
                default:
                    break;
            }
            
        };
        
    }
    
    return _topBarView;
}

-(WTJTopBarDeleteView *)deleteTopBarView{
    
    if (!_deleteTopBarView) {
        
        __weak typeof(self) weakSelf=self;
        
        _deleteTopBarView = [[WTJTopBarDeleteView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kTopBarViewHeight)];
        _deleteTopBarView.photos =_photoModels;
        _deleteTopBarView.currentPhotoIndex = _currentImageIndex;
        _deleteTopBarView.WTJTopBarViewBlock = ^(WTJTopBarType type){
            
            switch (type) {
                case DeleteImage:{
                    [weakSelf deleteImage];
                }break;
                case BackMth:{
                    [weakSelf dismiss];
                }break;
                default:
                    break;
            }
            
        };
        
    }
    
    return _deleteTopBarView;
}

-(void)setPhotoModels:(NSArray *)photoModels{
    _photoModels = photoModels;
    
}

//#pragma mark 横竖屏设置
//- (BOOL)shouldAutorotate
//{
//    return shouldSupportLandscape;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    if (shouldSupportLandscape) {
//        return UIInterfaceOrientationMaskAll;
//    } else{
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
@end
