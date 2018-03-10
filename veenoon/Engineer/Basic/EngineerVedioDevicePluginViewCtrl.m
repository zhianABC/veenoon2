//
//  EngineerPortDNSViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2017/12/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerVedioDevicePluginViewCtrl.h"
#import "EngineerEnvDevicePluginViewCtrl.h"
#import "CustomPickerView.h"

@interface EngineerVedioDevicePluginViewCtrl ()<CustomPickerViewDelegate> {
    UIButton *_dianyuanguanliBtn;
    UIButton *_shipinbofangBtn;
    UIButton *_shexiangjiBtn;
    UIButton *_xinxiheBtn;
    UIButton *_yuanchengshixunBtn;
    UIButton *_shipinchuliBtn;
    UIButton *_pinjiepingBtn;
    UIButton *_yejingdianshiBtn;
    UIButton *_lubojiBtn;
    UIButton *_touyingjiBtn;
    
    UIButton *_confirmButton;
    
    CustomPickerView *_productTypePikcer;
    CustomPickerView *_brandPicker;
    CustomPickerView *_productCategoryPicker;
    CustomPickerView *_numberPicker;
}
@end

@implementation EngineerVedioDevicePluginViewCtrl
@synthesize _meetingRoomDic;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *portDNSLabel = [[UILabel alloc] initWithFrame:CGRectMake(ENGINEER_VIEW_LEFT, ENGINEER_VIEW_TOP+10, SCREEN_WIDTH-80, 30)];
    portDNSLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:portDNSLabel];
    portDNSLabel.font = [UIFont boldSystemFontOfSize:20];
    portDNSLabel.textColor  = [UIColor whiteColor];
    portDNSLabel.text = @"请配置您的视频管理系统";
    
    portDNSLabel = [[UILabel alloc] initWithFrame:CGRectMake(ENGINEER_VIEW_LEFT, CGRectGetMaxY(portDNSLabel.frame)+20, SCREEN_WIDTH-80, 20)];
    portDNSLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:portDNSLabel];
    portDNSLabel.font = [UIFont systemFontOfSize:18];
    portDNSLabel.textColor  = [UIColor colorWithWhite:1.0 alpha:0.9];
    portDNSLabel.text = @"选择您所需要设置的设备类型> 品牌 > 型号> 数量";
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomBar];
    
    //缺切图，把切图贴上即可。
    bottomBar.backgroundColor = [UIColor grayColor];
    bottomBar.userInteractionEnabled = YES;
    bottomBar.image = [UIImage imageNamed:@"botomo_icon.png"];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0,160, 50);
    [bottomBar addSubview:cancelBtn];
    [cancelBtn setTitle:@"< 上一步" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelBtn addTarget:self
                  action:@selector(cancelAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 50);
    [bottomBar addSubview:okBtn];
    [okBtn setTitle:@"下一步 >" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okBtn addTarget:self
              action:@selector(okAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    int left = 150;
    int rowGap = (SCREEN_WIDTH - left * 2)/5 - 10;
    int height = 200;
    _dianyuanguanliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dianyuanguanliBtn.frame = CGRectMake(left, height, 80, 132);
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_s.png"] forState:UIControlStateHighlighted];
    [_dianyuanguanliBtn setTitle:@"电源管理" forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _dianyuanguanliBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_dianyuanguanliBtn setTitleEdgeInsets:UIEdgeInsetsMake(_dianyuanguanliBtn.imageView.frame.size.height+3,-80,-18,-20)];
    [_dianyuanguanliBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,_dianyuanguanliBtn.titleLabel.bounds.size.height, 0)];
    [_dianyuanguanliBtn addTarget:self action:@selector(dianyuanguanliAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dianyuanguanliBtn];
    
    
    _shipinbofangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shipinbofangBtn.frame = CGRectMake(left+rowGap, height, 80, 132);
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_s.png"] forState:UIControlStateHighlighted];
    [_shipinbofangBtn setTitle:@"视频播放" forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _shipinbofangBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_shipinbofangBtn setTitleEdgeInsets:UIEdgeInsetsMake(_shipinbofangBtn.imageView.frame.size.height+10,-90,-20,-10)];
    [_shipinbofangBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,_shipinbofangBtn.titleLabel.bounds.size.height, 0)];
    [_shipinbofangBtn addTarget:self action:@selector(shipinbofangAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shipinbofangBtn];
    
    _shexiangjiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shexiangjiBtn.frame = CGRectMake(left+rowGap*2, height, 80, 132);
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_s.png"] forState:UIControlStateHighlighted];
    [_shexiangjiBtn setTitle:@"摄像机" forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _shexiangjiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_shexiangjiBtn setTitleEdgeInsets:UIEdgeInsetsMake(_shexiangjiBtn.imageView.frame.size.height+10,-85,-20,-35)];
    [_shexiangjiBtn setImageEdgeInsets:UIEdgeInsetsMake(-10,0,_shexiangjiBtn.titleLabel.bounds.size.height, -10)];
    [_shexiangjiBtn addTarget:self action:@selector(shexiangjiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shexiangjiBtn];
    
    _xinxiheBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _xinxiheBtn.frame = CGRectMake(left+rowGap*3, height, 80, 132);
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_s.png"] forState:UIControlStateHighlighted];
    [_xinxiheBtn setTitle:@"信息盒" forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _xinxiheBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_xinxiheBtn setTitleEdgeInsets:UIEdgeInsetsMake(_xinxiheBtn.imageView.frame.size.height+10,-55,-20,-5)];
    [_xinxiheBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,5.0,_xinxiheBtn.titleLabel.bounds.size.height, -5)];
    [_xinxiheBtn addTarget:self action:@selector(xinxiheAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xinxiheBtn];
    
    _yuanchengshixunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _yuanchengshixunBtn.frame = CGRectMake(left+rowGap*4, height, 80, 132);
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_s.png"] forState:UIControlStateHighlighted];
    [_yuanchengshixunBtn setTitle:@"远程视讯" forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _yuanchengshixunBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_yuanchengshixunBtn setTitleEdgeInsets:UIEdgeInsetsMake(_yuanchengshixunBtn.imageView.frame.size.height+10,-90,-20,-10)];
    [_yuanchengshixunBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,_yuanchengshixunBtn.titleLabel.bounds.size.height, 0)];
    [_yuanchengshixunBtn addTarget:self action:@selector(yuanchengshixunAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_yuanchengshixunBtn];
    
    _shipinchuliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shipinchuliBtn.frame = CGRectMake(left+rowGap*5, height, 80, 132);
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_s.png"] forState:UIControlStateHighlighted];
    [_shipinchuliBtn setTitle:@"视频处理" forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _shipinchuliBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_shipinchuliBtn setTitleEdgeInsets:UIEdgeInsetsMake(_shipinchuliBtn.imageView.frame.size.height+10,-80,-20,-30)];
    [_shipinchuliBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,_shipinchuliBtn.titleLabel.bounds.size.height, 0)];
    [_shipinchuliBtn addTarget:self action:@selector(shipinchuliAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shipinchuliBtn];
    
    _pinjiepingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pinjiepingBtn.frame = CGRectMake(left, height+132, 80, 132);
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_s.png"] forState:UIControlStateHighlighted];
    [_pinjiepingBtn setTitle:@"拼接屏" forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _pinjiepingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_pinjiepingBtn setTitleEdgeInsets:UIEdgeInsetsMake(_pinjiepingBtn.imageView.frame.size.height+10,-65,-20,0)];
    [_pinjiepingBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0,_pinjiepingBtn.titleLabel.bounds.size.height, 0)];
    [_pinjiepingBtn addTarget:self action:@selector(pinjiepingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pinjiepingBtn];
    
    _yejingdianshiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _yejingdianshiBtn.frame = CGRectMake(left+rowGap, height+132, 80, 132);
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_s.png"] forState:UIControlStateHighlighted];
    [_yejingdianshiBtn setTitle:@"液晶电视" forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _yejingdianshiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_yejingdianshiBtn setTitleEdgeInsets:UIEdgeInsetsMake(_yejingdianshiBtn.imageView.frame.size.height+10,-90,-20,-10)];
    [_yejingdianshiBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,_yejingdianshiBtn.titleLabel.bounds.size.height, 0)];
    [_yejingdianshiBtn addTarget:self action:@selector(yejingdianshiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_yejingdianshiBtn];
    
    _lubojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lubojiBtn.frame = CGRectMake(left+rowGap*2, height+132, 80, 132);
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_s.png"] forState:UIControlStateHighlighted];
    [_lubojiBtn setTitle:@"录播机" forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _lubojiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_lubojiBtn setTitleEdgeInsets:UIEdgeInsetsMake(_lubojiBtn.imageView.frame.size.height+10,-70,-20,10)];
    [_lubojiBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0,_lubojiBtn.titleLabel.bounds.size.height, 0)];
    [_lubojiBtn addTarget:self action:@selector(lubojiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lubojiBtn];
    
    _touyingjiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _touyingjiBtn.frame = CGRectMake(left+rowGap*3, height+132, 80, 132);
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_s.png"] forState:UIControlStateHighlighted];
    [_touyingjiBtn setTitle:@"投影机" forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
    _touyingjiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_touyingjiBtn setTitleEdgeInsets:UIEdgeInsetsMake(_touyingjiBtn.imageView.frame.size.height+15,-60,-25,5)];
    [_touyingjiBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,5.0,_touyingjiBtn.titleLabel.bounds.size.height, -5)];
    [_touyingjiBtn addTarget:self action:@selector(touyingjiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_touyingjiBtn];
    
    int labelStartX = 170;
    int labelStartY = 500;
    
    UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(labelStartX-40, labelStartY, 200, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = @"产品类型";
    
    _productTypePikcer = [[CustomPickerView alloc] initWithFrame:CGRectMake(labelStartX, labelStartY+30, 120, 150) withGrayOrLight:@"light"];
    [_productTypePikcer removeArray];
    _productTypePikcer.delegate_=self;
    _productTypePikcer.fontSize = 14;
    _productTypePikcer._pickerDataArray = @[@{@"values":@[@"电源管理",@"视频播放",@"摄像机",@"信息盒",@"远程视讯",@"视频处理",@"拼接屏",@"液晶电视",@"录播机",@"投影机"]}];
    [_productTypePikcer selectRow:0 inComponent:0];
    _productTypePikcer._selectColor = RGB(253, 180, 0);
    _productTypePikcer._rowNormalColor = RGB(117, 165, 186);
    [self.view addSubview:_productTypePikcer];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(labelStartX+145, labelStartY, 200, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = @"品牌";
    
    _brandPicker = [[CustomPickerView alloc] initWithFrame:CGRectMake(labelStartX+200, labelStartY+30, 91, 150) withGrayOrLight:@"light"];
    [_brandPicker removeArray];
    _brandPicker._pickerDataArray = @[@{@"values":@[@"f",@"e",@"a"]}];
    [_brandPicker selectRow:0 inComponent:0];
    _brandPicker._selectColor = RGB(253, 180, 0);
    _brandPicker._rowNormalColor = RGB(117, 165, 186);
    [self.view addSubview:_brandPicker];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(labelStartX+345, labelStartY, 200, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = @"型号";
    
    _productCategoryPicker = [[CustomPickerView alloc] initWithFrame:CGRectMake(labelStartX+400, labelStartY+30, 91, 150) withGrayOrLight:@"light"];
    [_productCategoryPicker removeArray];
    _productCategoryPicker._pickerDataArray = @[@{@"values":@[@"c",@"v",@"b"]}];
    [_productCategoryPicker selectRow:0 inComponent:0];
    _productCategoryPicker._selectColor = RGB(253, 180, 0);
    _productCategoryPicker._rowNormalColor = RGB(117, 165, 186);
    [self.view addSubview:_productCategoryPicker];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(labelStartX+595, labelStartY, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:16];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = @"数量";
    
    _numberPicker = [[CustomPickerView alloc] initWithFrame:CGRectMake(labelStartX+600, labelStartY+30, 91, 150) withGrayOrLight:@"light"];
    [_numberPicker removeArray];
    _numberPicker._pickerDataArray = @[@{@"values":@[@"12",@"10",@"09"]}];
    [_numberPicker selectRow:0 inComponent:0];
    _numberPicker._selectColor = RGB(253, 180, 0);
    _numberPicker._rowNormalColor = RGB(117, 165, 186);
    [self.view addSubview:_numberPicker];
    
    UIButton *signup = [UIButton buttonWithColor:RGB(0, 89, 118) selColor:YELLOW_COLOR];
    signup.frame = CGRectMake(SCREEN_WIDTH/2-50, labelStartY+120+25, 100, 40);
    signup.layer.cornerRadius = 5;
    signup.layer.borderWidth = 2;
    signup.layer.borderColor = RGB(0, 89, 118).CGColor;
    signup.clipsToBounds = YES;
    [self.view addSubview:signup];
    [signup setTitle:@"确认" forState:UIControlStateNormal];
    [signup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signup setTitleColor:RGB(1, 138, 182) forState:UIControlStateHighlighted];
    signup.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];
}

- (void) confirmAction:(id)sender{
    
}
- (void) touyingjiAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_s.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}
- (void) lubojiAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_s.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:RGB(230, 151, 50)forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}
- (void) yejingdianshiAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_s.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}
- (void) pinjiepingAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_s.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) shipinchuliAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_s.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) yuanchengshixunAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_s.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) xinxiheAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_s.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:RGB(230, 151, 50)forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) shexiangjiAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_s.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) shipinbofangAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_n.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_s.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

- (void) dianyuanguanliAction:(id)sender{
    [_dianyuanguanliBtn setImage:[UIImage imageNamed:@"engineer_dianyuanguanli_s.png"] forState:UIControlStateNormal];
    [_dianyuanguanliBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
    
    [_shipinbofangBtn setImage:[UIImage imageNamed:@"engineer_video_dvd_n.png"] forState:UIControlStateNormal];
    [_shipinbofangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shexiangjiBtn setImage:[UIImage imageNamed:@"engineer_video_shexiangji_n.png"] forState:UIControlStateNormal];
    [_shexiangjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_xinxiheBtn setImage:[UIImage imageNamed:@"engineer_video_xinxihe_n.png"] forState:UIControlStateNormal];
    [_xinxiheBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yuanchengshixunBtn setImage:[UIImage imageNamed:@"engineer_video_yuanchengshixun_n.png"] forState:UIControlStateNormal];
    [_yuanchengshixunBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_shipinchuliBtn setImage:[UIImage imageNamed:@"engineer_video_shipinchuli_n.png"] forState:UIControlStateNormal];
    [_shipinchuliBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_pinjiepingBtn setImage:[UIImage imageNamed:@"engineer_video_pinjieping_n.png"] forState:UIControlStateNormal];
    [_pinjiepingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_yejingdianshiBtn setImage:[UIImage imageNamed:@"engineer_video_yejingdianshi_n.png"] forState:UIControlStateNormal];
    [_yejingdianshiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_lubojiBtn setImage:[UIImage imageNamed:@"engineer_video_luboji_n.png"] forState:UIControlStateNormal];
    [_lubojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_touyingjiBtn setImage:[UIImage imageNamed:@"engineer_video_touyingji_n.png"] forState:UIControlStateNormal];
    [_touyingjiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *btn = (UIButton*) sender;
    NSString *btnText = btn.titleLabel.text;
    [self setBrandValue:btnText];
}

-(void) didScrollPickerValue:(NSString*)brand {
    if ([@"电源管理" isEqualToString:brand]) {
        [self dianyuanguanliAction:_dianyuanguanliBtn];
    } else if ([@"视频播放" isEqualToString:brand]) {
        [self shipinbofangAction:_shipinbofangBtn];
    } else if ([@"摄像机" isEqualToString:brand]) {
        [self shexiangjiAction:_shexiangjiBtn];
    } else if ([@"信息盒" isEqualToString:brand]) {
        [self xinxiheAction:_xinxiheBtn];
    } else if ([@"远程视讯" isEqualToString:brand]) {
        [self yuanchengshixunAction:_yuanchengshixunBtn];
    } else if ([@"视频处理" isEqualToString:brand]) {
        [self shipinchuliAction:_shipinchuliBtn];
    } else if ([@"拼接屏" isEqualToString:brand]) {
        [self pinjiepingAction:_pinjiepingBtn];
    } else if ([@"液晶电视" isEqualToString:brand]) {
        [self yejingdianshiAction:_yejingdianshiBtn];
    }  else if ([@"录播机" isEqualToString:brand]) {
        [self lubojiAction:_lubojiBtn];
    } else {
        [self touyingjiAction:_touyingjiBtn];
    }
}

-(void) setBrandValue:(NSString*)brand {
    if (brand == nil) {
        return;
    }
    NSArray *array = _productTypePikcer._pickerDataArray;
    int index = 0;
    for (NSDictionary *dic in array) {
        NSArray *valueArray = [dic objectForKey:@"values"];
        for (NSString * str in valueArray) {
            if ([str isEqualToString:brand]) {
                break;
            }
            index++;
        }
    }
    [_productTypePikcer selectRow:index inComponent:0];
}
- (void) okAction:(id)sender{
    EngineerEnvDevicePluginViewCtrl *ctrl = [[EngineerEnvDevicePluginViewCtrl alloc] init];
    ctrl._meetingRoomDic = self._meetingRoomDic;
    
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end



