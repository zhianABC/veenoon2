//
//  UserFloorWarmViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2017/12/3.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "UserAirCleanViewCtrl.h"
#import "UIButton+Color.h"
#import "MapMarkerLayer.h"

@interface UserAirCleanViewCtrl <MapMarkerLayerDelegate>() {
    NSMutableArray *_airCleanRoomList;
    NSMutableArray *_aireCleanBtnList;
    MapMarkerLayer *markerLayer;
}
    @property (nonatomic, strong) NSMutableArray *_airCleanRoomList;
    @end

@implementation UserAirCleanViewCtrl
    @synthesize _airCleanRoomList;
    
- (void) initData {
    if (_airCleanRoomList) {
        [_airCleanRoomList removeAllObjects];
    } else {
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"小会议室", @"name",
                                     nil];
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        NSMutableDictionary *dic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        NSMutableDictionary *dic6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        NSMutableDictionary *dic7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"大会议室", @"name",
                                     nil];
        self._airCleanRoomList = [NSMutableArray arrayWithObjects:dic1, dic2, dic3, dic4, dic5, dic6, dic7, nil];
    }
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    if (_aireCleanBtnList) {
        [_aireCleanBtnList removeAllObjects];
    } else {
        _aireCleanBtnList = [[NSMutableArray alloc] init];
    }
    
    self.view.backgroundColor = RGB(63, 58, 55);
    
    UIImageView *titleIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_view_title.png"]];
    [self.view addSubview:titleIcon];
    titleIcon.frame = CGRectMake(70, 30, 70, 10);
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
    line.backgroundColor = RGB(83, 78, 75);
    [self.view addSubview:line];
    
    UIImageView *bottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
    [self.view addSubview:bottomBar];
    
    //缺切图，把切图贴上即可。
    bottomBar.backgroundColor = [UIColor grayColor];
    bottomBar.userInteractionEnabled = YES;
    bottomBar.image = [UIImage imageNamed:@"user_botom_Line.png"];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 0,160, 60);
    [bottomBar addSubview:cancelBtn];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelBtn addTarget:self
                  action:@selector(cancelAction:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-10-160, 0,160, 60);
    [bottomBar addSubview:okBtn];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitleColor:RGB(255, 180, 0) forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [okBtn addTarget:self
              action:@selector(okAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    int leftGap = 160;
    int scrollHeight = 600;
    int cellWidth = 100;
    int rowGap = 30;
    int number = [self._airCleanRoomList count];
    int contentWidth = number * 100 + (number-1) * rowGap;
    UIScrollView *airCondtionView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftGap, SCREEN_HEIGHT-scrollHeight, SCREEN_WIDTH - leftGap*2, cellWidth+10)];
    airCondtionView.contentSize =  CGSizeMake(contentWidth, cellWidth+10);
    airCondtionView.scrollEnabled=YES;
    airCondtionView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:airCondtionView];
    
    int index = 0;
    for (id dic in _airCleanRoomList) {
        int startX = index*cellWidth+index*rowGap+10;
        int startY = 5;
        
        UIButton *airConditionBtn = [UIButton buttonWithColor:nil selColor:nil];
        airConditionBtn.tag = index;
        airConditionBtn.frame = CGRectMake(startX, startY, cellWidth, cellWidth);
        [airConditionBtn setImage:[UIImage imageNamed:@"user_aireclean_n.png"] forState:UIControlStateNormal];
        [airConditionBtn setImage:[UIImage imageNamed:@"user_aireclean_s.png"] forState:UIControlStateHighlighted];
        [airConditionBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        [airConditionBtn setTitleColor:SINGAL_COLOR forState:UIControlStateNormal];
        [airConditionBtn setTitleColor:RGB(230, 151, 50) forState:UIControlStateHighlighted];
        airConditionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [airConditionBtn setTitleEdgeInsets:UIEdgeInsetsMake(airConditionBtn.imageView.frame.size.height+10,-90,-20,20)];
        [airConditionBtn setImageEdgeInsets:UIEdgeInsetsMake(-10.0,-15,airConditionBtn.titleLabel.bounds.size.height, 0)];
        [airConditionBtn addTarget:self action:@selector(airConditionAction:) forControlEvents:UIControlEventTouchUpInside];
        [airCondtionView addSubview:airConditionBtn];
        
        index++;
        
        [_aireCleanBtnList addObject:airConditionBtn];
    }
    
    int btnLeftRight = 300;
    
    UIButton *zhilengBtn = [UIButton buttonWithColor:RGB(46, 105, 106) selColor:RGB(242, 148, 20)];
    zhilengBtn.frame = CGRectMake(btnLeftRight+70, SCREEN_HEIGHT-350, 100, 100);
    zhilengBtn.layer.cornerRadius = 5;
    zhilengBtn.layer.borderWidth = 2;
    zhilengBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    zhilengBtn.clipsToBounds = YES;
    [zhilengBtn setImage:[UIImage imageNamed:@"user_aireclean_p_n.png"] forState:UIControlStateNormal];
    [zhilengBtn setImage:[UIImage imageNamed:@"user_aireclean_p_n.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:zhilengBtn];
    [zhilengBtn addTarget:self action:@selector(aircleanPAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zhireBtn = [UIButton buttonWithColor:RGB(46, 105, 106) selColor:RGB(242, 148, 20)];
    zhireBtn.frame = CGRectMake(btnLeftRight+210, SCREEN_HEIGHT-350, 100, 100);
    zhireBtn.layer.cornerRadius = 5;
    zhireBtn.layer.borderWidth = 2;
    zhireBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    zhireBtn.clipsToBounds = YES;
    [zhireBtn setImage:[UIImage imageNamed:@"user_aireclean_f_n.png"] forState:UIControlStateNormal];
    [zhireBtn setImage:[UIImage imageNamed:@"user_aireclean_f_n.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:zhireBtn];
    [zhireBtn addTarget:self action:@selector(aircleanFAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *aireWindBtn = [UIButton buttonWithColor:RGB(46, 105, 106) selColor:RGB(242, 148, 20)];
    aireWindBtn.frame = CGRectMake(btnLeftRight+350, SCREEN_HEIGHT-350, 100, 100);
    aireWindBtn.layer.cornerRadius = 5;
    aireWindBtn.layer.borderWidth = 2;
    aireWindBtn.layer.borderColor = [UIColor clearColor].CGColor;;
    aireWindBtn.clipsToBounds = YES;
    [aireWindBtn setImage:[UIImage imageNamed:@"user_aireclean_a_n.png"] forState:UIControlStateNormal];
    [aireWindBtn setImage:[UIImage imageNamed:@"user_aireclean_a_n.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:aireWindBtn];
    [aireWindBtn addTarget:self action:@selector(aircleanAAction:)
          forControlEvents:UIControlEventTouchUpInside];
}
- (void) aircleanPAction:(id)sender{
    
}
- (void) aircleanFAction:(id)sender{
    
}
- (void) aircleanAAction:(id)sender{
    
}
- (void) didSelectView:(int) path {
    markerLayer.isSelected = path;
    [markerLayer setNeedsDisplay];
}
- (void) didUnSelectView:(int) path {
    markerLayer.isSelected = 0;
    [markerLayer setNeedsDisplay];
}
- (void) airConditionAction:(id)sender{
    UIButton *selectBtn = (UIButton*) sender;
    int selectTag = selectBtn.tag;
    
    for (UIButton *btn in _aireCleanBtnList) {
        if (btn.tag == selectTag) {
            [btn setImage:[UIImage imageNamed:@"user_aireclean_s.png"] forState:UIControlStateNormal];
            [btn setTitleColor:RGB(230, 151, 50) forState:UIControlStateNormal];
        } else {
            [btn setImage:[UIImage imageNamed:@"user_aireclean_n.png"] forState:UIControlStateNormal];
            [btn setTitleColor:SINGAL_COLOR forState:UIControlStateNormal];
        }
    }
}
    
- (void) okAction:(id)sender{
    
}
    
- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
    
    @end
