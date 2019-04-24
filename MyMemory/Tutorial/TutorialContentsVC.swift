//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by 윤성호 on 24/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class TutorialContentsVC: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!          // 타이틀
    @IBOutlet var bgImageView: UIImageView!     // 배경 이미지
    
    // parameter
    var pageIndex: Int!         // 페이지 번호
    var titleText: String!      // 타이틀
    var imageFile: String!      // 이미지 정보
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 전달받은 타이틀 정보를 레이블에 대입
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        // 전달받은 이미지 정보를 이미지 뷰에 대입
        self.bgImageView.image = UIImage(named: self.imageFile)
    }

}
