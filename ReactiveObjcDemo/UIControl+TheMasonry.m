//
//  UIView+TheMasonry.m
//  ReactiveObjcDemo
//
//  Created by 刘隆昌 on 2020/4/25.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

#import "UIControl+TheMasonry.h"

#import "View+MASAdditions.h"
#import <UIKit/UIKit.h>



@implementation MAS_VIEW (TheMasonry)


- (UIControl*)mas_theMakeConstraints:(void(^)(MASConstraintMaker *)) __attribute__((noescape)) block{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    [constraintMaker install];
    return self;
}


@end
