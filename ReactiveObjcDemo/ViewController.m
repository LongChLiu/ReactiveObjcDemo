//
//  ViewController.m
//  ReactiveObjcDemo
//
//  Created by 刘隆昌 on 2020/4/24.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "UIControl+TheMasonry.h"


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UITextField* textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.borderStyle = UITextBorderStyleLine;
    [[[textField mas_theMakeConstraints:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(100);
    }] rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UITextField * _Nullable x) {
        NSLog(@"XXXXXXXX:   %@",x.text);
    }];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];btn.backgroundColor = [UIColor blueColor];
//    [[[btn mas_theMakeConstraints:^(MASConstraintMaker * _Nonnull make) {
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//        make.top.mas_equalTo(textField.mas_bottom).offset(20);
//        make.height.mas_equalTo(40);
//    }] rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable btn) {
//        NSLog(@"点击了按钮");
//    }];
    
    [btn mas_theMakeConstraints:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(textField.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [ViewController loginWithUsernameAndPassword:@"LongChang" password:@"AS9876RFF"];
        
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [subscriber sendNext:@"按钮点击了"];
//                [subscriber sendCompleted];
//            });
//            return nil;
//        }];
    }];
    
    [[btn.rac_command executionSignals] subscribeNext:^(RACSignal<id> * _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"++++++++++： %@",x);
        }];
    }];
    
    
}

/*创建用户名密码登陆的RACSignal   模拟网络请求、读取数据库等耗时操作*/
+(RACSignal*)loginWithUsernameAndPassword:(NSString*)username password:(NSString*)password{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:[NSString stringWithFormat:@"User: %@  Password: %@",username,password]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}



//防止按钮重复点击的RxSwift方案:
/*
 pushButton.rx.tap.asObservable()
 .throttle(2, scheduler: MainScheduler.instance)
 .bind {
     print("被点击了...")
 }
 .disposed(by: bag)
 */




@end
