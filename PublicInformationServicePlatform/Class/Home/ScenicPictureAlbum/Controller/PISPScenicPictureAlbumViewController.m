//
//  PISPScenicPictureAlbumViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPScenicPictureAlbumViewController.h"

#import "UIViewController+Cloudox.h"
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>

#import "PISPScenicPictureAlbumModel.h"

static const CGFloat Spacing = 12.0;
static const NSInteger MaxColumnCount = 2;
#define ITEM_WIDTH (((SCREEN_WIDTH - ((MaxColumnCount + 1) * Spacing)) / MaxColumnCount) - 1)
#define ITEM_HEIGHT (ITEM_WIDTH / (337.0 / 250.0))

@interface PISPScenicPictureAlbumViewController ()

@end

@implementation PISPScenicPictureAlbumViewController

#pragma mark - Init
- (void)setupProperties
{
    [super setupProperties];
    
    self.interfaceName = @"scenery/getSceneryImg";
    [self.parameters addDefaultParameters];
    self.modelClass = [PISPScenicPictureAlbumModel class];
}

- (void)setupCollectionView
{
    [super setupCollectionView];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.and.bottom.and.trailing.equalTo(self.view);
        make.top.mas_equalTo([self topBarHeight]);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = (UICollectionViewFlowLayout *)(self.collectionView.collectionViewLayout);
    collectionViewFlowLayout.minimumLineSpacing = Spacing;
    collectionViewFlowLayout.minimumInteritemSpacing = Spacing;
    collectionViewFlowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(Spacing, Spacing, 0, Spacing);
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"1.0";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Tool
- (NSMutableArray<IDMPhoto *> *)photosWithModels
{
    NSMutableArray<IDMPhoto *> *photos = [[NSMutableArray alloc] init];
    for (PISPScenicPictureAlbumModel *model in self.models)
    {
        IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:model.path] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        photo.caption = [NSString ifIsEmptyWithStr:model.name];
        [photos addObject:photo];
    }
    return photos;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    UIImageView *imageView = nil;
    if (cell.backgroundView && [cell.backgroundView isKindOfClass:[UIImageView class]])
    {
        imageView = (UIImageView *)(cell.backgroundView);
    }
    else
    {
        imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = CornerRadius;
        imageView.layer.masksToBounds = YES;
        cell.backgroundView = imageView;
    }
    
    PISPScenicPictureAlbumModel *model = self.models[indexPath.item];
    [imageView setImageWithURLString:model.path placeholderImageName:nil];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PISPScenicPictureAlbumModel *model = self.models[indexPath.item];
    
    [self presentIDMPhotoBrowserWithPhotos:[self photosWithModels] delegate:nil initialPageIndex:indexPath.item];
}

@end
