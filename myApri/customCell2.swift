//
//  customCell2.swift
//  myApri
//
//  Created by MacUser on 2017/07/04.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit

class customCell2: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
  
    @IBOutlet weak var limitDate: UILabel!
    
    @IBOutlet weak var savetype: UILabel!
    
    @IBOutlet weak var dose: UILabel!
    
    @IBOutlet weak var buyDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
