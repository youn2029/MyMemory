//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 윤성호 on 10/03/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var param : MemoData?               // 데이터를 저장하는 변수
    @IBOutlet var subject: UILabel!     // 제목
    @IBOutlet var contents: UILabel!    // 내용
    @IBOutlet var img: UIImageView!     // 이미지
    
    override func viewDidLoad() {
        
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        // 작성일이 title
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        self.navigationItem.title = formatter.string(from: (param?.regdate)!)
    }
    
    // 메모 삭제 이벤트
    @IBAction func deleteMemo(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let alert = UIAlertController(title: "알림", message: "메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default){
            (_) in
            
            let index = self.param?.memoIdx
            appDelegate.memolist.remove(at: index!)
            
            self.navigationController?.popViewController(animated: false)
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "update_seg" {
            
            let vc = segue.destination as! MemoFormVC
            
            vc.param = self.param
        }
    }
    
}
