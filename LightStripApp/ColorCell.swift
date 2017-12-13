import UIKit

class ColorCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 6;
        
    }
    
}

