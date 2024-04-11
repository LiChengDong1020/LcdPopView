//
//  LeftPopViewDelegate.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "LeftPopViewDelegate.h"
#import "Header.h"
#import "StockInfoView.h"
@interface LeftPopViewDelegate ()
@property (nonatomic, strong) StockInfoView *infoView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LeftPopViewDelegate
#pragma mark - PopupContainerViewControllerDelegate

- (UIView *)containerView {
    UIView *rtView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setupViews:rtView];
    [self setupLayouts:rtView];
    return rtView;
}

- (NSString *)centerTitle {
    return @"标题";
}

- (void)setupViews:(UIView *)containerView {
    containerView.backgroundColor = UIColor.whiteColor;
    [containerView addSubview:self.infoView];
    [containerView addSubview:self.bottomView];
}

- (void)setupLayouts:(UIView *)containerView {
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).offset(30);
        make.leading.trailing.equalTo(containerView);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(15);
        make.leading.trailing.equalTo(containerView).inset(20);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 200));
        make.bottom.equalTo(containerView).offset(-10);
    }];
}
- (StockInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[StockInfoView alloc] initWithLastStock:nil nextStock:nil];
    }
    return _infoView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = UIColor.cyanColor;
    }
    return _bottomView;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
