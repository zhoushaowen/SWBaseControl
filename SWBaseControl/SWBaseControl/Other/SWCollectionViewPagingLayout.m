//
//  SWCollectionViewPagingLayout.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "SWCollectionViewPagingLayout.h"


@interface SWCollectionViewPagingLayout ()
{
    NSInteger _numberOfPage;
}
@property (nonatomic,strong) NSMutableArray *layoutAttributes;
@property (nonatomic,weak) id<SWCollectionViewPagingLayoutDelegate> delegate;

@end

@implementation SWCollectionViewPagingLayout

- (void)prepareLayout {
    [super prepareLayout];
    _numberOfPage = 1;
    [self.layoutAttributes removeAllObjects];
    self.collectionView.pagingEnabled = YES;
    id delegate = self.collectionView.delegate;
    self.delegate = delegate;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for(int i=0;i<count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGSize size = CGSizeZero;
        UIEdgeInsets insets = UIEdgeInsetsZero;
        CGFloat lineSpacing = 0;
        CGFloat interitemSpacing = 0;
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:pagingLayout:sizeForItemAtIndexPath:)]){
            size = [self.delegate collectionView:self.collectionView pagingLayout:self sizeForItemAtIndexPath:indexPath];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:pagingLayout:insetForSectionAtIndex:)]){
            insets = [self.delegate collectionView:self.collectionView pagingLayout:self insetForSectionAtIndex:0];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:pagingLayout:lineSpacingForSectionAtIndex:)]){
            lineSpacing = [self.delegate collectionView:self.collectionView pagingLayout:self lineSpacingForSectionAtIndex:0];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:pagingLayout:interitemSpacingForSectionAtIndex:)]){
            interitemSpacing = [self.delegate collectionView:self.collectionView pagingLayout:self interitemSpacingForSectionAtIndex:0];
        }
        if(i == 0){
            attributes.frame = CGRectMake(insets.left, insets.top, size.width, size.height);
        }else{
            UICollectionViewLayoutAttributes *previousAttributes = self.layoutAttributes[i - 1];
            CGRect frame = CGRectMake(CGRectGetMaxX(previousAttributes.frame) + interitemSpacing, CGRectGetMinY(previousAttributes.frame), size.width, size.height);
            if(CGRectGetMaxX(frame) + insets.right - (_numberOfPage -1)*self.collectionView.frame.size.width > self.collectionView.frame.size.width){
                frame = CGRectMake(insets.left + (_numberOfPage -1)*self.collectionView.frame.size.width, CGRectGetMaxY(previousAttributes.frame) + lineSpacing, size.width, size.height);
                if(CGRectGetMaxY(frame) + insets.bottom > self.collectionView.frame.size.height){
                    frame = CGRectMake(self.collectionView.frame.size.width*_numberOfPage + insets.left, insets.top, size.width, size.height);
                    attributes.frame = frame;
                    _numberOfPage++;
                }else{
                    attributes.frame = frame;
                }
            }
            else{
                attributes.frame = frame;
            }
        }
        [self.layoutAttributes addObject:attributes];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:pagingLayout:pageCount:)]){
        [self.delegate collectionView:self.collectionView pagingLayout:self pageCount:count > 0? _numberOfPage:0];
    }
}

- (NSMutableArray *)layoutAttributes {
    if(!_layoutAttributes){
        _layoutAttributes = [NSMutableArray arrayWithCapacity:0];
    }
    return _layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width*_numberOfPage, self.collectionView.frame.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[indexPath.item];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.layoutAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes*  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return CGRectIntersectsRect(rect, evaluatedObject.frame);
    }]];
}






@end
