//
//  IngreMaterialCell.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreMaterialCell: UITableViewCell {
    //点击事件
    var jumpClosure:IngreJumpClourse?
    var cellModel:IngreMaterialType?{
        didSet{
            if  cellModel != nil{
                for sub in contentView.subviews{
                sub.removeFromSuperview()
                }
                showData()

    }
            
    }
}
    
    //标题高度
    class private var tltleH:CGFloat{
        return 20
    }
    //间距
    class  private var margin:CGFloat{
        return 10
    }
    //按钮的高度
    class  private var btnH:CGFloat{
        return 44
    }
    //按钮列数
    class private var column:Int{
        return 5
    }
    class private var btnW:CGFloat{
        return (kScreenWidth-margin*CGFloat(column+1))/CGFloat(column)
    }
    
    func  showData(){
        //标题类型
        let titleLabel=UILabel.creatLabel(cellModel!.text, textAlignmet: .Left, font: UIFont.systemFontOfSize(17))
        //titleLabel.numberOfLines=0
        contentView.addSubview(titleLabel)
        
        
        //约束
        titleLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(IngreMaterialCell.margin)
            make.right.equalTo(-IngreMaterialCell.margin)
            make.height.equalTo((IngreMaterialCell.tltleH))

        }
        
        //左边的图片
        let typeImageView=UIImageView()
        let url=NSURL(string: (cellModel?.image)!)
        typeImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(typeImageView)
        
        typeImageView.snp_makeConstraints { (make) in
            make.left.equalTo(IngreMaterialCell.margin)
            make.top.equalTo(IngreMaterialCell.margin*2+IngreMaterialCell.tltleH)
            make.width.equalTo(IngreMaterialCell.btnW*2+IngreMaterialCell.margin)
            make.height.equalTo(IngreMaterialCell.btnH*2+IngreMaterialCell.margin)
        }
        // 子类型按钮
        let cnt=cellModel?.data?.count
        if cnt>0{
            for i in 0..<cnt!{
            //显示文字
             let model=cellModel?.data![i]
            let btn=IngreMaterialBtn()
            btn.model=model
                //点击事件
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            contentView.addSubview(btn)
            
                //约束
                if  i<6{
                    //前两行按钮
                    let row=i/(IngreMaterialCell.column-2)
                     let col=i%(IngreMaterialCell.column-2)
                    btn.snp_makeConstraints(closure: { (make) in
                        let x=IngreMaterialCell.btnW*2+IngreMaterialCell.margin*3+(IngreMaterialCell.btnW+IngreMaterialCell.margin)*CGFloat(col)
                        make.left.equalTo(x)
                        let top=IngreMaterialCell.tltleH+IngreMaterialCell.margin*2+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
                        make.top.equalTo(top)
                        make.width.equalTo(IngreMaterialCell.btnW)
                        make.height.equalTo(IngreMaterialCell.btnH)
                    })
                }else{
                    //后面按钮
                    let row=(i-6)/IngreMaterialCell.column
                    let col=(i-6)%IngreMaterialCell.column
                    btn.snp_makeConstraints(closure: { (make) in
                        let x=IngreMaterialCell.margin+(IngreMaterialCell.margin+IngreMaterialCell.btnW)*CGFloat(col)
                        make.left.equalTo(x)
                        let topMagri=IngreMaterialCell.margin+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
                        make.top.equalTo(typeImageView.snp_bottom).offset(topMagri)
                        make.width.equalTo(IngreMaterialCell.btnW)
                        make.height.equalTo(IngreMaterialCell.btnH)
                    })

                }
            
            
        }
        }
        
        
        
    }
    
    func clickBtn(btn:IngreMaterialBtn){
        let tmpModel=btn.model
        if tmpModel?.id != nil && jumpClosure != nil{
            let urlString="app://material##\((tmpModel?.id)!)#"
            jumpClosure!(urlString)
        }
    }
    //计算cell的高度
    class func heightForCellWithModel(typeModel:IngreMaterialType)->CGFloat{
        //子类型只有两行高度
        var h=IngreMaterialCell.margin*2+IngreMaterialCell.tltleH+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*2
        //如果超过两行
        if typeModel.data?.count>6{
            var row=((typeModel.data?.count)!-6)/(IngreMaterialCell.column)
            let tmpNum=((typeModel.data?.count)!-6)%(IngreMaterialCell.column)
            if tmpNum>0{
                //除不尽加一行
                row+=1
                
            }
            h+=(IngreMaterialCell.margin+IngreMaterialCell.btnH)*CGFloat(row)
        }
        return h
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


//按钮
class IngreMaterialBtn:UIControl{
    private var titleLabel:UILabel?
    
    //显示数据
   var model:IngreMaterialSubType?{
        didSet{
            titleLabel?.text=model!.text
            //print(model?.text)
        }
    }
    
    init(){
        super.init(frame: CGRectZero)
        
        
        titleLabel=UILabel.creatLabel(nil, textAlignmet: .Center, font: UIFont.systemFontOfSize(17))
         titleLabel?.numberOfLines=0
        addSubview(titleLabel!)
       
        //约束
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
        //设置背景色
        titleLabel?.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}