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
    let cellIdentifier: String = "cellId"
    var leftSwipeGesture: UISwipeGestureRecognizer?
    var rightSwipeGesture: UISwipeGestureRecognizer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatSubViews(){
        self.titleView = UILabel.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: itemHeight))
        self.titleView?.textAlignment = .center
        self.titleView?.textColor = UIColor.black
        self.addSubview(self.titleView!)
        self.refreshTitleView()
        
        let weekTitles: [String] = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        for i in 0..<weekTitles.count{
            let lable: UILabel = UILabel.init(frame: CGRect.init(x: CGFloat(i) * itemWidth , y: 64.0 + itemHeight, width: itemWidth, height: itemHeight))
            lable.textAlignment = .center
            lable.text = weekTitles[i]
            lable.font = UIFont.systemFont(ofSize: 12)
            lable.textColor = UIColor.gray
            self.addSubview(lable)
        }
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: (itemHeight + itemHeight + 64.0), width: kScreenWidth, height: CGFloat(6) * itemHeight), collectionViewLayout: flowLayout)
        self.collectionView?.register(HZCaledarCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.scrollsToTop = true
        self.collectionView?.isScrollEnabled = false
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.addSubview(self.collectionView!)
        
        self.leftSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(leftSlide))
        self.leftSwipeGesture?.direction = .left
        self.collectionView?.addGestureRecognizer(self.leftSwipeGesture!)
        
        self.rightSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(rightSlide))
        self.rightSwipeGesture?.direction = .right
        self.collectionView?.addGestureRecognizer(self.rightSwipeGesture!)
        
    }
    @objc func leftSlide(){
        self.currentDate = self.currentDate.nextMonth
        self.performAnimation(transition: kCATransitionFromRight)
        self.handleData()
        self.refreshTitleView()
    }
    @objc func rightSlide(){
        self.currentDate = self.currentDate.lastMonth
        self.performAnimation(transition: kCATransitionFromLeft)
        self.handleData()
        self.refreshTitleView()
    }
    func refreshTitleView(){
        self.titleView?.text = "\(currentDate.year)年 \(currentDate.month)月"
    }
    func setupDataSource(){
        self.handleData()
    }
    func performAnimation(transition: String){
        let animation = CATransition.init()
        animation.duration = 0.25
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = transition
        self.collectionView?.layer.add(animation, forKey: nil)
    }
    func handleData(){
        self.dayModelsArray.removeAll()
        let lastMonthDate: Date = self.currentDate.lastMonth
        let currentMonthModel: HZMonthModel = HZMonthModel.init(date: self.currentDate)
        let lastMonthModel: HZMonthModel = HZMonthModel.init(date: lastMonthDate)
        let totalDays: Int = currentMonthModel.totalDays
        let firstWeekDay: Int = currentMonthModel.firstWeekDay
        
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
        guard self.dayModelsArray.count > indexPath.row else {return UICollectionViewCell()}
        let cell: HZCaledarCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HZCaledarCell
        let dayModel: HZDayModel = self.dayModelsArray[indexPath.row]
        cell.updateContentCell(dayModel: dayModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dayModelsArray.count
    }
}
