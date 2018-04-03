//
//  EngineerElectonicSysConfigViewCtrl.m
//  veenoon
//
//  Created by 安志良 on 2017/12/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerElectronicSysConfigViewCtrl.h"
#import "UIButton+Color.h"
#import "PowerSettingView.h"
#import "CustomPickerView.h"
#import "APowerESet.h"

@interface EngineerElectronicSysConfigViewCtrl () <CustomPickerViewDelegate>{
    PowerSettingView *_psv;
    
    UIButton *_selectSysBtn;
    
    CustomPickerView *_customPicker;
    
    UIButton *okBtn;
    
    BOOL isSettings;
    
    NSMutableArray *lableArray;
    NSMutableArray *_selectedBtnArray;
    NSMutableArray *_allBtnArray;
}

@property (nonatomic, strong) APowerESet *_objSet;

@end

@implementation EngineerElectronicSysConfigViewCtrl
@synthesize _electronicSysArray;
@synthesize _number;

@synthesize _objSet;

- (void)viewDidLoad {
    [super viewDidLoad];
    isSettings = NO;
    
    lableArray = [[NSMutableArray alloc] init];
    _selectedBtnArray = [[NSMutableArray alloc] init];
    _allBtnArray = [[NSMutableArray alloc] init];
    
    [super setTitleAndImage:@"audio_corner_dianyuanguanli.png" withTitle:@"电源实时器"];
    
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
    
    int index = 0;
    int top = ENGINEER_VIEW_COMPONENT_TOP;
    
    int leftRight = ENGINEER_VIEW_LEFT;
    
    int cellWidth = 92;
    int cellHeight = 92;
    int colNumber = ENGINEER_VIEW_COLUMN_N;
    int space = ENGINEER_VIEW_COLUMN_GAP*3;
    
    self._objSet = [[APowerESet alloc] init];
    [_objSet initLabs:_number];
    
    
    if ([self._electronicSysArray count] == 0) {
        int nameStart = 1;
        for (int i = 0; i < self._number; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            if (nameStart < 10) {
                NSString *startStr = [NSString stringWithFormat:@"%d",nameStart];
                NSString *name = [@"0" stringByAppendingString:startStr];
                
                [dic setObject:name forKey:@"name"];
            } else {
                NSString *startStr = [NSString stringWithFormat:@"%d",nameStart];
                [dic setObject:startStr forKey:@"name"];
            }
            
            [dic setObject:@"OFF" forKey:@"status"];
            
            nameStart++;
            [self._electronicSysArray addObject:dic];
            
            int row = index/colNumber;
            int col = index%colNumber;
            int startX = col*cellWidth+col*space+leftRight;
            int startY = row*cellHeight+space*row+top;
            
            UIButton *scenarioBtn = [UIButton buttonWithColor:nil selColor:nil];
            scenarioBtn.frame = CGRectMake(startX, startY, cellWidth, cellHeight);
            scenarioBtn.layer.cornerRadius = 5;
            scenarioBtn.layer.borderWidth = 2;
            scenarioBtn.layer.borderColor = [UIColor clearColor].CGColor;
            scenarioBtn.clipsToBounds = YES;
            [scenarioBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_n.png"] forState:UIControlStateNormal];
            [scenarioBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_s.png"] forState:UIControlStateHighlighted];
            scenarioBtn.tag = index;
            [self.view addSubview:scenarioBtn];
            
            [scenarioBtn addTarget:self
                            action:@selector(scenarioAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            [self createBtnLabel:scenarioBtn dataDic:dic];
            
            [_allBtnArray addObject:scenarioBtn];
            
            index++;
        }
    } else {
        for (int i = 0; i < self._number; i++) {
            NSMutableDictionary *dic = [self._electronicSysArray objectAtIndex:i];
            
            int row = index/colNumber;
            int col = index%colNumber;
            int startX = col*cellWidth+col*space+leftRight;
            int startY = row*cellHeight+space*row+top;
            
            UIButton *scenarioBtn = [UIButton buttonWithColor:nil selColor:RGB(0, 89, 118)];
            scenarioBtn.frame = CGRectMake(startX, startY, cellWidth, cellHeight);
            scenarioBtn.clipsToBounds = YES;
            scenarioBtn.layer.cornerRadius = 5;
            scenarioBtn.layer.borderWidth = 2;
            scenarioBtn.layer.borderColor = [UIColor clearColor].CGColor;
            NSString *status = [dic objectForKey:@"status"];
            
            [scenarioBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_n.png"] forState:UIControlStateNormal];
            [scenarioBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_s.png"] forState:UIControlStateHighlighted];
            
            if ([status isEqualToString:@"ON"]) {
                [scenarioBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_s.png"] forState:UIControlStateNormal];
            }
            scenarioBtn.tag = index;
            [self.view addSubview:scenarioBtn];
            
            [scenarioBtn addTarget:self
                            action:@selector(scenarioAction:)
                  forControlEvents:UIControlEventTouchUpInside];
            [self createBtnLabel:scenarioBtn dataDic:dic];
            index++;
        }
    }
}
- (void) createBtnLabel:(UIButton*)sender dataDic:(NSMutableDictionary*) dataDic{
    UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.backgroundColor = [UIColor clearColor];
    [sender addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:11];
    titleL.textColor  = [UIColor whiteColor];
    
    NSString *title = [@"Channel  " stringByAppendingString: [dataDic objectForKey:@"name"]];
    titleL.text = title;
    
    [lableArray addObject:titleL];
}

- (void) sysSelectAction:(id)sender{
    
    if(_customPicker == nil)
    _customPicker = [[CustomPickerView alloc]
                                      initWithFrame:CGRectMake(50, _selectSysBtn.frame.origin.y, _selectSysBtn.frame.size.width, 120) withGrayOrLight:@"gray"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for(int i = 1; i<5; i++)
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

- (void) didConfirmPickerValue:(NSString*) pickerValue {
  }

- (void) scenarioAction:(id)sender{
    UIButton *btn = (UIButton*) sender;
    int index = (int) btn.tag;
    
    UILabel *titleL = [lableArray objectAtIndex:index];
    
    UIButton *selctedBtn;
    
    for(UIButton *btn in _selectedBtnArray) {
        if (index == (int) btn.tag) {
            selctedBtn = btn;
            break;
        }
    }
    
    if (selctedBtn != nil) {
        [selctedBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_n.png"] forState:UIControlStateNormal];
        [titleL setTextColor:[UIColor whiteColor]];
        
        [_selectedBtnArray removeObject:selctedBtn];
    } else {
        selctedBtn = [_allBtnArray objectAtIndex:index];
        
        [selctedBtn setImage:[UIImage imageNamed:@"dianyuanshishiqi_s.png"] forState:UIControlStateNormal];
        [titleL setTextColor:YELLOW_COLOR];
        
        [_selectedBtnArray addObject:selctedBtn];
    }
}

- (void) okAction:(id)sender{
    if (!isSettings) {
        _psv = [[PowerSettingView alloc]
                initWithFrame:CGRectMake(SCREEN_WIDTH-300,
                                         64, 300, SCREEN_HEIGHT-114)];
        [self.view addSubview:_psv];
        
        _psv._objSet = [[APowerESet alloc] init];
        [_psv._objSet initLabs:_number];
        
        if (self._number == 8) {
            [_psv show8Labs];
        } else {
            [_psv show16Labs];
        }
        
        [okBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        isSettings = YES;
    } else {
        if (_psv) {
            [_psv removeFromSuperview];
        }
        [okBtn setTitle:@"设置" forState:UIControlStateNormal];
        isSettings = NO;
    }
}

- (void) cancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
