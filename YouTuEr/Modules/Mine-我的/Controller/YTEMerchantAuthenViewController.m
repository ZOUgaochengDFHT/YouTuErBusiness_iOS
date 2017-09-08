//
//  YTEMerchantAuthenViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMerchantAuthenViewController.h"
#import "YTEUploadImageViewController.h"
#import "SRCompanyAuthServiceModel.h"
#import "SRGuideAuthServiceModel.h"
#import "SRTranslateServiceModel.h"
#import "SRCarAuthServiceModel.h"

#import "SRAuthService.h"

static const CGFloat    YTEDelayTime1   = 0.4;
static const CGFloat    YTEDelayTime2   = 0.1;
static       NSString*  YTEDateFormmat  = @"yyyy.MM.dd";

@interface YTEMerchantAuthenViewController ()

@property (strong, nonatomic) RETextItem *textItem5;
@property (strong, nonatomic) RETextItem *yearItem1; 
@property (strong, nonatomic) RETextItem *yearItem2; 
@property (strong, nonatomic) RETextItem *textItem1; 
@property (strong, nonatomic) RETextItem *textItem2; 
@property (strong, nonatomic) RETextItem *textItem3; 
@property (strong, nonatomic) RETextItem *textItem4;
@property (strong, nonatomic) REDateTimeItem *passportValidDayBeginItem;
@property (strong, nonatomic) REDateTimeItem *passportValidDayEndItem;
@property (strong, nonatomic) REDateTimeItem *visaValidDayBeginItem;
@property (strong, nonatomic) REDateTimeItem *visaValidDayEndItem;
@property (strong, nonatomic) REDateTimeItem *licenseValidDayEndItem;
@property (strong, nonatomic) RETableViewItem *photosItem1;
@property (strong, nonatomic) RETableViewItem *photosItem2;
@property (strong, nonatomic) RETableViewItem *photosItem3;
@property (strong, nonatomic) RETableViewSection *section;
@property (strong, nonatomic) SRCompanyAuthServiceModel *companySModel;
@property (strong, nonatomic) SRGuideAuthServiceModel *guideSModel;
@property (strong, nonatomic) SRTranslateServiceModel *translateSModel;
@property (strong, nonatomic) SRCarAuthServiceModel *carSModel;
@property (strong, nonatomic) UIButton *submitButton;

@property (strong, nonatomic) NSMutableArray *selectedPhotos1;
@property (strong, nonatomic) NSMutableArray *selectedAssets1;
@property (strong, nonatomic) NSMutableArray *selectedPhotos2;
@property (strong, nonatomic) NSMutableArray *selectedAssets2;
@property (strong, nonatomic) NSMutableArray *selectedPhotos3;
@property (strong, nonatomic) NSMutableArray *selectedAssets3;
@end

@implementation YTEMerchantAuthenViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [self titleFromMerchantAuthenType:self.authType];
    if (self.authType == YTEMerchantAuthTypeJieji) {
        [self initTableViewManager];
    } else {
        [self showProgressView];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_section && self.authType != YTEMerchantAuthTypeJieji) {
        @weakify(self);
        [self performBlock:^{
            @strongify(self);
            [self hideProgressView];
        } afterDelay:(self.authType == YTEMerchantAuthTypeDaoyou || self.authType == YTEMerchantAuthTypeFanyi) ? YTEDelayTime1 : YTEDelayTime2];
        [self initTableViewManager];
    }
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
}

- (RETableViewSection *)addBasicControls {
    [self.manager addSection:self.section];
    [self.section addItemsFromArray:[self itemArrFromMerchantAuthenType:self.authType]];
    [self addButtonSectionWithTitle:@"提交"];
    @weakify(self);
    self.buttonItem.selectionHandler = ^(id item) {
        @strongify(self);
        [self.tableView reloadData];
        [self submit];
    };
    return self.section;
}


#pragma mark - Action

- (void)submit {
    if (![SRReachabilityManager networkIsReachable]) return;
    @weakify(self);
    switch (self.authType) {
        case YTEMerchantAuthTypeDaoyou:
        {
            if (!self.guideSModel.cicerone_type || [self.guideSModel.cicerone_type isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入导游类型！" withType:MessageTypeNotice];
                return;
            }
            if (!self.guideSModel.working_years || [self.guideSModel.working_years isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入导龄！" withType:MessageTypeNotice];
                return;
            }
            if (self.selectedPhotos1 && self.selectedPhotos1.count) self.guideSModel.visa_image = [self.selectedPhotos1 componentsJoinedByString:@","];
            if (self.selectedPhotos2 && self.selectedPhotos2.count) self.guideSModel.passport_image = [self.selectedPhotos2 componentsJoinedByString:@","];
            if (self.selectedPhotos3 && self.selectedPhotos3.count) self.guideSModel.certificate_image = [self.selectedPhotos3 componentsJoinedByString:@","];
            if (!self.guideSModel.visa_image || [self.guideSModel.visa_image isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传签证照片！" withType:MessageTypeNotice];
                return;
            }
            if (!self.guideSModel.passport_image || [self.guideSModel.passport_image isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传护照照片！" withType:MessageTypeNotice];
                return;
            }
            if (!self.guideSModel.certificate_image || [self.guideSModel.certificate_image isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传从业资格照片！" withType:MessageTypeNotice];
                return;
            }
            [self showProgressView];
            [[SRAuthService sharedService] authenCiceroneRequestWithModel:self.guideSModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                @strongify(self);
                [self requestSucceed];
            } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                @strongify(self);
                [self hideProgressView];
            }];
        }
            break;
        case YTEMerchantAuthTypeFanyi:
        {
            if (!self.translateSModel.translation_type || [self.translateSModel.translation_type isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入翻译类型！" withType:MessageTypeNotice];
                return;
            }
            if (!self.translateSModel.working_years || [self.translateSModel.working_years isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入从业时间！" withType:MessageTypeNotice];
                return;
            }
            [self showProgressView];
            [[SRAuthService sharedService] authenTranslateRequestWithModel:self.translateSModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                @strongify(self);
                [self requestSucceed];
            } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                @strongify(self);
                [self hideProgressView];
            }];
        }
            break;
        case YTEMerchantAuthTypeJieji:
        {
            if (!self.carSModel.brand || [self.carSModel.brand isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入品牌！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.car_type || [self.carSModel.car_type isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入车辆型号！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.guest_num || [self.carSModel.guest_num isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入最大载客数！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.luggage_num || [self.carSModel.luggage_num isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入最多行李数！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.driving_years || [self.carSModel.driving_years isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入驾龄！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.car_age || [self.carSModel.car_age isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入年龄！" withType:MessageTypeNotice];
                return;
            }
            if (self.selectedPhotos1 && self.selectedPhotos1.count) self.carSModel.car_image = [self.selectedPhotos1 componentsJoinedByString:@","];
            if (self.selectedPhotos2 && self.selectedPhotos2.count) self.carSModel.driving_license = [self.selectedPhotos2 componentsJoinedByString:@","];
            if (!self.carSModel.car_image || [self.carSModel.car_image isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传车辆照片！" withType:MessageTypeNotice];
                return;
            }
            if (!self.carSModel.driving_license || [self.carSModel.driving_license isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传驾照照片！" withType:MessageTypeNotice];
                return;
            }
            [self showProgressView];
            [[SRAuthService sharedService] authenCarRequestWithModel:self.carSModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                @strongify(self);
                [self requestSucceed];
            } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                @strongify(self);
                [self hideProgressView];
            }];
        }
            break;
        default:
        {
            if (!self.companySModel.company_number || [self.companySModel.company_number isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入营业执照号！" withType:MessageTypeNotice];
                return;
            }
            if (!self.companySModel.country || [self.companySModel.country isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入国家！" withType:MessageTypeNotice];
                return;
            }
            if (!self.companySModel.city || [self.companySModel.city isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入城市！" withType:MessageTypeNotice];
                return;
            }
            if (!self.companySModel.address || [self.companySModel.address isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请输入地址！" withType:MessageTypeNotice];
                return;
            }
            if (self.selectedPhotos1 && self.selectedPhotos1.count) self.companySModel.company_certificate = [self.selectedPhotos1 componentsJoinedByString:@","];
            if (!self.companySModel.company_certificate || [self.companySModel.company_certificate isEqual:@""]) {
                [[SRMessage sharedMessage] showMessage:@"请上传营业执照照片！" withType:MessageTypeNotice];
                return;
            }
            self.companySModel.isvalidity = [[NSDate date] compareDate:self.companySModel.validity] == 1 ? @"1"  : @"2";
            [self showProgressView];
            if (self.authType == YTEMerchantAuthTypeTravelagency) {
                [[SRAuthService sharedService] authenTravelagencyRequestWithModel:self.companySModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                    @strongify(self);
                    [self requestSucceed];
                } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                    @strongify(self);
                    [self hideProgressView];
                }];
            } else {
                [[SRAuthService sharedService] authenBusRequestWithModel:self.companySModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
                    @strongify(self);
                    [self requestSucceed];
                } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
                    @strongify(self);
                    [self hideProgressView];
                }];
            }
        }
            break;
    }
  
}



#pragma mark - Private

- (NSArray *)itemArrFromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    switch (authenType) {
        case YTEMerchantAuthTypeJieji:
            return @[self.textItem2, self.textItem1, self.textItem3,
                     self.textItem4, self.yearItem1, self.yearItem2,
                     self.photosItem1, self.photosItem2];
            break;
        default:
            if (authenType == YTEMerchantAuthTypeTravelagency || authenType == YTEMerchantAuthTypeAgency) return @[self.textItem1, self.textItem2, self.textItem3, self.textItem4, self.licenseValidDayEndItem ,self.photosItem1];
            return @[self.textItem5, self.yearItem1, self.passportValidDayBeginItem,
                     self.passportValidDayEndItem, self.visaValidDayBeginItem, self.visaValidDayEndItem,
                     self.photosItem1, self.photosItem2, self.photosItem3];
            break;
    }
}

- (void)gotoUploadImageVC:(NSString *)title {
    YTEUploadImageViewController *uploadImageVC = [[YTEUploadImageViewController alloc]init];
    uploadImageVC.navigationItem.title = [title replaceAll:@"上传" with:@""];
    [self.navigationController pushViewController:uploadImageVC animated:YES];
    if (self.authType == YTEMerchantAuthTypeDaoyou || self.authType == YTEMerchantAuthTypeFanyi) {
        if ([title isEqual:@"签证照片上传"]) {
            uploadImageVC.selectedPhotos = self.selectedPhotos1;
            uploadImageVC.selectedAssets = self.selectedAssets1;
        } else if ([title isEqual:@"护照照片上传"]) {
            uploadImageVC.selectedPhotos = self.selectedPhotos2;
            uploadImageVC.selectedAssets = self.selectedAssets2;
        } else {
            uploadImageVC.selectedPhotos = self.selectedPhotos3;
            uploadImageVC.selectedAssets = self.selectedAssets3;
        }
    } else if (self.authType == YTEMerchantAuthTypeJieji){
        if ([title isEqual:@"车辆照片上传"]) {
            uploadImageVC.selectedPhotos = self.selectedPhotos1;
            uploadImageVC.selectedAssets = self.selectedAssets1;
        } else {
            uploadImageVC.selectedPhotos = self.selectedPhotos2;
            uploadImageVC.selectedAssets = self.selectedAssets2;
        }
    } else {
        uploadImageVC.selectedPhotos = self.selectedPhotos1;
        uploadImageVC.selectedAssets = self.selectedAssets1;
    }
    @weakify(self);
    uploadImageVC.uploadImageHandle = ^(NSMutableArray *urlArr, NSMutableArray *assetsArr, NSString *navTitle) {
        @strongify(self);
        if (self.authType == YTEMerchantAuthTypeDaoyou || self.authType == YTEMerchantAuthTypeFanyi) {
            if ([navTitle isEqual:@"签证照片"]) {
                self.selectedPhotos1 = urlArr;
                self.selectedAssets1 = assetsArr;
            } else if ([navTitle isEqual:@"护照照片"]) {
                self.selectedPhotos2 = urlArr;
                self.selectedAssets2 = assetsArr;
            } else {
                self.selectedPhotos3 = urlArr;
                self.selectedAssets3 = assetsArr;
            }
        } else if (self.authType == YTEMerchantAuthTypeJieji){
            if ([navTitle isEqual:@"车辆照片"]) {
                self.selectedPhotos1 = urlArr;
                self.selectedAssets1 = assetsArr;
            } else {
                self.selectedPhotos2 = urlArr;
                self.selectedAssets2 = assetsArr;
            }
        } else {
            self.selectedPhotos1 = urlArr;
            self.selectedAssets1 = assetsArr;
        }
    };
}

- (void)requestSucceed {
    [self hideProgressView];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[SRMessage sharedMessage] showMessage:@"商家申请认证成功！" withType:MessageTypeNotice];
}

#pragma mark - Setter

- (RETableViewSection *)section {
    if (!_section) _section = [RETableViewSection sectionWithHeaderTitle:@""];
    return _section;
}

- (RETextItem *)yearItem1 {
    if (!_yearItem1) {
        _yearItem1 = [RETextItem itemWithTitle:[self itemTitle2FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle2FromMerchantAuthenType:self.authType]]];
        _yearItem1.keyboardType = UIKeyboardTypeDecimalPad;
        @weakify(self);
        _yearItem1.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.working_years = item.value;
            if (self.authType == YTEMerchantAuthTypeJieji) self.carSModel.driving_years = item.value;
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.working_years = item.value;
        };
    }
    return _yearItem1;
}
- (RETextItem *)yearItem2 {
    if (!_yearItem2) {
        _yearItem2 = [RETextItem itemWithTitle:@"年龄" value:nil placeholder:@"请输入年龄"];
        _yearItem2.keyboardType = UIKeyboardTypeDecimalPad;
        @weakify(self);
        _yearItem2.onChange = ^(RETextItem *item) {
            @strongify(self);
            self.carSModel.car_age = item.value;
        };
    }
    return _yearItem2;
}

- (RETextItem *)textItem1 {
    if (!_textItem1) {
        _textItem1 = [RETextItem itemWithTitle:[self itemTitle3FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle3FromMerchantAuthenType:self.authType]]];
        @weakify(self);
        _textItem1.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeJieji) self.carSModel.car_type = item.value;
            if (self.authType == YTEMerchantAuthTypeAgency || self.authType == YTEMerchantAuthTypeTravelagency) self.companySModel.company_number = item.value;
        };
    }
    return _textItem1;
}

- (RETextItem *)textItem2 {
    if (!_textItem2) {
        _textItem2 = [RETextItem itemWithTitle:[self itemTitle4FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle4FromMerchantAuthenType:self.authType]]];
        @weakify(self);
        _textItem2.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeJieji) self.carSModel.brand = item.value;
            if (self.authType == YTEMerchantAuthTypeAgency || self.authType == YTEMerchantAuthTypeTravelagency) self.companySModel.country = item.value;
        };
    }
    return _textItem2;
}

- (RETextItem *)textItem3 {
    if (!_textItem3) {
        _textItem3 = [RETextItem itemWithTitle:[self itemTitle7FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle7FromMerchantAuthenType:self.authType]]];
        if (self.authType == YTEMerchantAuthTypeJieji) _textItem3.keyboardType = UIKeyboardTypeNumberPad;
        @weakify(self);
        _textItem3.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeJieji) {
                self.carSModel.guest_num = item.value;
            } else {
                self.companySModel.city = item.value;
            }
        };
    }
    return _textItem3;
}

- (RETextItem *)textItem4 {
    if (!_textItem4) {
        _textItem4 = [RETextItem itemWithTitle:[self itemTitle8FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle8FromMerchantAuthenType:self.authType]]];
        if (self.authType == YTEMerchantAuthTypeJieji) _textItem4.keyboardType = UIKeyboardTypeNumberPad;
        @weakify(self);
        _textItem4.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeJieji) {
                self.carSModel.luggage_num = item.value;
            } else {
                self.companySModel.address = item.value;
            }
        };
    }
    return _textItem4;
}

- (RETextItem *)textItem5 {
    if (!_textItem5) {
        _textItem5 = [RETextItem itemWithTitle:[self itemTitle1FromMerchantAuthenType:self.authType] value:nil placeholder:[NSString stringWithFormat:@"请输入%@", [self itemTitle1FromMerchantAuthenType:self.authType]]];
        @weakify(self);
        _textItem5.onChange = ^(RETextItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.translation_type = item.value;
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.cicerone_type = item.value;
        };
    }
    return _textItem5;
}

- (REDateTimeItem *)passportValidDayBeginItem {
    if (!_passportValidDayBeginItem) {
        _passportValidDayBeginItem = [REDateTimeItem itemWithTitle:@"护照有效期(生效日期)" value:[NSDate date] placeholder:nil format:YTEDateFormmat datePickerMode:UIDatePickerModeDate];
        @weakify(self);
        _passportValidDayBeginItem.onChange = ^(REDateTimeItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.passport_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:0];
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.passport_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:0];
        };
    }
    return _passportValidDayBeginItem;
}

- (REDateTimeItem *)passportValidDayEndItem {
    if (!_passportValidDayEndItem) {
        _passportValidDayEndItem = [REDateTimeItem itemWithTitle:@"护照有效期(截止日期)" value:[[NSDate date] getTomorrowDay] placeholder:nil format:YTEDateFormmat datePickerMode:UIDatePickerModeDate];
        @weakify(self);
        _passportValidDayEndItem.onChange = ^(REDateTimeItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.passport_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:1];
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.passport_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:1];
        };
    }
    return _passportValidDayEndItem;
}

- (REDateTimeItem *)visaValidDayBeginItem {
    if (!_visaValidDayBeginItem) {
        _visaValidDayBeginItem = [REDateTimeItem itemWithTitle:@"签证有效期(生效日期)" value:[NSDate date] placeholder:nil format:YTEDateFormmat datePickerMode:UIDatePickerModeDate];
        @weakify(self);
        _visaValidDayBeginItem.onChange = ^(REDateTimeItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.visa_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:0];
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.visa_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:0];
        };
    }
    return _visaValidDayBeginItem;
}

- (REDateTimeItem *)visaValidDayEndItem {
    if (!_visaValidDayEndItem) {
        _visaValidDayEndItem = [REDateTimeItem itemWithTitle:@"签证有效期(截止日期)" value:[[NSDate date] getTomorrowDay] placeholder:nil format:YTEDateFormmat datePickerMode:UIDatePickerModeDate];
        @weakify(self);
        _visaValidDayEndItem.onChange = ^(REDateTimeItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeDaoyou) self.guideSModel.visa_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:1];
            if (self.authType == YTEMerchantAuthTypeFanyi) self.translateSModel.visa_validtime = [self.guideSModel.passport_validtime stringFromFormatterDate:item.value index:1];
        };
    }
    return _visaValidDayEndItem;
}

- (REDateTimeItem *)licenseValidDayEndItem {
    if (!_licenseValidDayEndItem) {
        _licenseValidDayEndItem = [REDateTimeItem itemWithTitle:@"营业执照有效期" value:[NSDate date] placeholder:nil format:YTEDateFormmat datePickerMode:UIDatePickerModeDate];
        @weakify(self);
        _licenseValidDayEndItem.onChange = ^(REDateTimeItem *item) {
            @strongify(self);
            if (self.authType == YTEMerchantAuthTypeTravelagency || self.authType == YTEMerchantAuthTypeAgency) self.companySModel.validity = [item.value stringFromDateFormat:YTEDateFormmat];
        };
    }
    return _licenseValidDayEndItem;
}

- (RETableViewItem *)photosItem1 {
    if (!_photosItem1) {
        @weakify(self);
        _photosItem1 = [RETableViewItem itemWithTitle:[self itemTitle5FromMerchantAuthenType:self.authType] accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            @strongify(self);
            [self gotoUploadImageVC:[self itemTitle5FromMerchantAuthenType:self.authType]];
        }];
    }
    return _photosItem1;
}

- (RETableViewItem *)photosItem2 {
    if (!_photosItem2) {
        @weakify(self);
        _photosItem2 = [RETableViewItem itemWithTitle:[self itemTitle6FromMerchantAuthenType:self.authType] accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            @strongify(self);
            [self gotoUploadImageVC:[self itemTitle6FromMerchantAuthenType:self.authType]];
        }];
    }
    return _photosItem2;
}

- (RETableViewItem *)photosItem3 {
    if (!_photosItem3) {
        @weakify(self);
        _photosItem3 = [RETableViewItem itemWithTitle:@"从业资格照片上传" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
            @strongify(self);
            [self gotoUploadImageVC:@"从业资格照片上传"];
        }];
    }
    return _photosItem3;
}

- (SRCompanyAuthServiceModel *)companySModel {
    if (!_companySModel) {
        _companySModel = [SRCompanyAuthServiceModel new];
        _companySModel.validity = [[NSDate date] stringFromDateFormat:YTEDateFormmat];
    }
    return _companySModel;
}

- (SRGuideAuthServiceModel *)guideSModel {
    if (!_guideSModel) {
        _guideSModel = [SRGuideAuthServiceModel new];
        NSString *today = [[NSDate date] stringFromDateFormat:YTEDateFormmat];
        NSString *tomorrow = [[[NSDate date] getTomorrowDay] stringFromDateFormat:YTEDateFormmat];
        _guideSModel.passport_validtime = [NSString stringWithFormat:@"%@-%@", today, tomorrow];
        _guideSModel.visa_validtime = [NSString stringWithFormat:@"%@-%@", today, tomorrow];
    }
    return _guideSModel;
}

- (SRTranslateServiceModel *)translateSModel {
    if (!_translateSModel) {
        _translateSModel = [SRTranslateServiceModel new];
        NSString *today = [[NSDate date] stringFromDateFormat:YTEDateFormmat];
        NSString *tomorrow = [[[NSDate date] getTomorrowDay] stringFromDateFormat:YTEDateFormmat];
        _translateSModel.passport_validtime = [NSString stringWithFormat:@"%@-%@", today, tomorrow];
        _translateSModel.visa_validtime = [NSString stringWithFormat:@"%@-%@", today, tomorrow];
    }
    return _translateSModel;
}

- (SRCarAuthServiceModel *)carSModel {
    if (!_carSModel) _carSModel = [SRCarAuthServiceModel new];
    return _carSModel;
}

@end
