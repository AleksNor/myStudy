//
//  CourseCell.swift
//  SwiftbookApp
//
//  Created by Alexey Efimov on 04/08/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UIKit

protocol CellModelRepresentable {
    var cellModel: CellIdentifiable? { get set }
}

class CourseTableViewCell: UITableViewCell, CellModelRepresentable {
    var cellModel: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    func configure(with course: Course) {
        var content = defaultContentConfiguration()
        content.text = course.name
        guard let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) else { return }
        content.image = UIImage(data: imageData)
        contentConfiguration = content
    }
    
    private func updateViews() {
        guard let cellModel = cellModel as? CourseCellViewModel else {
            return
        }
        var content = defaultContentConfiguration()
        content.text = cellModel.name
        if let imageData = ImageManager.shared.fetchImageData(from: cellModel.imageURL) {
            content.image = UIImage(data: imageData)
        }
        contentConfiguration = content

    }
}
