//
//  HZDayModel.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/8.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZDayModel: NSObject {
    var day: Int = 0
    var month: Int = 0
    var year: Int = 0
    var totalDays: Int = 0 //该月的天数
    var isToday: Bool = false
    var isNextMonth: Bool = false //是否是下个月的日期
    var isLastMonth: Bool = false //是否是上个月的日期
    var isCurrentMonth: Bool = false //是否是当前月的日期
    var isSelected: Bool = false
}
