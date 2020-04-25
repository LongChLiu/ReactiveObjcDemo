//
//  UIView+TheMasonry.h
//  ReactiveObjcDemo
//
//  Created by 刘隆昌 on 2020/4/25.
//  Copyright © 2020 刘隆昌. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Masonry/MASUtilities.h>

NS_ASSUME_NONNULL_BEGIN

@class MASConstraintMaker;

@interface MAS_VIEW (TheMasonry)

- (UIControl *)mas_theMakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;


@end

NS_ASSUME_NONNULL_END
