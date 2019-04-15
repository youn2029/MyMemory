//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 윤성호 on 10/03/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject : String!                   // 제목 : 내용의 첫 줄
    var param : MemoData?                   // 수정 시 메모 정보를 전달받음
    
    @IBOutlet var contents: UITextView!     // 메모내용
    @IBOutlet var preview: UIImageView!     // 이미지
    
    // 저장 버튼 이벤트
    @IBAction func save(_ sender: Any) {
        
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text.isEmpty == false else {
            
            // 내용이 비어 있을 때 처리
            alertError("내용을 입력해주세요")
                
            return
        }
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let idx = self.param?.memoIdx! {
            
            appDelegate.memolist[idx].contents = self.contents.text
            appDelegate.memolist[idx].image = self.preview.image
            appDelegate.memolist[idx].title = self.subject
            appDelegate.memolist[idx].regdate = Date()
            
            // 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
            performSegue(withIdentifier: "unwind_list", sender: self)
            
            
        } else {
            // MemoData 객체를 생성하고, 데이터를 담는다
            let data = MemoData()
            
            data.title = self.subject           // 메모제목
            data.contents = self.contents.text  // 메모내용
            data.image = self.preview.image     // 이미지
            data.regdate = Date()               // 작성일
                        
            appDelegate.memolist.append(data)   // memolist는 구조체이다.
            
            // 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        
       
    }
    
    // 카메라 버튼 이벤트
    @IBAction func pick(_ sender: Any) {
        
        /// 카메라, 저장앨범, 사진 라이브러리를 이용 가능하게 하라
        
        // 이미지 피커 인스턴스를 생성
        let picker = UIImagePickerController()
        picker.delegate = self      // 델리게이트 속성을 현재의 뷰 컨트롤러 인스턴스로 결정
        
        let sheet = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default){
            (_) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                
                picker.sourceType = .camera
                picker.allowsEditing = true
                
                // 이미지 피커 화면을 표시
                self.present(picker, animated: false)
                
            }else{
                self.alertError("카메라를 이용할 수 없습니다.")
            }
            
            
        }
        
        let albumAction = UIAlertAction(title: "저장앨범", style: .default){
            (_) in
            
            if (UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)) {
                
                picker.sourceType = .savedPhotosAlbum
                picker.allowsEditing = true
                
                // 이미지 피커 화면을 표시
                self.present(picker, animated: false)
                
            }else {
                self.alertError("저장앨범을 이용할 수 없습니다.")
            }
            
        }
        
        let libraryAction = UIAlertAction(title: "사진 라이브러리", style: .default){
            (_) in
            
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true     // 이미지 편집 허용
                
                // 이미지 피커 화면을 표시
                self.present(picker, animated: false)
            } else {
                self.alertError("사진 라이브러리를 이용할 수 없습니다.")
            }
        }
        
        sheet.addAction(cameraAction)
        sheet.addAction(albumAction)
        sheet.addAction(libraryAction)
        
        self.present(sheet, animated: false)
        
    }

    // 이미지 선택을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 선탠된 이미지를 미리보기에 표시한다
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 담는다
        picker.dismiss(animated: false)
        
    }
    
    // Tells the delegate that the text or attributes in the specified text view were changed by the user.
    func textViewDidChange(_ textView: UITextView) {
        
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다
        let contents = textView.text as NSString
        let length = (contents.length > 15) ? 15 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비게이션 타이틀에 표시
        self.navigationItem.title = subject
    }
    
    override func viewDidLoad() {
        
        self.contents.delegate = self
        
        if let _ = self.param {
            
            self.contents.text = self.param!.contents
            self.preview.image = self.param!.image
            
        }
        
        // view의 배경 이미지 설정
        let bgImage = UIImage(named: "memo-background")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        // 텍스트 뷰 배경 설정
        self.contents.backgroundColor = .clear
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        
        // 배경과 맞추기 위해 줄 간경 설정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9                   // 줄 간경 설정
        self.contents.attributedText = NSAttributedString(string: " ",
                                                          attributes: [NSAttributedString.Key.paragraphStyle : style])
        self.contents.text = ""
        
    }
    
    // 화면 전체를 터치했을 때 호출되는 메소드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let bar = self.navigationController?.navigationBar
        
        UIView.animate(withDuration: TimeInterval(0.3)) {
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }

    // Error alert
    func alertError(_ msg: String) {
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        // contentViewController 에 이미지 추가 - 커스터마이징
        let contentView = UIViewController()
        
        let image = UIImage(named: "warning-icon-60")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        
        contentView.view.addSubview(imageView)
        contentView.preferredContentSize = CGSize(width: (image?.size.width)!, height: (image?.size.height)!+10)
        
        // alert에 contentViewController 추가
        alert.setValue(contentView, forKey: "contentViewController")
        
        self.present(alert, animated: false)
    }

}
