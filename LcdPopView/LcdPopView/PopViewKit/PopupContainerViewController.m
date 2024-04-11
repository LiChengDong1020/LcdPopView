//
//  delegateViewController.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "PopupContainerViewController.h"
#import "Header.h"

@interface PopupContainerViewController ()
@property (nonatomic, weak) id<PopupContainerViewControllerDelegate> delegate;
@property (nonatomic, assign) CGFloat popUpHeight;
@property (nonatomic, strong) UIView *containerView;///整体的弹出视图，包括代理返回视图、取消按钮、更多按钮、
@property (nonatomic, strong) UIView *alphaView;///弹出时透明度是0.5 其余是0
@property (nonatomic, strong) UIView *delegateView;///代理返回的View
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
    self.delegateView = [self.delegate containerView];
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
    [self.containerView addSubview:self.delegateView];
}
- (void)setupLayouts {
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //这个是需要自动撑大、布局的
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset([UIScreen mainScreen].bounds.size.height);
    }];
    //x,y,w,h
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.containerView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    //x,y,w,h
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self.containerView).inset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    //如果宽度需要自适应centerX 相当于左右约束
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.height.top.equalTo(self.cancelBtn);
    }];
    //需要自适应的、不确定高度的，给约束（一般是上下左右都给了），保证那方程有唯一解，不给高度
    [self.delegateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom);
        make.bottom.leading.trailing.equalTo(self.containerView);
    }];
    //原则就是自适应那个控件算好高度、宽度后，逐步往父控件那么去计算，保证方程有唯一的解
    //自适应宽度，就是上下左右都添加好约束，不要给宽度值
    //自适应高度，就是上下左右都添加好约束，不要给高度值

}
- (void)popup {
    [self makeContainerCorner];
    [self makePopupAnimation];
}
- (void)makeContainerCorner {
    //此处因为containerView没有bounds 所以要放在这里处理圆角
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
            make.bottom.equalTo(self.view).offset(self.popUpHeight);
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
#pragma mark - lazy
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
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
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

- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
