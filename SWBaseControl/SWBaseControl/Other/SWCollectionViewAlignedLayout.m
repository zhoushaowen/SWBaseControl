//
//  SWCollectionViewAlignedLayout.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/3/11.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "SWCollectionViewAlignedLayout.h"

@implementation SWCollectionViewAlignedLayout

- (void)setAlignment:(SWCollectionViewAlignment)alignment {
    _alignment = alignment;
    [self.collectionView reloadData];
}

//UICollectionViewFlowLayout内部默认已经做好了布局了 只是每行的布局方式是左右两边对齐 所以只需要调整每行元素的x轴坐标就行了
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentAttri = [super layoutAttributesForItemAtIndexPath:indexPath];
    UIEdgeInsets insets = [self sectionInsetForSection:indexPath.section];
    //如果是第一个item 位置默认不动
    if(indexPath.item == 0) {
        CGRect frame = currentAttri.frame;
        frame.origin.x = self.alignment == SWCollectionViewAlignmentLeft? insets.left:(CGRectGetWidth(self.collectionView.frame) - frame.size.width - insets.right);
        currentAttri.frame = frame;
        return currentAttri;
    }
    //获取上一个UICollectionViewLayoutAttributes一定要调用self的layoutAttributesForItemAtIndexPath获取上一次处理之后的attributes(递归操作) 不能调用super
    UICollectionViewLayoutAttributes *previousAttri = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]];
    //previousAttri所在的矩形框位置
    CGRect rect = CGRectMake(insets.left, previousAttri.frame.origin.y - insets.top, CGRectGetWidth(self.collectionView.frame) - insets.left - insets.right, previousAttri.size.height);
    if(CGRectIntersectsRect(rect, currentAttri.frame)){
        //当前UICollectionViewLayoutAttributes与上一个在同一行
        CGRect frame = currentAttri.frame;
        if(self.alignment == SWCollectionViewAlignmentLeft){
            frame.origin.x = CGRectGetMaxX(previousAttri.frame) + [self minimumInteritemSpacingForSection:indexPath.section];
        }else if (self.alignment == SWCollectionViewAlignmentRight){
            frame.origin.x = CGRectGetMinX(previousAttri.frame) - [self minimumInteritemSpacingForSection:indexPath.section] - frame.size.width;
        }
        currentAttri.frame = frame;
        return currentAttri;
    }else{
        //不在同一行
        CGRect frame = currentAttri.frame;
        frame.origin.x = self.alignment == SWCollectionViewAlignmentLeft? insets.left:(CGRectGetWidth(self.collectionView.frame) - frame.size.width - insets.right);
        currentAttri.frame = frame;
        return currentAttri;
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:attributes];
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //representedElementKind为空表示当前attribute是cell 不是UICollectionElementKindSectionHeader或者UICollectionElementKindSectionFooter
        if(obj.representedElementKind == nil){
            [mutableArr replaceObjectAtIndex:idx withObject:[self layoutAttributesForItemAtIndexPath:obj.indexPath]];
        }
    }];
    return mutableArr;
}


- (UIEdgeInsets)sectionInsetForSection:(NSInteger)section {
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    if(delegate && [delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]){
        UIEdgeInsets insets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        return insets;
    }
    return self.sectionInset;
}

- (CGFloat)minimumInteritemSpacingForSection:(NSInteger)section {
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    if(delegate && [delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]){
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];;
    }
    return self.minimumInteritemSpacing;
}


@end
