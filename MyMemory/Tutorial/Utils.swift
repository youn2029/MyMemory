//
//  Utils.swift
//  MyMemory
//
//  Created by 윤성호 on 23/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // tutorial Story Board 객체
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    // name에 해당하는 뷰 컨트롤러의 인스턴스 가져오기
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}

