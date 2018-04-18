//
//  ViewController.swift
//  ZXLottery
//
//  Created by JuanFelix on 2018/4/18.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    var gridCount = 8   //奖品格子数量（包含[谢谢参与]）
    var drawPrizeView: ZXDrawPrizeView!
    
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet weak var lbPrizeInfo: UILabel!
    var selectedIndex = 2
    var drawEnd = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let offset:CGFloat = 30
        let contentWidth: CGFloat = UIScreen.main.bounds.size.width - offset * 2
        drawPrizeView = ZXDrawPrizeView.init(CGPoint(x: offset, y: (UIScreen.main.bounds.size.height - contentWidth) / 2 - 60), width: contentWidth)
        self.view.addSubview(drawPrizeView)
        drawPrizeView.delegate = self
        drawPrizeView.dataSource = self
        
        self.segmentCtrl.selectedSegmentIndex = self.selectedIndex
    }
    
    @IBAction func segmentCtrlValueChange(_ sender: UISegmentedControl) {
        if self.drawEnd {//抽奖动画结束
            switch sender.selectedSegmentIndex{
            case 0:
                self.gridCount = 3
            case 1:
                self.gridCount = 6
            case 2:
                self.gridCount = 8
            case 3:
                self.gridCount = 20
            default:
                break
            }
            self.selectedIndex = sender.selectedSegmentIndex
            self.drawPrizeView.reloadData()
        } else {
            sender.selectedSegmentIndex = self.selectedIndex
        }
    }
    
}

//MARK: - ZXDrawPrizeDataSource
extension ViewController: ZXDrawPrizeDataSource {
    ///奖品格子数，不得小于三个
    func numberOfPrize(for drawprizeView: ZXDrawPrizeView) -> NSInteger {
        return gridCount
    }
    ///各项奖品图片
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageAt index: NSInteger) -> UIImage {
        if index == gridCount - 1 {
            return #imageLiteral(resourceName: "giftEmpty")
        }
        return UIImage.init(named: "gift\(index % 7 + 1)")!
    }
    ///某一项奖品抽完（不需要，直接return false 即可）
    func zxDrawPrize(prizeView: ZXDrawPrizeView, drawOutAt index: NSInteger) -> Bool {
        if index == 3 {
            return true
        }
        return false
    }
    ///指针图片
    func zxDrawPrizeButtonImage(prizeView: ZXDrawPrizeView) -> UIImage {
        return #imageLiteral(resourceName: "Pointer")
    }
    ///大背景
    func zxDrawPrizeBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return #imageLiteral(resourceName: "turntableBg")
    }
    ///滚动背景 （if nil , fill with color）
    func zxDrawPrizeScrollBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        if gridCount == 8 {
            return #imageLiteral(resourceName: "lattice")
        }
        return nil
    }
}

//MARK: - ZXDrawPrizeDelegate
extension ViewController: ZXDrawPrizeDelegate {
    ///点击抽奖按钮
    func zxDrawPrizeStartAction(prizeView: ZXDrawPrizeView) {
        //这里是本地测试的 随机 奖品 index
        //具体可根据业务数据，定位到index (顺时针顺序)
        let prizeIndex = Int(arc4random() % (UInt32(gridCount)))
        print("random index:\(prizeIndex)")
        //执行动画
        self.drawPrizeView.drawPrize(at: NSInteger(prizeIndex), reject: {
            [unowned self] reject in
            if !reject {
                self.drawEnd = false
            }
        })
        //不关注是否正在执行动画，直接调用这个
        //self.drawPrizeView.drawPrize(at: NSInteger(prizeIndex))
    }
    ///动画执行结束
    func zxDrawPrizeEndAction(prizeView: ZXDrawPrizeView, prize index: NSInteger) {
        //本地测试
        self.drawEnd = true
        var value = ""
        if index == 3 {
            value = "已抽完"
        } else if index == (self.gridCount - 1) {
            value = "谢谢参与"
        } else {
            value = "\((index + 1) % 7)"
        }
        self.lbPrizeInfo.text = "Index:\(index), 奖品:\(value)"
    }
}


