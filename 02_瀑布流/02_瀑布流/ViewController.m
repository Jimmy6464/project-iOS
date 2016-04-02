//
//  ViewController.m
//  02_瀑布流
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"
#import "WaterfallLayout.h"
#import "ShopCell.h"
#import "MJExtension.h"
#import "HMShop.h"
#import "MJRefresh.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterfallLayoutDelgate>
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *shops;
@end
static  NSString *const ID = @"shop";
@implementation ViewController
- (NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *shopArray = [HMShop objectArrayWithFilename:@"1.plist"];
    [self initialSubviews];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.shops addObjectsFromArray:shopArray];
    
}
- (void)initialSubviews
{
    CGRect rect = self.view.bounds;
    WaterfallLayout *waterfall = [WaterfallLayout new];
    waterfall.delgate = self;
    waterfall.sectionInsets = UIEdgeInsetsMake(50, 20, 10, 20);
    waterfall.rowMargin = 20;
    waterfall.columnsCount = 3;
    waterfall.columnMargin = 20;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:waterfall];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
- (CGFloat)waterflowLayout:(WaterfallLayout *)waterfallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    HMShop *shop =[self.shops objectAtIndex:indexPath.item];
    return shop.h/shop.w*width;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}
- (void)loadMoreData
{
    NSArray *shopArray = [HMShop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.collectionView footerEndRefreshing];
    });
    
}
@end
