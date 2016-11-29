//
//  CommentCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var  model:FoodCourseCommentDetail?{
        didSet{
            if model != nil{
                
            //图片
                let url=NSURL(string: (model?.head_img)!)
                
                userImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named:"sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                userImageView.layer.cornerRadius=30
                
            // 名字
                nameLabel.text=model?.nick
            // 评论
                descLabel.text=model?.content
            //时间
              timeLabel.text=model?.create_time
                //print(model?.creat_time)
            }
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
