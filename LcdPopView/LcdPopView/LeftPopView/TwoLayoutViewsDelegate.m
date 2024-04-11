//
//  TwoLayoutViewsDelegate.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/11.
//

#import "TwoLayoutViewsDelegate.h"
#import "Header.h"
@interface TwoLayoutViewsDelegate ()
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *bottomLabel;

@end
@implementation TwoLayoutViewsDelegate
#pragma mark - PopupContainerViewControllerDelegate

- (UIView *)containerView {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
    containerView.backgroundColor = UIColor.blueColor;
    [self setupViews:containerView];
    [self setupLayouts:containerView];
    [self setupData];
    return containerView;
}

- (NSString *)centerTitle {
    return @"两个控件自适应高度";
}

- (void)setupViews:(UIView *)containerView {
    containerView.backgroundColor = UIColor.whiteColor;
    [containerView addSubview:self.topLabel];
    [containerView addSubview:self.topView];
    [containerView addSubview:self.bottomLabel];

}
- (void)setupData {
    self.topLabel.text = @"usingSpringWithDamping：弹簧阻尼，这是一个0到1之间的值，值越接近1，弹簧效果越不明显，值越接近0，弹簧效果越明显。";
    self.bottomLabel.text = @"别和管理技术风险，及时调整计划和资源（让他请教别人，参考什么什么资料），避免技术障碍对项目进度的影响。别和管理技术风险，及时调整计划和资源（别和管理技术风险，及时调整计划和资源（别和管理技术风险，及时调整计划和资源（";

}

- (void)setupLayouts:(UIView *)containerView {
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(20);
        make.leading.equalTo(containerView).offset(20);
        make.trailing.equalTo(containerView).offset(-20);
        make.width.mas_equalTo(kScreenWidth - 40);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.topLabel);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 200));
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.width.equalTo(self.topLabel);
        make.bottom.equalTo(containerView).offset(-20);
    }];
}

#pragma mark - label

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [UILabel setLabelWithTextColor:nil font:nil];
    }
    return _topLabel;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = UIColor.cyanColor;
    }
    return _topView;
}
- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [UILabel setLabelWithTextColor:nil font:nil];
    }
    return _bottomLabel;
}
@end
