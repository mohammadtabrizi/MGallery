//
//  AlbumCell.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    let colors : Array = [
        "#fad390",
        "#f8c291",
        "#6a89cc",
        "#82ccdd",
        "#b8e994",
        "#f6b93b",
        "#e55039",
        "#4a69bd",
        "#60a3bc",
        "#78e08f",
        "#fa983a",
        "#3c6382",
    ]

    let albumTitleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline).withSize(12)
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth=true
        l.textColor = .white
        return l
    }()

    let container: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 10, y: 5, width:UIScreen.main.bounds.width-20, height: 80)
        v.dropShadow()
        v.layer.cornerRadius=10;
        v.clipsToBounds=true
        return v
    }()



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        container.backgroundColor = UIColor(hexString: colors.randomElement()!)
        addSubview(container)

        addSubview(albumTitleLabel)
       albumTitleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        albumTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        albumTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       // albumTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
       // albumTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
//
    }

    func displayAlbumInCell(using viewModel: AlbumViewModel) {
        albumTitleLabel.text = viewModel.title
        }


}


