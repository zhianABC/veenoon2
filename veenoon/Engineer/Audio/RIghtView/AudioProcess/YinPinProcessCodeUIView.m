//
//  YinPinProcessCodeUIView.m
//  veenoon
//
//  Created by 安志良 on 2018/3/4.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "YinPinProcessCodeUIView.h"

@interface YinPinProcessCodeUIView()<UITextFieldDelegate> {
    UIView *_inputPannel;
    UITextField *_invitationCode;
}

@end

@implementation YinPinProcessCodeUIView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = RGB(1, 138, 182);
        view.alpha = 0.9;
        
        [self addSubview:view];
        
        UIImageView *titleIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_view_title.png"]];
        [self addSubview:titleIcon];
        titleIcon.frame = CGRectMake(60, 40, 70, 10);
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGB(75, 163, 202);
        [self addSubview:line];
        
        UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        [self addSubview:bottomBar];
        
        //缺切图，把切图贴上即可。
        bottomBar.backgroundColor = [UIColor grayColor];
        bottomBar.userInteractionEnabled = YES;
        bottomBar.image = [UIImage imageNamed:@"botomo_icon_black.png"];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0,160, 50);
        [bottomBar addSubview:cancelBtn];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [cancelBtn addTarget:self
                      action:@selector(cancelAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 50);
        [bottomBar addSubview:okBtn];
        [okBtn setTitle:@"确认" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
        okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [okBtn addTarget:self
                  action:@selector(okAction:)
        forControlEvents:UIControlEventTouchUpInside];
        
        _inputPannel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 180)];
        [self addSubview:_inputPannel];
        _inputPannel.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        
        ///在这里编写登录输入内容框 _inputPannel
        int top = 40;
        int left = 0;
        int w = CGRectGetWidth(_inputPannel.frame);
        UILabel *tL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, w-40, 50)];
        tL.textAlignment = NSTextAlignmentCenter;
        tL.text = @"授权码";
        tL.textColor = RGB(70, 219, 254);
        tL.font = [UIFont boldSystemFontOfSize:18];
        [_inputPannel addSubview:tL];
        
        ///手机号输入框 pending....
        _invitationCode = [[UITextField alloc] initWithFrame:CGRectMake(25, top+20, w-50, 30)];
        _invitationCode.delegate = self;
        _invitationCode.layer.cornerRadius = 5;
        _invitationCode.layer.masksToBounds = YES;
        _invitationCode.textAlignment = NSTextAlignmentCenter;
        _invitationCode.returnKeyType = UIReturnKeyDone;
        _invitationCode.placeholder = @"";
        _invitationCode.backgroundColor = [UIColor whiteColor];
        _invitationCode.textColor = RGB(1, 138, 182);
        _invitationCode.borderStyle = UITextBorderStyleNone;
        [_inputPannel addSubview:_invitationCode];
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

- (void)  textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void) okAction:(id)sender {
    [self removeFromSuperview];
}

- (void) cancelAction:(id)sender{
    [self removeFromSuperview];
}

@end
