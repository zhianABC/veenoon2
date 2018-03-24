//
//  EngineerWirlessYaoBaoViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2017/12/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerWirlessYaoBaoViewCtrl.h"
#import "UIButton+Color.h"
#import "CustomPickerView.h"
#import "EngineerSliderView.h"
#import "SlideButton.h"
#import "BatteryView.h"
#import "SignalView.h"
#import "WirlessYaoBaoViewSettingsView.h"


@interface EngineerWirlessYaoBaoViewCtrl () <CustomPickerViewDelegate, EngineerSliderViewDelegate, SlideButtonDelegate> {
    
    UIButton *_selectSysBtn;
    
    CustomPickerView *_customPicker;
    
    EngineerSliderView *_zengyiSlider;
    
    NSMutableArray *_imageViewArray;
    NSMutableArray *_buttonArray;
    
    NSMutableArray *_buttonSeideArray;
    NSMutableArray *_buttonChannelArray;
    NSMutableArray *_buttonNumberArray;
    
    NSMutableArray *_selectedBtnArray;
    
    WirlessYaoBaoViewSettingsView *_rightSetView;
    
    BOOL isSettings;
    UIButton *okBtn;
    
    NSMutableArray *signalArray;
}
@end

@implementation EngineerWirlessYaoBaoViewCtrl
@synthesize _wirelessYaoBaoSysArray;
@synthesize _number;
- (void) inintData {
    if (_wirelessYaoBaoSysArray) {
        [_wirelessYaoBaoSysArray removeAllObjects];
    } else {
        _wirelessYaoBaoSysArray = [[NSMutableArray alloc] init];
    }
    NSMutableDictionary *wuxianDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"100", @"dianliang", nil];
  NSMutableDictionary *wuxianDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong2", @"name",
    @"off", @"status",
    @"1", @"singnal",
    @"yaobao", @"type",
    @"100", @"dianliang", nil];
  NSMutableDictionary *wuxianDic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
    @"off", @"status",
    @"1", @"singnal",
    @"huatong", @"type",
    @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    NSMutableDictionary *wuxianDic10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"huangliurong3", @"name",
                                       @"off", @"status",
                                       @"1", @"singnal",
                                       @"huatong", @"type",
                                       @"90", @"dianliang", nil];
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:wuxianDic1, wuxianDic2, wuxianDic3, wuxianDic4
                              ,wuxianDic5,wuxianDic6,wuxianDic7,wuxianDic8,wuxianDic9,wuxianDic10,nil];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"001", @"name",
                                 array1, @"value", nil];
    [_wirelessYaoBaoSysArray addObject:dic1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSettings = NO;
    
    _imageViewArray = [[NSMutableArray alloc] init];
    _buttonArray = [[NSMutableArray alloc] init];
    _buttonSeideArray = [[NSMutableArray alloc] init];
    _buttonChannelArray = [[NSMutableArray alloc] init];
    _buttonNumberArray = [[NSMutableArray alloc] init];
    _selectedBtnArray = [[NSMutableArray alloc] init];
    signalArray = [[NSMutableArray alloc] init];
    
    [self inintData];
    
    [super setTitleAndImage:@"audio_corner_huatong.png" withTitle:@"无线手持腰包系统"];
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomBar];
    
    //缺切图，把切图贴上即可。
    bottomBar.backgroundColor = [UIColor grayColor];
    bottomBar.userInteractionEnabled = YES;
    bottomBar.image = [UIImage imageNamed:@"botomo_icon.png"];
    
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
    
    okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 50);
    [bottomBar addSubview:okBtn];
    [okBtn setTitle:@"设置" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okBtn addTarget:self
              action:@selector(okAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    _selectSysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectSysBtn.frame = CGRectMake(50, 100, 80, 30);
    [_selectSysBtn setImage:[UIImage imageNamed:@"engineer_sys_select_down_n.png"] forState:UIControlStateNormal];
    [_selectSysBtn setTitle:@"001" forState:UIControlStateNormal];
    _selectSysBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_selectSysBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectSysBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _selectSysBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_selectSysBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,_selectSysBtn.imageView.bounds.size.width)];
    [_selectSysBtn setImageEdgeInsets:UIEdgeInsetsMake(0,_selectSysBtn.titleLabel.bounds.size.width+35,0,0)];
    [_selectSysBtn addTarget:self action:@selector(sysSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectSysBtn];
    
    
    _zengyiSlider = [[EngineerSliderView alloc]
                       initWithSliderBg:[UIImage imageNamed:@"engineer_zengyi_n.png"]
                       frame:CGRectZero];
    [self.view addSubview:_zengyiSlider];
    [_zengyiSlider setRoadImage:[UIImage imageNamed:@"e_v_slider_road.png"]];
    [_zengyiSlider setIndicatorImage:[UIImage imageNamed:@"wireless_slide_s.png"]];
    _zengyiSlider.topEdge = 90;
    _zengyiSlider.bottomEdge = 79;
    _zengyiSlider.maxValue = 20;
    _zengyiSlider.minValue = -20;
    _zengyiSlider.delegate = self;
    [_zengyiSlider resetScale];
    _zengyiSlider.center = CGPointMake(SCREEN_WIDTH - 150, SCREEN_HEIGHT/2);
    
    int index = 0;
    int top = ENGINEER_VIEW_COMPONENT_TOP;
    
    int leftRight = ENGINEER_VIEW_LEFT;
    
    int cellWidth = 120;
    int cellHeight = 240;
    int colNumber = ENGINEER_VIEW_COLUMN_N-2;
    int space = ENGINEER_VIEW_COLUMN_GAP;
    
    NSMutableDictionary *dataDic = [_wirelessYaoBaoSysArray objectAtIndex:0];
    NSMutableArray *dataArray = [dataDic objectForKey:@"value"];
    
    if ([dataArray count] == 0) {
        int nameStart = 1;
        for (int i = 0; i < self._number; i++) {
            
        }
    } else {
        for (int i = 0; i < [dataArray count]; i++) {
            NSMutableDictionary *dataDic = [dataArray objectAtIndex:i];
            
            int row = index/colNumber;
            int col = index%colNumber;
            int startX = col*cellWidth+col*space+leftRight;
            int startY = row*cellHeight+space*row+top;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(startX, startY, cellWidth, 240)];
            view.userInteractionEnabled = YES;
            view.backgroundColor = [UIColor clearColor];
            [self.view addSubview:view];
            
            SlideButton *btn = [[SlideButton alloc] initWithFrame:CGRectMake(0, 0, cellWidth, 120)];
            [view addSubview:btn];
            btn.delegate = self;
            btn.tag = i;
            
            UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.size.width/2 - 30, 0, 60, 20)];
            titleL.textAlignment = NSTextAlignmentCenter;
            titleL.backgroundColor = [UIColor clearColor];
            [view addSubview:titleL];
            titleL.font = [UIFont boldSystemFontOfSize:11];
            titleL.textColor  = [UIColor whiteColor];
            titleL.text = [NSString stringWithFormat:@"0%d",i+1];
            [_buttonNumberArray addObject:titleL];
            
            titleL = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.size.width/2 -50, btn.frame.size.height - 20, 100, 20)];
            titleL.textAlignment = NSTextAlignmentCenter;
            titleL.backgroundColor = [UIColor clearColor];
            [view addSubview:titleL];
            titleL.font = [UIFont boldSystemFontOfSize:12];
            titleL.textColor  = [UIColor whiteColor];
            titleL.textAlignment = NSTextAlignmentCenter;
            titleL.text = @"Channel";
            [_buttonChannelArray addObject:titleL];
            
            UIView *signalView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, cellWidth, 120)];
            [view addSubview:signalView];
            signalView.alpha=0.8;
            [signalArray addObject:signalView];
            
            UIImage *image;
            NSString *huatongType = [dataDic objectForKey:@"type"];
            if ([@"huatong" isEqualToString:huatongType]) {
                image = [UIImage imageNamed:@"huatong_yellow_n.png"];
            } else {
                image = [UIImage imageNamed:@"yaobao_yellow_n.png"];
            }
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.center = CGPointMake(40, 40);
            [signalView addSubview:imageView];
            
            
            BatteryView *batter = [[BatteryView alloc] initWithFrame:CGRectZero];
            batter.normalColor = [UIColor whiteColor];
            [signalView addSubview:batter];
            batter.center = CGPointMake(60, 20);
            
            NSString *dianliangStr = [dataDic objectForKey:@"dianliang"];
            int dianliang = [dianliangStr intValue];
            double dianliangDouble = 1.0f * dianliang / 100;
            [batter setBatteryValue:dianliangDouble];
            
            SignalView *signal = [[SignalView alloc] initWithFrameAndStep:CGRectMake(70, 40, 30, 20) step:2];
            [signalView addSubview:signal];
            [signal setLightColor:[UIColor whiteColor]];//
            [signal setGrayColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
            NSString *sinalString = [dataDic objectForKey:@"signal"];
            int signalInt = [sinalString intValue];
            [signal setSignalValue:signalInt];
            
            titleL = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, 20, 20)];
            titleL.backgroundColor = [UIColor clearColor];
            [signalView addSubview:titleL];
            titleL.font = [UIFont boldSystemFontOfSize:12];
            titleL.textColor  = [UIColor whiteColor];
            titleL.textAlignment = NSTextAlignmentCenter;
            NSString *title = @"优";
            if (3 <= signalInt < 5) {
                title = @"良";
            } else if (signalInt < 3) {
                title = @"差";
            }
            
            titleL.text = title;
            
            [_imageViewArray addObject:imageView];
            [_buttonArray addObject:btn];
            
            index++;
        }
    }
}

- (void) didSliderValueChanged:(int)value object:(id)object {
    float circleValue = (value +20.0f)/40.0f;
    for (SlideButton *button in _selectedBtnArray) {
        [button setCircleValue:circleValue];
    }
}


- (void) didTappedMSelf:(SlideButton*)slbtn{
    
    int tag = (int)slbtn.tag;
    
    SlideButton *btn = nil;
    for (SlideButton *button in _selectedBtnArray) {
        if (button.tag == tag) {
            btn = button;
            break;
        }
    }
    // want to choose it
    if (btn == nil) {
        SlideButton *button = [_buttonArray objectAtIndex:tag];
        [_selectedBtnArray addObject:button];
        
        [button enableValueSet:YES];
        
        UILabel *chanelL = [_buttonChannelArray objectAtIndex:tag];
        chanelL.textColor = YELLOW_COLOR;
        
        UILabel *numberL = [_buttonNumberArray objectAtIndex:tag];
        numberL.textColor = YELLOW_COLOR;
        
        UIView *signalView = [signalArray objectAtIndex:tag];
        [signalView setAlpha:1];
        
    } else {
        // remove it
        [_selectedBtnArray removeObject:btn];
        
        [btn enableValueSet:NO];
     
        UILabel *chanelL = [_buttonChannelArray objectAtIndex:tag];
        chanelL.textColor = [UIColor whiteColor];
        
        UILabel *numberL = [_buttonNumberArray objectAtIndex:tag];
        numberL.textColor = [UIColor whiteColor];
        
        UIView *signalView = [signalArray objectAtIndex:tag];
        [signalView setAlpha:0.8];
    }
}

- (void) scenarioAction:(id)sender{
    
}

- (void) sysSelectAction:(id)sender{
    _customPicker = [[CustomPickerView alloc]
                     initWithFrame:CGRectMake(_selectSysBtn.frame.origin.x, _selectSysBtn.frame.origin.y, _selectSysBtn.frame.size.width, 100) withGrayOrLight:@"gray"];
    
    
    NSMutableArray *arr = [NSMutableArray array];
    for(int i = 1; i< 2; i++)
    {
        [arr addObject:[NSString stringWithFormat:@"00%d", i]];
    }
    
    _customPicker._pickerDataArray = @[@{@"values":arr}];
    
    
    _customPicker._selectColor = [UIColor orangeColor];
    _customPicker._rowNormalColor = [UIColor whiteColor];
    [self.view addSubview:_customPicker];
    _customPicker.delegate_ = self;
}

- (void) didConfirmPickerValue:(NSString*) pickerValue {
    if (_customPicker) {
        [_customPicker removeFromSuperview];
    }
    NSString *title =  [@"" stringByAppendingString:pickerValue];
    [_selectSysBtn setTitle:title forState:UIControlStateNormal];
}

- (void) okAction:(id)sender{
    if (!isSettings) {
        if (_rightSetView == nil) {
            _rightSetView = [[WirlessYaoBaoViewSettingsView alloc]
                             initWithFrame:CGRectMake(SCREEN_WIDTH-300,
                                                      64, 300, SCREEN_HEIGHT-114)];
        } else {
            [UIView beginAnimations:nil context:nil];
            _rightSetView.frame  = CGRectMake(SCREEN_WIDTH-300,
                                              64, 300, SCREEN_HEIGHT-114);
            [UIView commitAnimations];
        }
        
        [self.view addSubview:_rightSetView];
        [okBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        isSettings = YES;
    } else {
        if (_rightSetView) {
            [_rightSetView removeFromSuperview];
        }
        [okBtn setTitle:@"设置" forState:UIControlStateNormal];
        isSettings = NO;
    }
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
