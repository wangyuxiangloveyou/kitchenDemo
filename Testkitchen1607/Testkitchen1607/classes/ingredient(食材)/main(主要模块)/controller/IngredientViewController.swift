//
//  IngredientViewController.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngredientViewController: KTCTabViewController {
    //滚动视图
    private var scrollView:UIScrollView?
    //推荐视图
    private var recommendView:IngreRecommendView?
    //食材视图
    private var materialView:IngreMateriaView?
    //分类视图
    private var categoryView:IngreMateriaView?
    //导航上面的选择控件
    private var segCtrl:KtcSegCtrl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        automaticallyAdjustsScrollViewInsets=false
        //下载首页数据
        //methodName=SceneHome&token=&user_id=&version=4.5
        downloadRecommendData()
        creatNav()
        creatHomePage()
        downloadRecommendMaterial()
        downloadCategoryData()
    }
    //下载首页分页数据
    func downloadCategoryData(){
        //methodName=CategoryIndex&token=&user_id=&version=4.32
        let downloader=KTCDownloader()
        downloader.delegate=self
     downloader.downloaderType = .IngreCategory
        
        downloader.postWithUrl(kHostUrl, params: ["methodName":"CategoryIndex"])
    }
    //methodName=MaterialSubtype&token=&user_id=&version=4.32
    // 首页食材
    func  downloadRecommendMaterial(){
        let dict=["methodName":"MaterialSubtype"]
        let downloader=KTCDownloader()
        downloader.delegate=self
        downloader.downloaderType = .IngreMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    //创建首页视图
    func creatHomePage(){
        scrollView=UIScrollView()
        scrollView!.pagingEnabled=true
        //设置代理
        scrollView?.delegate=self
        
        view.addSubview(scrollView!)
        //约束
        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        //容器视图
        let containerView=UIView.creatView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }
        //添加子视图
        //1.推荐子视图
        recommendView=IngreRecommendView()
        
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
        })
        //2.食材视图
        materialView=IngreMateriaView()
        materialView?.backgroundColor=UIColor.greenColor()
        containerView.addSubview(materialView!)
        materialView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        //3.分类视图
        categoryView=IngreMateriaView()
        categoryView?.backgroundColor=UIColor.redColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((materialView?.snp_right)!)
            
        })
        //修改容器视图大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
        
    }
    
    func creatNav(){
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
        //选择控件
        let frame=CGRectMake(80, 0, kScreenWidth-80*2, 44)
        segCtrl=KtcSegCtrl(frame: frame, titleArray: ["推荐","食材","分类"])
        segCtrl!.delegate=self
        navigationItem.titleView=segCtrl
    }
    func scanAction(){
       // print("扫一扫")
    }
    func searchAction(){
        //print("搜索")
    }
    func downloadRecommendData(){
        let params=["methodName":"SceneHome"]
        let downloader=KTCDownloader()
        downloader.delegate=self
        downloader.downloaderType = .IngreRecommend
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

//MARK:KTCDownloaderDelegate代理方法
extension IngredientViewController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        //print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.downloaderType == .IngreRecommend{
            if let tmpData = data {
                //1.json解析
                let recommendModel=IngreRcommend.parseData(tmpData)
                //2.显示ui
                recommendView?.model=recommendModel
                //点击食材的推荐界面跳转后面界面
                recommendView?.jumpClosure={
                    [weak self]
                    jumUrl in
                    self!.handleClickEvent(jumUrl)
                }
                
            }
        }else if downloader.downloaderType == .IngreMaterial{
            if  let tmpData=data{
                let model=IngreMaterial.parseData(tmpData)
                materialView?.model=model
                // 点击事件
                materialView?.jumpClosure={
                    [weak self]
                    jumUrl in
                    self!.handleClickEvent(jumUrl)
                }
            }
            
        }else if downloader.downloaderType == .IngreCategory{
            if  let tmpData=data{
                let model=IngreMaterial.parseData(tmpData)
                categoryView?.model=model
                // 点击事件
                categoryView?.jumpClosure={
                    [weak self]
                    jumUrl in
                    self!.handleClickEvent(jumUrl)
                }
            }
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(str!)
        
        }
        
        
    }
    
    //处理点击事件的方法
    func handleClickEvent(urlString:String){
        //print(urlString)
        IngreService.handleEvent(urlString, onViewController: self)
    }
    
}

//Mark: KtcSegCtrl代理
extension IngredientViewController:KtcSegCtrlDelegate{
    func segCtrl(segCtrl: KtcSegCtrl, didClickBtnIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*kScreenWidth, 0), animated: true)
    }
}
//Mark: scrollView代理

extension IngredientViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index=scrollView.contentOffset.x/scrollView.bounds.size.width
        segCtrl?.selectIndex=Int(index)
    }
}



