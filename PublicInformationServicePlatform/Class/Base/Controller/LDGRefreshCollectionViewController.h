//
//  LDGRefreshCollectionViewController.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseViewController.h"

@interface LDGRefreshCollectionViewController : LDGBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) __kindof UIView *noDataView;
@property (strong, nonatomic) NSMutableArray *models;

@property (assign, nonatomic) BOOL needPullDownRefreshing;
@property (assign, nonatomic) BOOL needPullUpRefreshing;

@property (assign, nonatomic) LDGRefreshControlType refreshControlType;

@property (assign, nonatomic) BOOL responseCache;
@property (assign, nonatomic) BOOL showLoadingHUD;

@property (assign, nonatomic) NSInteger page;

- (void)setupNoDataView;//子类重写时不用调super

- (void)endRefreshingWithCount:(NSNumber *)count;
- (void)showPromptStatus;
- (void)disposeNULLResponse;
- (void)disposeSuccess:(id)responseObject;////////////子类重写时不用调super
- (void)disposeError:(id)error;

- (void)loadNewData;
- (void)loadMoreData;
- (void)requestData;//子类重写时不用调super

///////////////////////////////////////////以下属性和方法为常用的设置/////////////////////////////////////////

@property (copy, nonatomic) NSString *interfaceName;

@property (strong, nonatomic) NSMutableDictionary *parameters;

@property (strong, nonatomic) Class modelClass;

- (void)setupProperties NS_REQUIRES_SUPER;
- (void)setupCollectionView NS_REQUIRES_SUPER;//子类重写时主要做注册自定义cell操作

@end
