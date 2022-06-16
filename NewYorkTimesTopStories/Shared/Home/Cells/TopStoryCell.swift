//
//  TopStoryCell.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

class TopStoryCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: self.superview?.frame.width ?? containerView.frame.width,
                      height: contentView.frame.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 8
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.grey60.cgColor
        cardView.renderShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    func configure(with viewModel: CellViewModelProtocol) {
        guard let viewModel = viewModel as? TopStoryCellViewModel else { return }
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        if let urlString = viewModel.imageURL, let url = URL(string: urlString) {
            setupImage(with: url)
        } else {
            imageView.image = UIImage(named: "image_placeholder")
        }
    }
    
    func setupImage(with link: URL) {
        imageView.loadImage(from: link)
    }
}
