//
//  StackLayout.m
//  01_自定义collectionview布局
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "StackLayout.h"
#define Random0_1 (arc4random_uniform(100)/100.0)
@implementation StackLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(500, 500);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray new];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0 ; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] ];
        [array addObject:attrs];
    }
    return array;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
        NSArray *angles = @[@0,@(-0.2),@(-0.5),@(0.2),@(0.5)];
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(150, 150);
    attrs.center = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
    if (indexPath.item >= 5) {
        attrs.hidden = YES;
    }else {
        attrs.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        //zIndex越大越在上面
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.row;
    }
    return attrs;
}
@end
