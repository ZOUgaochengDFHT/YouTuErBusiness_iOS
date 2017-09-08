//
//  YTEChangeTableViewCell.swift
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/7.
//  Copyright © 2017年 ss. All rights reserved.
//

import UIKit

protocol YTEChangeTableViewCellDelegate: class {
    func inputChanged(cell: YTEChangeTableViewCell, text: String)
}

class YTEChangeTableViewCell: UITableViewCell {
    
    weak var delegate: YTEChangeTableViewCellDelegate?

    
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        self.delegate?.inputChanged(cell: self, text: sender.text ?? "")
    }
}
