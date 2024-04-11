//
//  BaseModel.h
//  LcdPopView
//
//  Created by lichengdong on 2024/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
