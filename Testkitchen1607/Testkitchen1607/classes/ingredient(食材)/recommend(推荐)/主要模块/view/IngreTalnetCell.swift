//
//  IngreTalnetCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreTalnetCell: UITableViewCell {

    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    
    var  cellArray:Array<IngreRecommendWidgetData>?{
        didSet{
            showData()
        }
    }
    
    //点击事件
     var jumpClosure:IngreJumpClourse?
    func showData(){
        //图片
        let imageData=cellArray![0]
        if cellArray?.count>0{
            if imageData.type=="image"{
                let url=NSURL(string: imageData.content!)
                leftImage.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                //设置圆角
                leftImage.layer.cornerRadius=30
                leftImage.layer.masksToBounds=true
        }
        }
          //标题
        if cellArray?.count>1{
            let titledata=cellArray![1]
            if titledata.type=="text"{
               nameLabel.text=titledata.content
            }
        }
        //des
        if cellArray?.count>2{
            let desData=cellArray![2]
            if desData.type=="text"{
                desLabel.text=desData.content
            }
        }

        
        //粉丝数
        if cellArray?.count>3{
            let fansData=cellArray![3]
            if fansData.type=="text"{
                fansLabel.text=fansData.content
            }
        }
        //点击手势
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)

        
    }
    func tapAction(){
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.link != nil && jumpClosure != nil{
                jumpClosure!(imageData.link!)
            }
        }
    }
    
    //创建cell
    //创建cell的方法
    class func creatingreTalnetCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,cellArray:Array<IngreRecommendWidgetData>?)->IngreTalnetCell{
        let cellId="ingreTalnetCellId"
        
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId)as?IngreTalnetCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngreTalnetCell", owner: nil, options: nil).last as?IngreTalnetCell
        }
     cell?.cellArray=cellArray
        return cell!

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
