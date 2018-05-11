//
//  ECPlusSelectView.m
//  veenoon
//
//  Created by chen jack on 2017/12/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "VideoProcessRightView.h"
#import "EPlusLayerView.h"
#import "UIButton+Color.h"
#import "VVideoProcessSet.h"

@interface VideoProcessRightView () <UITableViewDelegate,
UITableViewDataSource,
VideoProcessRightViewDelegate, EPlusLayerViewDelegate, UITextFieldDelegate>
{
    UITableView *_tableView;
    UIView     *_maskView;
    
    int _curIndex;
}
@property (nonatomic, strong) NSMutableArray *_btns;
@end

@implementation VideoProcessRightView
@synthesize _data;
@synthesize delegate;
@synthesize _btns;
@synthesize _currentObj;
@synthesize _numOfDevice;
@synthesize _callback;
@synthesize _curentDeviceIndex;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (void) initData{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"icon" ofType:@"plist"];
    self._data = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (id) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        _curIndex = 0;
        
        [self initData];
        
        self.backgroundColor = RGB(0, 89, 118);
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   frame.size.width,
                                                                   frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        _tableView.clipsToBounds = NO;
        
    }
    return self;
}



-(void) refreshView:(VVideoProcessSet*) vVideoProcessSet {
    self._currentObj = vVideoProcessSet;
    
    
    
    self._curentDeviceIndex = _currentObj._index;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //_curIndex = (int)textField.tag;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    float fy = scrollView.contentOffset.y;
    
    if(fy < -40)
    {
    }
    
}

#pragma mark -
#pragma mark Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_data count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_curIndex == section)
    {
        NSDictionary *row = [_data objectAtIndex:section];
        NSArray *items = [row objectForKey:@"items"];
        
        return [items count];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *sec = [_data objectAtIndex:indexPath.section];
    NSArray *items = [sec objectForKey:@"items"];
    if(indexPath.row < [items count]) {
        NSDictionary *dic = [items objectAtIndex:indexPath.row];
        
        int idx = [[dic objectForKey:@"id"] intValue];
        
        if(idx)
        {
            
            return 80;
        }
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellID = @"listCell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //cell.editing = NO;
    }
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *sec = [_data objectAtIndex:indexPath.section];
    NSArray *items = [sec objectForKey:@"items"];
    
    if(indexPath.row < [items count]) {
        NSDictionary *dic = [items objectAtIndex:indexPath.row];
        
        int idx = [[dic objectForKey:@"id"] intValue];
        
        if(idx)
        {
        
        EPlusLayerView *rowCell = [[EPlusLayerView alloc]
                                   initWithFrame:CGRectMake(0, 0,
                                                            80, 80)];
        
        [rowCell setIconContentsGravity:kCAGravityCenter];
        
        [cell.contentView addSubview:rowCell];
        rowCell.tag = indexPath.section * 100 + indexPath.row;
        rowCell._enableDrag = YES;
        rowCell.delegate_ = self;
        rowCell._element = dic;
        NSString *image = [dic objectForKey:@"icon"];
        [rowCell setSticker:image];
        
        NSString *sel = [dic objectForKey:@"icon_sel"];
        rowCell.selectedImg = [UIImage imageNamed:sel];
        
        }
        int xx = 90;
        
        UILabel* textLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(xx,
                                                       20,
                                                       tableView.frame.size.width-xx-10, 20)];
        [cell.contentView addSubview:textLabel];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor whiteColor];
        
        UILabel *detailLabel = [[UILabel alloc]
                                initWithFrame:CGRectMake(xx,
                                                         40,
                                                         tableView.frame.size.width-xx-10, 20)];
        [cell.contentView addSubview:detailLabel];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.textColor = [UIColor whiteColor];
        
        
        textLabel.text = [dic objectForKey:@"name"];
        detailLabel.text = [dic objectForKey:@"type"];
    
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_header_bg.png"]];
    [header addSubview:bg];
    bg.frame = header.bounds;
    
    NSDictionary *sec = [_data objectAtIndex:section];
    
    UILabel *tL = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH, 20)];
    tL.textColor = [UIColor whiteColor];
    tL.font = [UIFont systemFontOfSize:14];
    [header addSubview:tL];
    
    tL.text = [sec objectForKey:@"title"];
    
    UIImageView *iconAdd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arraw.png"]];
    [header addSubview:iconAdd];
    iconAdd.center = CGPointMake(20, 20);
    
    if(_curIndex == section)
    {
        iconAdd.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [btn addTarget:self action:@selector(extendAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    btn.tag = section;
    
    return header;
}

- (void) extendAction:(UIButton*)sender{
    
    int nextIndex = (int)sender.tag;
    
    if(_curIndex == nextIndex)
    {
        _curIndex = -1;
    }
    else
    {
        _curIndex = nextIndex;
    }
    
    [_tableView reloadData];
}

- (void) didBeginTouchedStickerLayer:(id)layer sticker:(id)sticker{
    
    _tableView.scrollEnabled = NO;
    
    //NSLog(@"1");
    
    
    //    EPlusLayerView *st = layer;
    //    UIImageView *icon = sticker;
    //
    //    CGPoint pt = [_tableView convertPoint:icon.center
    //                           fromView:st];
    //
    //    NSLog(@"%f - %f", pt.x, pt.y);
    
}
- (void) didMovedStickerLayer:(id)layer sticker:(id)sticker{
    
    //
    //    EPlusLayerView *st = layer;
    //    UIImageView *icon = sticker;
    //
    //    CGPoint pt = [_tableView convertPoint:icon.center
    //                                 fromView:st];
    //
    //    NSLog(@"%f - %f", pt.x, pt.y);
    
}
- (void) didEndTouchedStickerLayer:(id)layer sticker:(id)sticker{
    
    _tableView.scrollEnabled = YES;
    
    //NSLog(@"-1");
    
    EPlusLayerView *st = layer;
    UIImageView *icon = sticker;
    
    CGPoint pt = [_tableView convertPoint:icon.center
                                 fromView:st];
    
    CGPoint ptNew = pt;
    ptNew.y = pt.y - _tableView.contentOffset.y;
    
    NSLog(@"%f - %f", ptNew.x, ptNew.y);
    
    if(delegate && [delegate respondsToSelector:@selector(didEndDragingElecCell:pt:)])
    {
        [delegate didEndDragingElecCell:st._element pt:ptNew];
    }
    
}

@end
