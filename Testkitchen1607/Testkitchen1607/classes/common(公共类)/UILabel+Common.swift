//
//  UILabel+Common.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    class func creatLabel(text:String?,textAlignmet:NSTextAlignment?,font:UIFont?)->UILabel{
        let label=UILabel()
        if let tmpText = text{
            label.text=tmpText
        }
        if let tmpAlignmet=textAlignmet{
            label.textAlignment=tmpAlignmet
        }
        if let tmpfont = font{
            label.font=tmpfont
        }

   return label
        
    }
    
}
