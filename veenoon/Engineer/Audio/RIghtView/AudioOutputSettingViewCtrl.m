//
//  AudioOutputSettingViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2018/2/25.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "AudioOutputSettingViewCtrl.h"
#import "UIButton+Color.h"
#import "XinHaoFaShengQi_UIView.h"
#import "DianPing_UIView.h"
#import "LvBoJunHeng_UIView.h"
#import "YaXianQi_UIView.h"
#import "YanShiQi_UIView.h"

@interface AudioOutputSettingViewCtrl () {
    
    XinHaoFaShengQi_UIView *xinhaoView;
    UIButton *xinhaofashengqiBtn;
    
    DianPing_UIView *dianpingView;
    UIButton *dianpingBtn;
    
    LvBoJunHeng_UIView *lvbojunhengView;
    UIButton *lvbojunhengBtn;
    
    YaXianQi_UIView *yaxianView;
    UIButton *yaxianBtn;
    
    YanShiQi_UIView *yanshiView;
    UIButton *yanshiqiBtn;
}

@end

@implementation AudioOutputSettingViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setCenterTitle:@"输出设置"];
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomBar];
    
    //缺切图，把切图贴上即可。
    bottomBar.backgroundColor = [UIColor grayColor];
    bottomBar.userInteractionEnabled = YES;
    bottomBar.image = [UIImage imageNamed:@"botomo_icon_black.png"];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0,160, 50);
    [bottomBar addSubview:cancelBtn];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelBtn addTarget:self
                  action:@selector(cancelAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 50);
    [bottomBar addSubview:okBtn];
    [okBtn setTitle:@"保存" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okBtn addTarget:self
              action:@selector(okAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    int startX = 60;
    int startY = 100;
    int gap = 10;
    int bw = 80;
    int bh = 30;
    
    xinhaofashengqiBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
    xinhaofashengqiBtn.frame = CGRectMake(startX, startY, bw, bh);
    xinhaofashengqiBtn.clipsToBounds = YES;
    xinhaofashengqiBtn.layer.cornerRadius = 5;
    xinhaofashengqiBtn.layer.borderWidth = 2;
    xinhaofashengqiBtn.layer.borderColor = [UIColor clearColor].CGColor;
    xinhaofashengqiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [xinhaofashengqiBtn setTitle:@"信号发生器" forState:UIControlStateNormal];
    [xinhaofashengqiBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    [xinhaofashengqiBtn setTitleColor:YELLOW_COLOR forState:UIControlStateHighlighted];
    [self.view addSubview:xinhaofashengqiBtn];
    [xinhaofashengqiBtn addTarget:self
                  action:@selector(xinhaofashengqiAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    
    dianpingBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
    dianpingBtn.frame = CGRectMake(CGRectGetMaxX(xinhaofashengqiBtn.frame) + gap, startY, bw, bh);
    dianpingBtn.clipsToBounds = YES;
    dianpingBtn.layer.cornerRadius = 5;
    dianpingBtn.layer.borderWidth = 2;
    dianpingBtn.layer.borderColor = [UIColor clearColor].CGColor;
    dianpingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [dianpingBtn setTitle:@"电平" forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:YELLOW_COLOR forState:UIControlStateHighlighted];
    [self.view addSubview:dianpingBtn];
    [dianpingBtn addTarget:self
                       action:@selector(dianpingAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    
    lvbojunhengBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
    lvbojunhengBtn.frame = CGRectMake(CGRectGetMaxX(dianpingBtn.frame) + gap, startY, bw, bh);
    lvbojunhengBtn.clipsToBounds = YES;
    lvbojunhengBtn.layer.cornerRadius = 5;
    lvbojunhengBtn.layer.borderWidth = 2;
    lvbojunhengBtn.layer.borderColor = [UIColor clearColor].CGColor;
    lvbojunhengBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [lvbojunhengBtn setTitle:@"滤波/均衡" forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:YELLOW_COLOR forState:UIControlStateHighlighted];
    [self.view addSubview:lvbojunhengBtn];
    [lvbojunhengBtn addTarget:self
                       action:@selector(lvbojunhengAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    yaxianBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
    yaxianBtn.frame = CGRectMake(CGRectGetMaxX(lvbojunhengBtn.frame) + gap, startY, bw, bh);
    yaxianBtn.clipsToBounds = YES;
    yaxianBtn.layer.cornerRadius = 5;
    yaxianBtn.layer.borderWidth = 2;
    yaxianBtn.layer.borderColor = [UIColor clearColor].CGColor;
    yaxianBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yaxianBtn setTitle:@"压限器" forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:YELLOW_COLOR forState:UIControlStateHighlighted];
    [self.view addSubview:yaxianBtn];
    [yaxianBtn addTarget:self
                  action:@selector(yaxianqiAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    yanshiqiBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
    yanshiqiBtn.frame = CGRectMake(CGRectGetMaxX(yaxianBtn.frame) + gap, startY, bw, bh);
    yanshiqiBtn.clipsToBounds = YES;
    yanshiqiBtn.layer.cornerRadius = 5;
    yanshiqiBtn.layer.borderWidth = 2;
    yanshiqiBtn.layer.borderColor = [UIColor clearColor].CGColor;
    yanshiqiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [yanshiqiBtn setTitle:@"延时器" forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:YELLOW_COLOR forState:UIControlStateHighlighted];
    [self.view addSubview:yanshiqiBtn];
    [yanshiqiBtn addTarget:self
                    action:@selector(yanshiqiAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    CGRect vrc = CGRectMake(60, 140, SCREEN_WIDTH-120, SCREEN_HEIGHT-140-60);
    xinhaoView = [[XinHaoFaShengQi_UIView alloc] initWithFrame:vrc];
    [self.view addSubview:xinhaoView];
    xinhaoView.hidden = NO;
    
    dianpingView = [[DianPing_UIView alloc] initWithFrame:vrc];
    [self.view addSubview:dianpingView];
    dianpingView.hidden = YES;
    
    lvbojunhengView = [[LvBoJunHeng_UIView alloc] initWithFrame:vrc];
    [self.view addSubview:lvbojunhengView];
    lvbojunhengView.hidden = YES;
    
    yaxianView = [[YaXianQi_UIView alloc] initWithFrame:vrc];
    [self.view addSubview:yaxianView];
    yaxianView.hidden = YES;
    
    yanshiView = [[YanShiQi_UIView alloc] initWithFrame:vrc];
    [self.view addSubview:yanshiView];
    yanshiView.hidden = YES;
}
- (void) yanshiqiAction:(id)sender{
    [xinhaofashengqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    xinhaoView.hidden=YES;
    yanshiView.hidden = NO;
    yaxianView.hidden = YES;
    lvbojunhengView.hidden = YES;
    dianpingView.hidden = YES;
}
- (void) yaxianqiAction:(id)sender{
    [xinhaofashengqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    xinhaoView.hidden=YES;
    yanshiView.hidden = YES;
    yaxianView.hidden = NO;
    lvbojunhengView.hidden = YES;
    dianpingView.hidden = YES;
}
- (void) lvbojunhengAction:(id)sender{
    [xinhaofashengqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    xinhaoView.hidden=YES;
    yanshiView.hidden = YES;
    yaxianView.hidden = YES;
    lvbojunhengView.hidden = NO;
    dianpingView.hidden = YES;
}
- (void) dianpingAction:(id)sender{
    [xinhaofashengqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    
    xinhaoView.hidden=YES;
    yanshiView.hidden = YES;
    yaxianView.hidden = YES;
    lvbojunhengView.hidden = YES;
    dianpingView.hidden = NO;
}
- (void) xinhaofashengqiAction:(id)sender{
    [xinhaofashengqiBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    [yanshiqiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yaxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lvbojunhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dianpingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    xinhaoView.hidden=NO;
    yanshiView.hidden = YES;
    yaxianView.hidden = YES;
    lvbojunhengView.hidden = YES;
    dianpingView.hidden = YES;
}

- (void) okAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
