//
//  IngrePostCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngrePostCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    //点击事件
    var jumpClosure:IngreJumpClourse?
    
    
    var  listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    
    
    func showData(){
        
        if listModel!.widget_data?.count>0{
            for i in 0..<3{
                //图片
                if listModel!.widget_data?.count>3*i{
                    let imageData=listModel!.widget_data![i*3]
                    if imageData.type=="image"{
                        let tmpview=contentView.viewWithTag(200+i)
                        if tmpview?.isKindOfClass(UIImageView)==true{
                            let imageView=tmpview as! UIImageView
                            
                            let url=NSURL(string: imageData.content!)
                            imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named:"sdefaultImage" ), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }
                //用户头像
                if listModel!.widget_data?.count>3*i+1{
                    let userImageData=listModel!.widget_data![i*3+1]
                    if userImageData.type=="image"{
                        let tmpview=contentView.viewWithTag(300+i)
                        if tmpview?.isKindOfClass(UIButton)==true{
                            let userBtn=tmpview as! UIButton
                            let url=NSURL(string: userImageData.content!)
                            userBtn.kf_setBackgroundImageWithURL(url, forState:.Normal)
                            userBtn.layer.cornerRadius=15
                            userBtn.layer.masksToBounds=true
                            
                        }
                    }
                      }
                    //用户名
                    if listModel!.widget_data?.count>3*i+2{
                        let testData=listModel!.widget_data![3*i+2]
                        if testData.type=="text"{
                            let tmpview=contentView.viewWithTag(400+i)
                            if tmpview?.isKindOfClass(UILabel)==true{
                                let label=tmpview as! UILabel
                                label.text=testData.content
                            }
                        }
                        }
            }
            //描述文字
            descLabel.text=listModel!.desc
        }
    }
    

    
    
    
    @IBOutlet weak var descLabel: UILabel!
    //点击用户头像按钮
    @IBAction func clickUserBtn(sender: UIButton) {
        let index = sender.tag-300
        if listModel!.widget_data?.count>3*index+1{
            let userData = listModel!.widget_data![index*3+1]
            if userData.link != nil && jumpClosure != nil{
                jumpClosure!(userData.link!)
            }
        }

        
    }
    //点击外层三个大按钮
    @IBAction func clickBtn(sender: UIButton) {
       let index = sender.tag-100
        if listModel!.widget_data?.count>3*index{
            let imageData = listModel!.widget_data![index*3]
            if imageData.link != nil && jumpClosure != nil{
                jumpClosure!(imageData.link!)
            }
        }
    }
    
    //创建cell的方法
    class func creatingrePostCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngrePostCell{
        let cellId="ingrePostCellId"
        
        var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as?IngrePostCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngrePostCell", owner: nil, options: nil).last as? IngrePostCell
        }
        cell?.listModel=listModel!
        return cell!
        
        
    }
    
  
      override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
