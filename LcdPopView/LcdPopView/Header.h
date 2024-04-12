//
//  Header.h
//  LcdPopView
//
//  Created by lichengdong on 2024/4/11.
//

#ifndef Header_h
#define Header_h

#import <Masonry.h>
#import "UILabel+Extension.h"
#import <YYModel.h>
#import "BaseModel.h"
#import <SDWebImage.h>
#import "CustomCell.h"
#import "ThirdVCCell.h"
#import "ThirdModel.h"

//安全区顶部距离
#define ksafeAreaInsetsTop \
({ \
  float topValue = 0; \
  if (@available(iOS 11.0, *)) { \
      topValue = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top; \
  } \
  (topValue); \
})



//安全区底部距离
#define ksafeAreaInsetsBottom \
({ \
  float bottomValue = 0; \
  if (@available(iOS 11.0, *)) { \
      bottomValue = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom; \
  } \
  (bottomValue); \
})

/**
 * 判断是否为iPhone X 系列 YES代表是iPHone X系列机型 NO代表不是iPHone X系列机型
 */
#define KIsiPhoneX \
({ \
  BOOL KIsiPhoneX = NO; \
  if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) { \
    KIsiPhoneX = NO; \
  } else if (@available(iOS 11.0, *)) { \
    KIsiPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0; \
  } \
  (KIsiPhoneX); \
})

/**
 * 底部间距 IPHONEX系列是34 其他是0
 */
#define kBottomHeight  (KIsiPhoneX ? 34 : 0)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#endif /* Header_h */
