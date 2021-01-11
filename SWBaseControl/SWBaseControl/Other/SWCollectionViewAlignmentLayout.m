//
//  SWCollectionViewAlignmentLayout.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/8.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "SWCollectionViewAlignmentLayout.h"

@interface SWCollectionViewAlignmentLayout ()
@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes;
@property (nonatomic,weak) id<SWCollectionViewAlignmentLayoutDelegate> delegate;


@end

@implementation SWCollectionViewAlignmentLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self.layoutAttributes removeAllObjects];
    CGSize collectionViewSize = self.collectionView.frame.size;
    [self.layoutAttributes addObjectsFromArray:[self createLayoutAttributesWithCollectionViewSize:collectionViewSize]];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)createLayoutAttributesWithCollectionViewSize:(CGSize)collectionViewSize {
    id delegate = self.collectionView.delegate;
    self.delegate = delegate;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *layoutAttributes = [NSMutableArray arrayWithCapacity:count];
    for(int i=0;i<count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGSize size = CGSizeZero;
        UIEdgeInsets insets = [self layoutInsets];
        CGFloat lineSpacing = 0;
        CGFloat interitemSpacing = 0;
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:alignmentLayout:sizeForItemAtIndexPath:)]){
            size = [self.delegate collectionView:self.collectionView alignmentLayout:self sizeForItemAtIndexPath:indexPath];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:alignmentLayout:lineSpacingForSectionAtIndex:)]){
            lineSpacing = [self.delegate collectionView:self.collectionView alignmentLayout:self lineSpacingForSectionAtIndex:0];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:alignmentLayout:interitemSpacingForSectionAtIndex:)]){
            interitemSpacing = [self.delegate collectionView:self.collectionView alignmentLayout:self interitemSpacingForSectionAtIndex:0];
        }
        if(i == 0){
            if(self.alignment == SWCollectionViewAlignmentLeft){
                attributes.frame = CGRectMake(insets.left, insets.top, size.width, size.height);
            }
            else if (self.alignment == SWCollectionViewAlignmentRight){
                attributes.frame = CGRectMake(collectionViewSize.width - size.width - insets.right, insets.top, size.width, size.height);
            }
        }else{
            UICollectionViewLayoutAttributes *previousAttributes = layoutAttributes[i - 1];
            if(self.alignment == SWCollectionViewAlignmentLeft){
                CGRect frame = CGRectMake(CGRectGetMaxX(previousAttributes.frame) + interitemSpacing, CGRectGetMinY(previousAttributes.frame), size.width, size.height);
                if(CGRectGetMaxX(frame) + insets.right > collectionViewSize.width){
                    frame = CGRectMake(insets.left, CGRectGetMaxY(previousAttributes.frame) + lineSpacing, size.width, size.height);
                    attributes.frame = frame;
                }
                else{
                    attributes.frame = frame;
                }
            }else{
                CGRect frame = CGRectMake(CGRectGetMinX(previousAttributes.frame) - interitemSpacing - size.width, CGRectGetMinY(previousAttributes.frame), size.width, size.height);
                if(CGRectGetMinX(frame) < insets.left){
                    frame = CGRectMake(collectionViewSize.width - size.width - insets.right, CGRectGetMaxY(previousAttributes.frame) + lineSpacing, size.width, size.height);
                    attributes.frame = frame;
                }
                else{
                    attributes.frame = frame;
                }
            }
        }
        [layoutAttributes addObject:attributes];
    }
    return layoutAttributes;
}


- (CGSize)getCollectionViewContentSizeWithPreCollectionViewSize:(CGSize)preCollectionViewSize {
    NSArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [self createLayoutAttributesWithCollectionViewSize:preCollectionViewSize];
    return CGSizeMake(preCollectionViewSize.width, MAX(preCollectionViewSize.height, CGRectGetMaxY(layoutAttributes.lastObject.frame) + [self layoutInsets].bottom));
}

- (void)setAlignment:(SWCollectionViewAlignment)alignment {
    _alignment = alignment;
    [self.collectionView reloadData];
}

- (NSMutableArray *)layoutAttributes {
    if(!_layoutAttributes){
        _layoutAttributes = [NSMutableArray arrayWithCapacity:0];
    }
    return _layoutAttributes;
}

- (UIEdgeInsets)layoutInsets {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if(self.delegate && [self.delegate respondsToSelector:@selector(collectionView:alignmentLayout:insetForSectionAtIndex:)]){
        insets = [self.delegate collectionView:self.collectionView alignmentLayout:self insetForSectionAtIndex:0];
    }
    return insets;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, MAX(self.collectionView.frame.size.height, CGRectGetMaxY(self.layoutAttributes.lastObject.frame) + [self layoutInsets].bottom));
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
