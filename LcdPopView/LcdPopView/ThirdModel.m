//
//  ThirdModel.m
//  LcdPopView
//
//  Created by lichengdong on 2024/4/12.
//

#import "ThirdModel.h"

@implementation ThirdModel
//数组对应
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"members": [MemberModel class]};
}
//该名称
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"members": @"member"};
}
@end
@implementation MemberModel

@end
