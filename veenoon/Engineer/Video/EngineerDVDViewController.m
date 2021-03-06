//
//  EngineerDVDViewController.m
//  veenoon
//
//  Created by 安志良 on 2017/12/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerDVDViewController.h"
#import "UIButton+Color.h"
#import "CustomPickerView.h"
#import "VDVDPlayerSet.h"
#import "BrandCategoryNoUtil.h"
#import "PlugsCtrlTitleHeader.h"

@interface EngineerDVDViewController () <CustomPickerViewDelegate>{
    
    UIButton *_volumnMinus;
    UIButton *_lastSing;
    UIButton *_playOrHold;
    UIButton *_nextSing;
    UIButton *_volumnAdd;
    
    BOOL isplay;
    
    UIButton *_luboBtn;
    UIButton *_tanchuBtn;
    UIButton *_addressBtn;
    
    UIButton *okBtn;
    BOOL isSettings;
    
    VDVDPlayerSet *_currentObj;
}
@property (nonatomic, strong) VDVDPlayerSet *_currentObj;
@end

@implementation EngineerDVDViewController
@synthesize _dvdSysArray;
@synthesize _number;
@synthesize _currentObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSettings = NO;
    
    if ([_dvdSysArray count]) {
        self._currentObj = [_dvdSysArray objectAtIndex:0];
    }
    
    if(_currentObj == nil) {
        self._currentObj = [[VDVDPlayerSet alloc] init];
    }
    
    
    [super setTitleAndImage:@"video_corner_dvd.png" withTitle:@"DVD"];
    
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
    
    okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 50);
    [bottomBar addSubview:okBtn];
    [okBtn setTitle:@"设置" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okBtn addTarget:self
              action:@selector(settingsAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    int height = SCREEN_HEIGHT - 200;
    int width = 80;
    
    _volumnMinus = [UIButton buttonWithType:UIButtonTypeCustom];
    _volumnMinus.frame = CGRectMake(0, 0, width, width);
    _volumnMinus.center = CGPointMake(SCREEN_WIDTH/2 - 200, height);
    [_volumnMinus setImage:[UIImage imageNamed:@"audio_player_r_minus_n.png"] forState:UIControlStateNormal];
    [_volumnMinus setImage:[UIImage imageNamed:@"audio_player_minus_s.png"] forState:UIControlStateHighlighted];
    [_volumnMinus addTarget:self action:@selector(volumnMinusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_volumnMinus];
    
    _lastSing = [UIButton buttonWithType:UIButtonTypeCustom];
    _lastSing.frame = CGRectMake(0, 0, width, width);
    _lastSing.center = CGPointMake(SCREEN_WIDTH/2 - 100, height);
    [_lastSing setImage:[UIImage imageNamed:@"audio_player_r_last_n.png"] forState:UIControlStateNormal];
    [_lastSing setImage:[UIImage imageNamed:@"audio_player_last_s.png"] forState:UIControlStateHighlighted];
    [_lastSing addTarget:self action:@selector(lastSingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lastSing];
    
    isplay = NO;
    _playOrHold = [UIButton buttonWithType:UIButtonTypeCustom];
    _playOrHold.frame = CGRectMake(0, 0, width, width);
    _playOrHold.center = CGPointMake(SCREEN_WIDTH/2, height);
    [_playOrHold setImage:[UIImage imageNamed:@"audio_player_r_hold.png"] forState:UIControlStateNormal];
    [_playOrHold setImage:[UIImage imageNamed:@"audio_player_play.png"] forState:UIControlStateHighlighted];
    [_playOrHold addTarget:self action:@selector(audioPlayHoldAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playOrHold];
    
    _nextSing = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextSing.frame = CGRectMake(0, 0, width, width);
    _nextSing.center = CGPointMake(SCREEN_WIDTH/2 + 100, height);
    [_nextSing setImage:[UIImage imageNamed:@"audio_player_r_next_n.png"] forState:UIControlStateNormal];
    [_nextSing setImage:[UIImage imageNamed:@"audio_player_next_s.png"] forState:UIControlStateHighlighted];
    [_nextSing addTarget:self action:@selector(nextSingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextSing];
    
    _volumnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    _volumnAdd.frame = CGRectMake(0, 0, width, width);
    _volumnAdd.center = CGPointMake(SCREEN_WIDTH/2 + 200, height);
    [_volumnAdd setImage:[UIImage imageNamed:@"audio_layer_r_next_n.png"] forState:UIControlStateNormal];
    [_volumnAdd setImage:[UIImage imageNamed:@"audio_layer_next_s.png"] forState:UIControlStateHighlighted];
    [_volumnAdd addTarget:self action:@selector(volumnAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_volumnAdd];
    
    
    _luboBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    _luboBtn.frame = CGRectMake(70, SCREEN_HEIGHT-140, 60, 60);
    _luboBtn.layer.cornerRadius = 5;
    _luboBtn.layer.borderWidth = 2;
    _luboBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    _luboBtn.clipsToBounds = YES;
    [_luboBtn setImage:[UIImage imageNamed:@"engineer_lubo_n.png"] forState:UIControlStateNormal];
    [_luboBtn setImage:[UIImage imageNamed:@"engineer_lubo_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:_luboBtn];
    
    [_luboBtn addTarget:self
                 action:@selector(luboAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    
    _tanchuBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    _tanchuBtn.frame = CGRectMake(150, SCREEN_HEIGHT-140, 60, 60);
    _tanchuBtn.layer.cornerRadius = 5;
    _tanchuBtn.layer.borderWidth = 2;
    _tanchuBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    _tanchuBtn.clipsToBounds = YES;
    [_tanchuBtn setImage:[UIImage imageNamed:@"engineer_tanchu_n.png"] forState:UIControlStateNormal];
    [_tanchuBtn setImage:[UIImage imageNamed:@"engineer_tanchu_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:_tanchuBtn];
    
    [_tanchuBtn addTarget:self
                   action:@selector(tanchuAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    _addressBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    _addressBtn.frame = CGRectMake(230, SCREEN_HEIGHT-140, 60, 60);
    _addressBtn.layer.cornerRadius = 5;
    _addressBtn.layer.borderWidth = 2;
    _addressBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    _addressBtn.clipsToBounds = YES;
    [_addressBtn setImage:[UIImage imageNamed:@"engineer_address_n.png"] forState:UIControlStateNormal];
    [_addressBtn setImage:[UIImage imageNamed:@"engineer_address_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:_addressBtn];
    
    [_addressBtn addTarget:self
                   action:@selector(addressAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    int playerLeft = 155;
    int playerHeight = 10;
    
    UIButton *lastVideoUpBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    lastVideoUpBtn.frame = CGRectMake(230+playerLeft, SCREEN_HEIGHT-500+playerHeight, 80, 80);
    lastVideoUpBtn.layer.cornerRadius = 5;
    lastVideoUpBtn.layer.borderWidth = 2;
    lastVideoUpBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    lastVideoUpBtn.clipsToBounds = YES;
    [lastVideoUpBtn setImage:[UIImage imageNamed:@"engineer_left_n.png"] forState:UIControlStateNormal];
    [lastVideoUpBtn setImage:[UIImage imageNamed:@"engineer_left_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:lastVideoUpBtn];
    
    [lastVideoUpBtn addTarget:self
                       action:@selector(lastSingAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okPlayerBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    okPlayerBtn.frame = CGRectMake(315+playerLeft, SCREEN_HEIGHT-500+playerHeight, 80, 80);
    okPlayerBtn.layer.cornerRadius = 5;
    okPlayerBtn.layer.borderWidth = 2;
    okPlayerBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    okPlayerBtn.clipsToBounds = YES;
    [okPlayerBtn setTitle:@"ok" forState:UIControlStateNormal];
    [okPlayerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okPlayerBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okPlayerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.view addSubview:okPlayerBtn];
    
    [okPlayerBtn addTarget:self action:@selector(okPlayAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *volumnUpBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    volumnUpBtn.frame = CGRectMake(315+playerLeft, SCREEN_HEIGHT-585+playerHeight, 80, 80);
    volumnUpBtn.layer.cornerRadius = 5;
    volumnUpBtn.layer.borderWidth = 2;
    volumnUpBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    volumnUpBtn.clipsToBounds = YES;
    [volumnUpBtn setImage:[UIImage imageNamed:@"engineer_up_n.png"] forState:UIControlStateNormal];
    [volumnUpBtn setImage:[UIImage imageNamed:@"engineer_up_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:volumnUpBtn];
    
    [volumnUpBtn addTarget:self
                    action:@selector(volumnAddAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextPlayBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    nextPlayBtn.frame = CGRectMake(400+playerLeft, SCREEN_HEIGHT-500+playerHeight, 80, 80);
    nextPlayBtn.layer.cornerRadius = 5;
    nextPlayBtn.layer.borderWidth = 2;
    nextPlayBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    nextPlayBtn.clipsToBounds = YES;
    [nextPlayBtn setImage:[UIImage imageNamed:@"engineer_next_n.png"] forState:UIControlStateNormal];
    [nextPlayBtn setImage:[UIImage imageNamed:@"engineer_next_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:nextPlayBtn];
    
    [nextPlayBtn addTarget:self
                    action:@selector(nextSingAction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *volumnDownBtn = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:BLUE_DOWN_COLOR];
    volumnDownBtn.frame = CGRectMake(315+playerLeft, SCREEN_HEIGHT-415+playerHeight, 80, 80);
    volumnDownBtn.layer.cornerRadius = 5;
    volumnDownBtn.layer.borderWidth = 2;
    volumnDownBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    volumnDownBtn.clipsToBounds = YES;
    [volumnDownBtn setImage:[UIImage imageNamed:@"engineer_down_n.png"] forState:UIControlStateNormal];
    [volumnDownBtn setImage:[UIImage imageNamed:@"engineer_down_s.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:volumnDownBtn];
    
    [volumnDownBtn addTarget:self
                      action:@selector(volumnMinusAction:)
            forControlEvents:UIControlEventTouchUpInside];
}
- (void) okPlayAction:(id)sender {
    
}
- (void) luboAction:(id)sender{
}

- (void) tanchuAction:(id)sender{
    
}
- (void) addressAction:(id)sender{
    
}
- (void) nextSingAction:(id)sender{
    
}

- (void) audioPlayHoldAction:(id)sender{
    if (isplay) {
        [_playOrHold setImage:[UIImage imageNamed:@"audio_player_r_hold.png"] forState:UIControlStateNormal];
        isplay = NO;
    } else {
        [_playOrHold setImage:[UIImage imageNamed:@"audio_player_play.png"] forState:UIControlStateNormal];
        isplay = YES;
    }
}

- (void) lastSingAction:(id)sender{
    
}

- (void) volumnMinusAction:(id)sender{
    
}

- (void) volumnAddAction:(id)sender{
    
}

- (void) settingsAction:(id)sender{
    //检查是否需要创建
    
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
