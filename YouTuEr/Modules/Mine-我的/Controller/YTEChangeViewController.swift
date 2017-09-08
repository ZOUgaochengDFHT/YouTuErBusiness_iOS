//
//  YTEChangeViewController.swift
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/7.
//  Copyright © 2017年 ss. All rights reserved.
//

import UIKit

let changeCellId = "YTEChangeTableViewCell"
let placeHolderArr = ["请输入旧密码", "请输入新密码"]


class YTEChangeViewController: UITableViewController {
    
    var serviceModel = SRUpdatePwdSerivceModel()
    
    struct State {
        let tag: Int
        let text: String
    }
    
    // MARK: - Getter & Setter
    var state = State(tag: 0, text: "") {
        didSet {
            if state.tag == 0 {
                serviceModel.oldPwd = state.text
            } else {
                serviceModel.sr_newPwd = state.text
            }
        }
    }
    
    var sureButton: UIButton {
        get {
            let sureButton = UIButton(type: .custom)
            sureButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            sureButton.setTitle("确定", for: .normal)
            sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            sureButton.addTarget(self, action: #selector(updateRequest), for: .touchUpInside)
            return sureButton
        }
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: changeCellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: changeCellId)
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.sureButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: changeCellId, for: indexPath) as! YTEChangeTableViewCell
        cell.textField.placeholder = placeHolderArr[indexPath.row]
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    // MARK: - Actions
    
    func updateRequest() {
        view.endEditing(true)
        if serviceModel.oldPwd == nil || (serviceModel.oldPwd != nil && serviceModel.oldPwd.isEmpty) {
            SRMessage.shared().show("旧密码不能为空", with: .notice)
            return
        }
        if serviceModel.sr_newPwd == nil || (serviceModel.sr_newPwd != nil && serviceModel.sr_newPwd.isEmpty) {
            SRMessage.shared().show("新密码不能为空", with: .notice)
            return
        }
        if SRReachabilityManager.networkIsReachable() == false {return}
        self.showProgressView()
        SRUserService.shared().memberUpdatePwdRequest(with: serviceModel, successBlock: {[unowned self] (returnData, task) -> () in
            self.hideProgressView()
            self.navigationController?.popViewController(animated: true)
            SRMessage.shared().show("密码修改成功！", with: .notice)
        }) { [unowned self] (status, task) -> () in
            self.hideProgressView()
        }
    }
    
}


extension YTEChangeViewController: YTEChangeTableViewCellDelegate {
    func inputChanged(cell: YTEChangeTableViewCell, text: String) {
        state = State(tag: cell.tag, text: text)
    }
}
