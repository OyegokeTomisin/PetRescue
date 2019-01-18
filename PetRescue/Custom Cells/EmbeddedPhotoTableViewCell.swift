//
//  EmbeddedPhotoTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmbeddedPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    var cellItem: EmbeddedPhotoCellItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with element: JSON?){
        guard let element = element else { return }
        if let imageUrl = element["file"].string{
            photo.downloadImage(from: imageUrl)
        }
    }
}

extension UIImageView{
    func downloadImage(from urlString: String){
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url){ data, response, error in
                guard let data = data else { return }
                let downloadedImage = UIImage(data: data)
                DispatchQueue.main.async { self.image = downloadedImage }
                }.resume()
        }
    }
}
