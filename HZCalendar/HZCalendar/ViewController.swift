//
//  ViewController.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/7.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var firstWeekdayThisMonth: UILabel!
    
    @IBOutlet weak var lastDate: UILabel!
    
    @IBOutlet weak var nextDate: UILabel!
    
    @IBOutlet weak var lastMonthDate: UILabel!
    
    @IBOutlet weak var nextMonthDate: UILabel!
    
    @IBOutlet weak var totaldaysLabel: UILabel!
    var dateFormatter : DateFormatter = DateFormatter()
    var subDayCount: Int = 1
    var addDayCount: Int = 1
    var date: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateField.delegate = self
    }
    func getDateStringFromDate(date: Date) -> String{
       return self.dateFormatter.string(from: date)
    }
    func getDateFromStrin(dateStr: String) -> Date{
        return self.dateFormatter.date(from: dateStr) ?? Date()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard textField.text?.count ?? 0 > 0 else {return}
        
        let date = self.getDateFromStrin(dateStr: textField.text ?? "")
        //该月第一天
        self.firstWeekdayThisMonth.text = "\(date.firstWeekdayInMonth)"
        self.totaldaysLabel.text = "\(date.totalDaysInthisMonth)"
        self.date = date
        
        self.addDayCount = 1
        self.subDayCount = 1
        
        self.lastMonthDate.text = nil
        self.lastDate.text = nil
        self.nextMonthDate.text = nil
        self.nextDate.text = nil
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dateField.resignFirstResponder()
    }
    
   
    @IBAction func lastDayClick(_ sender: Any) {
        guard self.dateField.text?.count ?? 0 > 0 else {return}
        let lastDate = self.getLastDay(pading: -self.subDayCount)
        self.subDayCount = self.subDayCount + 1
        self.lastDate.text = self.getDateStringFromDate(date:lastDate)
    }
    
    @IBAction func nextDayClick(_ sender: Any) {
        guard self.dateField.text?.count ?? 0 > 0 else {return}
        let nextDate = self.getLastDay(pading: self.addDayCount)
        self.addDayCount = self.addDayCount + 1
        self.nextDate.text = self.getDateStringFromDate(date:nextDate)
    }
    
    
    @IBAction func lastMonthClick(_ sender: Any) {
        guard self.dateField.text?.count ?? 0 > 0 else {return}
        let lastDate = self.getDateFromStrin(dateStr: self.dateField.text ?? "").lastMonth
        self.lastMonthDate.text = self.getDateStringFromDate(date:lastDate)
    }
    
    @IBAction func nextMonthClick(_ sender: Any) {
        guard self.dateField.text?.count ?? 0 > 0 else {return}
        let lastDate = self.getDateFromStrin(dateStr: self.dateField.text ?? "").nextMonth
        self.nextMonthDate.text = self.getDateStringFromDate(date:lastDate)
    }
    
    func getLastDay(pading: Int) -> Date{
        var dateComponets = DateComponents()
        dateComponets.day = pading
        let newDate = Calendar.current.date(byAdding: dateComponets, to: self.date)
        return newDate ?? Date()
    }
    
    
    @IBAction func calendarViewClick(_ sender: Any) {
        self.navigationController?.pushViewController(HZCalendarController(), animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

