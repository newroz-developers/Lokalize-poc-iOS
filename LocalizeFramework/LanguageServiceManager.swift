//
//  LanguageServiceManager.swift
//  Localize
//
//  Created by Newroz Tech on 4/7/21.
//

import Foundation
import UIKit

struct DictionaryLanguage: Codable {
    let code: String
    var fullName: String
}

class LanguageServiceManager {
    private static var privateSharedInstance: LanguageServiceManager?
    static var sharedInstance: LanguageServiceManager {
        if privateSharedInstance == nil {
            privateSharedInstance = LanguageServiceManager()
            //privateSharedInstance?.commonInit()
        }
        return privateSharedInstance!
    }
//    var labelView:UIVisualEffectView = UIVisualEffectView()
//    var labelVerifying:UILabel = UILabel()
//    var spinner:UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
//    func commonInit() {
//            languagesArray = LocalizationManager.sharedInstance.getLocalLanguageVersions()
//    }
    var languagesArray: [DictionaryLanguage]!
    
    
//    func getLanguagesFromServer(url: URL)  {
////        self.showLoading()
//        let task = URLSession.shared.dataTask(with: url as URL) { data, response, error in
////            self.dismissLoading()
//            guard let dataResponse = data,
//                error == nil else {
//                    print(error?.localizedDescription ?? "Response Error")
//                    return }
//            do{
//                let jsonResponse = try JSONSerialization.jsonObject(with:
//                    dataResponse, options: []) as?  [String : Any]
//                if let languagesArray = jsonResponse!["languages"] as? [[String : Any]] {
//                    for lang in languagesArray {
//                        let translations = lang["translations"] as? Dictionary<String,String>
//                        let langName = lang["code"] as? String
//                        let dict : Dictionary<String, Dictionary<String, String>> = [langName!: translations!]
//                        print(dict)
//                        let rt = Localizable(translations:dict)
//                        do {
//                            _ = try rt.writeToBundle()
//                            
//                        }catch {
//                            print("error")
//                        }
//                    }
//                }
//            } catch let parsingError {
//                print("Error", parsingError)
//            }
//        }
//        
//        task.resume()
//
//    }
    
    func getLanguagesFromServer(url: URL, completion: @escaping (Bool) -> ()){
        let task = URLSession.shared.dataTask(with: url as URL) { data, response, error in
//            self.dismissLoading()
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as?  [String : Any]

                if let languagesArray = jsonResponse!["languages"] as? [[String : Any]] {
                    for lang in languagesArray {
                        var translations: Dictionary<String,String> = [:]
                        if let translationArray = lang["translation"] as? [[String : String]] {
                            for trans in translationArray{
                                let key = trans["key"]
                                let value = trans["value"]
                                translations[key!] = value
                            }
                        }
//                        let translations = lang["translation"] as? Dictionary<String,String>
                        let langName = lang["languageCode"] as? String
                        let dict : Dictionary<String, Dictionary<String, String>> = [langName!: translations]
                        print(dict)
                        let rt = Localizable(translations:dict)
                        do {
                            _ = try rt.writeToBundle()
                            DispatchQueue.main.async {
                                completion(true)
                            }
                            
                        }catch {
                            print("error")
                        }
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        task.resume()

    }

//    func showLoading(){
//        if  let window = UIApplication.shared.delegate!.window {
//            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
//            labelVerifying.removeFromSuperview()
//            labelView.removeFromSuperview()
//            labelVerifying = UILabel(frame: CGRect(x: 0, y: 0, width: 195, height: 25))
//            labelVerifying.textAlignment = .center
//            labelVerifying.center = (window?.center)!
//            labelVerifying.frame = CGRect(x: labelVerifying.frame.origin.x,
//                                          y: labelVerifying.frame.origin.y + 40,
//                                          width: labelVerifying.frame.width,
//                                          height: labelVerifying.frame.height)
//            labelVerifying.text = "Downloading Language Files"
//            labelVerifying.textColor = UIColor.darkGray
//            labelView.effect = blurEffect
//            labelView.contentView.addSubview(spinner)
//            labelView.backgroundColor = UIColor(white: 1, alpha: 1)
//            labelView.contentView.addSubview(labelVerifying)
//            labelView.frame = (window?.bounds)!
//            spinner.center = ((window?.center)!)
//            spinner.startAnimating()
//
//            window?.addSubview(labelView)
//            UIView.animate(withDuration: 0.2, animations: { [unowned self] () -> Void in
//                self.labelView.alpha = 1
//            })
//        }
//    }
//    func dismissLoading() {
//        DispatchQueue.main.async()  { [weak self] () -> Void in
//            self?.labelView.removeFromSuperview()
//            self?.labelVerifying.removeFromSuperview()
//        }
//    }
}



extension UserDefaults {
    
    class var selectedLanguage:String {
        get {
            if (standard.string(forKey: "SelectedLanguage") == nil) {
                return "en"
            }
            else {
                return standard.string(forKey: "SelectedLanguage")!
            }
        }
        set {
            standard.set(newValue, forKey: "SelectedLanguage")
            standard.synchronize()
        }
    }
}
struct Constants {
    struct Notifications {
        static let LanguageChangeNotification = "LanguageChanged"
    }
//        struct Labels {
//    //        static let key1 = "key1"
//            static let key2 = "key2"
//            static let key3 = "key3"
//            static let key4 = "key4"
//            static let key5 = "key5"
//            static let key6 = "key6"
//            static let key7 = "key7"
//            static let key8 = "key8"
//            static let key9 = "key9"
//            static let key10 = "key10"
//        }
}
