//
//  ViewController.swift
//  sampleCollectionView
//
//  Created by Eriko Ichinohe on 2016/02/11.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate  {

    var musicList:[NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //itunesのAPIからmaroon5の情報を20件取得
        var url = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=marron5&limit=20")
        var request = URLRequest(url:url!)
        var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        let jsonDictionary = (try! JSONSerialization.jsonObject(with: jsondata, options: [])) as! NSDictionary
        for(key, data) in jsonDictionary{
            //print("\(key)=\(data)")
            if (key as! String == "results"){
                var resultArray = data as! NSArray
                for (eachMusic) in resultArray{
                    var dicMusic:NSDictionary = eachMusic as! NSDictionary
                
                    print(dicMusic["artworkUrl100"])
                    print(dicMusic["trackName"])
                    var newMusic:NSDictionary = ["name":dicMusic["trackName"] as! String,"image":dicMusic["artworkUrl100"] as! String]
                    
                    musicList.append(newMusic)
                }
                
                
            
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//        cell.title.text = "タイトル";
//        cell.image.image = UIImage(named: "berry.png")
        
        
        let url = URL(string: musicList[indexPath.row]["image"] as! String);
        var err: NSError?;
        let imageData :Data = (try! Data(contentsOf: url!,options: NSData.ReadingOptions.mappedIfSafe));
        let img = UIImage(data:imageData);
        
        cell.title.text = musicList[indexPath.row]["name"] as! String;
        cell.image.image = img
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }

}

