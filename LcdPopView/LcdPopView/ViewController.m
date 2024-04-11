//
//  ViewController.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import "ViewController.h"
#import "Header.h"

#import "PopupContainerViewController.h"
#import "LeftPopView/LeftPopViewDelegate.h"
#import "LeftPopView/TwoLayoutViewsDelegate.h"
#import "SecondVC.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;



//@property (nonatomic, strong) UIButton *rightBtn;//底部潜龙

@end

@implementation ViewController
/**
 //make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
 //make.width.equalTo(self).multipliedBy(0.5);
 //make.width.equalTo(subView.mas_height).multipliedBy(2);
//      make.width.equalTo(@[subView2, subView3,@100]).priorityHigh();

//subView的宽度是 父视图的宽度的30% + 10个单位
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    

    
    
    
    
    
    [self setupViews];
    [self setupLayouts];
}
- (void)setupViews {
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];

}
- (void)setupLayouts {
    NSArray *btns = @[self.button1, self.button2,self.button3];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:100 tailSpacing:100];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.height.mas_equalTo(44);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.button1);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.button1);
    }];
}
- (void)buttonAction1 {
    LeftPopViewDelegate *leftDelegate = [[LeftPopViewDelegate alloc] init];
    PopupContainerViewController *popupVC = [[PopupContainerViewController alloc] initWithDeletate:leftDelegate];
    popupVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:popupVC animated:NO completion:nil];
}
- (void)buttonAction2 {
    TwoLayoutViewsDelegate *delegate = [[TwoLayoutViewsDelegate alloc] init];
    PopupContainerViewController *popupVC = [[PopupContainerViewController alloc] initWithDeletate:delegate];
    popupVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:popupVC animated:NO completion:nil];
}
- (void)buttonAction3 {
    
    SecondVC *vc = [[SecondVC alloc]init];
    [self presentViewController:vc animated:NO completion:nil];

}

#pragma mark - Lazy
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [self setButtonWithTitle:@"自适应1个控件" andAciton:@selector(buttonAction1)];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [self setButtonWithTitle:@"自适应2个控件" andAciton:@selector(buttonAction2)];
    }
    return _button2;
}
- (UIButton *)button3 {
    if (!_button3) {
        _button3 = [self setButtonWithTitle:@"cell自适应高度" andAciton:@selector(buttonAction3)];
    }
    return _button3;
}


-(UIButton *)setButtonWithTitle:(NSString *)title andAciton:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = UIColor.yellowColor;
    button.layer.cornerRadius = 8;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
