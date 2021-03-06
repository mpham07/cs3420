//
//  StudentCell.swift
//  cs_3420
//
//  Created by Minh Pham on 3/18/17.
//  Copyright © 2017 devmen. All rights reserved.
//

import UIKit

protocol StudentCellDelegate: NSObjectProtocol {
    func imageProfile_Pressed(cell: StudentCell)
}

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: CustomizedImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTaking: UILabel!
    @IBOutlet weak var lblGPA: UILabel!
    weak var delegate: StudentCellDelegate!
 
    @IBAction func tapProfile(_ sender: Any) {
        delegate.imageProfile_Pressed(cell: self)
    }
    
    func updateUI(student: User) {
        
       // print(student.photoUrl!)
        if let img = student.photoUrl {
            imgProfile.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: CONSTANTS.imagesAssets.PROFILE_DEFAULT))
        }
        
        lblName.text = student.name
        lblTaking.text = student.takingCourses
        lblGPA.text = student.GPA
    }
}
