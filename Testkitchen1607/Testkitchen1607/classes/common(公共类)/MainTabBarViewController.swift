//
//  MainTabBarViewController.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    //tabbar的背景
    private var bgView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor=UIColor.whiteColor()
        tabBar.hidden=true
      
        createViewControllers()
        
        
    }
    //自定制tabbar
    func creatMyTabBar(imageNames:Array<String>,titles:Array<String>){
        //createViewControllers()
        // 1创建背景视图
        bgView = UIView.creatView()
        bgView?.backgroundColor=UIColor.init(white: 0.9, alpha: 1.0)
        //设置边框
        //        bgView?.layer.borderColor=UIColor.blackColor().CGColor
        //        bgView?.layer.borderWidth=1
        view.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: {[weak self] (make) in
            make.left.right.bottom.equalTo(self!.view)
            make.height.equalTo(49)
            })
        
        //图片名字
        let imageNames=["home","community","shop","shike","mine"]
        //标题
        let titles=["食材","社区","商城","食课","我的"]
        
        //循坏创建按钮
        let width=kScreenWidth/CGFloat(imageNames.count)
        
        for i in 0...imageNames.count-1{
            //2.1按钮
            let imageName=imageNames[i]+"_normal"
            let selectName=imageNames[i]+"_select"
            let btn=UIButton.creatBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: selectName, target: self, action: #selector(clickBtn(_:)))
            btn.tag=300+i
            bgView?.addSubview(btn)
            
            //设置位置
            btn.snp_makeConstraints(closure: { [weak self](make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
                
                
                })
            
            //2.2显示标题
            let titleLabel=UILabel.creatLabel(titles[i], textAlignmet: .Center, font: UIFont.systemFontOfSize(12))
            titleLabel.textColor=UIColor.lightGrayColor()
            titleLabel.tag=400
            
            btn.addSubview(titleLabel)
            
            //设置位置
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(btn)
                make.height.equalTo(20)
                
            })
            //默认选择第一个按钮
            if i==0{
                btn.selected=true
                titleLabel.textColor=UIColor.brownColor()
                
            }
        }
        
    }
    
    
    func clickBtn(curbtn:UIButton){
        let index=curbtn.tag-300
        if selectedIndex != index {
            //1.1 取消之前选中的按钮
            let lastBtn = bgView?.viewWithTag(300+selectedIndex)as! UIButton
            lastBtn.selected=false
            lastBtn.userInteractionEnabled=true
            
            let lastlabel=lastBtn.viewWithTag(400) as! UILabel
            lastlabel.textColor=UIColor.lightGrayColor()
            
            //1.2选中当前的按钮
            curbtn.selected=true
            curbtn.userInteractionEnabled=false
            
            let curLabel=curbtn.viewWithTag(400) as! UILabel
            curLabel.textColor=UIColor.brownColor()
            
            
            
            
            //1.3切换视图控制器
            selectedIndex=index
        }
    }
    //创建视图控制器imageNames:Array<String>,titles:Array<String>
    func createViewControllers()  {
        
        //从Contrlllers.Json文件里面读取数据
        let path=NSBundle.mainBundle().pathForResource("Contrlllers", ofType: "Json")
        let data=NSData(contentsOfFile: path!)
        
        //视图控制器名字的数组
        var nameArray=[String]()
        var images = [String]()
        var titles = [String]()
        do {
            //可能抛异常代码写这里
            let json=try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if json.isKindOfClass(NSArray){
                let tmpArray=json as! Array<Dictionary<String,String>>
                
                
                //获取视图控制器的名字
                for tmpDict in tmpArray{
                    //视图控制器
                    let name=tmpDict["ctrLname"]
                    nameArray.append(name!)
                    //图片
                     let imageName=tmpDict["image"]
                    images.append(imageName!)
                    //标题
                    let title=tmpDict["title"]
                    titles.append(title!)
                }
                
            }
        } catch(_){
            //捕获错误信息
           // print(error)
            
        }
        //如果获取的数组有错误
        if nameArray.count==0{
            
            nameArray=["IngredientViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            //图片名字
            _=["home","community","shop","shike","mine"]
            //标题文字
            _=["食材","社区","商城","食课","我的"]
            
        }
        
        //        print(array)
        
        //视图控制器对象的数组
        var ctrlArray=Array<UINavigationController>()
        for i in 0..<nameArray.count{
            let name="Testkitchen1607."+nameArray[i]
            //使用类名创建类名对象
            let ctrl = NSClassFromString(name)as! UIViewController.Type
            let vc=ctrl.init()
            //导航
            let navCtrl=UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)
        }
        viewControllers=ctrlArray
        
        //3.设置图片和文字
        //createViewControllers()
        //自定制tabbar
        tabBar.hidden=true
        creatMyTabBar(images, titles: titles)

    }
    
    /* //创建视图控制器
     func createViewControllers()  {
     let nameArray=["IngredientViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
     //图片名字
     let imageNames=["home","community","shop","shike","mine"]
     //标题
     let titles=["食材","社区","商城","食课","我的"]
     //视图控制器对象的数组
     var ctrlArray=Array<UINavigationController>()
     for i in 0..<nameArray.count{
     let name="Testkitchen1607."+nameArray[i]
     //使用类名创建类名对象
     let ctrl = NSClassFromString(name)as! UIViewController.Type
     
     let vc=ctrl.init()
     //设置图片文字
     vc.tabBarItem.title=titles[i]
     let imageName=imageNames[i]+"_normal"
     vc.tabBarItem.image=UIImage(named: imageName)
     
     let selectName=imageNames[i]+"_select"
     vc.tabBarItem.selectedImage=UIImage(named: selectName)
     
     
     //导航
     let navCtrl=UINavigationController(rootViewController: vc)
     ctrlArray.append(navCtrl)
     }
     viewControllers=ctrlArray
     
     }
     */
    //显示tabbar
//    func showTabbar(){
//        UIView.animateWithDuration(0.25){
//            self.bgView?.hidden=true
//        }
//
//        
//    }
//    func  hideTabbar(){
//        UIView.animateWithDuration(0.25){
//        self.bgView?.hidden=true
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
