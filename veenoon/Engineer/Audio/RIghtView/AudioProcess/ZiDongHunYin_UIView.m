//
//  ZiDongHunYin_UIView.m
//  veenoon
//
//  Created by 安志良 on 2018/2/25.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "ZiDongHunYin_UIView.h"
#import "UIButton+Color.h"
#import "SlideButton.h"

@interface ZiDongHunYin_UIView() <SlideButtonDelegate> {
    UIButton *channelBtn;
    
    SlideButton *zengyi;
    
    UILabel *labelL1;
}

@end

@implementation ZiDongHunYin_UIView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        channelBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:nil];
        channelBtn.frame = CGRectMake(0, 50, 70, 36);
        channelBtn.clipsToBounds = YES;
        channelBtn.layer.cornerRadius = 5;
        channelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [channelBtn setTitle:@"In 1" forState:UIControlStateNormal];
        [channelBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        [self addSubview:channelBtn];
        
        int y = CGRectGetMaxY(channelBtn.frame)+20;
        contentView.frame  = CGRectMake(0, y, frame.size.width, 340);
        
        [self contentViewComps];
    }
    
    return self;
}

- (void) channelBtnAction:(UIButton*)sender{
    
    int tag = (int)sender.tag+1;
    [channelBtn setTitle:[NSString stringWithFormat:@"In %d", tag] forState:UIControlStateNormal];
    
    for(UIButton * btn in _channelBtns)
    {
        if(btn == sender)
        {
            [btn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (void) contentViewComps{
    int startX = 140;
    int gap = 250;
    int labelY = 100;
    int labelBtnGap = 0;
    int weiYi = 30;
    
    UILabel *addLabel2 = [[UILabel alloc] init];
    addLabel2.text = @"增益 (dB)";
    addLabel2.font = [UIFont systemFontOfSize: 13];
    addLabel2.textColor = [UIColor whiteColor];
    addLabel2.frame = CGRectMake(startX+gap+weiYi, labelY-20, 120, 20);
    [contentView addSubview:addLabel2];
    
    SlideButton *zengyi = [[SlideButton alloc] initWithFrame:CGRectMake(startX+gap, labelY+labelBtnGap, 120, 120)];
    zengyi._grayBackgroundImage = [UIImage imageNamed:@"slide_btn_gray_nokd.png"];
    zengyi._lightBackgroundImage = [UIImage imageNamed:@"slide_btn_light_nokd.png"];
    [zengyi enableValueSet:YES];
    zengyi.delegate = self;
    zengyi.tag = 3;
    [contentView addSubview:zengyi];
    
    labelL1 = [[UILabel alloc] initWithFrame:CGRectMake(startX+gap, labelY+labelBtnGap+80, 120, 120)];
    labelL1.text = @"-12dB";
    labelL1.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:labelL1];
    labelL1.font = [UIFont systemFontOfSize:13];
    labelL1.textColor = YELLOW_COLOR;
    
    UIButton *zhitongBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    zhitongBtn.frame = CGRectMake(contentView.frame.size.width/2 - 25, contentView.frame.size.height - 40, 50, 30);
    zhitongBtn.layer.cornerRadius = 5;
    zhitongBtn.layer.borderWidth = 2;
    zhitongBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    zhitongBtn.clipsToBounds = YES;
    [zhitongBtn setTitle:@"自动" forState:UIControlStateNormal];
    zhitongBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [zhitongBtn addTarget:self
                   action:@selector(zhitongBtnAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:zhitongBtn];
}

- (void) didSlideButtonValueChanged:(float)value slbtn:(SlideButton*)slbtn{
    
    int k = (value *24)-12;
    NSString *valueStr= [NSString stringWithFormat:@"%dB", k];
    
    labelL1.text = valueStr;
}
- (void) zhitongBtnAction:(id) sender {
    
}

@end
