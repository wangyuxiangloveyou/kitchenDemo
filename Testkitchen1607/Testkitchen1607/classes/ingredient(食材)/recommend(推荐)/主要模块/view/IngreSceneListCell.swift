//
//  IngreSceneListCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreSceneListCell: UITableViewCell {
    //点击事件
     var jumpClosure:IngreJumpClourse?

    var listModel:IngreRecommendWidgetList?{
        didSet{
           config((listModel?.title)!)
        }
    }

    @IBOutlet weak var titleLabel1: UILabel!
    
    func config(text:String){
        titleLabel1.text=text
        //手势
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //点击手势
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
        
          }
    func tapAction(){
        if jumpClosure != nil && listModel?.title_link != nil{
            jumpClosure!((listModel?.title_link)!)
        }
    }

    //创建cell的方法
    class func creatSceneListCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngreSceneListCell{
        let cellId="IngreSceneListCellId"
        
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId)as?IngreSceneListCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngreSceneListCell", owner: nil, options: nil).last as?IngreSceneListCell
        }
        cell?.listModel=listModel
        return cell!
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
