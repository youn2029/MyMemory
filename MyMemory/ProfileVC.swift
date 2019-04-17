//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 윤성호 on 17/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            cell.detailTextLabel?.text = "윤성호"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = "youn2029@naver.com"
        default:
            ()
        }
        
        return cell
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
        let img = UIImage(named: "account.jpg")
        
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
        
        // 뷰에 추가
        self.view.addSubview(bgImg)
        self.view.addSubview(self.tv)
        self.view.addSubview(self.profileImage)
    }
    
    // 닫기 버튼과 연결될 액션 메소드
    @objc func close(_ sender: Any){
        self.dismiss(animated: true)
    }
    
}
