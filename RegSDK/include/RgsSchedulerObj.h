/*!
 @header RgsSchedulerObj.h
 @brief  日程预约对象 头文件信息
 这个文件包含日程预约对象的主要方法和属性声明
 
 @author zongtai.ye
 @copyright © 2017年 zongtai.ye.
 @version 17.12.21
 */

#import <Foundation/Foundation.h>
#include "RgsConstants.h"

/*!
 @class RgsSchedulerObj
 @since 3.0.0
 @brief 日程预约对象
 */

@interface RgsSchedulerObj : NSObject

/*!
 日程id
 */
@property NSInteger m_id;

/*!
 关联情景id
 */
@property NSInteger scene_id;

/*!
 起始日期
 */
@property NSDate * start_date;

/*!
 执行时间
 */
@property NSDate * exce_time;

/*!
 结束日期
 */
@property NSDate * end_date;

/*!
 重复类型
 */
@property RgsFrequencyType frequency_type;

/*!
 重复频率
 */
@property NSInteger rate;

/*!
 周重复掩码
 */
@property NSInteger mask;

@end
