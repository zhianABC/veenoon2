//
//  VAProcessorProxys.m
//  veenoon
//
//  Created by chen jack on 2018/5/4.
//  Copyright © 2018年 jack. All rights reserved.
//

#import "VAProcessorProxys.h"
#import "RegulusSDK.h"
#import "KVNProgress.h"

/*
 SET_MUTE
 SET_UNMUTE
 SET_DIGIT_MUTE | options [True, False]
 SET_DIGIT_GRAIN
 SET_ANALOGY_GRAIN
 SET_INVERTED
 SET_MODE     | options [LINE, MIC]
 SET_MIC_DB   | options [.....]
 SET_48V      | ENABLE
 SET_NOISE_GATE
 SET_FB_CTRL
 SET_PRESS_LIMIT
 SET_DELAY
 SET_HIGH_FILTER
 SET_LOW_FILTER
 SET_PEQ
 */

@interface VAProcessorProxys ()
{
    float _voiceDb;
    BOOL _isMute;
    BOOL _isDigitalMute;
    float _digitalGain;
    
    BOOL _inverted;
    
    
    BOOL _isSetOK;
}
@property (nonatomic, strong) NSArray *_rgsCommands;
@property (nonatomic, strong) NSMutableDictionary *_cmdMap;

@property (nonatomic, strong) NSMutableDictionary *_RgsSceneDeviceOperationShadow;


@end

@implementation VAProcessorProxys
@synthesize _icon_name;
@synthesize _voiceInDevice;

@synthesize _rgsCommands;
@synthesize _rgsProxyObj;
@synthesize _cmdMap;

@synthesize _mode;
@synthesize _is48V;
@synthesize _micDb;

@synthesize _RgsSceneDeviceOperationShadow;

- (id) init
{
    if(self = [super init])
    {
        _isMute = NO;
        _isDigitalMute = NO;
        _voiceDb = 0;
        _digitalGain = 0;
        
        _inverted = NO;
        self._is48V = NO;
        self._micDb = @"0db";
        
        self._mode = @"LINE"; //LINE or MIC
        
        self._icon_name = nil;
        
        _isSetOK = NO;
        
        self._RgsSceneDeviceOperationShadow = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSDictionary *)getScenarioSliceLocatedShadow{
    
    return _RgsSceneDeviceOperationShadow;
}

- (void) recoverWithDictionary:(NSDictionary *)data
{
    NSInteger proxy_id = [[data objectForKey:@"proxy_id"] integerValue];
    
    if(!_rgsProxyObj || (_rgsProxyObj && (proxy_id == _rgsProxyObj.m_id)))
    {
        self._icon_name = [data objectForKey:@"icon_name"];
        
        self._voiceInDevice = [data objectForKey:@"voiceInDevice"];
        
        _voiceDb = [[data objectForKey:@"analogy_gain"] floatValue];
        _isMute = [[data objectForKey:@"analogy_mute"] boolValue];
        
        _digitalGain = [[data objectForKey:@"digital_gain"] floatValue];
        _isDigitalMute = [[data objectForKey:@"digital_mute"] boolValue];
        
        self._mode = [data objectForKey:@"mode"];
        self._micDb = [data objectForKey:@"mic_db"];
        
        _is48V = [[data objectForKey:@"48v"] boolValue];
        
        _inverted = [[data objectForKey:@"inverted"] boolValue];
        
        
        
        
        if([data objectForKey:@"RgsSceneDeviceOperation"]){
            self._RgsSceneDeviceOperationShadow = [data objectForKey:@"RgsSceneDeviceOperation"];
            _isSetOK = YES;
        }

    }
}

- (NSArray*)getModeOptions{

    RgsCommandInfo *cmd = nil;
    cmd = [_cmdMap objectForKey:@"SET_MODE"];
    if(cmd)
    {
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                return param_info.available;
            }
            
        }
    }
    
    return nil;
}

- (NSArray*)getMicDbOptions{
    
    RgsCommandInfo *cmd = nil;
    cmd = [_cmdMap objectForKey:@"SET_MIC_DB"];
    if(cmd)
    {
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                return param_info.available;
            }
            
        }
    }
    
    return nil;
}

- (BOOL) isProxyMute{
    
    return _isMute;
}
- (BOOL) isProxyDigitalMute{
    
    return _isDigitalMute;
}
- (float) getDigitalGain{

    return _digitalGain;
}

- (float) getAnalogyGain{
    
    return _voiceDb;
}

- (BOOL) getInverted{
    
    return _inverted;
}

- (BOOL) isSetChanged{
    
    return _isSetOK;
}

- (void) checkRgsProxyCommandLoad{
    
    if(_rgsProxyObj == nil || _rgsCommands)
        return;
    
    self._cmdMap = [NSMutableDictionary dictionary];
    
    IMP_BLOCK_SELF(VAProcessorProxys);
    
    [[RegulusSDK sharedRegulusSDK] GetProxyCommands:_rgsProxyObj.m_id completion:^(BOOL result, NSArray *commands, NSError *error) {
        if (result)
        {
            if ([commands count]) {
                
                block_self._rgsCommands = commands;
                for(RgsCommandInfo *cmd in commands)
                {
                    [block_self._cmdMap setObject:cmd forKey:cmd.name];
                }
                
                _isSetOK = YES;
            }
        }
        else
        {
            NSString *errorMsg = [NSString stringWithFormat:@"%@ - proxyid:%d",
                               [error description], (int)_rgsProxyObj.m_id];
            
            [KVNProgress showErrorWithStatus:errorMsg];
        }
       
    }];
}



//SET_ANALOGY_GRAIN
- (void) controlDeviceDb:(float)db force:(BOOL)force{
    
//    if(!force)
//    {
//        int iv = _voiceDb;
//        int now = db;
//        
//        if(iv == now)
//            return;
//    }
    _voiceDb = db;
    
    RgsCommandInfo *cmd = [_cmdMap objectForKey:@"SET_ANALOGY_GRAIN"];
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_FLOAT)
            {
                [param setObject:[NSString stringWithFormat:@"%0.1f",_voiceDb]
                          forKey:param_info.name];
            }
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
            if (result) {
                
            }
            else{
                
            }
        }];
    }
}

- (void) controlDeviceDigitalGain:(float)digVal{
    
    _digitalGain = digVal;
    
    RgsCommandInfo *cmd = [_cmdMap objectForKey:@"SET_DIGIT_GRAIN"];
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_FLOAT)
            {
                [param setObject:[NSString stringWithFormat:@"%0.1f",digVal]
                          forKey:param_info.name];
            }
            else if(param_info.type == RGS_PARAM_TYPE_INT)
            {
                [param setObject:[NSString stringWithFormat:@"%0.0f",digVal]
                          forKey:param_info.name];
            }
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}
- (void) controlDeviceMute:(BOOL)isMute{
    
    RgsCommandInfo *cmd = nil;
    if(isMute)
    {
        cmd = [_cmdMap objectForKey:@"SET_MUTE"];
        
        _isMute = YES;
    }
    else
    {
        cmd = [_cmdMap objectForKey:@"SET_UNMUTE"];
        
        _isMute = NO;
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (void) controlInverted:(BOOL)invert{
    
    RgsCommandInfo *cmd = nil;
    cmd = [_cmdMap objectForKey:@"SET_INVERTED"];
    NSString* tureOrFalse = @"False";
    if(invert)
    {
        tureOrFalse = @"True";
        _inverted = YES;
    }
    else
    {
        tureOrFalse = @"False";
        _inverted = NO;
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        
        
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
            
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (void) controlDigtalMute:(BOOL)isMute{
    
    RgsCommandInfo *cmd = nil;
    cmd = [_cmdMap objectForKey:@"SET_DIGIT_MUTE"];
    NSString* tureOrFalse = @"False";
    if(isMute)
    {
        tureOrFalse = @"True";
        _isDigitalMute = YES;
    }
    else
    {
        tureOrFalse = @"False";
        _isDigitalMute = NO;
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        
        
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
           
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (void) control48V:(BOOL)is48v{
    
    RgsCommandInfo *cmd = nil;
    cmd = [_cmdMap objectForKey:@"SET_48V"];
    NSString* tureOrFalse = @"False";
    
    self._is48V = is48v;
    
    if(_is48V)
    {
        tureOrFalse = @"True";
    }
    else
    {
        tureOrFalse = @"False";
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        
        
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
            
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (void) controlDeviceMode:(NSString*)mode{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_MODE"];
    self._mode = mode;
    
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:mode forKey:param_info.name];
            }
            
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (void) controlDeviceMicDb:(NSString*)db{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_MIC_DB"];
    self._micDb = db;
    
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:_micDb forKey:param_info.name];
            }
            
        }
        [[RegulusSDK sharedRegulusSDK] ControlDevice:_rgsProxyObj.m_id
                                                 cmd:cmd.name
                                               param:param completion:^(BOOL result, NSError *error) {
                                                   if (result) {
                                                       
                                                   }
                                                   else{
                                                       
                                                   }
                                               }];
    }
}

- (id) generateEventOperation_AnalogyGain
{
    RgsCommandInfo *cmd = nil;
    if(_cmdMap)
    {
        cmd = [_cmdMap objectForKey:@"SET_ANALOGY_GRAIN"];
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_FLOAT)
            {
                [param setObject:[NSString stringWithFormat:@"%0.1f",_voiceDb]
                          forKey:param_info.name];
            }
        }
        
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_ANALOGY_GRAIN"];

        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_ANALOGY_GRAIN"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}
- (id) generateEventOperation_Mute{
    
    RgsCommandInfo *cmd = nil;
    NSString *cmd_name = nil;
    if(_cmdMap)
    {
        if(_isMute)
        {
            cmd_name = @"SET_MUTE";
        }
        else
        {
            cmd_name = @"SET_UNMUTE";
        }
        
        cmd = [_cmdMap objectForKey:cmd_name];
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:cmd_name];
        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:cmd_name];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}

- (id) generateEventOperation_DigitalGain
{
    RgsCommandInfo *cmd = nil;
   
    if(_cmdMap)
        cmd = [_cmdMap objectForKey:@"SET_DIGIT_GRAIN"];
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_FLOAT)
            {
                [param setObject:[NSString stringWithFormat:@"%0.1f",_digitalGain]
                          forKey:param_info.name];
            }
        }
        
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_DIGIT_GRAIN"];
        
        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_DIGIT_GRAIN"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}

- (id) generateEventOperation_DigitalMute{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_DIGIT_MUTE"];
    NSString* tureOrFalse = @"False";
    if(_isDigitalMute)
    {
        tureOrFalse = @"True";
    }
    else
    {
        tureOrFalse = @"False";
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];

        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
            
        }
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_DIGIT_MUTE"];
        
        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_DIGIT_MUTE"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}
- (id) generateEventOperation_Mode{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_MODE"];

    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:_mode forKey:param_info.name];
            }
            
        }
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_MODE"];
        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_MODE"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}

- (id) generateEventOperation_MicDb{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_MIC_DB"];
    
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:_micDb forKey:param_info.name];
            }
            
        }
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_MIC_DB"];

        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_MIC_DB"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}
- (id) generateEventOperation_48v{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
    cmd = [_cmdMap objectForKey:@"SET_48V"];
    
    NSString* tureOrFalse = @"False";
    if(_is48V)
    {
        tureOrFalse = @"True";
    }
    else
    {
        tureOrFalse = @"False";
    }
 
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
            
        }
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_48V"];
        

        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_48V"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}

- (id) generateEventOperation_Inverted{
    
    RgsCommandInfo *cmd = nil;
    
    if(_cmdMap)
        cmd = [_cmdMap objectForKey:@"SET_INVERTED"];
    
    NSString* tureOrFalse = @"False";
    if(_inverted)
    {
        tureOrFalse = @"True";
    }
    else
    {
        tureOrFalse = @"False";
    }
    if(cmd)
    {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        
        
        if([cmd.params count])
        {
            RgsCommandParamInfo * param_info = [cmd.params objectAtIndex:0];
            if(param_info.type == RGS_PARAM_TYPE_LIST)
            {
                [param setObject:tureOrFalse forKey:param_info.name];
            }
            
        }
        RgsSceneDeviceOperation * scene_opt = [[RgsSceneDeviceOperation alloc]init];
        scene_opt.dev_id = _rgsProxyObj.m_id;
        scene_opt.cmd = cmd.name;
        scene_opt.param = param;
        
        //用于保存还原
        NSMutableDictionary *slice = [NSMutableDictionary dictionary];
        [slice setObject:[NSNumber numberWithInteger:_rgsProxyObj.m_id] forKey:@"dev_id"];
        [slice setObject:cmd.name forKey:@"cmd"];
        [slice setObject:param forKey:@"param"];
        [_RgsSceneDeviceOperationShadow setObject:slice forKey:@"SET_INVERTED"];

        
        RgsSceneOperation * opt = [[RgsSceneOperation alloc] initCmdWithParam:scene_opt.dev_id
                                                                          cmd:scene_opt.cmd
                                                                        param:scene_opt.param];
        
        return opt;
    }
    else
    {
        NSDictionary *cmdsRev = [_RgsSceneDeviceOperationShadow objectForKey:@"SET_INVERTED"];
        if(cmdsRev)
        {
            RgsSceneOperation * opt = [[RgsSceneOperation alloc]
                                       initCmdWithParam:[[cmdsRev objectForKey:@"dev_id"] integerValue]
                                       cmd:[cmdsRev objectForKey:@"cmd"]
                                       param:[cmdsRev objectForKey:@"param"]];
            
            return opt;
        }
    }
    return nil;
}

@end
