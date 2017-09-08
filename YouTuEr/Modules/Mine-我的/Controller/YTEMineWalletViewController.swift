//
//  YTEMineWalletViewController.swift
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/8.
//  Copyright © 2017年 ss. All rights reserved.
//

import UIKit
import SwiftyJSON

class YTEMineWalletViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    var number: Float!
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAmountRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Requests
    
    func getAmountRequest() {
        if SRReachabilityManager.networkIsReachable() == false {return}
        self.showProgressView()
        let serviceModel = SRAmountServiceModel();
        SRUserService.shared().memberGetAmountRequest(with: serviceModel, successBlock: { [unowned self] (returnData, task) ->() in
            self.hideProgressView()
            let json = JSON(dictionary: returnData as Any)
            self.number = json["member"]["amount"].float!
            self.balanceLabel.text = "¥\(String(format:"%.2f", self.number))"
        }) {[unowned self]  (status, task) ->() in
            self.hideProgressView()
        }
    }
    
    // MARK: - Action
    @IBAction func withdrawalsRequest(_ sender: UIButton) {
        if self.number > 0 {
            let withdrawalsVC = YTEWithdrawalsViewController()
            withdrawalsVC.amount = CGFloat(number)
            self.navigationController?.pushViewController(withdrawalsVC, animated: true)
        } else {
            SRMessage.shared().show("余额为0,无法提现!", with: .notice)
        }
    }

}
