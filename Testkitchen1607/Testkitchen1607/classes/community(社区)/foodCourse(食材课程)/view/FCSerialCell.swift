//
//  FCSerialCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class FCSerialCell: UITableViewCell {

    //集数
    var serialNum:Int?{
        didSet{
            if serialNum>0{
                showData()
            }
        }
    }
    
    //点击事件
    var clickClosure:(Int->Void)?
    
    //设置选中按钮序号
    
    var selectIndex:Int = -1{
    didSet{
        if selectIndex != oldValue{
            //取消之前按钮的选中
            if oldValue>=0{
            let lastBtn=contentView.viewWithTag(200+oldValue)as! UIButton
            lastBtn.backgroundColor=UIColor.lightGrayColor()
                
            lastBtn.setTitleColor(UIColor.lightTextColor(), forState: .Normal)
            }
            // 选中当前按钮
         if selectIndex >= 0{
            let curBtn=contentView.viewWithTag(200+selectIndex)as! UIButton
            curBtn.backgroundColor=UIColor.orangeColor()
            curBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            
        }
    
    }
    }
    //左右间距
   class private var margin:CGFloat{
        return 20
    }
    
    //横向间距
   class private var spaceX:CGFloat{
        return 4
    }
    
    //纵向间距
    class private var spaceY:CGFloat{
        return 10
    }

    // 一行列数
   class private var colCount:Int{
        return 8
    }

    // 宽度
   class private var btnW:CGFloat{
        return (kScreenWidth-margin*2-spaceX*CGFloat(colCount-1))/CGFloat(colCount)
    }

    // 高度
    class private var btnH:CGFloat{
        return (kScreenWidth-margin*2-spaceX*CGFloat(colCount-1))/CGFloat(colCount)
    }

    func showData(){
        for  sub in contentView.subviews{
            sub.removeFromSuperview()
        }
        // 循坏创建按钮
        for i in 0...serialNum!-1{
        let title="\(i+1)"
        let btn=UIButton.creatBtn(title, bgImageName: nil, highlightImageName: nil, selectImageName: nil, target: self, action: #selector(clickBtn(_:)))
            btn.tag=200+i
            
                // 默认选中第一个
            btn.backgroundColor=UIColor.lightGrayColor()
            btn.setTitleColor(UIColor.lightTextColor(), forState: .Normal)
            
            contentView.addSubview(btn)
            
            btn.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(FCSerialCell.btnW)
                make.height.equalTo(FCSerialCell.btnH)
                //计算当前的行和列
                let  row=i/FCSerialCell.colCount
                let col=i%FCSerialCell.colCount
                make.top.equalTo(FCSerialCell.spaceY+(FCSerialCell.btnH+FCSerialCell.spaceY)*CGFloat(row))
                make.left.equalTo(FCSerialCell.margin+(FCSerialCell.btnW+FCSerialCell.spaceX)*CGFloat(col))

            })
    }
    }
    func clickBtn(btn:UIButton){
        
        let index=btn.tag-200
        //selectIndex=index
        if selectIndex != index{
            selectIndex=index
            
            //切换其他cell上面的数据
            if clickClosure != nil{
                clickClosure!(selectIndex)
            }

            
        }
        
    }
    
    // 计算高度
    class func heightForSerialCell(num:Int)->CGFloat{
        var row=num/FCSerialCell.colCount
        if num%FCSerialCell.colCount>0{
            row+=1
        }
        return CGFloat(row)*(FCSerialCell.spaceY+FCSerialCell.btnH)+spaceY
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
