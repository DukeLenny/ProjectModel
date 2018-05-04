//
//  PISPAKeyAlarmReportTableViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/12.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPAKeyAlarmReportTableViewController.h"

#import "UIViewController+Cloudox.h"
#import "D3RecordButton.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <Photos/Photos.h>
#import "LDGAssetTool.h"
#import <TZImagePickerController/TZImagePickerController.h>

#import "PISPAKeyAlarmReportImageCollectionViewCell.h"

static const CGFloat BottomButtonHeight = 49.0;

#define HorizontalSpace (7.0)
#define VerticalSpace HorizontalSpace
static const NSInteger MaxColumnCount = 3;
static const NSInteger MaxAssetCount = 9;
#define ItemCount (self.assets.count < MaxAssetCount ? self.assets.count + 1 : self.assets.count)

@interface PISPAKeyAlarmReportTableViewController ()<UITextViewDelegate, D3RecordDelegate, AVAudioPlayerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIButton *bottomButton;

@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet D3RecordButton *audioButton;
@property (nonatomic, strong) NSData *voiceData;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (nonatomic, strong) PHAsset *videoAsset;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionView_height;
@property (strong, nonatomic) NSMutableArray<PHAsset *> *assets;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;

@end

@implementation PISPAKeyAlarmReportTableViewController

#pragma mark - Event
- (void)bottomButtonClicked:(UIButton *)button
{
    
}

- (void)tableViewTaped
{
    [self.tableView endEditing:YES];
}

- (IBAction)videoButtonClicked:(UIButton *)sender
{
    if (self.videoAsset)
    {
        [self presentVideoAlertController];
    }
    else
    {
        [self presentGetVideoAlertController];
    }
}

#pragma mark - Tool
- (void)presentAudioAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"音频操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"试听" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.audioPlayer)
        {
            [SVProgressHUD showWithStatus:@"正在播放音频..."];
            [self playAudio];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.voiceData = nil;
        
        self.audioPlayer = nil;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentGetVideoAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照或从相册中选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self presentTZImagePickerController];
//    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"录制视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentVideoAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"视频操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentAVPlayerViewControllerWithVideoAsset:self.videoAsset];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.videoAsset = nil;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentAVPlayerViewControllerWithVideoAsset:(PHAsset *)videoAsset
{
    [[PHImageManager defaultManager] requestPlayerItemForVideo:videoAsset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        playerViewController.player = player;
        playerViewController.showsPlaybackControls = YES;
        playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
        [self presentViewController:playerViewController animated:YES completion:nil];
    }];
}

- (void)presentUIImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self presentAlertControllerWithMessage:@"设备不支持此功能"];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imageButtonClickedWithAsset:(PHAsset *)asset indexPath:(NSIndexPath *)indexPath
{
    if (asset)
    {
        GetWeakSelf
        [self presentTZImagePickerControllerWithSelectedAssets:self.assets selectedPhotos:self.images index:indexPath.item maxImagesCount:MaxAssetCount didFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            weakSelf.images = [NSMutableArray arrayWithArray:photos];
            weakSelf.assets = [NSMutableArray arrayWithArray:assets];
            [weakSelf reloadCollectionViewData];
        }];
    }
    else
    {
        GetWeakSelf
        [self presentTZImagePickerControllerWithMaxImagesCount:MaxAssetCount columnNumber:4 selectedAssets:self.assets didFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            weakSelf.images = [NSMutableArray arrayWithArray:photos];
            weakSelf.assets = [NSMutableArray arrayWithArray:assets];
            [weakSelf reloadCollectionViewData];
        }];
    }
}

#pragma mark - 音频
/**
 *  创建音频播放器
 *
 *  @return 音频播放器
 */
- (AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer)
    {
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:self.voiceData error:&error];
        _audioPlayer.numberOfLoops = 0;//设置为0不循环
        _audioPlayer.delegate = self;
        if(error)
        {
            MMLog(@"初始化音乐播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  播放音频
 */
- (void)playAudio
{
    if (![self.audioPlayer isPlaying])
    {
        [self.audioPlayer play];
    }
}

/**
 *  暂停播放音频
 */
- (void)pauseAudio
{
    if ([self.audioPlayer isPlaying])
    {
        [self.audioPlayer pause];
    }
}

#pragma mark - Init
- (UIButton *)bottomButton
{
    if (!_bottomButton)
    {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, 0, 0, BottomButtonHeight);
        _bottomButton.backgroundColor = NavigationBarBarTintColor;
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:17.5];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomButton setTitle:@"立即上报" forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

- (void)setVoiceData:(NSData *)voiceData
{
    _voiceData = voiceData;
    
    if (voiceData)
    {
        [self.audioButton setImage:[UIImage imageNamed:@"report_fill_icon_record_highlighted"] forState:UIControlStateNormal];
        [self.audioButton setTitle:@"试听/删除" forState:UIControlStateNormal];
        [self.audioButton setTitleColor:UIColorFromRGB(0x12a2fe) forState:UIControlStateNormal];
    }
    else
    {
        [self.audioButton setImage:[UIImage imageNamed:@"report_fill_icon_record_normal"] forState:UIControlStateNormal];
        [self.audioButton setTitle:@"按住录音" forState:UIControlStateNormal];
        [self.audioButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    }
    [self.audioButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:ButtonImageTitleSpacing];
}

- (void)setVideoAsset:(PHAsset *)videoAsset
{
    _videoAsset = videoAsset;
    
    if (videoAsset)
    {
        self.videoButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.videoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        self.videoButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        
        [LDGAssetTool requestImageForAsset:videoAsset sync:YES targetSize:CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT) completion:^(UIImage *image) {
            [self.videoButton setImage:image forState:UIControlStateNormal];
        }];
        [self.videoButton setTitle:nil forState:UIControlStateNormal];
        self.videoButton.imageEdgeInsets = UIEdgeInsetsZero;
        self.videoButton.titleEdgeInsets = UIEdgeInsetsZero;
        self.playImageView.hidden = NO;
    }
    else
    {
        self.videoButton.imageView.contentMode = UIViewContentModeScaleToFill;
        self.videoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.videoButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.videoButton setImage:[UIImage imageNamed:@"report_fill_icon_camera_normal"] forState:UIControlStateNormal];
        [self.videoButton setTitle:@"视频" forState:UIControlStateNormal];
        [self.videoButton setContentEdgeInsetsWithLayoutType:UIButtonContentLayoutTypeTopImageBottomTitle space:ButtonImageTitleSpacing];
        self.playImageView.hidden = YES;
    }
}

- (NSMutableArray<PHAsset *> *)assets
{
    if (!_assets)
    {
        _assets = [[NSMutableArray alloc] init];
    }
    return _assets;
}

- (NSMutableArray<UIImage *> *)images
{
    if (!_images)
    {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

#pragma mark - SetupUI
- (void)setupUI
{
    [self setupTableView];
    
    self.typeLabel.text = [NSString ifIsEmptyWithStr:self.navigationItem.title];
    
    [self setupAudioButton];
    [self setupVideoButton];
    [self setupCollectionView];
}

- (void)setupTableView
{
    self.tableView.tableFooterView = self.bottomButton;
    self.tableView.estimatedRowHeight = 400.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTaped)]];
}

- (void)setupAudioButton
{
    self.audioButton.layer.borderColor = UIColorFromRGB(0xD4D4D4).CGColor;
    self.audioButton.layer.borderWidth = 0.5;
    
    self.voiceData = nil;
    
    [self.audioButton initRecord:self maxtime:120 title:@"上滑取消录音"];
}

- (void)setupVideoButton
{
    self.videoButton.layer.borderColor = UIColorFromRGB(0xD4D4D4).CGColor;
    self.videoButton.layer.borderWidth = 0.5;
    
    self.videoAsset = nil;
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.minimumLineSpacing = VerticalSpace;
    collectionViewFlowLayout.minimumInteritemSpacing = HorizontalSpace;
    collectionViewFlowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
//    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PISPAKeyAlarmReportImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PISPAKeyAlarmReportImageCollectionViewCell class])];
    
    [self setCollectionViewHeight];
}

- (void)reloadCollectionViewData
{
    [self setCollectionViewHeight];
    
    [self.collectionView reloadData];
    
    [self.tableView reloadData];
}

- (void)setCollectionViewHeight
{
    NSInteger itemCount = ItemCount;
    NSInteger maxItem = itemCount - 1;
    NSInteger maxRow = maxItem / MaxColumnCount;
    NSInteger rowCount = maxRow + 1;
    self.collectionView_height.constant = rowCount * ITEM_HEIGHT + (rowCount - 1) * VerticalSpace;
}

- (void)deleteAsset:(PHAsset *)asset
{
    [self.assets removeObject:asset];
    [self reloadCollectionViewData];
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, [self topBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT - [self topBarHeight]);
    self.locationImageView.layer.cornerRadius = self.locationImageView.bounds.size.height / 2.0;
    self.locationImageView.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"1.0";
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = textView.text.length > 0;
    
    [textView didChangeWithMaxTextLength:200];
}

#pragma mark - D3RecordDelegate
- (void)endRecord:(NSData *)voiceData
{
    self.voiceData = voiceData;
}

- (BOOL)shouldStartRecord
{
    if (self.voiceData)
    {
        [self presentAudioAlertController];
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag)
    {
        [SVProgressHUD dismiss];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"音频播放失败"];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    [SVProgressHUD showErrorWithStatus:@"音频解码错误"];
}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MMLog(@"%@",info);
    /*
     //从相册中选择视频
     {
     UIImagePickerControllerMediaType = "public.movie";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.MOV?id=9D116530-54C1-41E0-A171-087C55BB5D10&ext=MOV";
     }
     //录制视频
     {
     UIImagePickerControllerMediaType = "public.movie";
     UIImagePickerControllerMediaURL = "file:///private/var/mobile/Containers/Data/Application/73E9B1DB-ABF1-4555-B7E0-CA6C2D93B65E/tmp/51953032586__3E02521F-E38F-43D9-8EB6-A3C1F577CADB.MOV";
     }
     */
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        {
            NSURL *referenceURL = info[UIImagePickerControllerReferenceURL];
            if (!referenceURL)
            {
                [self presentAlertControllerWithMessage:@"选择视频失败"];
            }
            else
            {
                PHAsset *asset = [PHAsset fetchAssetsWithALAssetURLs:@[referenceURL] options:nil].firstObject;
                self.videoAsset = asset;
            }
        }
        else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
            if (!mediaURL)
            {
                [self presentAlertControllerWithMessage:@"录制视频失败"];
            }
            else
            {
                [LDGAssetTool saveVideoToCameraRollAtFileURL:mediaURL.relativePath completion:^(BOOL success, PHAsset *asset) {
                    if (!success)
                    {
                        [self presentAlertControllerWithMessage:@"录制视频失败"];
                    }
                    else
                    {
                        self.videoAsset = asset;
                    }
                }];
            }
        }
    }
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PISPAKeyAlarmReportImageCollectionViewCell *cell = (PISPAKeyAlarmReportImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PISPAKeyAlarmReportImageCollectionViewCell class]) forIndexPath:indexPath];
    
    PHAsset *asset = indexPath.item < self.assets.count ? self.assets[indexPath.item] : nil;
    
    cell.asset = asset;
    
    GetWeakSelf
    cell.imageButtonClicked = ^(UIButton *button) {
        [weakSelf imageButtonClickedWithAsset:asset indexPath:indexPath];
    };
    
    return cell;
}

@end
