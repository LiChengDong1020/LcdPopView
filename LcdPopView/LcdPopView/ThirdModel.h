//
//  ThirdModel.h
//  LcdPopView
//
//  Created by lichengdong on 2024/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface MemberModel : NSObject
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *pic;
@end
@interface ThirdModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray <MemberModel *> *members;
@end





NS_ASSUME_NONNULL_END
