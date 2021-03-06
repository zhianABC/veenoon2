//
//  EngineerPortSettingView.m
//  veenoon
//
//  Created by 安志良 on 2017/12/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EngineerDNSSettingView.h"
#import "CenterCustomerPickerView.h"

@interface EngineerDNSSettingView () <UITableViewDelegate,UITableViewDataSource, CenterCustomerPickerViewDelegate> {
    int startX;
    int rowGap;
}

@end

@implementation EngineerDNSSettingView
@synthesize _portList;
@synthesize _serialLabel;
@synthesize _devicNameLabel;
@synthesize _devicIPLabel;
@synthesize _macAddressLabel;
@synthesize _portLvPicker;
@synthesize _digitPicker;
@synthesize _checkPicker;
@synthesize _stopPicker;
@synthesize _tableView;
@synthesize _selectedRow;
@synthesize _previousSelectedRow;

-(void) initDat {
    if (_portList) {
        [_portList removeAllObjects];
    } else {
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"1", @"serialNumber",
                                     @"TESLARIA", @"deviceName",
                                     @"192.168.1.1", @"deviceIP",
                                     @"00-E0-66-10-E7-7C", @"macAddress",
                                     @"4800", @"portLv",
                                     @"NONE1", @"digitPosition",
                                     @"NONE1", @"checkPosition",
                                     @"NONE1", @"stopPosition",
                                     nil];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"2", @"serialNumber",
                                     @"TESLARIA", @"deviceName",
                                     @"192.168.1.2", @"deviceIP",
                                     @"00-E0-66-10-E7-7C", @"macAddress",
                                     @"4800", @"portLv",
                                     @"4", @"digitPosition",
                                     @"PAR_EVEN", @"checkPosition",
                                     @"NONE1", @"stopPosition",
                                     nil];
        self._portList = [NSMutableArray arrayWithObjects:dic1, dic2, nil];
    }
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        maskView.backgroundColor = [UIColor clearColor];
        maskView.userInteractionEnabled = YES;
        [self addSubview:maskView];
        
    
        [self initDat];
        self.backgroundColor = THEME_COLOR;
        self.clipsToBounds = YES;
        _selectedRow = -1;
        _previousSelectedRow=-1;
        startX = 40;
        rowGap = (SCREEN_WIDTH - startX)/8;
        
        
        UILabel *_portDNSLabel = [[UILabel alloc] initWithFrame:CGRectMake(ENGINEER_VIEW_LEFT, ENGINEER_PORT_VIEW_HEIGHT, SCREEN_WIDTH-80, 20)];
        _portDNSLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_portDNSLabel];
        _portDNSLabel.font = [UIFont boldSystemFontOfSize:20];
        _portDNSLabel.textColor  = [UIColor whiteColor];
        _portDNSLabel.text = @"端口设置";
        
        int titleHeight = ENGINEER_PORT_VIEW_HEIGHT + 80;
        
        UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"序号";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*0.5, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"设备名称";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*1.5, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"设备IP";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*2.5, titleHeight, 150, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"MAC地址";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*4, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"波特率";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*5, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"数据位";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*6, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"校验位";
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*7, titleHeight, 100, 30)];
        titleL.backgroundColor = [UIColor clearColor];
        [self addSubview:titleL];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor  = [UIColor whiteColor];
        titleL.text = @"停止位";
        
        int tableHeight = titleHeight + 40;
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableHeight, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
        
        
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_portList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedRow) {
        return 180;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (_selectedRow == indexPath.row) {
        _tableView.scrollEnabled=NO;
        return cell;
    } else if (_selectedRow == -1) {
        _tableView.scrollEnabled=YES;
    }
    
    NSMutableDictionary *dic = [self._portList objectAtIndex:indexPath.row];
    
    UILabel* titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"serialNumber"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*0.5, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"deviceName"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*1.5, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"deviceIP"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*2.5, 5, 150, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"macAddress"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*4, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"portLv"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*5, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"digitPosition"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*6, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"checkPosition"];
    
    titleL = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*7, 5, 100, 30)];
    titleL.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleL];
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor  = [UIColor whiteColor];
    titleL.text = [dic objectForKey:@"stopPosition"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // firstly update the pre selected row number
    if (_previousSelectedRow > -1) {
        NSMutableDictionary *dic = [_portList objectAtIndex:_previousSelectedRow];
        [dic setObject:_portLvPicker._unitString forKey:@"portLv"];
        [dic setObject:_digitPicker._unitString forKey:@"digitPosition"];
        [dic setObject:_checkPicker._unitString forKey:@"checkPosition"];
        [dic setObject:_stopPicker._unitString forKey:@"stopPosition"];
    }
    
    //secondly
    _selectedRow = (int) indexPath.row;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    
    NSMutableDictionary *dic = [_portList objectAtIndex:_selectedRow];
    
    if (_serialLabel == nil) {
        _serialLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, 10, 100, 130)];
        _serialLabel.backgroundColor = [UIColor clearColor];
        
        _serialLabel.font = [UIFont boldSystemFontOfSize:14];
        _serialLabel.textAlignment = NSTextAlignmentCenter;
        _serialLabel.textColor  = [UIColor whiteColor];
        _serialLabel.text = [dic objectForKey:@"serialNumber"];
    }
    [cell.contentView addSubview:_serialLabel];
    
    if (_devicNameLabel == nil) {
        _devicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*0.5, 10, 100, 130)];
        _devicNameLabel.backgroundColor = [UIColor clearColor];
        
        _devicNameLabel.font = [UIFont boldSystemFontOfSize:14];
        _devicNameLabel.textAlignment = NSTextAlignmentCenter;
        _devicNameLabel.textColor  = [UIColor whiteColor];
        _devicNameLabel.text = [dic objectForKey:@"deviceName"];
    }
    [cell.contentView addSubview:_devicNameLabel];
    
    if (_devicIPLabel == nil) {
        _devicIPLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*1.5, 10, 100, 130)];
        _devicIPLabel.backgroundColor = [UIColor clearColor];
        
        _devicIPLabel.font = [UIFont boldSystemFontOfSize:14];
        _devicIPLabel.textAlignment = NSTextAlignmentCenter;
        _devicIPLabel.textColor  = [UIColor whiteColor];
        _devicIPLabel.text = [dic objectForKey:@"deviceIP"];
    }
    [cell.contentView addSubview:_devicIPLabel];
    
    if (_macAddressLabel == nil) {
        _macAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX+rowGap*2.5, 10, 150, 130)];
        _macAddressLabel.backgroundColor = [UIColor clearColor];
        
        _macAddressLabel.font = [UIFont boldSystemFontOfSize:14];
        _macAddressLabel.textAlignment = NSTextAlignmentCenter;
        _macAddressLabel.textColor  = [UIColor whiteColor];
        _macAddressLabel.text = [dic objectForKey:@"macAddress"];
    }
    [cell.contentView addSubview:_macAddressLabel];
    
    if (_portLvPicker == nil) {
        _portLvPicker = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(startX+rowGap*4, 5, 100, 150) ];
        [_portLvPicker removeArray];
        _portLvPicker._pickerDataArray = @[@{@"values":@[@"12",@"10",@"09"]}];
        [_portLvPicker selectRow:0 inComponent:0];
        _portLvPicker._selectColor = RGB(253, 180, 0);
        _portLvPicker._rowNormalColor = RGB(117, 165, 186);
    }
    [cell.contentView addSubview:_portLvPicker];
    if (_digitPicker == nil) {
        _digitPicker = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(startX+rowGap*5, 5, 100, 150)];
        [_digitPicker removeArray];
        _digitPicker._pickerDataArray = @[@{@"values":@[@"12",@"10",@"09"]}];
        [_digitPicker selectRow:0 inComponent:0];
        _digitPicker._selectColor = RGB(253, 180, 0);
        _digitPicker._rowNormalColor = RGB(117, 165, 186);
    }
    [cell.contentView addSubview:_digitPicker];
    if (_checkPicker==nil) {
        _checkPicker = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(startX+rowGap*6, 5, 100, 150)];
        [_checkPicker removeArray];
        _checkPicker._pickerDataArray = @[@{@"values":@[@"12",@"10",@"09"]}];
        [_checkPicker selectRow:0 inComponent:0];
        _checkPicker._selectColor = RGB(253, 180, 0);
        _checkPicker._rowNormalColor = RGB(117, 165, 186);
    }
    
    [cell.contentView addSubview:_checkPicker];
    if (_stopPicker == nil) {
        _stopPicker = [[CenterCustomerPickerView alloc] initWithFrame:CGRectMake(startX+rowGap*7, 5, 100, 150)];
        [_stopPicker removeArray];
        _stopPicker._pickerDataArray = @[@{@"values":@[@"12",@"10",@"09"]}];
        [_stopPicker selectRow:0 inComponent:0];
        _stopPicker._selectColor = RGB(253, 180, 0);
        _stopPicker._rowNormalColor = RGB(117, 165, 186);
    }
    [cell.contentView addSubview:_stopPicker];
    
    [_tableView reloadData];
    
    _previousSelectedRow = (int)indexPath.row;
}
@end

