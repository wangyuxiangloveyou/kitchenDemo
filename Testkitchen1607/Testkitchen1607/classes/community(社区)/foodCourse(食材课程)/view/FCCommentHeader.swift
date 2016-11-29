//
//  FCCommentHeader.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class FCCommentHeader: UIView {

    
    @IBAction func commentAction(sender: AnyObject) {
    }
    func config(num: String) {
        titleLabel.text = "\(num)条评论"
    }
    

    @IBOutlet weak var titleLabel: UILabel!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
