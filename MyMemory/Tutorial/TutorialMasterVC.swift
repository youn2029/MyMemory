//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by 윤성호 on 24/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {
    
    var pageVC: UIPageViewController!       // 페이지 뷰 컨트롤러의 인스턴스
    
    // 콘텐츠 뷰 컨트롤러에 들어갈 타이틀과 이미지
    var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
    var contentImages = ["page0", "page1", "page2", "page3"]
    
    // 시작하기 버튼
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    // 콘텐츠 뷰 컨트롤러를 동적으로 생성하기 위한 메소드
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        
        // 인덱스가 데이터 배열 크기 범위를 벗어나면 nil
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        // "ContentsVC"라는 Storyboard ID를 가진 뷰 컨트롤러의 인스턴스를 생성하고 캐스팅
        guard let contentsVC = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
        // 콘턴츠 뷰 컨트롤러의 내용을 구성
        contentsVC.pageIndex = idx
        contentsVC.titleText = self.contentTitles[idx]
        contentsVC.imageFile = self.contentImages[idx]
        return contentsVC
    }
    
    // 현재의 상태에서 앞쪽으로 스와아프했을 때 보여줄 콘텐츠 뷰 컨트롤러 객체
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재의 페이지 인덱스
        guard var idx = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        // 현재의 인덱스가 맨 앞이면
        guard idx > 0 else {
            return nil
        }
        
        idx -= 1
        return self.getContentVC(atIndex: idx)
    }
    
    // 현재의 상태에서 뒤쪽으로 스와이프했을 때 보여줄 콘턴츠 뷰 컨트롤러 객체
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 현재 페이지의 인덱스
        guard var idx = (viewController as? TutorialContentsVC)?.pageIndex else {
            return nil
        }
        
        idx += 1
        
        // 인덱스+1이 배열 인덱스보다 작아야 한다
        guard idx < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: idx)
    }
    
    // 인디케이터의 페이지 개수 설정
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    
    // 처음 선택될 인디케이터의 인덱스 설정
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 페이지 뷰 컨트롤러 객체 생성
        self.pageVC = (self.instanceTutorialVC(name: "PageVC") as! UIPageViewController)
        self.pageVC.dataSource = self
        
        // 페이지 뷰 컨트롤러의 기본 페이지 지정
        let startContentVC = self.getContentVC(atIndex: 0)! // 최초 노출될 콘텐츠 뷰 컨트롤러
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true, completion: nil)
        
        // 페이지 뷰 컨트롤러의 축력 영역 지정
        self.pageVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height - 50
        )
        
        // 페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParent: self)
    }
    

}
