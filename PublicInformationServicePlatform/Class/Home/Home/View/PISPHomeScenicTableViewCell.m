//
//  PISPHomeScenicTableViewCell.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPHomeScenicTableViewCell.h"
#import "PISPNotMissScenicSpotModel.h"

#import "PISPHomeScenicCollectionViewCell.h"

@interface PISPHomeScenicTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PISPHomeScenicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.minimumLineSpacing = 8.0;
    collectionViewFlowLayout.minimumInteritemSpacing = 8.0;
    collectionViewFlowLayout.itemSize = CGSizeMake(150.0, 170.0);
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPHomeScenicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PISPHomeScenicCollectionViewCell class])];
}

- (void)setModels:(NSArray<PISPNotMissScenicSpotModel *> *)models
{
    _models = models;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PISPHomeScenicCollectionViewCell *cell = (PISPHomeScenicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PISPHomeScenicCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.models[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionViewItemAtIndexPath:)])
    {
        [self.delegate didSelectCollectionViewItemAtIndexPath:indexPath];
    }
}

@end
