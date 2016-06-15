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

// browser消失的动画时长
#define kPhotoBrowserHideDuration 0.4f
//topBar的高度
#define kTopBarViewHeight  60

@interface WTJPhotoBrosweerVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 外部操作控制器 */
@property (nonatomic,weak) UIViewController *handleVC;
/** 相册数组 */
@property (nonatomic,strong) NSArray *photoModels;
/** collectionView */
@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/** 顶部工具条 */
@property (strong, nonatomic) WTJTopBarView *topBarView;
/** 当前索引 */
@property (assign,nonatomic) NSUInteger currentImageIndex;
@end

@implementation WTJPhotoBrosweerVC
+(void)show:(UIViewController *)handleVC Index:(NSUInteger)index photoModelBlock:(NSArray *(^)())photoModelBlock{
    
    //取出相册数组
    NSArray *photoModels = photoModelBlock();
    
    WTJPhotoBrosweerVC *pbVC = [[self alloc] init];
    pbVC.photoModels = photoModels;
    pbVC.handleVC = handleVC;
    pbVC.currentImageIndex = index;
    [pbVC show];
}

#pragma mark - lefe cycle

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.topBarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -priteMth
//单击
-(void)singleTap{
    
    __weak typeof(self) weakSelf=self;
    CGFloat topBarY;
    
    topBarY =  (weakSelf.topBarView.frame.origin.y == 0)? (-kTopBarViewHeight):0;
    
    [UIView animateWithDuration:kPhotoBrowserHideDuration animations:^{
        
        weakSelf.topBarView.frame= CGRectMake(weakSelf.topBarView.frame.origin.x, topBarY, weakSelf.topBarView.frame.size.width, weakSelf.topBarView.frame.size.height);
    }];
}

//当前cell
-(void)currentPhotoBroswerCell:(WTJPohotBroswerCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf=self;
    
    PhotoModel *pbModel = self.photoModels[indexPath.row];
    cell.photoModel = pbModel;
    
    cell.ItemViewSingleTapBlock = ^(){
        
        [weakSelf singleTap];
        
    };
    
}

//show
-(void)show{
    
    [self.handleVC presentViewController:self animated:YES completion:nil];
    
}

//dismiss

-(void)dismiss{


    [self dismissViewControllerAnimated:YES completion:nil];
    
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

    NSIndexPath *path = collectionView.indexPathsForVisibleItems.lastObject;
    
    //改变当前索引
    self.topBarView.currentPhotoIndex = path.item;
  
}

#pragma mark - setter and getter

-(UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        [_flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height)];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _flowLayout;
}


-(UICollectionView *)mainView{
    
    if (!_mainView) {
        
        _mainView= [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _mainView.backgroundColor = [UIColor clearColor];
        _mainView.pagingEnabled = YES;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        [_mainView registerClass:[WTJPohotBroswerCell class] forCellWithReuseIdentifier:WTJPhotoBroswerCellKey];
        _mainView.dataSource = self;
        _mainView.delegate = self;
        
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentImageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
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

-(void)setPhotoModels:(NSArray *)photoModels{
    _photoModels = photoModels;

}
@end
