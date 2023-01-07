//
//  ViewController.swift
//  app13
//
//  Created by Ahmet Bostancıklıoğlu on 6.01.2023.
//

import UIKit


//MARK: - URL is decoded onto array Model struct
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo { resp in
            print("1-", resp[0].modelTitle)
            print("2-", resp[1].modelTitle)
            print("3-", resp[2].modelTitle)
            print("4-", resp[3].modelTitle)
        }
    }
    
    func getInfo(completion: @escaping ([Model]) -> ()) {
        let URL = "Type a URL to here"
        guard let urlString = URL(string: URL) else {return}
        let _: Void = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if  error == nil, let data = data {
                do {
                    let responseData = try JSONDecoder().decode([Model].self, from: data)
                    completion(responseData)
                
                } catch {
                    print(error.localizedDescription)
                }
                
            }else {
                print(error?.localizedDescription ?? "1")
            }
            
        }.resume()
        
    }
}

//MARK: Customize Model Struct according to your URL
struct Model: Codable {
    var ModelIdOfuser: Int
    var idOfModel: Int
    var modelTitle: String
    var modelCompleted: Bool
}
