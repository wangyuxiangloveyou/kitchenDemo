//
//  FoodCourseController.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {
    
    // id
    var courseId:String?
    private var tbView:UITableView?
    //当前选择第几集
    private var serialIndex:Int=0
    //详情的数据
    private var detailData:FoodCourseDetail?
    //评论的数据
      private var comment:FoodCourseComment?
    
    //评论的分页
    private var curPage=1
    //是否有更多
    private var hasMore:Bool=true
    //表格
    func creatTableView(){
        
        automaticallyAdjustsScrollViewInsets=false
        
        tbView=UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
        view.addSubview(tbView!)
        
        // 约束
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 0, 0))
            })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //下载详情数据
        creatTableView()
        downloadDetailData()
        downloadComment()
        
        
    }
    //methodName=CommentList&page=1&relate_id=22&size=10&token=&type=2&user_id=&version=4.32
    func  downloadComment(){
        
        var params=[String:String]()
        params["methodName"]="CommentList"
        params["page"]="\(curPage)"
        params["relate_id"]=courseId!
        params["size"]="10"
        params["type"]="2"
        
        
        
        let downloader=KTCDownloader()
        downloader.delegate=self
        downloader.downloaderType = .IngreFoodCourseComment
        
        
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    //下载详情数据
    func downloadDetailData(){
        //methodName=MaterialSubtype&token=&user_id=&version=4.32app://food_course_series#121#
        if courseId != nil {
            let params=["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
            let downloader=KTCDownloader()
            downloader.delegate=self
            downloader.downloaderType = . IngreFoodCourseDetail
            downloader.postWithUrl(kHostUrl, params: params)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
//MARK:KTCDownloaderDelegate
extension FoodCourseController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.downloaderType == .IngreFoodCourseDetail{
            if let tmpData=data{
                detailData=FoodCourseDetail.parseData(tmpData)
                //显示数据
                tbView?.reloadData()
            }
          }else if downloader.downloaderType == .IngreFoodCourseComment{
            let tmpComment=FoodCourseComment.parseData(data!)
                if curPage==1{
                    //第一页
                    comment=tmpComment
                }else{
                    // 其他页
                    let array=NSMutableArray(array: (comment?.data?.data)!)
                    
                    array.addObjectsFromArray((tmpComment.data?.data)!)
                    
                  comment!.data?.data?=(NSArray(array: array)as? [FoodCourseCommentDetail])!
                }
          
            //刷新表格
            tbView?.reloadData()
                //判断是不是有更多
             
                if comment?.data?.data?.count<NSString(string: (comment?.data?.total)!).integerValue{
                    hasMore=true
                }else{
                    hasMore=false
                }
                addFootView()
        }

            
        
    }
    //添加加载更多视图
    func addFootView(){
        let fView=UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        fView.backgroundColor=UIColor.grayColor()
        
        //显示文字
        
        let label=UILabel(frame: CGRect(x: 20, y: 10, width: kScreenWidth-20*2, height: 24))
       
        if hasMore{
            label.text="下拉加载更多"
        }else{
              label.text="没有更多"
        }
        label.textAlignment = .Center
        fView.addSubview(label)
        
        tbView?.tableFooterView=fView
    }
    
}




////MARK:UITableViewDelegate
extension FoodCourseController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num=0
        
        if section==0{
            
            if detailData != nil{
                num=3
            }
            
        }else if section==1{
            // 评论
            if comment?.data?.data?.count>0{
                num=(comment?.data?.data?.count)!
            }
            
        }
        
        return num
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat=0
        if indexPath.section==0{
            if indexPath.row == 0{
                h=160
                
            }else  if indexPath.row==1{
                //文字
                let model=detailData?.data?.data![serialIndex]
                h=subjectCell.heightForSubjectCell(model!)
            }else if indexPath.row==2{
                //集数
                h=FCSerialCell.heightForSerialCell((detailData?.data!.data!.count)!)
                
            }
        }else if indexPath.section==1{
            // 评论

            h=80
        }
        return h
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==0{
            
            if indexPath.row==0{
                //视频
                let cellId="VideoCellId"
                var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as? VideoCell
                if nil==cell{
                    cell=NSBundle.mainBundle().loadNibNamed("VideoCell", owner: nil, options: nil).last as? VideoCell
                }
                
                //显示数据
                let serialModel=detailData?.data?.data![serialIndex]
                cell?.cellModel=serialModel
                //播放的闭包
                cell?.palyClosure = {
                    [weak self]
                    urlString in
                    
                    IngreService.handleEvent(urlString, onViewController: self!)
                    
                }
                
                cell?.selectionStyle = .None
                return cell!
                
                
                
            }else  if indexPath.row==1{
                //描述文字
                let cellId="subjectCellId"
                var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as? subjectCell
                if nil==cell{
                    cell=NSBundle.mainBundle().loadNibNamed("subjectCell", owner: nil, options: nil).last as? subjectCell
                }
                
                //显示数据
                let model=detailData?.data?.data![serialIndex]
                cell?.cellModel=model
                cell?.selectionStyle = .None
                return cell!
                
            }
            else  if indexPath.row==2{
                
                let cellId="serialCellId"
                var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as? FCSerialCell
                if nil==cell{
                    cell=FCSerialCell(style: .Default, reuseIdentifier: cellId)
                }
                
                //显示数据
                cell?.serialNum = detailData?.data?.data?.count
                //设置选中的按钮
                cell?.selectIndex = serialIndex
                
                cell?.clickClosure = {
                    [weak self]
                    index in
                    self!.serialIndex = index
                    //刷新表格
                    
                    self!.tbView?.reloadData()
                }
                
                cell?.selectionStyle = .None
                return cell!
            }
            
            
        }else if indexPath.section == 1 {
            let cellId="CommentCellId"
            var cell=tableView.dequeueReusableCellWithIdentifier (cellId) as? CommentCell
            if nil==cell{
                cell=NSBundle.mainBundle().loadNibNamed("CommentCell", owner: nil, options: nil).last as? CommentCell
            }
            let model=comment?.data?.data![indexPath.row]
            cell?.model=model
            cell?.selectionStyle = .None
            return cell!
            

            
        }
        
        
        
        return UITableViewCell()
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y>=scrollView.contentSize.height-scrollView.bounds.size.height-10{
            //可以加载更多
            if hasMore{
                //  加载下页
                curPage+=1
                downloadComment()
            }
            
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            if comment?.data?.data?.count>0{
                return 60
            }
        }
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView=NSBundle.mainBundle().loadNibNamed("FCCommentHeader", owner: nil, options: nil).last as! FCCommentHeader
        // 显示数据
        headerView.config((comment?.data?.total)!)
        return headerView
    }
    
}

















