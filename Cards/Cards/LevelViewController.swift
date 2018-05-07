//
//  LevelViewController.swift
//  Cards
//
//  Created by Admin on 04/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LevelViewController: UIViewController  {


    
    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var chooseLevelLabel: StrokedLabel!
   
    @IBOutlet weak var levelCollectonView: UICollectionView!
    @IBOutlet weak var rabbit: UIImageView!
    @IBOutlet weak var rat_left: UIImageView!
    
    

    fileprivate let itemsPerRow: CGFloat = 5.0
    
    fileprivate var insets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 40.0, right: 20.0)

    
    let reuseIdentifier = "levelCell"
    
    let levelsManager = LevelsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelCollectonView.delegate = self
        levelCollectonView.dataSource = self
        
        
      //  chooseLevelLabel.font = UIFont(name: "EjaRoundFilled", size: 40)
        chooseLevelLabel.strockedText = NSLocalizedString("Choose level", comment: "Choose level")
    }

    override func viewWillAppear(_ animated: Bool) {
        let heightConstraint = calculateCellSize().height * 2 + insets.top + insets.bottom + insets.left
        levelCollectonView.heightAnchor.constraint(equalToConstant: heightConstraint).isActive = true
        levelCollectonView.reloadData()
        
        rabbit.translatesAutoresizingMaskIntoConstraints = false
        rabbit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -self.view.bounds.width/8).isActive = true
        rabbit.centerYAnchor.constraint(equalTo: chooseLevelLabel.centerYAnchor, constant: 0).isActive = true
        rabbit.widthAnchor.constraint(equalToConstant: self.view.bounds.height/5).isActive = true
        rabbit.heightAnchor.constraint(equalToConstant: self.view.bounds.height/5).isActive = true
        
        rat_left.translatesAutoresizingMaskIntoConstraints = false
        rat_left.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: self.view.bounds.width/8).isActive = true
        rat_left.centerYAnchor.constraint(equalTo: chooseLevelLabel.centerYAnchor, constant: 0).isActive = true
        rat_left.widthAnchor.constraint(equalToConstant: self.view.bounds.height/5).isActive = true
        rat_left.heightAnchor.constraint(equalToConstant: self.view.bounds.height/5).isActive = true
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calculateCellSize() -> CGSize{
        let paddingSpace = (insets.left) * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }

}

extension LevelViewController: UICollectionViewDataSource{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LevelsManager.levels.count
    }
    
//     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelViewCell
//        
//        let level = LevelsManager.levels[indexPath.row]
//        cell.levelImage.image = level.image
//        cell.bestTimeLabel.strockedText = level.bestTime == nil ? "" : level.bestTime!.textDescription as String
//        
//        if (level.number == 1) {
//            
//        }
//        
//        if (level.number != 1) {
//            cell.isUserInteractionEnabled = level.isLocked == false
//        }
//        cell.lockImage.isHidden = level.isLocked == false
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelViewCell
        
        let level = LevelsManager.levels[indexPath.row]
        cell.levelImage.image = level.image
        cell.bestTimeLabel.strockedText = level.bestTime == nil ? "" : level.bestTime!.textDescription as String
        cell.lockImage.isHidden = false //level.bestTime != nil
        cell.isUserInteractionEnabled = false
        
        if (level.number == 1) {
            cell.isUserInteractionEnabled = true
            cell.lockImage.isHidden = true
            
        }
        if (level.number > 1) && (LevelsManager.levels[indexPath.row - 1].bestTime != nil){
            cell.isUserInteractionEnabled = true
            cell.lockImage.isHidden = true
        }
        
        return cell
    }
}


extension LevelViewController: UICollectionViewDelegate{
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        

        LevelsManager.currentLevel = LevelsManager.levels[indexPath.row]
        
        vc.game = LevelsManager.levels[indexPath.row].currentGame
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension LevelViewController : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
}


//override func viewWillLayoutSubviews() {
/*  cardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
 let horizontalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
 let verticalConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
 
 let widthConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Settings.widthConstant)
 
 let heightConstraint = NSLayoutConstraint(item: cardsCollectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: Settings.heightConstant)
 
 view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
 cardsCollectionView.backgroundColor = UIColor.green */

//     chooseLevelLabel.translatesAutoresizingMaskIntoConstraints = false
//     chooseLevelLabel.backgroundColor = UIColor.clear

//       let leadingLabelConstraint = chooseLevelLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//       let trailingLabelConstraint = chooseLevelLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//       let topLabelConstraint = chooseLevelLabel.topAnchor.constraint(equalTo: self.view.topAnchor)
//  let bottomConstraint = colorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
//      let heightLabelConstraint = NSLayoutConstraint(item: chooseLevelLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.bounds.height/6)

//      view.addConstraints([leadingLabelConstraint, trailingLabelConstraint, topLabelConstraint, heightLabelConstraint])

//       let leadingCVConstraint = levelCollectonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//       let trailingCVConstraint = levelCollectonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//    let topCVConstraint = heightLabelConstraint//levelCollectonView.topAnchor.constraint(equalTo: self.view.topAnchor)
//       let bottomCVConstraint = levelCollectonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor/*, constant: -50*/)
//     levelCollectonView.backgroundColor = UIColor.green

//      view.addConstraints([leadingCVConstraint, trailingCVConstraint, topCVConstraint, bottomCVConstraint])
//  view.addConstraints([heightLabelConstraint, topCVConstraint])

//   }


// print(Unmanaged<AnyObject>.passUnretained(LevelsManager.currentLevel as AnyObject).toOpaque())
// print(Unmanaged<AnyObject>.passUnretained(LevelsManager.levels[indexPath.row] as AnyObject).toOpaque())
