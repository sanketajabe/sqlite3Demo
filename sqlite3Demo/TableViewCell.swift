//
//  TableViewCell.swift
//  sqlite3Demo
//
//  Created by Apple on 10/12/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var id: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
