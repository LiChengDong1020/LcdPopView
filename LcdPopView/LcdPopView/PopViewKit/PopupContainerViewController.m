//
//  PopupViewController.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "PopupContainerViewController.h"
#import <Masonry/Masonry.h>

@interface PopupContainerViewController ()
@property (nonatomic, weak) id<PopupContainerViewControllerDelegate> delegate;
@property (nonatomic, assign) CGFloat popUpHeight;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIView *popupView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation PopupContainerViewController


- (instancetype)init {
    @throw [NSException exceptionWithName:@"Depcrated init method" reason:@"Use initWithDeletate:" userInfo:nil];
    return nil;
}
- (instancetype)initWithDeletate:(id <PopupContainerViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfigs];
    [self setupSubviews];
    [self setupLayouts];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self popup];
}

- (void)setupConfigs {
    self.popUpHeight = [UIScreen mainScreen].bounds.size.height;
    self.popupView = [self.delegate containerView];
    
    if ([self.delegate respondsToSelector:@selector(centerTitle)]) {
        NSString *title = [self.delegate centerTitle];
        self.titleLabel.text = title;
    }
}
- (void)setupSubviews {
    [self.view addSubview:self.alphaView];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.cancelBtn];
    [self.containerView addSubview:self.moreBtn];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.popupView];
}
- (void)setupLayouts {
    
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset([UIScreen mainScreen].bounds.size.height);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.containerView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self.containerView).inset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.centerY.equalTo(self.cancelBtn);
    }];
    
    [self.popupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom);
        make.bottom.leading.trailing.equalTo(self.containerView);
    }];
}
- (void)popup {
    [self makeContainerCorner];
    [self makePopupAnimation];
}
- (void)makeContainerCorner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    self.containerView.layer.mask = maskLayer;
}

- (void)makePopupAnimation {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.alphaView.alpha = 0.5;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(popupComplete)]) {
            [self.delegate popupComplete];
        }
    }];
}
- (void)cancenAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.alphaView.alpha = 0;
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(self.popUpHeight);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:^{
            if ([self.delegate respondsToSelector:@selector(dismissComplete)]) {
                [self.delegate dismissComplete];
            }
        }];
    }];
}

- (void)moreAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.alphaView.alpha = 0;
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(self.popUpHeight + 50);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:^{
            if ([self.delegate respondsToSelector:@selector(more)]) {
                [self.delegate more];
            }
        }];
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [[UIView alloc] initWithFrame:CGRectZero];
        _alphaView.backgroundColor = UIColor.blackColor;
        _alphaView.alpha = 0;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancenAction)];
        [_alphaView addGestureRecognizer:tapGes];
    }
    return _alphaView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelBtn setImage:[UIImage imageNamed:@"close-popup"] forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(cancenAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreBtn;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = UIColor.blackColor;
    }
    return _titleLabel;
}

@end
