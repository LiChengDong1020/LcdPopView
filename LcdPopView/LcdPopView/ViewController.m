//
//  ViewController.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "ViewController.h"
#import <Masonry.h>
#import "PopupContainerViewController.h"
#import "LeftPopView/LeftPopViewDelegate.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton *leftBtn;//顶部机构
@property (nonatomic, strong) UIButton *rightBtn;//底部潜龙

@end

@implementation ViewController
/**
 //make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
 //make.width.equalTo(self).multipliedBy(0.5);
 //make.width.equalTo(subView.mas_height).multipliedBy(2);
//      make.width.equalTo(@[subView2, subView3,@100]).priorityHigh();

//subView的宽度是 父视图的宽度的30% + 10个单位
 //left right width height centerX centerY edges

 
 */




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
//    [self setupViews];
//    [self setupLayouts];
}
- (void)setupViews {
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
}
- (void)setupLayouts {
    NSArray *btns = @[self.leftBtn, self.rightBtn];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.leftBtn);
    }];
}
- (void)leftBtnAction {
    LeftPopViewDelegate *leftDelegate = [[LeftPopViewDelegate alloc] init];
    PopupContainerViewController *popupVC = [[PopupContainerViewController alloc] initWithDeletate:leftDelegate];
    popupVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:popupVC animated:NO completion:nil];
}

- (void)bottomDragonAction {
//    BottomPotentialStock *bottomPotentialStock = [[BottomPotentialStock alloc] init];
//    PopContainerVC *popupVC = [[PopContainerVC alloc] initWithDeletate:bottomPotentialStock];
//    popupVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:popupVC animated:NO completion:nil];
}
#pragma mark - Lazy
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_leftBtn setTitle:@"顶部机构" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _leftBtn.backgroundColor = UIColor.lightGrayColor;
        _leftBtn.layer.cornerRadius = 8;
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_rightBtn setTitle:@"底部潜龙" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _rightBtn.backgroundColor = UIColor.lightGrayColor;
        _rightBtn.layer.cornerRadius = 8;
        [_rightBtn addTarget:self action:@selector(bottomDragonAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightBtn;
}

@end
