//
//  TestViewCellTableViewCell.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 08/02/23.
//

import UIKit

class TestViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImg : UIImageView!
    @IBOutlet weak var tvTitle : UITextView!
    @IBOutlet weak var tvDesc : UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if(selected==true)
//        {
//            tvDesc.text = "selected"
//        }
//        else
//        {
//            tvDesc.text = "Not selected"
//        }
        // Configure the view for the selected state
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}
