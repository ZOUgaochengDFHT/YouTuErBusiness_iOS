//
//  YTEModifyDataViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/8.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEModifyDataViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImagePickerController.h"
#import "TZPhotoPickerController.h"
#import "SRSaveInfoServiceModel.h"
#import "SRGetInfoServiceModel.h"
#import <YYWebImage/YYWebImage.h>
#import "YTEUploadImageCell.h"
#import "YTEAccountModel.h"
#import "TZImageManager.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"
#import "SRUserService.h"


//#define REItemTextColor YTEARGBColor(51, 51, 51)
#define REItemTextColor [UIColor yellowColor]
#define REItemTextFont YTEFont(17)

static const NSInteger YTEMaxImagesCount       = 1;
static const CGFloat   YTECompressionQuality   = 0.1;

@interface YTEModifyDataViewController () <TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) RETextItem *phoneItem; // 联系方式
@property (strong, nonatomic) RETextItem *nickNameItem; //昵称
@property (strong, nonatomic) RETextItem *addressItem; //地址
@property (strong, nonatomic) RETextItem *postcodeItem; //邮编
@property (strong, nonatomic) RELongTextItem *signItem; //个性签名
@property (strong, nonatomic) REDateTimeItem *birthdayItem; //生日
@property (strong, nonatomic) REPickerItem *genderItem;  //性别：M 男；F 女
@property (strong, nonatomic) REPickerItem *countryItem; //国家
@property (strong, nonatomic) REPickerItem *provinceItem; //省
@property (strong, nonatomic) REPickerItem *cityItem; //城市
@property (strong, nonatomic) REPickerItem *areaItem; //区域

@property (strong, nonatomic) RETextItem *countryItem1; //国家
@property (strong, nonatomic) RETextItem *provinceItem1; //省
@property (strong, nonatomic) RETextItem *cityItem1; //城市

@property (strong, nonatomic) NSDictionary *provinceDict;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *area;

@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) SRSaveInfoServiceModel *serviceModel;
@property (strong, nonatomic) UIImageView *iconImageView;

@end

@implementation YTEModifyDataViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改资料";
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self initTableViewManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)initTableViewManager {
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    [self setupManager:self.manager];
    [self addBasicControls];
    [self addRemarksSection];
    [self addButtonSectionWithTitle:@"保存"];
    @weakify(self);
    self.buttonItem.selectionHandler = ^(RETableViewItem *item) {
        @strongify(self);
        [self memberSaveInfoRequest];
    };
}

- (RETableViewSection *)addBasicControls {
    self.serviceModel.photo = self.accountModel.photo;
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.manager addSection:section];
    // Add items to this section
    self.serviceModel.nickName = self.accountModel.nickName;
    self.nickNameItem = [RETextItem itemWithTitle:@"昵称" value:self.serviceModel.nickName placeholder:@"请输入昵称"];
    @weakify(self);
    self.nickNameItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.nickName = item.value;
    };
    self.serviceModel.gender = self.accountModel.gender ? : @"M";
    self.genderItem = [REPickerItem itemWithTitle:@"性别" value:@[[self.serviceModel.gender isEqual:@"M"]? @"男":@"女"] placeholder:nil options:@[@[@"男",@"女"]]];
    self.genderItem.onChange = ^(REPickerItem *item) {
        @strongify(self);
        self.serviceModel.gender = [item.value.lastObject isEqual:@"男"] ? @"M" :@"F";
    };
    self.serviceModel.birthday = self.accountModel.birthday ? : [[NSDate date] stringFromDateFormat:@"yyyy-MM-dd"];
    self.birthdayItem = [REDateTimeItem itemWithTitle:@"生日" value:self.serviceModel.birthday ? [NSDate dateFromString:self.accountModel.birthday  dateFormat:@"yyyy-MM-dd"] : [NSDate date] placeholder:nil format:@"yyyy-MM-dd" datePickerMode:UIDatePickerModeDate];
    self.birthdayItem.onChange = ^(REDateTimeItem *item) {
        @strongify(self);
        self.serviceModel.birthday = [item.value stringFromDateFormat:@"yyyy-MM-dd"];
    };
    
    self.serviceModel.country = self.accountModel.country;
    self.countryItem1 = [RETextItem itemWithTitle:@"国家" value:self.serviceModel.country placeholder:@"请输入国家"];
    self.countryItem1.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.country = item.value;
    };
    
    self.serviceModel.province = self.accountModel.province;
    self.provinceItem1 = [RETextItem itemWithTitle:@"省份" value:self.serviceModel.province placeholder:@"请输入省份"];
    self.provinceItem1.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.province = item.value;
    };
    
    self.serviceModel.city = self.accountModel.city;
    self.cityItem1 = [RETextItem itemWithTitle:@"城市" value:self.serviceModel.city placeholder:@"请输入城市"];
    self.cityItem1.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.city = item.value;
    };
    
//    self.countryItem = [REPickerItem itemWithTitle:@"国家" value:@[self.accountModel.country.isNotEmpty? self.accountModel.country:@"中国"] placeholder:nil options:@[@[@"中国"]]];
//    self.countryItem.onChange = ^(REPickerItem *item) {
//        @strongify(self);
//        self.accountModel.country = item.value.lastObject;
//    };
//    [self createProvinceItem];
//    [self createCityItem];
//    [self createAreaItem];
    self.serviceModel.postcode = self.accountModel.postcode;
    self.postcodeItem = [RETextItem itemWithTitle:@"邮编" value:self.serviceModel.postcode placeholder:@"请输入邮编号码"];
    self.postcodeItem.keyboardType = UIKeyboardTypeNumberPad;
    self.postcodeItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.postcode = item.value;
    };
    self.serviceModel.address = self.accountModel.address;
    self.addressItem = [RETextItem itemWithTitle:@"地址" value:self.serviceModel.address placeholder:@"请输入街道和门牌号"];
    self.addressItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.address = item.value;
    };
    [section addItemsFromArray:@[self.nickNameItem, self.genderItem, self.birthdayItem, self.countryItem1, self.provinceItem1, self.cityItem1, self.postcodeItem, self.addressItem]];
    return section;
}

- (void)createProvinceItem {
    self.province = self.accountModel.province.isNotEmpty ? self.accountModel.province : @"北京市";
    self.provinceItem = [REPickerItem itemWithTitle:@"省份" value:@[self.province] placeholder:nil options:@[self.provinceDict.allKeys]];
    @weakify(self);
    self.provinceItem.onChange = ^(REPickerItem *item) {
        @strongify(self);
        self.province = [item.value firstObject];
        [self createCityItem];
        [self createAreaItem];
    };
}



- (void)createCityItem {
    NSDictionary *cityDict = (NSDictionary *)((NSArray *)self.provinceDict[self.province]).lastObject;
    NSArray *cityArr = [cityDict allKeys];
    self.city = self.accountModel.city.isNotEmpty ? self.accountModel.city : [cityArr firstObject];
    if (self.cityItem) {
        self.cityItem = [self.cityItem initWithTitle:@"城市" value:@[self.city] placeholder:nil options:@[cityArr]];
        [self.manager.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        self.cityItem = [REPickerItem itemWithTitle:@"城市" value:@[self.city] placeholder:nil options:@[cityArr]];
    }
    @weakify(self);
    self.cityItem.onChange = ^(REPickerItem *item) {
        @strongify(self);
        self.city = [item.value lastObject];
        [self createAreaItem];
    };
}

- (void)createAreaItem {
    
    NSDictionary *cityDict = (NSDictionary *)((NSArray *)self.provinceDict[self.province]).lastObject;
    NSArray *areaArr = [cityDict objectForKey:self.city];
    if (self.areaItem) {
        self.areaItem = [self.areaItem initWithTitle:@"区域" value:@[[areaArr firstObject]] placeholder:nil options:@[areaArr]];
        [self.manager.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        self.areaItem = [REPickerItem itemWithTitle:@"区域" value:@[[areaArr firstObject]] placeholder:nil options:@[areaArr]];
    }
}

- (RETableViewSection *)addRemarksSection {
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"个性签名"];
    [self.manager addSection:section];
    self.signItem = [RELongTextItem itemWithValue:self.accountModel.sign placeholder:@"请输入您的个性签名"];
    self.signItem.cellHeight = 100;
    @weakify(self);
    self.serviceModel.sign = self.accountModel.sign;
    self.signItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.sign = item.value;
    };
    [section addItemsFromArray:@[self.signItem]];
    return section;
}


#pragma mark - Requests


- (void)memberSaveInfoRequest {
    self.serviceModel.clientId = [SRAppManager sharedManager].member_id;
    self.serviceModel.location = @"";
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberSaveInfoRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [[SRUserDefaultManager sharedManager] setObject:self.accountModel.nickName forKey:@"bidUsername"];
        [self.navigationController popViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:returnData[kDataJSONKey_Msg] withType:MessageTypeNotice];
        [YTENotifiCenter postNotificationName:YTEMODIFYDATASUCCESSNOTIFICATION object:nil];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

/**
 上传单张图片到服务器
 
 @param image 所上传的图片
 */
- (void)memberPicUpload:(UIImage *)image{
    SRRequestModel *requestModel = [SRRequestModel new];
    requestModel.url = SR_MEMBERPICUPLOAD;
    if (![SRReachabilityManager networkIsReachable]) return;
    dispatch_main_async_safe(^{
        [self showProgressView];
    });
    @weakify(self);
    [[SRNetworkRequest sharedNetworkRequest] uploadRequestWithModel:requestModel
                                                           fileData:UIImageJPEGRepresentation(image, YTECompressionQuality)
                                                       successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                                                           @strongify(self);
                                                           [self hideProgressView];
                                                           self.serviceModel.photo = returnData[@"url"];
                                                           [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:self.serviceModel.photo] placeholder:SR_IMGName(@"mine_head_circle")];
                                                       }
                                                       failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                                                           @strongify(self);
                                                           [self hideProgressView];
                                                           
                                                       }];
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushTZImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        @strongify(self);
        [self memberPicUpload:photos.lastObject];
    });
    // 1.打印图片名字
    // 2.图片位置信息
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}


#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:YTEMaxImagesCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPreview = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.tz_width - 2 * left;
    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:YTEMaxImagesCount delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        @weakify(self);
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
                            @strongify(self);
                            [self memberPicUpload:image];
                        });
                        
                    }];
                }];
            }
        }];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - Getter & Setter
- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0, 0, YTEScreenBoundsWidth, 140}];
        _iconImageView = [UIImageView new];
        _iconImageView.frame = CGRectMake((YTEScreenBoundsWidth - 100)/2, 20, 100, 100);
        _iconImageView.layer.cornerRadius = 50;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.userInteractionEnabled = YES;
        [_iconImageView yy_setImageWithURL:[NSURL URLWithString:self.accountModel.photo] placeholder:SR_IMGName(@"mine_head_circle")];
        _tableHeaderView.backgroundColor = YTEARGBColor(238, 238, 238);
        [_tableHeaderView addSubview:_iconImageView];
        @weakify(self);
        [_iconImageView addTapGesture:^(UITapGestureRecognizer *gesture) {
            @strongify(self);
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        }];
    }
    return _tableHeaderView;
}

- (UIImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (SRSaveInfoServiceModel *)serviceModel {
    if (!_serviceModel) _serviceModel = [SRSaveInfoServiceModel new];
    return _serviceModel;
}

@end
