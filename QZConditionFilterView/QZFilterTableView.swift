//
//  QZFilterTableView.swift
//  FastDevelop_Swift
//
//  Created by Yu,Qingzhu on 2020/9/22.
//  Copyright © 2020 Yu,Qingzhu. All rights reserved.
//

import UIKit

protocol QZFilterTableViewDelegate: AnyObject {
    func chooseFilterItem(item: String) -> Void
}

class QZFilterTableView: UITableView {

    var selectedItem: String?
    var dataArray: [String]?
    weak var chooseDelegate: QZFilterTableViewDelegate?
    
    func dismiss() {
        
    }
    
    
    
    

}
