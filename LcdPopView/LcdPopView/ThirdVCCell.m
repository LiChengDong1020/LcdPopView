//
//  ThirdVCCell.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/12.
//

#import "ThirdVCCell.h"
@interface ThirdVCCell ()
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray <UIView *>*containerArray;
@end
@implementation ThirdVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArray = [NSArray array];
        self.containerArray = [NSMutableArray array];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.messageLab];
        [self setupConstraints];
    }
    return self;
}
-(void)setupConstraints{
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.leading.equalTo(self.contentView).offset(5);
        make.trailing.equalTo(self.contentView).offset(-5);
        make.width.mas_equalTo(kScreenWidth - 10);
    }];
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom);
        make.leading.trailing.equalTo(self.nameLab);
        make.width.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}
- (void)setModel:(ThirdModel *)model{
    [self resetContainerArray];///防止cell重新排版错乱
    self.dataArray = model.members;
    self.nameLab.text = model.title;
    self.messageLab.text = model.content;
    if (model.members.count > 0) {
        [self.messageLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLab.mas_bottom);
            make.leading.trailing.equalTo(self.nameLab);
            make.width.equalTo(self.nameLab);
        }];
        [self setupSubViews];
    }else{
        [self.messageLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLab.mas_bottom);
            make.leading.trailing.equalTo(self.nameLab);
            make.width.equalTo(self.nameLab);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
    }
}
-(void)resetContainerArray{
    for (id obj in self.containerArray) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)obj;
            [view removeFromSuperview];
        }
    }
    [self.containerArray removeAllObjects];
}

-(UIView *)fetchPreviousViewWithIndex:(NSInteger)index{
    return index > 0? self.containerArray[index - 1] : nil;
}
-(void)setupSubViews{//6a00 7780 54f0
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        UIView *preView = [self fetchPreviousViewWithIndex:i];
        MemberModel * model = self.dataArray[i];
        
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = UIColor.grayColor;
        [self.contentView addSubview:backView];
        
        UIImageView *headView = [[UIImageView alloc]init];
        [headView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        [backView addSubview:headView];
        
        UILabel *contentLab = [UILabel setLabelWithTextColor:UIColor.cyanColor font:nil];
        contentLab.text = model.introduce;
        [backView addSubview:contentLab];

        if (!preView) {
            if (self.dataArray.count == 1) {
                //只有1个
                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(self.contentView).offset(5);
                    make.trailing.equalTo(self.contentView).offset(-5);
                    make.top.equalTo(self.messageLab.mas_bottom);
                    make.bottom.equalTo(self.contentView).offset(-5);
                }];
                
                [headView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(backView).offset(5);
                    make.centerX.equalTo(backView);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                }];
                
                [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.equalTo(backView);
                    make.top.equalTo(headView.mas_bottom).offset(5);
                    make.bottom.equalTo(backView).offset(-5);
                }];
            }else{
                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(self.contentView).offset(5);
                    make.trailing.equalTo(self.contentView).offset(-5);
                    make.top.equalTo(self.messageLab.mas_bottom);
                }];
                
                [headView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(backView).offset(5);
                    make.centerX.equalTo(backView);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                }];
                
                [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.equalTo(backView);
                    make.top.equalTo(headView.mas_bottom).offset(5);
                    make.width.mas_equalTo(kScreenWidth - 10);
                    make.bottom.equalTo(backView).offset(-5);
                }];
            }
        }else{
            
            if (i == self.dataArray.count - 1) {
                [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(self.contentView).offset(5);
                    make.trailing.equalTo(self.contentView).offset(-5);                    make.bottom.equalTo(self.contentView).offset(-5);
                    make.top.equalTo(preView.mas_bottom);
                }];

                [headView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(backView);
                    make.top.equalTo(backView).offset(5);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                }];
                
                [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.equalTo(backView);
                    make.width.mas_equalTo(kScreenWidth - 10);
                    make.top.equalTo(headView.mas_bottom).offset(5);
                    make.bottom.equalTo(backView).offset(-5);
                }];
            }else{
                [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(self.contentView).offset(5);
                    make.trailing.equalTo(self.contentView).offset(-5);              make.top.equalTo(preView.mas_bottom);
                }];

                [headView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(backView);
                    make.top.equalTo(backView).offset(5);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                }];
                
                [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.trailing.equalTo(backView);
                    make.width.mas_equalTo(kScreenWidth - 10);
                    make.top.equalTo(headView.mas_bottom).offset(5);
                    make.bottom.equalTo(backView).offset(-5);
                }];
            }
        }
        [self.containerArray addObject:backView];
    }
    
}
- (UILabel *)nameLab{
    if(!_nameLab){
        _nameLab = [UILabel setLabelWithTextColor:UIColor.orangeColor font:nil];
    }
    return _nameLab;
}
- (UILabel *)messageLab{
    if(!_messageLab){
        _messageLab = [UILabel setLabelWithTextColor:nil font:nil];
    }
    return _messageLab;
}
@end
