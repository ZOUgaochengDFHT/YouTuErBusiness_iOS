//
//  YTEBaseListViewController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/4/27.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEBaseListViewController.h"
#import "YTEB&OLeftCell.h"
#import "YTEOrderRightCell.h"

#define OrderLeftTableViewWID 75
#define OrderLeftTableViewHEI 40

#define OrderRightTableViewHEI 222

#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface YTEBaseListViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation YTEBaseListViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiConfig];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)uiConfig{
    _selectIndex = 0;
    self.view.backgroundColor = YTEGlobalBGColor;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    if (self.leftDataArray.count) [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _leftTableView){
        return self.leftDataArray.count;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _leftTableView){
        return OrderLeftTableViewHEI;
    }else{
        return OrderRightTableViewHEI;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        YTEB_OLeftCell *cell = [YTEB_OLeftCell cellWithTableView:tableView];
        cell.textLabel.text = self.leftDataArray[indexPath.row];
        return cell;
    } else {
        YTEOrderRightCell *cell = [YTEOrderRightCell cellWithTableView:tableView];
        cell.textLabel.text = self.leftDataArray[indexPath.row];
        return cell;

    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        self.selectIndex = indexPath.row;
        YTEB_OLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.highlighted = YES;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        self.selectIndex = indexPath.row;
        YTEB_OLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.highlighted = NO;
    }
}

#pragma mark - Public

- (void)reloadData {
    NSMutableArray *copyArr = [self.leftDataArray copy];
    self.leftDataArray = [self arrayFromAuthenValue];
    if (self.leftDataArray.count != copyArr.count) {
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark - Setter
- (void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)leftDataArray{
    if(!_leftDataArray) _leftDataArray = [self arrayFromAuthenValue];
    return _leftDataArray;
}

- (UITableView *)leftTableView{
    if(_leftTableView == nil){
        //#F2F2F2 100%
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, OrderLeftTableViewWID, ScreenHeight) style:UITableViewStyleGrouped];
        _leftTableView.separatorColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
//        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.backgroundColor = YTEGlobalBGColor;
        _leftTableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if(_rightTableView == nil){
        //#F2F2F2 100%
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(OrderLeftTableViewWID, 0, ScreenWidth - OrderLeftTableViewWID, ScreenHeight) style:UITableViewStyleGrouped];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.backgroundColor = YTEGlobalBGColor;
        _rightTableView.contentInset = UIEdgeInsetsMake(-35, 0, 85, 0);
    }
    return _rightTableView;
}


@end
