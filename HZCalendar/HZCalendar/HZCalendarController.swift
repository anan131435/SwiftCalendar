//
//  HZCalendarController.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/8.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZCalendarController: UIViewController {
    var calendarView: HZCalendarView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.calendarView = HZCalendarView.init(frame: self.view.bounds)
        self.calendarView?.setupDataSource()
        self.view.addSubview(self.calendarView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
