//
//  HZCaledarCell.swift
//  HZCalendar
//
//  Created by 韩志峰 on 2018/1/9.
//  Copyright © 2018年 韩志峰. All rights reserved.
//

import UIKit

class HZCaledarCell: UICollectionViewCell {
    var numberView: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupChildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupChildViews(){
        self.numberView = UILabel.init(frame: self.bounds)
        self.numberView?.textAlignment = .center
        self.contentView.addSubview(self.numberView!)
    }
    func updateContentCell(dayModel: HZDayModel){
        self.numberView?.text = "\(dayModel.day)"
        if dayModel.isLastMonth || dayModel.isNextMonth{
            self.numberView?.textColor = UIColor.lightGray
        }
        if dayModel.isCurrentMonth{
            self.numberView?.textColor = UIColor.black
            if dayModel.isToday{
                self.numberView?.textColor = UIColor.red
                self.numberView?.text = "今天"
            }
        }
        
    }
    
}
