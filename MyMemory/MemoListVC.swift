//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 윤성호 on 10/03/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
    
    // 앱 델리게이트 객체의 참조 정보를 읽어오기
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // 화면을 첫 로딩이 될때만 호출
    override func viewDidLoad() {
        
        let memo = MemoData()
        memo.title = "워크샵 준비 물품들"
        memo.contents = "워크샵 준비 물품들\n\n라면, 양파, 감자, 파, 계란, 세제류, 생수, 탄산수, 워셔액, 비누, 치약, 칫솔, 수건, 라면, 양파, 감자, 파, 계란, 세제류, 생수, 탄산수, 워셔액, 비누, 치약, 칫솔, 수건"
        memo.regdate = Date()
        
        appDelegate.memolist.append(memo)
        
        let memo1 = MemoData()
        memo1.title = "워크샵 출발 전 챙겨야 할 것들"
        memo1.contents = "워크샵 출발 전 챙겨야 할 것들\n\n이동중 섭취물품들, 인원 체크 및 예약장소 재확인"
        memo1.regdate = Date(timeIntervalSinceNow: 3000)
        
        appDelegate.memolist.append(memo1)
        
        let memo2 = MemoData()
        memo2.title = "출발 전 체크 항목들"
        memo2.contents = "출발 전 체크 항목들\n\n인원별 탑승 완료 여부 확인 및 각 이동 차량 점검"
        memo2.regdate = Date(timeIntervalSinceNow: 4000)
        
        appDelegate.memolist.append(memo2)
        
        let memo3 = MemoData()
        memo3.title = "워크샵 결과 정리"
        memo3.contents = "워크샵 결과 정리\n\n부족했던 점 : 워크샵 장소 이동 사이에 간격이 너무 길어 사람들의 주의가 분산됨"
        memo3.regdate = Date(timeIntervalSinceNow: 8000)
        
        appDelegate.memolist.append(memo3)
        
        // SWRevealViewController 라이브러리의 revealViewController 객체를 읽어온다
        if let revealVC = self.revealViewController() {
            
            // 사이드 바 버튼
            let btnSideBar = UIBarButtonItem(
                image: UIImage(named: "sidemenu.png"),
                style: .plain,
                target: revealVC,
                action: #selector(revealVC.revealToggle(_:)))
            
            // 왼쪽 바 버튼 아이템에 추가
            self.navigationItem.leftBarButtonItem = btnSideBar
            
            // 제스처 추가
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        
    }
    
    // 화면이 출력될 때마다 호출되는 메소드 (화면에 표시 전)
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // 화면이 출력될 때마다 호출되는 메소드 (화면에 표시 후)
    override func viewDidAppear(_ animated: Bool) {
//        self.tableView.reloadData()
    }

    // 테이블 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.memolist.count
    }

    // 테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memoObj = appDelegate.memolist[indexPath.row]
        
        let cellIdentifier = memoObj.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 캐스팅 오류 처리
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ) as? MemoCell else {
            return UITableViewCell()
        }
        
        let titleLengh = memoObj.title!.count
        
        let content = (memoObj.contents! as NSString).substring(from: titleLengh)
        
        cell.subject?.text = memoObj.title
        cell.contents?.text = content
        cell.img?.image = memoObj.image
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = dateFormatter.string(from: memoObj.regdate!)
          
        return cell
        
    }
    
    // 테이블 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 스토리보드의 ID를 이용
//        // memolist 배열에서 선택된 행에 맞는 데이터를 꺼낸다
//        let row = self.appDelegate.memolist[indexPath.row]
//
//        // 상세화면의 인스턴스를 생성한다
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
//
//            // 해당 vc가 없으면
//            return
//        }
//
//        // 값을 전달한 다음 상세 화면으로 이동한다
//        vc.param = row
//        self.navigationController?.pushViewController(vc, animated: true)
        
        // 메뉴얼 세그 이용
        self.performSegue(withIdentifier: "read_sg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "read_sg" {
            
            let path = self.tableView.indexPathForSelectedRow
            
            let memoObj = appDelegate.memolist[path!.row]
            
            memoObj.memoIdx = path!.row
            
            (segue.destination as! MemoReadVC).param = memoObj
        }
    }
    
    // MemoList로 오는 이정표
    @IBAction func gotoMemoList(_ segue: UIStoryboardSegue){        
    }
    
}
