//
//  QZFilterCell.swift
//  FastDevelop_Swift
//
//  Created by Yu,Qingzhu on 2020/9/22.
//  Copyright © 2020 Yu,Qingzhu. All rights reserved.
//

import UIKit

class QZFilterCell: UITableViewCell {

    var markView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeSubviews()
        self.width = SCREEN_WIDTH
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeSubviews() {
        self.markView.frame = CGRect(x: SCREEN_WIDTH - 11 - 25, y: 0, width: 11, height: 7)
        self.markView.image = UIImage(named: "PR_project_ok")
        self.addSubview(self.markView)
        self.markView.isHidden = true
        self.markView.y = self.height / 2.0
        
        let lineView = UIView(frame: CGRect(x: 10, y: self.height - 1, width: SCREEN_WIDTH - 20, height: 1))
        lineView.backgroundColor = UIColor.colorFromRGB(0xe6e6e6)
        lineView.alpha = 0.5
        self.addSubview(lineView)
    }
    

}
