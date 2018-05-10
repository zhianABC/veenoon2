//
//  MixVoiceSettingsView.m
//  veenoon 混音
//
//  Created by chen jack on 2017/12/16.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CameraRightView.h"
#import "UIButton+Color.h"
#import "ComSettingView.h"
#import "VCameraSettingSet.h"

@interface CameraRightView () <UITextFieldDelegate, ComSettingViewDelegate> {
    
    ComSettingView *_com;
    UITextField *ipTextField;
    
    UIView *_footerView;
}
@property (nonatomic, strong) NSMutableArray *_btns;
@end

@implementation CameraRightView
@synthesize _btns;
@synthesize _currentObj;
@synthesize _numOfDevice;
@synthesize _callback;
@synthesize _curentDeviceIndex;
@synthesize delegate_;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(0, 89, 118);
        
        UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 40, 30)];
        titleL.textColor = [UIColor whiteColor];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.text = @"IP地址";
        
        ipTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleL.frame)+30, 25, self.bounds.size.width - 35 - CGRectGetMaxX(titleL.frame), 30)];
        ipTextField.delegate = self;
        ipTextField.backgroundColor = [UIColor clearColor];
        ipTextField.returnKeyType = UIReturnKeyDone;
        ipTextField.text = @"192.168.1.100";
        ipTextField.textColor = [UIColor whiteColor];
        ipTextField.borderStyle = UITextBorderStyleRoundedRect;
        ipTextField.textAlignment = NSTextAlignmentRight;
        ipTextField.font = [UIFont systemFontOfSize:13];
        ipTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:ipTextField];
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.bounds.size.height - 160,
                                                               self.frame.size.width,
                                                               160)];
        [self addSubview:_footerView];
        _footerView.backgroundColor = M_GREEN_COLOR;
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [self addSubview:headView];
        
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(switchComSetting)];
        swip.direction = UISwipeGestureRecognizerDirectionDown;
        
        
        [headView addGestureRecognizer:swip];
        
        
        UISwipeGestureRecognizer *rightswip = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(swipClose)];
        rightswip.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightswip];
        
        
        _com = [[ComSettingView alloc] initWithFrame:self.bounds];
        _com.delegate = self;
    }
    
    return self;
}

- (void)layoutDevicePannel {
    
    [[_footerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIColor *rectColor = RGB(0, 146, 174);
    
    self._btns = [NSMutableArray array];
    
    int w = 50;
    int sp = 8;
    int y = (160 - w*2 - sp)/2;
    int x = (self.frame.size.width - 4*w - 3*sp)/2;
    for(int i = 0; i < _numOfDevice; i++)
    {
        int col = i%4;
        int xx = x + col*w + col*sp;
        
        if(i && i%4 == 0)
        {
            y+=w;
            y+=sp;
        }
        
        UIButton *btn = [UIButton buttonWithColor:rectColor selColor:BLUE_DOWN_COLOR];
        btn.frame = CGRectMake(xx, y, w, w);
        [_footerView addSubview:btn];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%d", i+1]
             forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor whiteColor]
                  forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self
                action:@selector(buttonAction:)
      forControlEvents:UIControlEventTouchUpInside];
        
        [_btns addObject:btn];
        
    }
    
    [self chooseChannelAtTagIndex:_curentDeviceIndex];
    
}

- (void) buttonAction:(UIButton*)btn{
    
    [self chooseChannelAtTagIndex:(int)btn.tag];
    
    int idx = (int)btn.tag;
    
    if(_callback) {
        _callback(idx);
    }
}

- (void) chooseChannelAtTagIndex:(int)index{
    
    for(UIButton *btn in _btns)
    {
        if(btn.tag == index)
        {
            [btn setTitleColor:YELLOW_COLOR
                      forState:UIControlStateNormal];
            [btn setSelected:YES];
        }
        else
        {
            [btn setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
            [btn setSelected:NO];
        }
    }
}

-(void) refreshView:(VCameraSettingSet*) vCameraSettingSet {
   
    self._currentObj = vCameraSettingSet;
    ipTextField.text = vCameraSettingSet._ipaddress;
    
    //self._curentDeviceIndex = _currentObj._index;
    
    //[self chooseChannelAtTagIndex:_curentDeviceIndex];
    
    [_com refreshCom:_currentObj];
}

- (void) didChoosedComVal:(NSString*)val{
    
    //[_currentObj createConnection];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //_curIndex = (int)textField.tag;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _currentObj._ipaddress = ipTextField.text;
}

- (void) saveCurrentSetting{
    
    _currentObj._ipaddress = ipTextField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void) switchComSetting{
    
    if([_com superview])
        return;
    
    CGRect rc = _com.frame;
    rc.origin.y = 0-rc.size.height;
    
    _com.frame = rc;
    [self addSubview:_com];
    [UIView animateWithDuration:0.25
                     animations:^{
                         
                         _com.frame = self.bounds;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

- (void) swipClose{
    
    
    if(delegate_ && [delegate_ respondsToSelector:@selector(dissmissSettingView)])
    {
        [delegate_ dissmissSettingView];
    }
    
}

@end



