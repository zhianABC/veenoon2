/*!
 @header RegulusSDK.h
 @brief  RegulusSDK主要API 头文件信息
 @discussion
    API为RgsAreaObj、RgsDriverObj、RgsConnectionObj提供查、增、删、减、改的方法。
 以及登录、登出、修改密码、新建工程、执行工程、编辑场景等方法。
    API包含工程配置接口、用户日常使用接口这两部分。但不作严格区分，
 以方便二次开发者根据实际方便调用。
    本API提供接口供开发人员使用，二次开发人员应根据APP实际应用，去区分用户的使用权限。
 建议至少区分两个种权限。工程人员、用户。
 用户一般不需要关心RgsDriverObj,RgsConnectionObj这类和工程配置的类和方法。
 
 @author zongtai.ye
 @copyright © 2017年 zongtai.ye.
 @version 17.12.21
 */

#import <Foundation/Foundation.h>
#include "RgsConstants.h"
#import "RgsDeviceNoteObj.h"
#import "RgsSceneObj.h"
#import "RgsAreaObj.h"
#import "RgsSceneDeviceOperation.h"
#import "RgsCommandInfo.h"
#import "RgsCommandParamInfo.h"
#import "RgsSchedulerObj.h"
#import "RgsDriverObj.h"
#import "RgsDriverInfo.h"
#import "RgsProxyObj.h"
#import "RgsEventObj.h"
#import "RgsConnectionObj.h"
#import "RgsPropertyObj.h"
#import "RgsProxyStateInfo.h"


@protocol RegulusSDKDelegate <NSObject>
@required -(void) onConnectChanged:(BOOL)connect;
@required -(void) onRecvDeviceNotify:(RgsDeviceNoteObj *) notify;
@optional -(void) onDowningTopology:(float) persen;
@optional -(void) onDownDoneTopology;
@end

@interface RegulusSDK : NSObject
@property (nonatomic,assign) id<RegulusSDKDelegate> delegate;
+(RegulusSDK *) sharedRegulusSDK;

/*!
   @since 1.0.0
   @brief 获取SDK版本号
   @return 版本号
 */
+(NSString *) GetVersion;

/*!
   @since 1.0.0
   @brief 登录网关
   @discussion 登录目标中控。调用本函数后，SDK获取会话句柄。
   @param user_id  网关分配的客户ID
   @param gw_id    网关ID
   @param password 一级密码
   @param level    登录等级,为1时需要验证一级密码 为0时不验证密码
   @param completion 回调block，正常时返回登录结果(result)以及登录等级(level)
 */
-(void) Login:(NSString *)user_id
        gw_id:(NSString *)gw_id
     password:(NSString *)password
        level:(int)level
   completion:(void(^)(BOOL result,NSInteger level,NSError * error)) completion;


/*!
   @since 1.0.0
   @brief 登出网关
   @discussion 登出中控，调用本函数后，SDK销毁会话句柄。
   @param user_id  网关分配的客户ID
   @param gw_id    网关ID
   @param completion 回调block，正常时返回登出结果(result)
 */
-(void) Logout:(NSString *)user_id gw_id:(NSString *)gw_id
    completion:(void(^)(BOOL result,NSError * error)) completion;


/*!
   @since 1.0.0
   @brief 设置一级密码
 
   @param user_id  网关分配的客户ID
   @param old_ps   原来密码
   @param new_ps   新密码
   @param completion 回调block，正常时返回登出结果(result)
 */
-(void)SetPassword:(NSString *)user_id
            old_ps:(NSString *)old_ps
            new_ps:(NSString *)new_ps
        completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 1.0.0
   @brief 获取区域对象
   @param completion 回调block，正常时返回RgsAreaObj对象数组
   @see RgsAreaObj
 */
-(void) GetAreas:(void(^)(NSArray *AreaObjs,NSError * error)) completion;

/*!
   @since 1.0.0
   @brief 控制设备
 
   @param dev_id     待控设备ID
   @param cmd        控制命令
   @param param      控制参数
   @param completion 回调block，正常时返回YES
   @see RgsDeviceObj
 */
-(void) ControlDevice:(unsigned long)dev_id
                  cmd:(NSString *)cmd
                param:(NSDictionary *)param
           completion:(void(^)(BOOL result,NSError * error)) completion;


/*!
   @since 1.0.0
   @brief 执行情景
 
   @param scene_id     待控情景ID
   @param completion 回调block，正常时返回YES
   @see RgsSceneObj
 */
-(void) ExecScene:(unsigned long)scene_id
       completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
 @since 3.3.1
 @brief 向网关添加用户请求
 @discussion APP在首次登录中控前，应该先向该中控调用本函数申请。获取中控返回的可用客户ID。APP开发者应保存中控返回的客户ID以方便登录使用。
 @param gw_id    网关ID 扫描二维码获取中控设备ID
 @param completion 回调block，result:添加结果,client_id: 登陆使用的ID
 */
-(void)RequestJoinGateWay:(NSString *)gw_id completion:(void (^)(BOOL result,NSString * client_id,NSError * error))completion;

/*!
   @since 3.0.0
   @brief 新建工程
   @param author           创建者
   @param completion       回调block 正常时返回YES
 */
-(void)NewProject:(NSString *)author completion:(void(^)(BOOL result,NSError * error)) completion;


/*!
   @since 3.0.0
   @brief 创建区域
   @param name         区域名称
   @param completion   回调block 正常时返回YES area:新建区域对象
   @see RgsAreaObj
 */
-(void)CreateArea:(NSString *)name
       completion:(void(^)(BOOL result,RgsAreaObj * area,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 修改区域名字
   @param name         区域名称
   @param completion       回调block 正常时返回YES
   @see RgsAreaObj
 */
-(void)RenameArea:(NSInteger) area_id
             name:(NSString *)name
       completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 删除区域
   @param area_id         区域ID
   @param completion      回调block 正常时返回YES
   @see RgsAreaObj
 */
-(void)DeleteArea:(NSInteger) area_id
       completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 3.2.1
   @brief 查询区域场景
   @param area_id         区域ID
   @param completion      回调block 正常时返回YES scene为RgsSceneObj列表
   @see RgsSceneObj
 */
-(void)GetAreaScenes:(NSInteger)area_id
          completion:(void(^)(BOOL result,NSArray * scenes,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 添加设备驱动
   @param area_id         所在区域id
   @param serial          驱动序列
   @param completion      回调block 正常时返回YES driver 添加的驱动对象
   @see RgsDriverObj
 */
-(void)CreateDriver:(NSInteger)area_id
             serial:(NSString *)serial
         completion:(void(^)(BOOL result,RgsDriverObj * driver ,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 删除设备驱动
   @param driver_id       驱动id
   @param completion      回调block 正常时返回YES
   @see RgsDriverObj
 */
-(void)DeleteDriver:(NSInteger)driver_id
         completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 修改设备驱动名字
   @param driver_id       驱动 id
   @param name            驱动名字
   @param completion      回调block 正常时返回YES
   @see RgsDriverObj
 */
-(void)RenameDriver:(NSInteger)driver_id
              name:(NSString *)name
        completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 修改设备驱动参数
   @param driver_id       驱动 id
   @param property_name   参数名称
   @param property_value  参数值
   @param completion      回调block 正常时返回YES
   @see RgsDriverObj
   @see RgsPropertyObj
 */
-(void)SetDriverProperty:(NSInteger)driver_id
           property_name:(NSString *)property_name
          property_value:(NSString *)property_value
              completion:(void(^)(BOOL result,NSError * error)) completion;

/*!
   @since 3.0.0
   @brief 查询区域设备驱动
   @param area_id       区域id
   @param completion      回调block 正常时返回YES drivers:RgsDriverObj列表
   @see RgsDriverObj
 */
-(void)GetDrivers:(NSInteger)area_id
       completion:(void(^)(BOOL result,NSArray * drivers,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询区域代理
 @param area_id    区域ID
 @param completion      回调block 正常时返回YES proxys:RgsProxyObj列表
 @see RgsProxyObj
 */
-(void)GetAreaProxys:(NSInteger)area_id completion:(void(^)(BOOL result,NSArray * proxys,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备驱动代理
 @param driver_id    设备ID
 @param completion      回调block 正常时返回YES proxys:RgsProxyObj列表
 @see RgsProxyObj
 */
-(void)GetDriverProxys:(NSInteger)driver_id completion:(void(^)(BOOL result,NSArray * proxys,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备驱动命令
 @param driver_id    设备ID
 @param completion   回调block 正常时返回YES commands:RgsCommandInfo列表
 @see RgsCommandInfo
 */
-(void)GetDriverCommands:(NSInteger)driver_id completion:(void(^)(BOOL result,NSArray * commands,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备驱动参数
 @param driver_id    设备ID
 @param completion   回调block 正常时返回YES properties:RgsPropertyObj列表
 @see RgsPropertyObj
 */
-(void)GetDriverProperties:(NSInteger)driver_id completion:(void(^)(BOOL result,NSArray * properties,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备驱动事件
 @param driver_id    设备ID
 @param completion   回调block 正常时返回YES events:RgsEventObj列表
 @see RgsEventObj
 */
-(void)GetDriverEvents:(NSInteger)driver_id completion:(void(^)(BOOL result,NSArray * events,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备驱动连接
 @param driver_id    设备ID
 @param completion   回调block 正常时返回YES connects:RgsConnectionObj列表
 @see RgsConnectionObj
 */
-(void)GetDriverConnects:(NSInteger)driver_id completion:(void(^)(BOOL result,NSArray * connects,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备代理命令
 @param proxy_id     代理ID
 @param completion   回调block 正常时返回YES commands:RgsCommandInfo列表
 @see RgsCommandInfo
 */
-(void)GetProxyCommands:(NSInteger)proxy_id completion:(void(^)(BOOL result,NSArray * commands,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备代理事件
 @param proxy_id     代理ID
 @param completion   回调block 正常时返回YES events:RgsEventObj列表
 @see RgsEventObj
 */
-(void)GetProxyEvents:(NSInteger)proxy_id completion:(void(^)(BOOL result,NSArray * events,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备代理状态信息对象
 @param proxy_id     代理ID
 @param completion   回调block 正常时返回YES stateInfos:RgsProxyStateInfo列表
 @see RgsProxyStateInfo
 */
-(void)GetProxyStateInfos:(NSInteger)proxy_id completion:(void(^)(BOOL result,NSArray * stateInfos,NSError * error)) completion;

/*!
 @since 3.2.1
 @brief 查询设备代理当前状态
 @param proxy_id     代理ID
 @param completion   回调block 正常时返回YES state:当前状态
 */
-(void)GetProxyCurState:(NSInteger)proxy_id completion:(void(^)(BOOL result,NSDictionary * state,NSError * error)) completion;


/*!
   @since 3.0.0
   @brief 修改代理名字
   @param proxy_id        代理id
   @param name            代理名字
   @param completion      回调block 正常时返回YES
   @see RgsProxyObj
 */
-(void)RenameProxy:(NSInteger)proxy_id
              name:(NSString *)name
        completion:(void(^)(BOOL result,NSError * error)) completion;


/*!
   @since 3.0.0
   @brief 请求设备驱动信息
   @param completion      回调block 正常时返回YES driver_infos为RgsDriverInfo列表
   @see RgsDriverInfo
 */
-(void)RequestDriverInfos:(void(^)(BOOL result,NSArray * driver_infos,NSError * error)) completion;


/*!
   @since 3.0.0
   @brief 设置事件操作
   @param evt_obj         事件对象
   @param operation       RgsSceneOperation 对象列表
   @param completion      回调block 正常时返回YES
   @see RgsEventObj
   @see RgsSceneOperation
 */
-(void)SetEventOperatons:(RgsEventObj *) evt_obj
               operation:(NSArray *)operation
              completion:(void(^)(BOOL result,NSError * error)) completion;


/*!
   @since 3.0.0
   @brief 查询事件操作
   @param evt_obj         事件对象
   @param completion      回调block 正常时返回YES operatins operations为 RgsSceneOperation对象列表
   @see RgsEventObj
   @see RgsSceneOperation
 */
-(void)GetEventOperations:(RgsEventObj *) evt_obj
               completion:(void(^)(BOOL result,NSArray * operatins,NSError * error)) completion;


/*!
 @since 3.0.0
 @brief 获取系统类型驱动
 @param completion 回调block 正常时返回YES drivers为RgsDriverObj对象列表
 @see RgsDriverObj
 */
-(void)GetSystemDrivers:(void(^)(BOOL result,NSArray * drivers,NSError * error)) completion;

///*!
// @since 3.0.0
// @brief 重新加载工程
// @param completion       回调block 正常时返回YES
// */
//-(void)ReloadProject:(void(^)(BOOL result,NSError * error)) completion;

@end



