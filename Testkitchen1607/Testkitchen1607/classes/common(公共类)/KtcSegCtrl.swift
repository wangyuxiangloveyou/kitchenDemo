//
//  KtcSegCtrl.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

protocol KtcSegCtrlDelegate:NSObjectProtocol {
    
    //点击事件
    func segCtrl(segCtrl:KtcSegCtrl,didClickBtnIndex index:Int)
}

class KtcSegCtrl: UIView {
    //代理属性
    weak var delegate:KtcSegCtrlDelegate?
    //设置当前序号
    private var linView:UIImageView?
    var selectIndex:Int=0{
        didSet{
            //取消之前的选中状态
            if selectIndex != oldValue{
                let lastBtn=viewWithTag(300+oldValue)
                if lastBtn?.isKindOfClass(KtcSegBtn)==true{
                    let tmpBtn=lastBtn as! KtcSegBtn
                    tmpBtn.clicked=false
                }
            }
            //选中当前选中状态
            let curBtn=viewWithTag(300+selectIndex)
            if curBtn?.isKindOfClass(KtcSegBtn)==true{
                let tmpBtn=curBtn as! KtcSegBtn
                tmpBtn.clicked=true
            }
            //修改下划线的位置
            UIView.animateWithDuration(0.25) { 
                self.linView?.frame.origin.x=(self.linView?.frame.size.width)!*CGFloat(self.selectIndex)

            }
            
        }
    }
    
    //重新给一个初始化方法
    init(frame: CGRect,titleArray:Array<String>) {
        super.init(frame: frame)
        
        if titleArray.count>0{
            creatBtns(titleArray)
        }
        
        
    }
    
    //创建按钮
    func creatBtns(titleArray:Array<String>){
        //按钮宽度
        let w=bounds.size.width/CGFloat(titleArray.count)
        
        for i in 0...titleArray.count-1{
            //循坏创建按钮
            
            let frame=CGRectMake(w*CGFloat(i), 0, w, bounds.size.height)
            let btn=KtcSegBtn(frame: frame)
            //默认选择第一个
            if i==0{
                btn.clicked=true
            }else{
                btn.clicked=false
            }
            
            btn.config(titleArray[i])
            
            //添加点击事件
            btn.tag=300+i
            btn.addTarget(self, action: #selector(cilckBtn(_:)), forControlEvents: .TouchUpInside)
            addSubview(btn)
        }
        //下划线
        linView=UIImageView(frame: CGRect(x: 0, y: bounds.size.height-2, width: w, height: 2))
       linView?.backgroundColor=UIColor.orangeColor()
        linView!.image=UIImage(named:"navBtn_bag")
        
        addSubview(linView!)
        
        
        
    }
    func cilckBtn(btn:KtcSegBtn){
        let index=btn.tag-300
        //修改选中的ui
        selectIndex=index
        delegate?.segCtrl(self, didClickBtnIndex: index)
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




//自定制按钮

class KtcSegBtn: UIControl {
    private var titleLabel:UILabel?
    
    //设置选中状态
    var clicked:Bool=false{
        didSet{
            if clicked==true{
                //选中
                titleLabel?.textColor=UIColor.blackColor()
            }else{
                titleLabel?.textColor=UIColor.lightGrayColor()
            }
        }
    }
    func config(title:String?){
        titleLabel?.text=title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel=UILabel.creatLabel(nil, textAlignmet: .Center, font: UIFont.systemFontOfSize(20))
        titleLabel?.frame=bounds
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



