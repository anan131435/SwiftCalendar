//
//  HZCalendarView.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/8.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZCalendarView: UIView {
    let itemWidth: CGFloat = kScreenWidth / 7
    let itemHeight: CGFloat = 50
    var collectionView: UICollectionView?
    var dayModelsArray: [HZDayModel] = Array()
    var currentDate: Date = Date()
    var titleView: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatSubViews(){
        self.titleView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: itemHeight))
        self.titleView?.textAlignment = .center
        self.titleView?.textColor = UIColor.black
        self.addSubview(self.titleView!)
        
        let weekTitles: [String] = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        for i in 0..<weekTitles.count{
            let lable: UILabel = UILabel.init(frame: CGRect.init(x: CGFloat(i) * itemWidth , y: itemHeight, width: itemWidth, height: itemHeight))
            lable.textAlignment = .center
            lable.text = weekTitles[i]
            lable.textColor = UIColor.gray
            self.addSubview(lable)
        }
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: (itemHeight + itemHeight), width: kScreenWidth, height: CGFloat(6) * itemHeight), collectionViewLayout: flowLayout)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.scrollsToTop = true
        self.collectionView?.isScrollEnabled = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.addSubview(self.collectionView!)
        
    }
    func setupDataSource(){
        self.handleData()
    }
    func handleData(){
        self.dayModelsArray.removeAll()
        let lastMonthDate: Date = self.currentDate.lastMonth
        let currentMonthModel: HZMonthModel = HZMonthModel.init(date: self.currentDate)
        let lastMonthModel: HZMonthModel = HZMonthModel.init(date: lastMonthDate)
        self.titleView?.text = "\(currentMonthModel.year)年 \(currentMonthModel.month)月"
        let totalDays: Int = lastMonthModel.totalDays
        let firstWeekDay: Int = lastMonthModel.firstWeekDay
        
        for i in 0..<42{
            let dayModel = HZDayModel.init()
            dayModel.totalDays = totalDays
            dayModel.month = currentMonthModel.month
            dayModel.year = currentMonthModel.year
            //上个月日期
            if i < firstWeekDay{
                dayModel.day = lastMonthModel.totalDays - (firstWeekDay - i) + 1
                dayModel.isLastMonth = true
            }
            //当月日期
            if (i >= firstWeekDay  &&  i < (firstWeekDay + totalDays)){
                dayModel.day = i - firstWeekDay + 1
                dayModel.isCurrentMonth = true
                if dayModel.year == Date().year && dayModel.month == Date().month && i ==
                    Date().day + firstWeekDay - 1{
                    dayModel.isToday = true
                }
            }
            //下月日期
            if i >= (firstWeekDay + currentMonthModel.totalDays){
                dayModel.day = i - firstWeekDay - currentMonthModel.totalDays + 1
                dayModel.isNextMonth = true
            }
            self.dayModelsArray.append(dayModel)
        }
        self.collectionView?.reloadData()
        
    }
}
extension HZCalendarView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
}
