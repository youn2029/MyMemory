//
//  MemoCell.swift
//  MyMemory
//
//  Created by 윤성호 on 10/03/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {
    
    @IBOutlet var subject: UILabel!     // 제목
    @IBOutlet var contents: UILabel!    // 내용
    @IBOutlet var regdate: UILabel!     // 작성일
    @IBOutlet var img: UIImageView!     // 이미지

}
