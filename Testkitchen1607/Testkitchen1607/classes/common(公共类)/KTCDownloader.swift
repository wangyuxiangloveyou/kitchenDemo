//
//  KTCDownloader.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit
import Alamofire

protocol KTCDownloaderDelegate:NSObjectProtocol {
    //下载失败
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    
    //下载成功
    func downloader(downloader:KTCDownloader,didFinishWithData data:NSData?)    
}

enum KTCDownloaderType:Int {
     case Normal=0
     case IngreRecommend //首页食材的推荐
     case IngreMaterial//首页食材的食材
     case IngreCategory//首页食材的分类
    
    case IngreFoodCourseDetail//首页食材课程详情
   case IngreFoodCourseComment//首页食材课程评论
}
class KTCDownloader: NSObject {
    //代理属性
    weak var delegate:KTCDownloaderDelegate?
    // 下载类型
    var downloaderType:KTCDownloaderType = .Normal
    // POST请求数据
    func postWithUrl(urlString:String,params:Dictionary<String,AnyObject>)
    {   //methodName=SceneHome&token=&user_id=&version=4.5
        var  tmpDict=NSDictionary(dictionary: params)as! Dictionary<String,AnyObject>
        //设置所有接口的公共参数
        tmpDict["token"]=""
        tmpDict["user_id"]=""
        tmpDict["version"]="4.5"
        
        
        Alamofire.request(.POST, urlString, parameters: tmpDict, encoding: ParameterEncoding.URL, headers:nil).responseData { (reaponse) in
            switch reaponse.result{
            //出错
            case.Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            //成功
            case.Success:
                self.delegate?.downloader(self, didFinishWithData: reaponse.data)
                
            }
        }
        
        
        
    }
}

