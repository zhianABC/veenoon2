//
//  EngineerAudioProcessViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2017/12/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerAudioProcessViewCtrl.h"
#import "UIButton+Color.h"
#import "SlideButton.h"
#import "AudioProcessRightView.h"
#import "AudioInputSettingViewCtrl.h"
#import "AudioOutputSettingViewCtrl.h"
#import "AudioMatrixSettingViewCtrl.h"
#import "AudioIconSettingView.h"
#import "CustomPickerView.h"

@interface EngineerAudioProcessViewCtrl () <EngineerSliderViewDelegate, CustomPickerViewDelegate, AudioProcessRightViewDelegate, AudioIconSettingViewDelegate, SlideButtonDelegate> {
    UIButton *_selectSysBtn;
    
    CustomPickerView *_customPicker;
    
    EngineerSliderView *_zengyiSlider;
    
    NSMutableArray *_buttonArray;
    
    NSMutableArray *_inputBtnArray;
    NSMutableArray *_selectedBtnArray;
    
    
    AudioProcessRightView *_rightView;
    BOOL isSettings;
    UIButton *okBtn;
    
    AudioIconSettingView *_inconView;
    BOOL isIcon;
    
    UIImageView *bottomBar;
 
}

@end

@implementation EngineerAudioProcessViewCtrl
@synthesize _audioProcessArray;
@synthesize _inputNumber;
@synthesize _outputNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isIcon = NO;
    isSettings = NO;
    _buttonArray = [[NSMutableArray alloc] init];
    
    
    _selectedBtnArray = [[NSMutableArray alloc] init];
    _inputBtnArray = [[NSMutableArray alloc] init];
    
    [super setTitleAndImage:@"audio_corner_yinpinchuli.png" withTitle:@"音频处理器"];

    bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
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
    _selectSysBtn.frame = CGRectMake(50, 70, 80, 30);
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
                     initWithSliderBg:[UIImage imageNamed:@"engineer_zengyi3.png"]
                     frame:CGRectZero];
    [self.view addSubview:_zengyiSlider];
    [_zengyiSlider setRoadImage:[UIImage imageNamed:@"e_v_slider_road.png"]];
    [_zengyiSlider setIndicatorImage:[UIImage imageNamed:@"wireless_slide_s.png"]];
    _zengyiSlider.topEdge = 90;
    _zengyiSlider.bottomEdge = 79;
    _zengyiSlider.maxValue = 12;
    _zengyiSlider.minValue = -70;
    _zengyiSlider.delegate = self;
    [_zengyiSlider resetScale];
    _zengyiSlider.center = CGPointMake(SCREEN_WIDTH - 110, SCREEN_HEIGHT/2+50);
    
    int height = 150;
    int inputOutGap = 282;
    
    UILabel* subTL = [[UILabel alloc] initWithFrame:CGRectMake(50, height-5, 100, 20)];
    subTL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subTL];
    subTL.font = [UIFont boldSystemFontOfSize:16];
    subTL.textColor  = [UIColor whiteColor];
    subTL.text = @"InPuts";
    
    subTL = [[UILabel alloc] initWithFrame:CGRectMake(50, height+inputOutGap-5, 100, 20)];
    subTL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subTL];
    subTL.font = [UIFont boldSystemFontOfSize:16];
    subTL.textColor  = [UIColor whiteColor];
    subTL.text = @"OutPuts";
    
    int colNumber = ENGINEER_VIEW_COLUMN_N;
    int index = 0;
    int cellWidth = 92;
    int cellHeight = 120;
    int leftRight = ENGINEER_VIEW_LEFT;
    int space = 8;
    
    for (int i = 0; i < self._inputNumber; i++) {
        
        int row = index/colNumber;
        int col = index%colNumber;
        int startX = col*cellWidth+col*space+leftRight;
        int startY = row*cellHeight+space*row+height+20;
        
        SlideButton *btn = [[SlideButton alloc] initWithFrame:CGRectMake(startX, startY, cellWidth, cellHeight)];
        btn.delegate = self;
        btn.tag = index;
        [self.view addSubview:btn];
        
        btn._titleLabel.text = [NSString stringWithFormat:@"Channel %02d",i+1];
        
        [_buttonArray addObject:btn];
        [_inputBtnArray addObject:btn];
        
        index++;
    }
    
    for (int i = 0; i < self._outputNumber; i++) {
        
        int row = i/colNumber;
        int col = i%colNumber;
        int startX = col*cellWidth+col*space+leftRight;
        int startY = row*cellHeight+space*row+height+20+inputOutGap;
        
        SlideButton *btn = [[SlideButton alloc] initWithFrame:CGRectMake(startX, startY, cellWidth, cellHeight)];
        btn.tag = index;
        btn.delegate = self;
        [self.view addSubview:btn];
        btn._titleLabel.text = [NSString stringWithFormat:@"Channel %02d",i+1];
        

        [_buttonArray addObject:btn];
        
        index++;
    }
    
    
    
    [self.view bringSubviewToFront:bottomBar];
    [self.view bringSubviewToFront:_topBar];
}
- (void) didSliderEndChanged:(id)object {
    
}

//value = 0....1
- (void) didSlideButtonValueChanged:(float)value slbtn:(SlideButton*)slbtn{
    
    float circleValue = -70 + (value * 82);
    slbtn._valueLabel.text = [NSString stringWithFormat:@"%0.1f db", circleValue];
}
- (void) didSliderValueChanged:(int)value object:(id)object {
    
    float circleValue = value;
    for (SlideButton *button in _selectedBtnArray) {
        
        button._valueLabel.text = [NSString stringWithFormat:@"%0.1f db", circleValue];
        [button setCircleValue:fabs((value+70)/82.0)];
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

    } else {
        // remove it
        [_selectedBtnArray removeObject:btn];
        
        [btn enableValueSet:NO];

    }
}


- (void) sysSelectAction:(id)sender{
    
    if(_customPicker == nil)
    _customPicker = [[CustomPickerView alloc]
                     initWithFrame:CGRectMake(_selectSysBtn.frame.origin.x, _selectSysBtn.frame.origin.y, _selectSysBtn.frame.size.width, 120) withGrayOrLight:@"gray"];
    
    
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

- (void) didChangedPickerValue:(NSDictionary*)value{
    
    if (_customPicker) {
        [_customPicker removeFromSuperview];
    }
    NSDictionary *dic = [value objectForKey:@0];
    NSString *title =  [dic objectForKey:@"value"];
    
    [_selectSysBtn setTitle:title forState:UIControlStateNormal];
    
}

- (void) okAction:(id)sender{
    if (_inconView) {
        [_inconView removeFromSuperview];
    }
    if (!isSettings) {
        if (_rightView == nil) {
            _rightView = [[AudioProcessRightView alloc]
                          initWithFrame:CGRectMake(SCREEN_WIDTH-300,
                                                   64, 300, SCREEN_HEIGHT-114)];
            _rightView.delegate_ = self;
        } else {
            [UIView beginAnimations:nil context:nil];
            _rightView.frame  = CGRectMake(SCREEN_WIDTH-300,
                                           64, 300, SCREEN_HEIGHT-114);
            [UIView commitAnimations];
        }
        
        [self.view addSubview:_rightView];
        [okBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        isSettings = YES;
    } else {
        if (_rightView) {
            [_rightView removeFromSuperview];
        }
        [okBtn setTitle:@"设置" forState:UIControlStateNormal];
        isSettings = NO;
    }
}

- (void) didEndDragingElecCell:(NSDictionary *)data pt:(CGPoint)pt {
    CGPoint viewPoint = [self.view convertPoint:pt fromView:_rightView];
    
    //NSLog(@"%f - %f", viewPoint.x, viewPoint.y);
    
    NSString *imageName = [data objectForKey:@"icon_s"];
    UIImage *img = [UIImage imageNamed:imageName];
    if(img) {
        for (SlideButton *button in _inputBtnArray) {
            CGRect rect = [self.view convertRect:button.frame fromView:button.superview];
            if (CGRectContainsPoint(rect, viewPoint)) {
                
                [button changToIcon:img];
            }
        }
    }
    
    NSLog(@"ssss");
}

- (void) didSelectButtonAction:(NSString*)value {
    if ([@"输入设置" isEqualToString:value]) {
        AudioInputSettingViewCtrl *ctrl = [[AudioInputSettingViewCtrl alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    } else if ([@"输出设置" isEqualToString:value]) {
        AudioOutputSettingViewCtrl *ctrl = [[AudioOutputSettingViewCtrl alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    } else if ([@"矩阵路由" isEqualToString:value]) {
        AudioMatrixSettingViewCtrl *ctrl = [[AudioMatrixSettingViewCtrl alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    } else {
        if (_rightView) {
            [_rightView removeFromSuperview];
            
            if (_inconView == nil) {
                _inconView = [[AudioIconSettingView alloc]
                              initWithFrame:CGRectMake(SCREEN_WIDTH-300,
                                                       64, 300, SCREEN_HEIGHT-114)];
                _inconView.delegate = self;
            } else {
                [UIView beginAnimations:nil context:nil];
                _inconView.frame  = CGRectMake(SCREEN_WIDTH-300,
                                               64, 300, SCREEN_HEIGHT-114);
                [UIView commitAnimations];
            }
            
            [self.view insertSubview:_inconView belowSubview:bottomBar];
            [okBtn setTitle:@"保存" forState:UIControlStateNormal];
        }
    }
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
