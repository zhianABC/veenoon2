//
//  Scenario.h
//  veenoon
//
//  Created by chen jack on 2018/3/24.
//  Copyright © 2018年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RgsSceneOperation;
@class RgsSceneObj;

@interface Scenario : NSObject

@property (nonatomic, assign) int room_id;
@property (nonatomic, strong) RgsSceneObj *_rgsSceneObj;

@property (nonatomic, strong) NSMutableArray *_areas;

@property (nonatomic, strong) NSMutableArray *_audioDevices;
@property (nonatomic, strong) NSMutableArray *_videoDevices;
@property (nonatomic, strong) NSMutableArray *_envDevices;

//场景的Event下的Operations，对应中控上的操作序列，最后生成场景的时候，提交到中控。
//<RgsSceneOperation> -- 参见Regulus SDK里的对象说明
@property (nonatomic, strong) NSMutableArray *_eventOperations;


- (void) addEventOperation:(RgsSceneOperation*)rgsSceneOp;

- (void) prepareSenarioSlice;
- (void) createEventScenario;
- (void) saveEventScenario;

- (void) fillWithData:(NSDictionary*)data;
- (NSMutableDictionary *)senarioData;


@end
