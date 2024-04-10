//
//  LeftPopViewDelegate.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "LeftPopViewDelegate.h"
#import <Masonry/Masonry.h>
#import "StockInfoView.h"
@interface LeftPopViewDelegate ()
@property (nonatomic, strong) StockInfoView *infoView;
@property (nonatomic, strong) UIImageView *kLineView;
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
    return @"Lcd顶部机构";
}

- (void)setupViews:(UIView *)containerView {
    containerView.backgroundColor = UIColor.whiteColor;
    [containerView addSubview:self.infoView];
    [containerView addSubview:self.kLineView];
}

- (void)setupLayouts:(UIView *)containerView {
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).offset(30);
        make.leading.trailing.equalTo(containerView);
    }];
    [self.kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(15);
        make.leading.trailing.equalTo(containerView).inset(20);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 330));
        make.bottom.equalTo(containerView);
    }];
}
- (StockInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[StockInfoView alloc] initWithLastStock:nil nextStock:nil];
    }
    return _infoView;
}

- (UIImageView *)kLineView {
    if (!_kLineView) {
        _kLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top-intuintion-kline"]];
    }
    return _kLineView;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
