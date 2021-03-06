//
//  UserVideoConfigView.h
//  veenoon
//
//  Created by chen jack on 2017/11/29.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickerLayerView.h"

@protocol UserVideoConfigViewDelegate <NSObject>

@optional
- (void) didPupConfigView:(StickerLayerView*)sticker;
@end

@interface UserVideoConfigView : UIView
{
    
}
@property (nonatomic, strong) NSArray *_inputDatas;
@property (nonatomic, strong) NSArray *_outputDatas;
@property (nonatomic, weak) id <UserVideoConfigViewDelegate> delegate_;
@property (nonatomic, strong) NSMutableDictionary *_result;

- (void) show;

@end
