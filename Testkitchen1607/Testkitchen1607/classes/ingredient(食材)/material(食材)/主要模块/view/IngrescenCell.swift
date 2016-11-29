//
//  IngrescenCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngrescenCell: UITableViewCell {
    
    var jumpClosure:IngreJumpClourse?
    
    //数据
    var listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
        }
    }

    @IBOutlet weak var senceBtn1: UIButton!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    //播放视频
    @IBAction func smallBtn(sender: UIButton) {
        let index = sender.tag-200
        //数据序号
        if listModel?.widget_data?.count>index*2+4{
            let video=listModel?.widget_data![index*2+4]
            if video?.content != nil && jumpClosure != nil{
                jumpClosure!((video?.content)!)
            }
            
        }
        
    }
    
    //点击图片跳转
    @IBAction func imageBtn(sender: UIButton) {
        let index = sender.tag-100
        if listModel?.widget_data?.count>index*2+3{
            let data=listModel?.widget_data![index*2+3]
            if data?.link != nil && jumpClosure != nil{
                jumpClosure!((data?.link)!)
            }
            
        }
        
        
    }
    @IBAction func sceneBtn() {
        //点击左边按钮
        if listModel?.widget_data?.count>0{
            let sceneDate=listModel?.widget_data![0]
            if sceneDate?.link != nil && jumpClosure != nil{
                jumpClosure!((sceneDate?.link)!)
            }
            
        }
        
    }
    
    
    
    
    
    
    
       func showData(){
        //1.左边
        //图片
        if listModel?.widget_data?.count>0{
            let scenData=listModel?.widget_data![0]
            let url=NSURL(string: (scenData?.content)!)
            senceBtn1.kf_setBackgroundImageWithURL(url!, forState: .Normal)
        }
        //标题
        if listModel?.widget_data?.count>1{
            let titileDate=listModel?.widget_data![1]
            namelabel.text=titileDate?.content
        }
        
        //数量
        if listModel?.widget_data?.count>2{
            let titileDate=listModel?.widget_data![2]
            numberLabel.text=titileDate?.content
        }
        
        //2.右边
        for i in 0..<4{
            if listModel?.widget_data?.count>i*2+3{
                let btnData=listModel?.widget_data![i*2+3]
                if btnData?.type=="image"{
                    
                    let tmpView=contentView.viewWithTag(100+i)
                    if tmpView?.isKindOfClass(UIButton)==true{
                        let btn=tmpView as! UIButton
                        let url=NSURL(string: (btnData?.content)!)
                      btn.kf_setBackgroundImageWithURL(url!, forState: .Normal)
                    }
                }
            }
          
        }
        //3.下边
        desLabel.text=listModel?.desc
    }
    
    //创建cell的方法
    class func creatSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngrescenCell{
        let cellId="ingrescenCellId"
        
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngrescenCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngrescenCell", owner: nil, options: nil).last  as? IngrescenCell
        }
        cell?.listModel=listModel
        return cell!
        
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
