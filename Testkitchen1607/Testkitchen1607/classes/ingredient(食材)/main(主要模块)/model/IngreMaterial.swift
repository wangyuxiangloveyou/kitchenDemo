//
//  IngreMaterial.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit
import SwiftyJSON

class IngreMaterial: NSObject {
    var code:String?
    var data:IngreMaterialData?
    var msg:String?
    var timestamp:NSNumber?
    var version:String?
    class func parseData(data:NSData)->IngreMaterial{
        let json=JSON(data:data)
        let model=IngreMaterial()
        model.code=json["code"].string
        model.data=IngreMaterialData.parse(json["data"])
        model.msg=json["msg"].string
        model.timestamp=json["timestamp"].number
        model.version=json["version"].string
        return model
        
    }
    
}
class IngreMaterialData: NSObject {
    var data:[IngreMaterialType]?
    var id:NSNumber?
    var name:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialData{
        let model=IngreMaterialData()
        var array=[IngreMaterialType]()
        for (_,subJson) in json["data"]{
            let typeModel=IngreMaterialType.parse(subJson)
            array.append(typeModel)
        }
        model.data=array
        model.id=json["id"].number
        model.name=json["name"].string
        model.text=json["text"].string
        return model
        
    }
}
class IngreMaterialType: NSObject {
    
    var data:Array<IngreMaterialSubType>?
    var id:String?
    var image:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialType{
        let model=IngreMaterialType()
       var array=Array<IngreMaterialSubType>()
        for (_,subJson) in json["data"]{
            let subtypeModel=IngreMaterialSubType.parse(subJson)
            array.append(subtypeModel)
        }
        model.data=array
        model.id=json["id"].string
        model.image=json["image"].string
        model.text=json["text"].string
        return model
    }
    
    
}
class IngreMaterialSubType: NSObject {
    var id:String?
    var image:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialSubType{
        let model=IngreMaterialSubType()
        
        model.id=json["id"].string
        model.image=json["image"].string
        model.text=json["text"].string
        return model
    }
    
    
}

