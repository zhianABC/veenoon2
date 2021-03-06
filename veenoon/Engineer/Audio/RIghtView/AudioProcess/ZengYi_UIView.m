//
//  YaXianQi_UIView.m
//  veenoon
//
//  Created by 安志良 on 2018/2/25.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "ZengYi_UIView.h"
#import "UIButton+Color.h"
#import "SlideButton.h"
#import "RegulusSDK.h"
#import "VAProcessorProxys.h"
#import "CenterCustomerPickerView.h"

@interface ZengYi_UIView() <SlideButtonDelegate, CenterCustomerPickerViewDelegate>{
    
    UIButton *channelBtn;
    SlideButton *btnJH2;
    
    UILabel *zaoshengL;
    UIButton *muteBtn;
    UIButton *fanxiangBtn;
    UIButton *lineBtn;
    UIButton *foureivBtn;
    UIButton *bianzuBtn;
    UIButton *zerodbBtn;
    
    CenterCustomerPickerView *_lineSelect;
    CenterCustomerPickerView *_micDbSelect;
    
    int _curSelectorIndex;
}
@property (nonatomic, strong) VAProcessorProxys *_curProxy;

@end


@implementation ZengYi_UIView
@synthesize _curProxy;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

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
        contentView.frame = CGRectMake(0, y, frame.size.width, 340);
       
        [self contentViewComps];
        
        [self createContentViewBtns];
    }
    
    return self;
}


- (void) onCopyData:(id)sender{
}
- (void) onPasteData:(id)sender{
}
- (void) onClearData:(id)sender{
}

- (void) channelBtnAction:(UIButton*)sender{
    
    int idx = (int)sender.tag;
    self._curProxy = [self._proxys objectAtIndex:idx];

    NSString *name = _curProxy._rgsProxyObj.name;
    [channelBtn setTitle:name forState:UIControlStateNormal];
    
    [_curProxy checkRgsProxyCommandLoad];
    
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
    
    
    float kdb = [_curProxy getDigitalGain];
    NSString *valueStr= [NSString stringWithFormat:@"%0.1fdB", kdb];
    zaoshengL.text = valueStr;
    
    float f = (12.0 + kdb)/24.0;
    [btnJH2 setCircleValue:f];
    
    [lineBtn setTitle:_curProxy._mode
             forState:UIControlStateNormal];
    
    [self updateMuteButtonState];
    [self update48VButtonState];
    [self updateInvertButtonState];
    
    [zerodbBtn setTitle:_curProxy._micDb
               forState:UIControlStateNormal];
    
    
}

- (void) updateMuteButtonState{
    
    BOOL isMute = [_curProxy isProxyDigitalMute];
    
    if(isMute)
    {
        [muteBtn changeNormalColor:THEME_RED_COLOR];
    }
    else
    {
        [muteBtn changeNormalColor:RGB(75, 163, 202)];
    }
}

- (void) updateInvertButtonState{
    
    BOOL isInverted = [_curProxy getInverted];
    
    if(isInverted)
    {
        [fanxiangBtn changeNormalColor:THEME_RED_COLOR];
    }
    else
    {
        [fanxiangBtn changeNormalColor:RGB(75, 163, 202)];
    }
}

- (void) contentViewComps{
    
    UILabel *addLabel = [[UILabel alloc] init];
    addLabel.text = @"增益 (db)";
    addLabel.font = [UIFont systemFontOfSize: 13];
    addLabel.textColor = [UIColor whiteColor];
    addLabel.frame = CGRectMake(735, 115, 120, 20);
    [contentView addSubview:addLabel];
    
    
    btnJH2 = [[SlideButton alloc] initWithFrame:CGRectMake(700, 235, 120, 120)];
    btnJH2._grayBackgroundImage = [UIImage imageNamed:@"slide_btn_gray_nokd.png"];
    btnJH2._lightBackgroundImage = [UIImage imageNamed:@"slide_btn_light_nokd.png"];
    [btnJH2 enableValueSet:YES];
    btnJH2.delegate = self;
    btnJH2.tag = 2;
    [self addSubview:btnJH2];
    
    zaoshengL = [[UILabel alloc] initWithFrame:CGRectMake(700, 135+100, 120, 20)];
    zaoshengL.text = @"-12dB";
    zaoshengL.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:zaoshengL];
    zaoshengL.font = [UIFont systemFontOfSize:13];
    zaoshengL.textColor = YELLOW_COLOR;
    
}

- (void) didSlideButtonValueChanged:(float)value slbtn:(SlideButton*)slbtn{
    
    float k = (value *24.0)-12.0;
    NSString *valueStr= [NSString stringWithFormat:@"%0.1fdB", k];
    
    zaoshengL.text = valueStr;
    
    [_curProxy controlDeviceDigitalGain:[valueStr floatValue]];
}

- (void) createContentViewBtns {
    
    int btnStartX = 100;
    int btnY = 150;
    
    lineBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    lineBtn.frame = CGRectMake(btnStartX, btnY, 120, 30);
    lineBtn.layer.cornerRadius = 5;
    lineBtn.layer.borderWidth = 2;
    lineBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    lineBtn.clipsToBounds = YES;
    //[lineBtn setTitle:@"线路" forState:UIControlStateNormal];
    [lineBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10,0,0)];
    
    lineBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    lineBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImageView *icon = [[UIImageView alloc]
                         initWithFrame:CGRectMake(lineBtn.frame.size.width - 20, 10, 10, 10)];
    icon.image = [UIImage imageNamed:@"remote_video_down.png"];
    [lineBtn addSubview:icon];
    icon.alpha = 0.8;
    icon.layer.contentsGravity = kCAGravityResizeAspect;
    [lineBtn addTarget:self
                  action:@selector(lineBtnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:lineBtn];
    
    
    muteBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    muteBtn.frame = CGRectMake(CGRectGetMaxX(lineBtn.frame)+10, btnY, 50, 30);
    muteBtn.layer.cornerRadius = 5;
    muteBtn.layer.borderWidth = 2;
    muteBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    muteBtn.clipsToBounds = YES;
    [muteBtn setTitle:@"静音" forState:UIControlStateNormal];
    muteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [muteBtn addTarget:self
                action:@selector(muteBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:muteBtn];
    
    
    zerodbBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    zerodbBtn.frame = CGRectMake(CGRectGetMaxX(muteBtn.frame)+20, btnY, 120, 30);
    zerodbBtn.layer.cornerRadius = 5;
    zerodbBtn.layer.borderWidth = 2;
    zerodbBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    zerodbBtn.clipsToBounds = YES;
    [zerodbBtn setTitle:@"0db" forState:UIControlStateNormal];
    [zerodbBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10,0,0)];
    zerodbBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    zerodbBtn.alpha = 0.8;
    zerodbBtn.enabled = NO;
    zerodbBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImageView *icon2 = [[UIImageView alloc]
                         initWithFrame:CGRectMake(zerodbBtn.frame.size.width - 20, 10, 10, 10)];
    icon2.image = [UIImage imageNamed:@"remote_video_down.png"];
    [zerodbBtn addSubview:icon2];
    icon2.layer.contentsGravity = kCAGravityResizeAspect;
    [contentView addSubview:zerodbBtn];
    
    [zerodbBtn addTarget:self
                action:@selector(micDbBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    foureivBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    foureivBtn.frame = CGRectMake(CGRectGetMaxX(zerodbBtn.frame)+10, btnY, 50, 30);
    foureivBtn.layer.cornerRadius = 5;
    foureivBtn.layer.borderWidth = 2;
    foureivBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    foureivBtn.clipsToBounds = YES;
    [foureivBtn setTitle:@"  48V" forState:UIControlStateNormal];
    foureivBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    foureivBtn.alpha = 0.8;
    foureivBtn.enabled = NO;
    foureivBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contentView addSubview:foureivBtn];
    
    [foureivBtn addTarget:self
                action:@selector(f48vBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    bianzuBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    bianzuBtn.frame = CGRectMake(CGRectGetMaxX(foureivBtn.frame)+20, btnY, 120, 30);
    bianzuBtn.layer.cornerRadius = 5;
    bianzuBtn.layer.borderWidth = 2;
    bianzuBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    bianzuBtn.clipsToBounds = YES;
    [bianzuBtn setTitle:@"  编组" forState:UIControlStateNormal];
    bianzuBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    bianzuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImageView *icon3 = [[UIImageView alloc]
                         initWithFrame:CGRectMake(bianzuBtn.frame.size.width - 20, 10, 10, 10)];
    icon3.image = [UIImage imageNamed:@"remote_video_down.png"];
    [bianzuBtn addSubview:icon3];
    icon3.layer.contentsGravity = kCAGravityResizeAspect;
    [bianzuBtn addTarget:self
                action:@selector(bianzuAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:bianzuBtn];
    
    
    fanxiangBtn = [UIButton buttonWithColor:RGB(75, 163, 202) selColor:nil];
    fanxiangBtn.frame = CGRectMake(CGRectGetMaxX(bianzuBtn.frame)+10, btnY, 50, 30);
    fanxiangBtn.layer.cornerRadius = 5;
    fanxiangBtn.layer.borderWidth = 2;
    fanxiangBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    fanxiangBtn.clipsToBounds = YES;
    [fanxiangBtn setTitle:@"反相" forState:UIControlStateNormal];
    fanxiangBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fanxiangBtn addTarget:self
                action:@selector(fanxiangAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:fanxiangBtn];
}

- (void) update48VButtonState{
    
    BOOL is48V = _curProxy._is48V;
    
    if(is48V)
    {
        [foureivBtn changeNormalColor:THEME_RED_COLOR];
    }
    else
    {
        [foureivBtn changeNormalColor:RGB(75, 163, 202)];
    }
}

- (void) f48vBtnAction:(UIButton*)sender{
    
    if(_curProxy == nil)
        return;
    
    BOOL is48v = _curProxy._is48V;
    
    [_curProxy control48V:!is48v];
    
    [self update48VButtonState];

}

-(void) fanxiangAction:(id) sender {
    
    if(_curProxy == nil)
        return;
    
    BOOL isInverted = [_curProxy getInverted];
    
    [_curProxy controlInverted:!isInverted];
    
    [self updateInvertButtonState];
    
}
-(void) bianzuAction:(id) sender {
    
}

- (void) micDbBtnAction:(UIButton*) sender {

    
    if([_micDbSelect superview])
    {
        [_micDbSelect removeFromSuperview];
        return;
    }
    
    NSArray *options = [_curProxy getMicDbOptions];
    
    if([options count])
    {
        
        if(_micDbSelect == nil)
        {
            _micDbSelect = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
            _micDbSelect._selectColor = RGB(253, 180, 0);
            _micDbSelect._rowNormalColor = RGB(117, 165, 186);
            _micDbSelect.delegate_= self;
            
            _micDbSelect._pickerDataArray = @[@{@"values":options}];
            [_micDbSelect selectRow:0 inComponent:0];
        }
        
        _curSelectorIndex = 1;
        _micDbSelect.center = CGPointMake(sender.center.x, CGRectGetMaxY(sender.frame)+75);
        [contentView addSubview:_micDbSelect];
    }
    
}



-(void) lineBtnAction:(UIButton*) sender {
    
    if([_lineSelect superview])
    {
        [_lineSelect removeFromSuperview];
        return;
    }
    
    NSArray *options = [_curProxy getModeOptions];
    
    if([options count])
    {
        
        if(_lineSelect == nil)
        {
            _lineSelect = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
            _lineSelect._selectColor = RGB(253, 180, 0);
            _lineSelect._rowNormalColor = RGB(117, 165, 186);
            _lineSelect.delegate_= self;
            
            _lineSelect._pickerDataArray = @[@{@"values":options}];
            [_lineSelect selectRow:0 inComponent:0];
        }
        
        _curSelectorIndex = 0;
        _lineSelect.center = CGPointMake(sender.center.x, CGRectGetMaxY(sender.frame)+75);
        [contentView addSubview:_lineSelect];
    }
}

- (void) didChangedPickerValue:(NSDictionary*)value{
    
    NSDictionary *val = [value objectForKey:@0];
    if(val)
    {
        //Mode select
        if(_curSelectorIndex == 0)
        {
            NSString *vtx = [val objectForKey:@"value"];
            [lineBtn setTitle:vtx forState:UIControlStateNormal];
            
            if(_curProxy)
            {
                [_curProxy controlDeviceMode:vtx];
            }
            
            if([vtx isEqualToString:@"MIC"])
            {
                foureivBtn.alpha = 1;
                foureivBtn.enabled = YES;
                
                zerodbBtn.alpha = 1;
                zerodbBtn.enabled = YES;
            }
            else
            {
                foureivBtn.alpha = 0.8;
                foureivBtn.enabled = NO;
                
                zerodbBtn.alpha = 0.8;
                zerodbBtn.enabled = NO;
            }
        }
        else//Mic db select
        {
            NSString *vtx = [val objectForKey:@"value"];
            [zerodbBtn setTitle:vtx forState:UIControlStateNormal];
            
            if(_curProxy)
            {
                [_curProxy controlDeviceMicDb:vtx];
            }
        }
    }
}

-(void) muteBtnAction:(id) sender {
    
    if(_curProxy == nil)
        return;
    
    BOOL isMute = [_curProxy isProxyDigitalMute];
    
    [_curProxy controlDigtalMute:!isMute];
    
    [self updateMuteButtonState];
}

@end

