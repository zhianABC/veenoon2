//
//  BasePlugElement.h
//  veenoon
//
//  Created by chen jack on 2018/4/21.
//  Copyright © 2018年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasePlugElement : NSObject

@property (nonatomic, strong) NSString *_name;
@property (nonatomic, strong) NSString *_brand;
@property (nonatomic, strong) NSString *_type;
@property (nonatomic, strong) NSString *_driverUUID;
@property (nonatomic, strong) NSString *_deviceno;
@property (nonatomic, strong) NSString *_deviceid;
@property (nonatomic, strong) NSString *_ipaddress;
@property (nonatomic, strong) NSString *_com;
@property (nonatomic, strong) NSArray *_comArray;

@property (nonatomic,assign) int _index;

- (NSString*) showName;

- (NSString *)objectToJsonString;
- (void) jsonStringToObject:(NSString*)json;

@end
