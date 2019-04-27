//
//  EmbeddedPhotoTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class EmbeddedPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    var element: Elements?{
        didSet{
            if let imageUrl = element?.file{
                photo.downloadImage(from: imageUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
