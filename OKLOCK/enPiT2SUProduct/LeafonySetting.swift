//
//  LeafonySetting.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/08.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class LeafonySetting: UIViewController, UIScrollViewDelegate {

    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        // ビューの縦、横のサイズを取得する.
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        // 背景の色をホワイトに設定する.
        self.view.backgroundColor = UIColor.white
        
        // ScrollViewを取得する.
        scrollView = UIScrollView(frame: self.view.frame)
        
        // ページ数を定義する.
        let pageSize = 4
        
        // 縦方向と、横方向のインディケータを非表示にする.
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        
        // ページングを許可する.
        scrollView.isPagingEnabled = true
        
        // ScrollViewのデリゲートを設定する.
        scrollView.delegate = self
        
        // スクロールの画面サイズを指定する.
        
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * width, height: 0)
        
        // ScrollViewをViewに追加する.
        self.view.addSubview(scrollView)
        
        // ページ数分ボタンを生成する.
        for i in 0 ..< pageSize {
            
            // ページごとに異なるラベルを生成する.
            
            let myLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 300, width: 80, height: 80))
            let myLabel2:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 90, y: height/2 - 80, width: 180, height: 80))
            myLabel.backgroundColor = UIColor.white
            myLabel.textColor = UIColor.black
            myLabel.textAlignment = NSTextAlignment.center
            myLabel.layer.masksToBounds = true
            myLabel.text = "STEP\(i+1)"
            myLabel.font = UIFont.systemFont(ofSize: 20)
            myLabel.layer.cornerRadius = 10.0
            
            switch i {
            case 0:
                myLabel2.text = "説明１"
            case 1:
                myLabel2.text = "説明２"
            case 2:
                myLabel2.text = "説明３"
            case 3:
                myLabel2.text = "説明４"
            default:
                myLabel2.text = "エラー"
            }
            
            myLabel2.backgroundColor = UIColor.white
            myLabel2.textColor = UIColor.black
            myLabel2.textAlignment = NSTextAlignment.center
            myLabel2.layer.masksToBounds = true
            myLabel2.font = UIFont.systemFont(ofSize: 20)
            myLabel2.layer.cornerRadius = 10.0
            
            scrollView.addSubview(myLabel)
            scrollView.addSubview(myLabel2)
        }
        
        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.maxY - 100, width:width, height:50))
        pageControl.backgroundColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        
        // PageControlするページ数を設定する.
        pageControl.numberOfPages = pageSize
        
        // 現在ページを設定する.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        self.view.addSubview(pageControl)
        
        self.navigationItem.hidesBackButton = true
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
}
