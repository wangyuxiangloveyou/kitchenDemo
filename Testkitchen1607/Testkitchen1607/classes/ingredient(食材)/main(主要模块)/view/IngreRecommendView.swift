//
//  IngreRecommendView.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit
public enum IngreWidgetType:Int{
    case GuessYouLike = 1//猜你喜欢
    case RedPacket = 2//红包入口
    case TodayNew=5//今日新品
    case Scene=3//早餐
    case SceneList=9//全部场景
    case Talent=4//推荐达人
    case post=8//精选作品
    case topic=7 //美食专题
}


class IngreRecommendView: UIView {
    //数据
    
    var jumpClosure:IngreJumpClourse?
    
    var model:IngreRcommend?{
        didSet{
            //set方法调用之后会调用这里方法
            tableView?.reloadData()
        }
    }
    //表格
    private var tableView:UITableView?
    //重新实现初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建表格视图
        tableView=UITableView(frame: CGRectZero, style: .Plain)
        tableView?.dataSource=self
        tableView?.delegate=self
        
        addSubview(tableView!)
        
        //约束
        tableView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:UITableView代理方法
extension IngreRecommendView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //banner广告部分显示一个分组
        var section=1
        if model?.data?.widgetList?.count>0{
            section+=(model?.data?.widgetList?.count)!
        }
        
        return section
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //banner广告Section显示一行
        var row=0
        if section==0{
            //广告
            row=1
        }else{
            //获取list对象
            let listModel = model?.data?.widgetList![section-1]
            
            if  (listModel?.widget_type?.integerValue)! == IngreWidgetType.GuessYouLike.rawValue||(listModel?.widget_type?.integerValue)! == IngreWidgetType.RedPacket.rawValue||(listModel?.widget_type?.integerValue)! == IngreWidgetType.TodayNew.rawValue||(listModel?.widget_type?.integerValue)! == IngreWidgetType.Scene.rawValue||(listModel?.widget_type?.integerValue)! == IngreWidgetType.SceneList.rawValue||(listModel?.widget_type?.integerValue)! == IngreWidgetType.post.rawValue{
                //猜你喜欢
                //红包入口
                //今日新品
                //早餐日记
                //全部场景
                //精选作品
                row=1
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue{
                //推荐达人
                row = (listModel?.widget_data?.count)!/4
                
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.topic.rawValue{
                //专题美食
                row = (listModel?.widget_data?.count)!/3
                
            }

            
        }
        return row
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat=0
        
        if indexPath.section==0{
            height=140
        }else{
            let listModel=model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                height=70
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.RedPacket.rawValue{
                //红包入口
                height=75
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue{
                //今日新品
                height=280
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue{
                //早餐日记
                height=200
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.SceneList.rawValue{
                //全部场景
                height=70
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue{
                //推荐达人
                height=80
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.post.rawValue{
                //精选作品
                height=180
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.topic.rawValue{
                //专题美食
                height=120
            }

            
            
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==0{
            let cell=IngreBannerCell.creatBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model?.data?.bannerArray)
            //点击事件
            cell.jumpClosure=jumpClosure
             cell.selectionStyle = .None
            return cell
            
        }else{
            let listModel=model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                let cell = IngreLikeCell.creatLikeCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
                
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.RedPacket.rawValue{
                //红包入口
                let cell = IngreRedPacketCell.creatRedPackCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
                
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue{
                //今日新品
                let cell = IngreTodayCell.creatRedTodayCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue{
                //早餐
                let cell = IngrescenCell.creatSceneCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
                
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.SceneList.rawValue{
                //全部
                let cell = IngreSceneListCell.creatSceneListCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue{
                //推荐达人
                //
                let range=NSMakeRange(indexPath.row*4, 4)
                let array=NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range)as! Array<IngreRecommendWidgetData>
                
                
                
                let cell = IngreTalnetCell.creatingreTalnetCellFor(tableView, atIndexPath: indexPath, cellArray: array)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.post.rawValue{
                //精选作品
                let cell = IngrePostCell.creatingrePostCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure=jumpClosure
                 cell.selectionStyle = .None
                return cell
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.topic.rawValue{
                //精选作品
                let range=NSMakeRange(indexPath.row*3, 3)
                let cellArray=NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range)as! [IngreRecommendWidgetData]
                let cell = IngreTopicCell.creatingreTopicCellFor(tableView, atIndexPath: indexPath, cellArray: cellArray)
                //点击事件
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None
                return cell
            }

            
            
            
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section>0{
            let listModel=model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                //猜你喜欢分组的header
                let likeHeaderView=IngreLikeHeaderView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44))
                return likeHeaderView
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.post.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.topic.rawValue{
                //今日新品
                //早餐日记
                //推荐达人
                   //精选作品
                //专题美食
                let headerView=IngreHeaderView(frame: CGRect(x: 0, y: 0, width:kScreenWidth , height: 54))
                //headerView.configText((listModel?.title)!)
                headerView.jumpClosure=jumpClosure
                headerView.listModel=listModel
                return headerView
            }
        }
        return nil
    }
    
    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height:CGFloat=0
        if section > 0{
            let listModel=model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                height=44
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.post.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.topic.rawValue{
                //
                height=54
            }
            
        }
        return height
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h:CGFloat=54
        if scrollView.contentOffset.y>=h{
            scrollView.contentInset=UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y>0{
            scrollView.contentInset=UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
}










