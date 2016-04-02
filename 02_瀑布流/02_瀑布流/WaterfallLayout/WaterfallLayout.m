//
//  WaterfallLayout.m
//  02_瀑布流
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "WaterfallLayout.h"
@interface WaterfallLayout ()
/**
 *  这个字典用来存储每一列最大的Y值（每一列的高度）
 */
@property (nonatomic, strong)NSMutableDictionary *maxYDict;
/**
 *  存放所有的布局属性
 */
@property (nonatomic, strong)NSMutableArray *attrsArray;
@end
@implementation WaterfallLayout
- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        for (int i = 0; i <self.columnsCount; i++) {
            dict[[NSString stringWithFormat:@"%d",i]] = @0;
        }
        _maxYDict = dict;
    }
    return _maxYDict;
}
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        NSMutableArray *array = [NSMutableArray new];
        _attrsArray = array;
    }
    return _attrsArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
   
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    //1.清空最大的y值
    for (int i = 0; i < self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInsets.top);
    }
    
    //2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    CGSize size = CGSizeMake(0, [self.maxYDict[maxColumn] floatValue]+self.sectionInsets.bottom);
    return size;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    __block NSString *miniColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] < [self.maxYDict[miniColumn] floatValue]) {
            miniColumn = column;
        }
    }];
    //计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInsets.left-self.sectionInsets.right-(self.columnsCount-1)*self.columnMargin)/_columnsCount;
    CGFloat height =  [self.delgate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    //计算位置
    CGFloat x = self.sectionInsets.left+(width+_columnMargin)*[miniColumn intValue];
    CGFloat y = [self.maxYDict[miniColumn] floatValue] + self.rowMargin;
    
    //更新这一列的最大Y值
    self.maxYDict[miniColumn] = @(y+height);
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
@end
