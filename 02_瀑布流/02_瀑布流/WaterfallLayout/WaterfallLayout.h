//
//  WaterfallLayout.h
//  02_瀑布流
//
//  Created by Jimmy on 16/3/10.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  WaterfallLayout;
@protocol WaterfallLayoutDelgate<NSObject>
- (CGFloat)waterflowLayout:(WaterfallLayout *)waterfallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end
@interface WaterfallLayout : UICollectionViewLayout
@property (nonatomic, assign)UIEdgeInsets sectionInsets;
//每一列的间距
@property (nonatomic, assign)CGFloat columnMargin;
//每一行的间距
@property (nonatomic, assign)CGFloat rowMargin;
//
@property (nonatomic, assign)CGFloat columnsCount;
@property (nonatomic, weak)id<WaterfallLayoutDelgate> delgate;
@end
