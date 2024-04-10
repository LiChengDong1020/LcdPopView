//
//  StockInfoView.h
//  LcdPopView
//
//  Created by lichengdong on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockItemInfoView : UIView

- (instancetype)initWithTopTitle: (NSString *)topTitle
                   topTitleColor: (UIColor *)topColor
                     BottomTitle: (NSString *)bottomTitle
                     bottomColor: (UIColor *)bottomColor;

- (void)updateTopTitle:(NSString *)topTitle
                 topTitleColor: (UIColor *)topColor
                   BottomTitle:(NSString *)bottomTitle
                   bottomColor: (UIColor *)bottomColor;

@end

@interface StockInfoView : UIView
- (instancetype)initWithLastStock:(nullable void (^)(void)) lastStockBlock nextStock:(nullable void (^)(void)) nextStockBlock;

@end

NS_ASSUME_NONNULL_END
