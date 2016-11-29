//
//  IngreTopicCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreTopicCell: UITableViewCell {
    
    
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var topicImageView: UIImageView!
    
    
    //点击事件
    var jumpClosure:IngreJumpClourse?
    
    
    var  cellArray:[IngreRecommendWidgetData]?{
        didSet{
            showData()
        }
    }
    func showData(){
        //图片
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.type=="image"{
                let url=NSURL(string: imageData.content!)
                topicImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage" ), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
            }
            
            
        }
        //标题
        if cellArray?.count>1{
            let titleData=cellArray![1]
            if titleData.type=="text"{
                nameLable.text=titleData.content
                
            }
            
        }
        
        //描述文字
        if cellArray?.count>2{
            let titleData=cellArray![2]
            if titleData.type=="text"{
                descLable.text=titleData.content
                
            }
            
        }
        //点击事件
        
        
    }
    func tapAction(){
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.link != nil && jumpClosure != nil{
                jumpClosure!(imageData.link!)
                    
            }
        }
        
    }
    //创建cell的方法
    class func creatingreTopicCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,cellArray:[IngreRecommendWidgetData]?)->IngreTopicCell{
        let cellId="ingreTopicCellId"
        
        var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as?IngreTopicCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngreTopicCell", owner: nil, options: nil).last as? IngreTopicCell
        }
        cell?.cellArray=cellArray!
        return cell!
        
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
