//
//  IngreLikeCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreLikeCell: UITableViewCell {
     var jumpClosure:IngreJumpClourse?
//数据
    var listModel:IngreRecommendWidgetList?
        {
       
        didSet{
             showData()
        }
    }
    //显示数据
     private func showData(){
        if listModel?.widget_data?.count>1{
            //循坏显示文字图片
        for var i in 0..<((listModel?.widget_data?.count)!-1){
            //图片
            let imageData=listModel?.widget_data![i]
            if imageData?.type=="image"{
                let imageTag=200+i/2
                
                let imageView=contentView
                .viewWithTag(imageTag)
                if imageView?.isKindOfClass(UIImageView)==true{
                    
                    let tmpImageView=imageView as! UIImageView
                    //数据
                
                    let url=NSURL(string:(imageData?.content)!)
                    tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named:"sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
            //文字
            let textData=listModel?.widget_data![i+1]
            if textData?.type=="text" {
                let label=contentView.viewWithTag(300+i/2)
                if label?.isKindOfClass(UILabel)==true{
                    let tmplabel=label as! UILabel
                    tmplabel.text=textData?.content
                    
                }
            }
            i+=1
        }
        }
    }
    @IBAction func clickBtn(sender: UIButton) {
        let index=sender.tag-100
        if index*2<listModel?.widget_data?.count{
            let data=listModel?.widget_data![index*2]
            if data?.link != nil && jumpClosure != nil{
                jumpClosure!((data?.link)!)
            }

        }
           }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //创建cell的方法
    class func creatLikeCellFor(tableView:UITableView,atIndexPath indexPatn:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngreLikeCell{
        let cellId="IngreLikeCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId)as? IngreLikeCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngreLikeCell", owner: nil, options: nil).last as?IngreLikeCell
        }
        cell?.listModel=listModel
        return cell!
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
