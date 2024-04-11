//
//  UILabel+Extension.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/11.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel *)setLabelWithTextColor:(nullable UIColor *)textColor font:(nullable UIFont *)font
{
    textColor = textColor ? textColor : UIColor.blackColor;
    font = font ? font : [UIFont systemFontOfSize:20];

    return [UILabel mcLabelWithTextColor:textColor font:font numberOfLines:0 textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping];
}
+ (UILabel *)mcLabelWithTextColor:(UIColor *)textColor font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    label.lineBreakMode = lineBreakMode;
    label.backgroundColor = UIColor.whiteColor;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}


@end
