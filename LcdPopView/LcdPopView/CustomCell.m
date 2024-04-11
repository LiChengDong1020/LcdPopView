//
//  CustomCell.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/11.
//

#import "CustomCell.h"
@interface CustomCell()
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UIImageView *headImageView;
@end
@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.messageLab];

        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.leading.equalTo(self.contentView).offset(5);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        
        
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.headImageView.mas_right).offset(5);
            make.centerY.equalTo(self.headImageView);
        }];
        

        
        [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLab.mas_bottom).offset(5);
            make.leading.equalTo(self.contentView).offset(5);
            make.trailing.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.width.mas_equalTo(kScreenWidth - 10);
        }];
        
        
    }
    return self;
}
- (void)setModel:(BaseModel *)model{
    _nameLab.text = model.name;
    _messageLab.text = model.message;
    [_headImageView sd_setImageWithURL:model.imageUrl];
}
- (void)setTitle:(NSString *)title{
    _nameLab.text = title;
}
- (UILabel *)nameLab{
    if(!_nameLab){
        _nameLab = [UILabel setLabelWithTextColor:nil font:nil];
    }
    return _nameLab;
}
- (UILabel *)messageLab{
    if(!_messageLab){
        _messageLab = [UILabel setLabelWithTextColor:nil font:nil];
    }
    return _messageLab;
}
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}
@end
