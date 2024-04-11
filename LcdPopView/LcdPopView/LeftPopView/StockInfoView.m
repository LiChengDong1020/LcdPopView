//
//  StockInfoView.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "StockInfoView.h"
#import "Header.h"
@interface StockItemInfoView ()
@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@end
@implementation StockItemInfoView
- (instancetype)initWithTopTitle:(NSString *)topTitle topTitleColor:(UIColor *)topColor BottomTitle:(NSString *)bottomTitle bottomColor:(UIColor *)bottomColor {
    self = [super initWithFrame: CGRectZero];
    if (self) {
        [self setupSubviews];
        [self setupLayouts];
        [self innerUpdateTopTitle:topTitle topTitleColor:topColor BottomTitle:bottomTitle bottomColor:bottomColor];
    }
    return self;
}

- (void)updateTopTitle:(NSString *)topTitle topTitleColor:(UIColor *)topColor BottomTitle:(NSString *)bottomTitle bottomColor:(UIColor *)bottomColor {
    [self innerUpdateTopTitle:topTitle topTitleColor:topColor BottomTitle:bottomTitle bottomColor:bottomColor];
}

- (void)setupSubviews {
    [self addSubview:self.containerStackView];
    [self.containerStackView addArrangedSubview:self.topLabel];
    [self.containerStackView addArrangedSubview:self.bottomLabel];
}

- (void)setupLayouts {
    [self.containerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.bottom.equalTo(self).inset(10);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
}

- (void)innerUpdateTopTitle:(NSString *)topTitle topTitleColor:(UIColor *)topColor BottomTitle:(NSString *)bottomTitle bottomColor:(UIColor *)bottomColor {
    self.topLabel.text = topTitle;
    self.topLabel.textColor = topColor;
    self.bottomLabel.text = bottomTitle;
    self.bottomLabel.textColor = bottomColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    @throw [NSException exceptionWithName:@"deprecate init" reason:@"Use the initWithTopTitle:topTitleColor:withBottomTitle:bottomColor" userInfo:nil];
    return nil;
}

- (UIStackView *)containerStackView {
    if (!_containerStackView) {
        _containerStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _containerStackView.axis = UILayoutConstraintAxisVertical;
        _containerStackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _containerStackView;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bottomLabel.font = [UIFont systemFontOfSize:13];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end


@interface StockInfoView ()
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, strong) StockItemInfoView *item1;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) StockItemInfoView *item2;

@property (nonatomic, copy) void(^lastStockBlock)(void) ;
@property (nonatomic, strong) void(^nextStockBlock)(void) ;
@end


@implementation StockInfoView
- (instancetype)initWithFrame:(CGRect)frame {
    @throw [NSException exceptionWithName:@"Deprecated init method" reason:@"Use initWithLastStock:lastStockBlock:nextStock:" userInfo:nil];
    return nil;
}
- (instancetype)initWithLastStock:(nullable void (^)(void)) lastStockBlock nextStock:(nullable void (^)(void)) nextStockBlock{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
        [self setupLayouts];
        if (lastStockBlock) {
            self.lastStockBlock = lastStockBlock;
        } else {
            self.lastBtn.hidden = YES;
        }
        if (nextStockBlock) {
            self.nextStockBlock = nextStockBlock;
        } else {
            self.nextBtn.hidden = YES;
        }
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.containerStackView];
    [self.containerStackView addArrangedSubview:self.item1];//入选时间
    [self.containerStackView addArrangedSubview:self.vLine];
    [self.containerStackView addArrangedSubview:self.item2];//入选后涨幅
    [self addSubview:self.lastBtn];
    [self addSubview:self.nextBtn];
}

- (void)setupLayouts {
    
    [self.containerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self).inset(20);
        make.top.bottom.equalTo(self);
        make.height.mas_equalTo(85);
    }];
    
    [self.item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width-40)/2-1);
    }];
    
    
    [self.item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width-40)/2-1);
    }];
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerStackView.mas_leading);
        make.centerY.equalTo(self.containerStackView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 50));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerStackView.mas_trailing);
        make.size.centerY.equalTo(self.lastBtn);
    }];
}
- (void)lastStockAction {
    if (self.lastStockBlock) {
        self.lastStockBlock();
    }
}

- (void)nextStockAction {
    if (self.nextStockBlock) {
        self.nextStockBlock();
    }
}
#pragma mark - lazy
- (UIStackView *)containerStackView {
    if (!_containerStackView) {
        _containerStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _containerStackView.layer.cornerRadius = 4;
        _containerStackView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];;
        _containerStackView.axis = UILayoutConstraintAxisHorizontal;
        _containerStackView.distribution = UIStackViewDistributionFill;
        _containerStackView.alignment = UIStackViewAlignmentCenter;
        _containerStackView.spacing = 0;
    }
    return _containerStackView;
}

- (StockItemInfoView *)item1 {
    if (!_item1) {
        _item1 = [[StockItemInfoView alloc] initWithTopTitle:@"2023-05-23" topTitleColor:[UIColor blackColor] BottomTitle:@"入选时间" bottomColor:[UIColor lightGrayColor]];
    }
    return _item1;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc] initWithFrame:CGRectZero];
        _vLine.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];;

    }
    return _vLine;
}

- (StockItemInfoView *)item2 {
    if (!_item2) {
        _item2 = [[StockItemInfoView alloc] initWithTopTitle:@"+34.38%" topTitleColor:[UIColor redColor] BottomTitle:@"入选后涨幅" bottomColor:[UIColor lightGrayColor]];
    }
    return _item2;
}

- (UIButton *)lastBtn {
    if (!_lastBtn) {
        _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastBtn setImage:[UIImage imageNamed:@"last-stock"] forState:UIControlStateNormal];
        [_lastBtn addTarget:self action:@selector(lastStockAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lastBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:[UIImage imageNamed:@"next-stock"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextStockAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nextBtn;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
