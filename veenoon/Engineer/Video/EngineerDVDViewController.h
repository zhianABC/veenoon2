//
//  EngineerDVDViewController.h
//  veenoon
//
//  Created by 安志良 on 2017/12/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class VDVDPlayerSet;

@interface EngineerDVDViewController: BaseViewController {
    NSMutableArray *_dvdSysArray;
    
    int _number;
}
@property (nonatomic,strong) NSArray *_dvdSysArray;
@property (nonatomic,assign) int _number;
@end
