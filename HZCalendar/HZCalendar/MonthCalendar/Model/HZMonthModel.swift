//
//  HZMonthModel.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/8.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZMonthModel: NSObject {
    var year: Int = 0
    var month: Int = 0
    var firstWeekDay: Int = 0 //第一天是礼拜几
    var totalDays: Int = 0
    var date: Date
    init(date: Date){
        self.date = date
        self.firstWeekDay = date.firstWeekdayInMonth
        self.year = date.year
        self.month = date.month
        self.totalDays = date.totalDaysInthisMonth
    }
}
