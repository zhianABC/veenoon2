//
//  VTouyingjiSet.m
//  veenoon
//
//  Created by 安志良 on 2018/4/25.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "VTouyingjiSet.h"
#import "RegulusSDK.h"
#import "DataSync.h"
#import "KVNProgress.h"
#import "VProjectProxys.h"

@interface VTouyingjiSet ()
{
    
}
@property (nonatomic, strong) RgsPropertyObj *_driver_ip_Property;


@end

@implementation VTouyingjiSet


@synthesize _driver;
@synthesize _driverInfo;
@synthesize _driver_ip_Property;
@synthesize _comDriver;
@synthesize _comDriverInfo;
@synthesize _proxyObj;
@synthesize _comConnections;
@synthesize _cameraConnections;


- (id) init
{
    if(self = [super init])
    {
        
        self._ipaddress = @"192.168.1.100";
        
    }
    
    return self;
}

- (NSString*) deviceName{
    
    return @"投影机";
}


- (void) syncDriverIPProperty{
    
    if(_driver_ip_Property)
    {
        self._ipaddress = _driver_ip_Property.value;
        return;
    }
    
    if(_comDriver && [_comDriver isKindOfClass:[RgsDriverObj class]])
    {
        IMP_BLOCK_SELF(VTouyingjiSet);
        
        RgsDriverObj *rd = (RgsDriverObj*)_comDriver;
        [[RegulusSDK sharedRegulusSDK] GetDriverProperties:rd.m_id completion:^(BOOL result, NSArray *properties, NSError *error) {
            if (result) {
                if ([properties count]) {
                    
                    for(RgsPropertyObj *pro in properties)
                    {
                        if([pro.name isEqualToString:@"IP"])
                        {
                            block_self._driver_ip_Property = pro;
                            block_self._ipaddress = pro.value;
                        }
                    }
                }
            }
            else
            {
                
            }
        }];
    }
}

- (void) syncDriverComs{
    
    if(_comDriver
       && [_comDriver isKindOfClass:[RgsDriverObj class]]
       && ![_comConnections count])
    {
        IMP_BLOCK_SELF(VTouyingjiSet);
        
        RgsDriverObj *comd = _comDriver;
        [[RegulusSDK sharedRegulusSDK] GetDriverConnects:comd.m_id
                                              completion:^(BOOL result, NSArray *connects, NSError *error) {
                                                  if (result) {
                                                      if ([connects count]) {
                                                          
                                                          block_self._comConnections = connects;
                                                          NSMutableArray *coms = [NSMutableArray array];
                                                          for(int i = 0; i < [connects count]; i++)
                                                          {
                                                              RgsConnectionObj *obj = [connects objectAtIndex:i];
                                                              [coms addObject:obj.name];
                                                          }
                                                          
                                                          block_self._comArray = coms;
                                                      }
                                                  }
                                                  else
                                                  {
                                                      //[KVNProgress showErrorWithStatus:[error description]];
                                                  }
                                              }];
        
    }
    
    if(_driver
       && [_driver isKindOfClass:[RgsDriverObj class]]
       && ![_cameraConnections count])
    {
        IMP_BLOCK_SELF(VTouyingjiSet);
        
        RgsDriverObj *comd = _driver;
        [[RegulusSDK sharedRegulusSDK] GetDriverConnects:comd.m_id
                                              completion:^(BOOL result, NSArray *connects, NSError *error) {
                                                  if (result) {
                                                      if ([connects count]) {
                                                          
                                                          block_self._cameraConnections = connects;
                                                      }
                                                  }
                                                  else
                                                  {
                                                      //[KVNProgress showErrorWithStatus:[error description]];
                                                  }
                                              }];
        
    }
}

- (void) uploadDriverIPProperty
{
    if(_comDriver && [_comDriver isKindOfClass:[RgsDriverObj class]])
    {
        IMP_BLOCK_SELF(VTouyingjiSet);
        
        RgsDriverObj *rd = (RgsDriverObj*)_comDriver;
        
        //保存到内存
        _driver_ip_Property.value = self._ipaddress;
        
        [[RegulusSDK sharedRegulusSDK] SetDriverProperty:rd.m_id
                                           property_name:_driver_ip_Property.name
                                          property_value:self._ipaddress
                                              completion:^(BOOL result, NSError *error) {
                                                  if (result) {
                                                      
                                                      [block_self saveProject];
                                                  }
                                                  else{
                                                      
                                                  }
                                              }];
    }
}

- (void) saveProject{
    
    [KVNProgress show];
    
    [[RegulusSDK sharedRegulusSDK] ReloadProject:^(BOOL result, NSError *error) {
        if(result)
        {
            NSLog(@"reload project.");
            
            [KVNProgress showSuccess];
        }
        else{
            NSLog(@"%@",[error description]);
            
            [KVNProgress showSuccess];
        }
    }];
}

- (void) createDriver{
    
    RgsAreaObj *area = [DataSync sharedDataSync]._currentArea;
    
    //串口服务器驱动
    if(area && _comDriverInfo && !_comDriver)
    {
        RgsDriverInfo *info = _comDriverInfo;
        
        IMP_BLOCK_SELF(VTouyingjiSet);
        [[RegulusSDK sharedRegulusSDK] CreateDriver:area.m_id
                                             serial:info.serial
                                         completion:^(BOOL result, RgsDriverObj *driver, NSError *error) {
                                             if (result) {
                                                 
                                                 block_self._comDriver = driver;
                                             }
                                             
                                         }];
    }
    
    //Camera驱动
    if(area && _driverInfo && !_driver)
    {
        RgsDriverInfo *info = _driverInfo;
        
        IMP_BLOCK_SELF(VTouyingjiSet);
        [[RegulusSDK sharedRegulusSDK] CreateDriver:area.m_id
                                             serial:info.serial
                                         completion:^(BOOL result, RgsDriverObj *driver, NSError *error) {
                                             if (result) {
                                                 
                                                 block_self._driver = driver;
                                             }
                                             
                                         }];
    }
    
    
}

- (void) removeDriver{
    
    if(_comDriver)
    {
        RgsDriverObj *dr = _comDriver;
        [[RegulusSDK sharedRegulusSDK] DeleteDriver:dr.m_id
                                         completion:^(BOOL result, NSError *error) {
                                             
                                         }];
    }
    
    if(_driver)
    {
        RgsDriverObj *dr = _driver;
        [[RegulusSDK sharedRegulusSDK] DeleteDriver:dr.m_id
                                         completion:^(BOOL result, NSError *error) {
                                             
                                         }];
    }
    
    
}

- (void) createConnection{
    
    if([_comConnections count]
       && self._comIdx < [_comConnections count]
       && [_cameraConnections count])
    {
        
        RgsConnectionObj * com_connt_obj = [_comConnections objectAtIndex:self._comIdx];
        RgsConnectionObj * cam_connt_obj = [_cameraConnections objectAtIndex:0];
        
        [com_connt_obj Connect:cam_connt_obj completion:^(BOOL result, NSError *error) {
            if(result)
            {
                
            }
        }];
    }
}


- (NSString *)objectToJsonString{
    
    NSMutableDictionary *allData = [NSMutableDictionary dictionary];
    
    //基本信息
    if(self._brand)
        [allData setObject:self._brand forKey:@"brand"];
    
    if(self._type)
        [allData setObject:self._type forKey:@"type"];
    
    if(self._deviceno)
        [allData setObject:self._deviceno forKey:@"deviceno"];
    
    if(self._ipaddress)
        [allData setObject:self._ipaddress forKey:@"ipaddress"];
    
    if(self._deviceid)
        [allData setObject:self._deviceid forKey:@"deviceid"];
    
    if(self._driverUUID)
        [allData setObject:self._driverUUID forKey:@"driverUUID"];
    
    if(self._comIdx)
        [allData setObject:[NSString stringWithFormat:@"%d",self._comIdx] forKey:@"com"];
    
    [allData setObject:[NSString stringWithFormat:@"%d",self._index] forKey:@"index"];
    
    
    if(_driverInfo)
    {
        RgsDriverInfo *info = _driverInfo;
        [allData setObject:info.serial forKey:@"driver_info_uuid"];
    }
    if(_driver)
    {
        RgsDriverObj *dr = _driver;
        [allData setObject:[NSNumber numberWithInteger:dr.m_id] forKey:@"driver_id"];
    }
    if(_comDriverInfo)
    {
        RgsDriverInfo *info = _comDriverInfo;
        [allData setObject:info.serial forKey:@"com_driver_info_uuid"];
    }
    if(_comDriver)
    {
        RgsDriverObj *dr = _comDriver;
        [allData setObject:[NSNumber numberWithInteger:dr.m_id] forKey:@"com_driver_id"];
    }
    
    if(_proxyObj)
    {
        VProjectProxys *vprj = _proxyObj;
        
        if(vprj._deviceId)
        {
            NSMutableArray *commands = [NSMutableArray array];
            NSMutableDictionary *cmdDic = [NSMutableDictionary dictionary];
            [commands addObject:cmdDic];
            
            [cmdDic setObject:[NSNumber numberWithInteger:vprj._deviceId] forKey:@"proxy_id"];
            [cmdDic setObject:vprj._power forKey:@"power"];
            [cmdDic setObject:vprj._input forKey:@"input"];
            
            [allData setObject:commands forKey:@"commands"];
        }
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error: &error];
    
    NSString *jsonresult = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    
    return jsonresult;
}


@end