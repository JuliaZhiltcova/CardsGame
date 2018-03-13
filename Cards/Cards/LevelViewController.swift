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

    @IBOutlet weak var chooseLevelLabel: UILabel!
    @IBOutlet weak var levelCollectonView: UICollectionView!
    
    var levels = [Level]()
    
    private let leftAndRightPaddings: CGFloat = 32.0
    private let numberOfItemsPerRow: CGFloat = 5.0
    private let heightAdjastment: CGFloat = 30.0
    
    let reuseIdentifier = "levelCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelCollectonView.delegate = self
        levelCollectonView.dataSource = self

        createLevels()
        
        let width = (levelCollectonView!.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = /*collectionViewLayout as! */ levelCollectonView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width + heightAdjastment)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    

    
    func createLevels(){
        for number in 0..<GameSettings.ElementsPerRowAndColumn.count { 
            let level = Level(numberOfLevel: number + 1, imageName: "l\(number)")
            levels.append(level)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    

}

extension LevelViewController: UICollectionViewDataSource{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelViewCell
        
        let level = levels[indexPath.row]
        cell.levelImage.image = level.image
        cell.bestTimeLabel.text = String(level.numberOfLevel)
        
        return cell
    }
    
}

extension LevelViewController: UICollectionViewDelegate{
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
//        Level.currentLevel = levels[indexPath.row]
//        vc.game = Level.currentLevel.currentGame
        Level.currentLevel = levels[indexPath.row].numberOfLevel
        vc.game = levels[indexPath.row].currentGame
        self.navigationController?.pushViewController(vc, animated: true)
        
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
