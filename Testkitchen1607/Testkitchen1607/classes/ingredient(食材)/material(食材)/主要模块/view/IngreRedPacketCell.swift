//
//  IngreRedPacketCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/26.
//  Copyright © 2016年 zhb. All rights reserved.
//IngreRedPacketCell

import UIKit

public typealias IngreJumpClourse=(String->Void)

class IngreRedPacketCell: UITableViewCell {
    var jumpClosure:IngreJumpClourse?
    //容器子视图
    private var containerView:UIView?
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //数据
    var listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
            
        }
    }
    func showData() {
        //删除之前的子视图
        if containerView != nil{
            containerView?.removeFromSuperview()
        }
        

        if listModel?.widget_data?.count > 0 {
                      //容器视图
            let containerView = UIView.creatView()
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo((self?.scrollView)!)
                make.height.equalTo((self?.scrollView)!)
                })
            //上一次视图
            var lastView:UIView?=nil
            let cnt = listModel?.widget_data?.count
            for i in 0..<cnt! {
                let data = listModel?.widget_data![i]
                if data?.type == "image"{
                    //创建图片
                    let url=NSURL(string:(data?.content)!)
                    let tmpImageView=UIImageView()
                    tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named:"sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    containerView.addSubview(tmpImageView)
                    
                    //点击事件
                    tmpImageView.userInteractionEnabled=true
                    tmpImageView.tag=300+i
                    let g=UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                    tmpImageView.addGestureRecognizer(g)
                    //约束
                    tmpImageView.snp_makeConstraints(closure: {
                        (make) in
                        make.top.bottom.equalTo(containerView)
                        make.width.equalTo(210)
                        if i == 0 {
                            //将滚动视图显示在最中间
                            let x = (CGFloat(210*cnt!)-scrollView.bounds.size.width)/2
                            make.left.equalTo(containerView).offset(-x)

                            
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    //设置上一张图片值
                    lastView = tmpImageView
                }
            }
            //修改容器视图的宽度
            
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            //将滚动视图显示在屏幕中间

            scrollView.showsHorizontalScrollIndicator=false
            //scrollView.delegate=self
        }
        
    }
    func tapImage(g:UIGestureRecognizer){
        let index=(g.view?.tag)!-300
        
        let data=listModel?.widget_data![index]
        if jumpClosure != nil && data?.link != nil{
            jumpClosure!((data?.link)!)
        }
        
    }
    class func creatRedPackCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList)->IngreRedPacketCell{
        let cellId="ingreRedPacketCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId)as?IngreRedPacketCell
        if nil==cell{
            cell=NSBundle.mainBundle().loadNibNamed("IngreRedPacketCell", owner: nil, options: nil).last as?IngreRedPacketCell
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

//MARK:UIScrollViewDelegate

extension  IngreRedPacketCell:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //let container=scrollView.viewWithTag(200)
        let firstImageView=containerView!.viewWithTag(300)
        if firstImageView?.isKindOfClass(UIImageView)==true{
            firstImageView?.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(containerView!)
            })
        }
    }
}
