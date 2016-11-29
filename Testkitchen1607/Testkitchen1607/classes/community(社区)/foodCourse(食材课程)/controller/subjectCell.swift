//
//  subjectCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class subjectCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var  cellModel:FoodCourseSerial?{
        didSet{
            if cellModel != nil{
                  showData()
            }
          
        }
    }
    func  showData(){
        titleLabel.text=cellModel?.course_name
        descLabel.text=cellModel?.course_subject
        print(cellModel?.course_name)
        print("111111  4 444444")
        
    }

    //计算cell高度
    class func heightForSubjectCell(model:FoodCourseSerial)->CGFloat{
        //表格高度
        let h:CGFloat=10+20+10
        let str=NSString(string: model.course_subject!)
        let attr=[NSFontAttributeName:UIFont.systemFontOfSize(17)]
        let subjectH=str.boundingRectWithSize(CGSizeMake(kScreenWidth-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
        return h+10+subjectH+10
    }
      override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
