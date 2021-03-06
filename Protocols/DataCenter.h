//
//  DataCenter.h
//  cntvForiPhone
//
//  Created by Jack on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Scenario;

@interface DataCenter : NSObject {
	   
   
}
@property (nonatomic, strong) NSMutableDictionary *_selectedDevice;
@property (nonatomic, strong) NSMutableDictionary *_roomData;

@property (nonatomic, strong) Scenario *_scenario;

+ (DataCenter*)defaultDataCenter;

- (void) cacheScenarioOnLocalDB;

@end
