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
    //详情的数据
    private var detailData:FoodCourseDetail?
    
    //表格
    func creatTableView(){
        automaticallyAdjustsScrollViewInsets=false
        
        tbView=UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
        view.addSubview(tbView!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //下载详情数据
   downloadDetailData()
        creatTableView()
        
    }

    //下载详情数据
    func downloadDetailData(){
          //methodName=MaterialSubtype&token=&user_id=&version=4.32app://food_course_series#121#
        let params=["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
        let downloader=KTCDownloader()
        downloader.delegate=self
        downloader.downloaderType = . IngreFoodCourseDetail
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK:KTCDownloaderDelegate
extension FoodCourseController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.downloaderType == .IngreFoodCourseDetail{
            //详情
            let str=NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            (str)
            if let tmpData=data{
                detailData=FoodCourseDetail.parseData(tmpData)
                //显示数据
            }
        }else if downloader.downloaderType == .IngreFoodCourseComment{
            //评论
        }
    }
}




////MARK:UITableViewDelegate
extension FoodCourseController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 3
        }else if section==1{
            // 评论
            return 0
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}