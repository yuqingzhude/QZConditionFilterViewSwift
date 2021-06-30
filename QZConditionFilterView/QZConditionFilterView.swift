//
//  QZConditionFilterView.swift
//  FastDevelop_Swift
//
//  Created by Yu,Qingzhu on 2020/9/22.
//  Copyright © 2020 Yu,Qingzhu. All rights reserved.
//

import UIKit

typealias FilterBlock = (String, String, String) -> Void
/*
 * 主流样式一般就是三个，所以暂时只支持三个
 * 通用框架反而可能增加不必要的复杂度，实际应用场景也有限
 * 通用可以考虑将所有数据源包在数组中
 */

// default config
let defaultFrame: CGRect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
let defaultFont: UIFont = UIFont.systemFont(ofSize: 13)
let defaultNum: NSInteger = 3

class QZConditionFilterView: UIView {
    var dataArray1: [String]?
    var dataArray2: [String]?
    var dataArray3: [String]?
    private(set) var isShow: Bool = false
    
    private var filterButton1: UIButton?
    private var filterButton2: UIButton?
    private var filterButton3: UIButton?
    
    private var selectBtn: UIButton?
    private var bgView: UIView?
    
    private var filterTableView1: QZFilterTableView?
    private var filterTableView2: QZFilterTableView?
    private var filterTableView3: QZFilterTableView?
    
    // 存储 tableView didSelected数据 数据来源：FilterDataTableView
    private var choosedTableItem1: String?
    private var choosedTableItem2: String?
    private var choosedTableItem3: String?
    
    private var filterBlock: FilterBlock?
    
    
    class func conditionFilterView(frame: CGRect?, filterBlock: @escaping FilterBlock) -> QZConditionFilterView {
        // default frame
        let conditionFilterView = QZConditionFilterView()
        if let frame = frame {
            conditionFilterView.frame = frame
        } else {
            conditionFilterView.frame = defaultFrame
        }
        conditionFilterView.filterBlock = filterBlock
        conditionFilterView.setupViews()
        return conditionFilterView
    }
    
    func updateFilterTableTitleWithTitleArray(titleArray: [String]) {
        if titleArray.count < defaultNum {
            print("数据源不足，请检查显示在筛选框上的标题数据")
            return
        }
        self.changeBtn(btn: self.filterButton1 ?? UIButton(), title: titleArray[0], font: defaultFont, imageName: "PR_filter_choice")
        self.changeBtn(btn: self.filterButton2 ?? UIButton(), title: titleArray[1], font: defaultFont, imageName: "PR_filter_choice")
        self.changeBtn(btn: self.filterButton3 ?? UIButton(), title: titleArray[2], font: defaultFont, imageName: "PR_filter_choice")
        
        self.dismiss()
        if let filterBlock = self.filterBlock {
            filterBlock(titleArray[0], titleArray[1], titleArray[2])
        }
    }
    
    func dismiss() {
        
    }
    
    //MARK:- private
    private func setupViews() {
        self.backgroundColor = .white
        self.isShow = false
        
        let btn1Frame = CGRect(x: 0, y: 0, width: (SCREEN_WIDTH - 1) / CGFloat(defaultNum), height: self.height)
        self.filterButton1 = self.createfilterButton(frame: btn1Frame,
                                                     title: "",
                                                     titleColor: UIColor.colorFromRGB(0x333333),
                                                     selectedTitleColor: UIColor.colorFromRGB(0x00a0ff),
                                                     font: defaultFont,
                                                     backgroundColor: .white,
                                                     rightImageName: "PR_filter_choice",
                                                     selectedRightImageName: "PR_filter_choice_top")

        self.addSubview(self.filterButton1!)
        
        let middleLine1 = UILabel(frame: CGRect(x: self.filterButton1!.right, y: 8, width: 0.5, height: 24))
        middleLine1.backgroundColor = UIColor.colorFromRGB(0xe6e6e6)
        self.addSubview(middleLine1)
        
        let btn2Frame = CGRect(x: self.filterButton1!.right + 0.5, y: 0, width: self.filterButton1!.width, height: self.height)
        self.filterButton2 = self.createfilterButton(frame: btn2Frame,
                                                     title: "",
                                                     titleColor: UIColor.colorFromRGB(0x333333),
                                                     selectedTitleColor: UIColor.colorFromRGB(0x00a0ff),
                                                     font: defaultFont,
                                                     backgroundColor: .white,
                                                     rightImageName: "PR_filter_choice",
                                                     selectedRightImageName: "PR_filter_choice_top")

        self.addSubview(self.filterButton2!)
        
        let middleLine2 = UILabel(frame: CGRect(x: self.filterButton2!.right, y: 8, width: 0.5, height: 24))
        middleLine2.backgroundColor = UIColor.colorFromRGB(0xe6e6e6)
        self.addSubview(middleLine2)
        
        let btn3Frame = CGRect(x: self.filterButton2!.right + 0.5, y: 0, width: self.filterButton1!.width, height: self.height)
        self.filterButton3 = self.createfilterButton(frame: btn3Frame,
                                                     title: "",
                                                     titleColor: UIColor.colorFromRGB(0x333333),
                                                     selectedTitleColor: UIColor.colorFromRGB(0x00a0ff),
                                                     font: defaultFont,
                                                     backgroundColor: .white,
                                                     rightImageName: "PR_filter_choice",
                                                     selectedRightImageName: "PR_filter_choice_top")

        self.addSubview(self.filterButton3!)
    }
    
    private func createfilterButton(frame: CGRect,
                                    title: String,
                                    titleColor: UIColor,
                                    selectedTitleColor: UIColor,
                                    font: UIFont,
                                    backgroundColor: UIColor,
                                    rightImageName: String,
                                    selectedRightImageName: String) -> UIButton {
        
        let btn = UIButton(frame: frame)
        btn.backgroundColor = backgroundColor
        
        let sizeLabel = UILabel()
        sizeLabel.font = font
        sizeLabel.text = title
        sizeLabel.sizeToFit()
        let titleSize = sizeLabel.frame
        let image = UIImage(named: rightImageName)
        let space : CGFloat = 5.0
        let imageWidth = CGFloat(image?.size.width ?? 0)
        let edgeSpace = (btn.width - (titleSize.width + imageWidth + space)) / 2.0 + titleSize.width + space
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -edgeSpace)
        btn.setImage(image, for: .normal)
        btn.setImage(UIImage(named: selectedRightImageName), for: .selected)
        
        var titleSpace = -(imageWidth + space)
        if SCREEN_WIDTH / 736 != 0 {
            titleSpace = -imageWidth - CGFloat(defaultNum) * space
        }
        
        btn.titleLabel?.contentMode = .center
        btn.titleLabel?.font = font
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitleColor(selectedTitleColor, for: .selected)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleSpace, bottom: 0, right: 0)
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(self.filterWithBtn(btn:)), for: .touchUpInside)
        return btn
    }
    
    @objc private func filterWithBtn(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            self.showTableView(btn: btn)
            self.selectBtn = btn
        } else {
            self.dismiss()
        }
    }
    
    private func showTableView(btn: UIButton) {
        
    }
    
    // 改按钮文字重新排列
    private func changeBtn(btn: UIButton, title: String, font: UIFont, imageName: String) {
        let sizeLabel = UILabel()
        sizeLabel.font = font
        sizeLabel.text = title
        sizeLabel.sizeToFit()
        let titleSize = sizeLabel.frame
        let image = UIImage(named: imageName)
        let space : CGFloat = 5.0
        let imageWidth = CGFloat(image?.size.width ?? 0)
        let edgeSpace = (btn.width - (titleSize.width + imageWidth + space)) / 2.0 + titleSize.width + space
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -edgeSpace)
        btn.setImage(image, for: .normal)

        
        var titleSpace = -(imageWidth + space)
        if SCREEN_WIDTH / 736 != 0 {
            titleSpace = -imageWidth - CGFloat(defaultNum) * space
        }

        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleSpace, bottom: 0, right: 0)
        btn.setTitle(title, for: .normal)
    }

}
