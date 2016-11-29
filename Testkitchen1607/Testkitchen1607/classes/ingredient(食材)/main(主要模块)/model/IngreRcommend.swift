//
//  IngreRcommend.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit
import SwiftyJSON

class IngreRcommend: NSObject {
    var code:NSNumber?
    var data:IngreRecommendData?
    var msg:NSNumber?
    var timestamp:NSNumber?
    var version:String?
    //解析
    class func parseData(data:NSData)->IngreRcommend{
        let json=JSON(data:data)
        let model=IngreRcommend()
        model.code=json["code"].number
        model.data=IngreRecommendData.parseModel(json["data"])
        model.msg=json["msg"].number
        model.timestamp=json["timestamp"].number
        model.version=json["version"].string
        return model
    }
}


//平级两个数组
class IngreRecommendData:NSObject{
    
    var bannerArray:Array<IngreRecommendBanner>?
    var  widgetList:Array<IngreRecommendWidgetList>?
    // 解析
    class func parseModel(json:JSON)->IngreRecommendData{
        let model=IngreRecommendData()
        
        //广告数据
       var tmpbannerArray=Array<IngreRecommendBanner>()
       for (_, subjson): (String,JSON) in json["banner"]{
            let bannerModel=IngreRecommendBanner.parseModel(subjson)
            tmpbannerArray.append(bannerModel)
        }
        model.bannerArray=tmpbannerArray
        
        
        
        //列表数据
        var tmpList=Array<IngreRecommendWidgetList>()
        for (_, subjson):(String,JSON) in json["widgetList"]{
            let wModel=IngreRecommendWidgetList.parseModel(subjson)
            tmpList.append(wModel)

        }
        model.widgetList=tmpList
        return model
    }
    
}

//第一组
class IngreRecommendBanner:NSObject{
    var banner_id:NSNumber?
    var banner_link:String?
    var banner_picture:String?
    
    var banner_title:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    
    var type_id:NSNumber?
    //解析
    class func parseModel(json:JSON)->IngreRecommendBanner{
        let model=IngreRecommendBanner()
        model.banner_id=json["banner_id"].number
        model.banner_link=json["banner_link"].string
        model.banner_picture=json["banner_picture"].string
        
        model.banner_title=json["banner_title"].string
        model.is_link=json["is_link"].number
        model.refer_key=json["refer_key"].number
        model.type_id=json["type_id"].number
        return model
        //print(model.banner_title)


    }
}
//第二组嵌套

class  IngreRecommendWidgetList:NSObject{
    var desc:String?
    var title:String?
    var title_link:String?
    
    var widget_data:Array<IngreRecommendWidgetData>?
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    class func parseModel(json:JSON)->IngreRecommendWidgetList{
        
        let model=IngreRecommendWidgetList()
        model.desc=json["desc"].string
         model.title=json["title"].string
         model.title_link=json["title_link"].string
        
        var dataArray=Array<IngreRecommendWidgetData>()
        for (_,subjson):(String,JSON)in json["widget_data"]{
            let subModel=IngreRecommendWidgetData.parseModel(subjson)
            dataArray.append(subModel)
        }
        
        model.widget_data=dataArray
        model.widget_id=json["widget_id"].number
        model.widget_type=json["widget_type"].number
          //print(model.desc)
          return model
    }
}

class IngreRecommendWidgetData:NSObject{
    var content:String?
    var id:NSNumber?
    var link:String?
    var type:String?
    class func parseModel(json:JSON)->IngreRecommendWidgetData{
        
        let model=IngreRecommendWidgetData()
        model.content=json["content"].string
        model.id=json["id"].number
        model.link=json["link"].string
        model.type=json["type"].string
        //print(model.content)
        return model
      
        
        

}

}







