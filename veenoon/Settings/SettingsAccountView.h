//
//  SettingsAccountView.h
//  veenoon
//
//  Created by 安志良 on 2017/11/18.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  SettingsAccountViewDelegate <NSObject>
- (void) enterOutSystem;
@end

@interface SettingsAccountView : UIView
@property(nonatomic, weak) id<SettingsAccountViewDelegate> delegate;

@end

