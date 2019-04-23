//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 윤성호 on 17/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let uinfo = UserInfoManager()       // 개인 정보 관리 매니저
    
    let profileImage = UIImageView()    // 프로필 사진 이미지
    let tv = UITableView()              // 프로필 목록
    
    // 테이블 뷰의 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // 테이블 뷰의 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.detailTextLabel?.font = .systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login please"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = self.uinfo.account ?? "Login please"
        default:
            ()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.uinfo.isLogin == false {
            // 로그인되어 있지 않다면 로그인 창을 띄워준다
            self.doLogin(self.tv)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 닫기 버튼
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.rightBarButtonItem = backBtn
        
        // 배경 이미지 설정
        let bg = UIImage(named: "profile-bg.png")
        let bgImg = UIImageView(image: bg)
        
        // bgImg의 크기와 위치 설정
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width / 2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        
        // 프로필 사진에 들어갈 이미지
        let img = self.uinfo.profile
        
        // 프로필 이미지 처리
        self.profileImage.image = img
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 270)
        
        // 프로필 이미지 둥글게 처리
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        // 개인 정보가 들어갈 테이블
        self.tv.frame = CGRect(
            x: 0,
            y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20,
            width: self.view.frame.width,
            height: 100
        )
        self.tv.dataSource = self
        self.tv.delegate = self
        
        // 탭 제스처 추가
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))  // 탭 제스처 객체
        self.profileImage.addGestureRecognizer(tap)                                     // 제스처 등록
        self.profileImage.isUserInteractionEnabled = true                               // 사용자와 상호반응할 수 있도록 해줌
        
        // 뷰에 추가
        self.view.addSubview(bgImg)
        self.view.addSubview(self.tv)
        self.view.addSubview(self.profileImage)
        self.drawBtn()
    }
    
    // 로그인 or 로그아웃 버튼
    func drawBtn(){
        
        // 버튼을 감쌀 뷰 정의
        let v = UIView()
        v.frame = CGRect(
            x: 0,
            y: self.tv.frame.origin.y + self.tv.frame.height,
            width: self.view.frame.width,
            height: 40
        )
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        // 버튼
        let btn = UIButton(type: .system)
        btn.frame.size = CGSize(width: 100, height: 30)
        btn.center = CGPoint(x: (v.frame.width / 2), y: (v.frame.height / 2))
        
        if self.uinfo.isLogin == true {
            btn.setTitle("Logout", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        }else {
            btn.setTitle("Login", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        
        v.addSubview(btn)
    }
    
    // 닫기 버튼과 연결될 액션 메소드
    @objc func close(_ sender: Any){
        self.dismiss(animated: true)
    }
    
    // 로그인을 처리하는 메소드
    @objc func doLogin(_ sender: Any){
        NSLog("???")
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        // 입력창에 들어갈 입력폼 추가
        loginAlert.addTextField { (tf) in
            tf.placeholder = "Your Account"
        }
        
        loginAlert.addTextField { (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true     // 비공개
        }
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        loginAlert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
            
            let account = loginAlert.textFields?[0].text ?? ""
            let passwd = loginAlert.textFields?[1].text ?? ""
            
            if self.uinfo.login(account: account, passwd: passwd) {
                
                // 로그인 성공시
                self.tv.reloadData()                            // 테이블 뷰 갱신
                self.profileImage.image = self.uinfo.profile    // 프로필 갱신
                self.drawBtn()                                  // 로그아웃 버튼
            }else {
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: false, completion: nil)
            }
        })
        
        self.present(loginAlert, animated: false, completion: nil)
    }
    
    // 로그아웃을 처리하는 메소드
    @objc func doLogout(_ sender: Any){
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
            
            if self.uinfo.logout() {
                
                // 로그아웃 성공
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()      // 로그인 버튼
            }
        })
        
        self.present(alert, animated: false, completion: nil)
    }
    
    // imagePicker
    func imgPicker(_ source: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    // 프로필 사진의 소스 타입을 선택하는 액션 메소드
    @objc func profile(_ sender: UIButton) {
        
        // 로그인이 안되어 있으면 로그인 알림창을 띄우기
        guard self.uinfo.account != nil else {
            return self.doLogin(self)
        }
        
        // UIImagePickerController Source Type에 따른 알림창
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {                 // 카메라를 사용할 수 있으면
            alert.addAction(UIAlertAction(title: "카메라", style: .default){ (_) in
                self.imgPicker(.camera)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {     // 포토 라이브러리를 사용할 수 있으면
            alert.addAction(UIAlertAction(title: "라이브러리", style: .default){ (_) in
                self.imgPicker(.photoLibrary)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction(title: "저장 앨범", style: .default){ (_) in
                self.imgPicker(.savedPhotosAlbum)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.uinfo.profile = img
            self.profileImage.image = img
        }
        
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: true, completion: nil)
    }
    
}
