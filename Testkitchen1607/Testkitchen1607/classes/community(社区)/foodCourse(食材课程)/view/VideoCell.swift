//
//  VideoCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    //点击事件
    var palyClosure:(String->Void)?
    
    
    var  cellModel:FoodCourseSerial?{
        didSet{
            if cellModel != nil{
            showData()
            }
        }
    }

    @IBOutlet weak var numLabel: UILabel!
    
    @IBAction func palyCtion() {
        if cellModel?.course_video != nil && palyClosure != nil {
            palyClosure!((cellModel?.course_video)!)
            print(cellModel?.course_video)
        }
    }
    
    
    
    @IBOutlet weak var bgImageVIew: UIImageView!
    
    
     func showData(){
        //图片
        if cellModel?.course_image != nil{
        let url=NSURL(string:(cellModel?.course_image)!)
            print(cellModel?.course_name)
        bgImageVIew.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage" ), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            //文字
            numLabel.text = "\((cellModel?.video_watchcount)!)人做过"
    }
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
