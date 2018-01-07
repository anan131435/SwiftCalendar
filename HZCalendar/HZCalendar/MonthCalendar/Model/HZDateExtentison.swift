//
//  DateExtentison.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/7.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import Foundation
extension Date{
    //获得日历拆分组件 DateComponents 传入不同属性可以直接拿到日期的  year month day etc
    func components(date: Date) -> DateComponents{
        let calendar = Calendar.current
        let componentsSet = Set<Calendar.Component>([.year,.month,.day,.hour,.minute,.second,.weekday])
        let components = calendar.dateComponents(componentsSet, from: date)
        return components
        
    }
    var  year: Int{
        return self.components(date: self).year ?? 0
    }
    var month: Int{
        return self.components(date: self).month ?? 0
    }
    var day: Int{
        return self.components(date: self).day ?? 0
    }
    var weekday: Int{
        return self.components(date: self).weekday ?? 0
    }
    
    //获得当前日期所在月份第一天是礼拜几
    var  firstWeekdayInMonth: Int{
        var calendar = Calendar.current
        let componentsSet = Set<Calendar.Component>([.year,.month,.day])
        var  components = calendar.dateComponents(componentsSet, from: self)
        calendar.firstWeekday = 1
        components.day = 1
        let first = calendar.date(from: components) ?? Date()
        let firstWeekDay = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: first) ?? 0
        return firstWeekDay - 1
    }
    //该月所有的天数
    var totalDaysInthisMonth: Int{
        let totalDays = Calendar.current.range(of: .day, in: .month, for: self)
        return totalDays?.count ?? 0
    }
    var totalDayInthisYear: Int{
        let totalDays = Calendar.current.range(of: .day, in: .year, for: self)
        return totalDays?.count ?? 0
    }
    //获取上一个月日期
    var lastMonth: Date{
        var dateComponets = DateComponents()
        dateComponets.month = -1
        let newDate = Calendar.current.date(byAdding: dateComponets, to: self)
        return newDate ?? Date()
    }
    //获取下一个月日期
    var nextMonth: Date{
        var dateComponets = DateComponents()
        dateComponets.month = 1
        let newDate = Calendar.current.date(byAdding: dateComponets, to: self)
        return newDate ?? Date()
    }
    //获取上一天日期
    var lastDay: Date{
        var dateComponets = DateComponents()
        dateComponets.day = -1
        let newDate = Calendar.current.date(byAdding: dateComponets, to: self)
        return newDate ?? Date()
    }
    //获取下一天日期
    var nextDay: Date{
        var dateComponets = DateComponents()
        dateComponets.day = 1
        let newDate = Calendar.current.date(byAdding: dateComponets, to: self)
        return newDate ?? Date()
    }
    
}
