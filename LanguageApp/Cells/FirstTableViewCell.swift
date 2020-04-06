//
//  FirstTableViewCell.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 05/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    var words = WordWithTranslate.getDictionary()
    
    @IBOutlet weak var titleOfFirstTableViewCell: UILabel!
    
    @IBOutlet weak var subtitleOfFirstTableViewCell: UILabel!
    override func
        awakeFromNib() {
        super.awakeFromNib()
        titleOfFirstTableViewCell.text = "\(words.count) слов"
        titleOfFirstTableViewCell.font = UIFont.systemFont(ofSize: 20)
        subtitleOfFirstTableViewCell.text = "0 выучено"
        subtitleOfFirstTableViewCell.font = UIFont.systemFont(ofSize: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
