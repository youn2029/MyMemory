//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 윤성호 on 15/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

public enum CSLogType: Int {
    case basic  // 기본 로그 타입
    case title  // 버튼의 타이틀을 출력
    case tag    // 버튼의 태그값을 출력
}

public class CSLogButton: UIButton {
    
    // 로그 타입 출력
    public var logType: CSLogType = .basic

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 버튼에 스타일 적용
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = .white
        
        // 버튼의 클릭 이벤트에 logging(_:) 메소드를 연결
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    
    @objc func logging(_ sender: UIButton){
        
        switch self.logType {
        case .basic:
            NSLog("버튼을 클릭했습니다")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀이 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다")
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다")
            
        }
    }

}
