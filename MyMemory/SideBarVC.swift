//
//  SideBarVC.swift
//  MyMemory
//
//  Created by 윤성호 on 16/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class SideBarVC: UITableViewController {
    
    // 타이틀 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    // 아이콘 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png")
    ]
    
    let profileImage = UIImageView()      // 프로필 사진
    let nameLabel = UILabel()             // 이름 레이블
    let emailLabel = UILabel()            // 이메일 레이블
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 회원의 프로필 (테이블 헤더)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        
        // 이름 설정
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.text = "성현이 똥꼬"
        self.nameLabel.textColor = .white
        self.nameLabel.backgroundColor = .clear
        self.nameLabel.font = .boldSystemFont(ofSize: 15)
        
        // 이메일 설정
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30)
        self.emailLabel.text = "youn2029@naver.com"
        self.emailLabel.textColor = .white
        self.emailLabel.backgroundColor = .clear
        self.emailLabel.font = .boldSystemFont(ofSize: 11)
        
        // 프로필 설정
        let defaultProfile = UIImage(named: "account.jpg")
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.image = defaultProfile
        
        // 프로필 사진 둥글게 설정
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2)      // 반원 형태로 바운딩
        self.profileImage.layer.borderWidth = 0                                         // 테두리 두께 0
        self.profileImage.layer.masksToBounds = true                                    // 마사크 효과
        
        // 헤더 뷰에 객체 추가
        headerView.addSubview(self.profileImage)
        headerView.addSubview(self.nameLabel)
        headerView.addSubview(self.emailLabel)
        
        // 테이블 뷰에 헤더 뷰 추가
        self.tableView.tableHeaderView = headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 큐를 이용하여 셀의 정보 가져오기
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 셀을 구성
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // textLabel의 폰트 설정
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 새글 작성하기 버튼을 클릭했을때
        if indexPath.row == 0 {
            
            // 메모 작성 뷰 컨트롤러 가져오기
            let memoFrom = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            
            // 프론트 컨트롤러의 참조 정보를 읽어와 화면 전환
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            target.pushViewController(memoFrom!, animated: true)
            
            // 사이드 바 닫기
            self.revealViewController()?.revealToggle(self)
        }
    }
}
