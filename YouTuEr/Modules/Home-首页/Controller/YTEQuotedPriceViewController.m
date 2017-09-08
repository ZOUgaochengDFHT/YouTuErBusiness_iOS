//
//  YTEQuotedPriceViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEQuotedPriceViewController.h"
#import "YTEQuotedPriceTableViewCell.h"
#import "SRQuoteOrderServiceModel.h"
#import "SROrderService.h"
#import "YTEGuideDemandModel.h"
#import "SRMyQuoteServiceModel.h"
#import "SRUpdateQuoteServiceModel.h"
#import "YTEMyQuoteModel.h"
#import "YWStringNumberHandler.h"
#import "NSString+DecimalsCalculation.h"

#define YTEQuotedPricePreTextArr @[@"报价", @"服务费", @"您的收入"]

@interface YTEQuotedPriceViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *quotedPriceTableView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (strong, nonatomic) SRQuoteOrderServiceModel *serviceModel;
@property (strong, nonatomic) SRUpdateQuoteServiceModel *serviceModel1;
@property (strong, nonatomic) YTEMyQuoteModel *myQuoteModel;
@property (assign, nonatomic) BOOL valueChange;

@end

@implementation YTEQuotedPriceViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.quotedPriceWay == YTEQuotedPriceWay_quoting ? @"报价" : @"修改报价";
    self.view.backgroundColor = YTEGlobalBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.quotedPriceTableView registerNib:[UINib nibWithNibName:@"YTEQuotedPriceTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTEQuotedPriceTableViewCell"];
    if (self.quotedPriceWay == YTEQuotedPriceWay_modifing) {
        _serviceModel1 = [SRUpdateQuoteServiceModel new];
        [self omerchartMyQuoteRequest];
    } else {
        _serviceModel = [SRQuoteOrderServiceModel new];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTEQuotedPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTEQuotedPriceTableViewCell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preLabel.text = YTEQuotedPricePreTextArr[indexPath.row];
    if (!indexPath.row) cell.contentTextField.placeholder = [@"请输入" stringByAppendingString:YTEQuotedPricePreTextArr[indexPath.row]];
    if (self.quotedPriceWay == YTEQuotedPriceWay_quoting) {
        cell.contentLabel.text = [NSString stringWithFormat:@"¥ %.2f", [(self.valueChange ? self.serviceModel.bidFee : @"0.00") floatValue] * (indexPath.row == 1 ? 0.1 : 0.9)];
    } else {
        if (!indexPath.row) cell.contentTextField.text = [NSString stringWithFormat:@"¥ %.2f", [self.myQuoteModel.bidFee floatValue]];
        cell.contentLabel.text = [NSString stringWithFormat:@"¥ %.2f", (self.valueChange ? [self.serviceModel1.bidFee floatValue] : [self.myQuoteModel.bidFee floatValue]) * (indexPath.row == 1 ? 0.1 : 0.9)];
    }
  
    @weakify(self);
    cell.quotedPricehandle = ^(NSString *text) {
        @strongify(self);
        self.valueChange = YES;
        text =  [text replaceAll:@"¥" with:@""];
        if (self.quotedPriceWay == YTEQuotedPriceWay_quoting) {
            self.serviceModel.bidFee = [NSString stringWithFormat:@"%.2f", [text floatValue]];
            self.serviceModel.fee = [NSString stringWithFormat:@"%.2f", [text floatValue]/10];
            self.serviceModel.total = [NSString stringWithFormat:@"%.2f", [text floatValue]*9/10];
        } else {
            self.serviceModel1.bidFee = [NSDecimalNumber decimalNumberWithString:[text addSuffixDoubleZero]];
            self.serviceModel1.fee = [NSDecimalNumber decimalNumberWithString:[[NSString stringWithFormat:@"%f", [text floatValue]/10] addSuffixDoubleZero]];
            self.serviceModel1.total = [NSDecimalNumber decimalNumberWithString:[[NSString stringWithFormat:@"%f", [text floatValue]*9/10] addSuffixDoubleZero]];
            
        }

        [self.quotedPriceTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.quotedPriceTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}

#pragma mark - Action

- (IBAction)submitQuotedPrice:(id)sender {

    if (self.quotedPriceWay == YTEQuotedPriceWay_quoting) {
        if (!self.serviceModel.bidFee || (self.serviceModel.bidFee && [self.serviceModel.bidFee isEqual:@""])) {
            [[SRMessage sharedMessage] showMessage:@"请输入报价！" withType:MessageTypeNotice];
            return;
        }
        if ([self.serviceModel.bidFee floatValue] <= 0) {
            [[SRMessage sharedMessage] showMessage:@"报价金额不能小于0" withType:MessageTypeNotice];
            return;
        }
        self.serviceModel.orderId = [self.guideDemandeModel.Id intValue];
        self.serviceModel.orderNum = self.guideDemandeModel.orderNum;
        self.serviceModel.merchantId = [SRAppManager sharedManager].member_id;
        self.serviceModel.bidUsername = [SRAppManager sharedManager].bidUsername;
        self.serviceModel.message = self.remarkTextView.text;
        [self omerchartQuoteOrderRequest];
    } else {
        if (!self.serviceModel1.bidFee || (self.serviceModel1.bidFee && [self.serviceModel1.bidFee isEqual:@""])) {
            [[SRMessage sharedMessage] showMessage:@"请输入报价！" withType:MessageTypeNotice];
            return;
        }
        if ([self.serviceModel1.bidFee floatValue] <= 0) {
            [[SRMessage sharedMessage] showMessage:@"报价金额不能小于0" withType:MessageTypeNotice];
            return;
        }
        self.serviceModel1.orderId = [self.myQuoteModel.orderId intValue];
        self.serviceModel1.merchantId = [self.myQuoteModel.merchantId intValue];
        self.serviceModel1.message = self.remarkTextView.text;
        [self omerchartUpdateQuoteRequest];
    }
}

#pragma mark - Request

/**
 抢单
 */
- (void)omerchartQuoteOrderRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SROrderService sharedService] omerchartQuoteOrderRequestWithModel:_serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"报价成功！" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}


/**
 查询报价
 */
- (void)omerchartMyQuoteRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    SRMyQuoteServiceModel *serviceModel = [SRMyQuoteServiceModel new];
    serviceModel.orderId = self.orderId;
    serviceModel.clientId = [SRAppManager sharedManager].member_id;
    [[SROrderService sharedService] omerchartMyQuoteRequestWithModel:serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        
        self.myQuoteModel = [YTEMyQuoteModel yy_modelWithDictionary:returnData[@"myQuote"]];
        self.remarkTextView.text = self.myQuoteModel.message;
        self.serviceModel1.bidFee = [NSDecimalNumber decimalNumberWithString:[self.myQuoteModel.bidFee addSuffixDoubleZero]];
        self.serviceModel1.fee = [NSDecimalNumber decimalNumberWithString:[self.myQuoteModel.fee addSuffixDoubleZero]];
        self.serviceModel1.total = [NSDecimalNumber decimalNumberWithString:[self.myQuoteModel.total addSuffixDoubleZero]];
        [self.quotedPriceTableView reloadData];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}


/**
 修改报价
 */
- (void)omerchartUpdateQuoteRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SROrderService sharedService] omerchartUpdateQuoteRequestWithModel:_serviceModel1 successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"修改成功！" withType:MessageTypeNotice];
        [YTENotifiCenter postNotificationName:YTEMODIFYPRICESUCCESSNOTIFICATION object:nil];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}


@end
