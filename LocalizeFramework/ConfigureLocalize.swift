//
//  ConfigureLocalize.swift
//  LocalizeFramework
//
//  Created by Newroz Tech on 6/7/21.
//

import Foundation


public class ConfigureLocalize {
    
    public init() {
        
    }
    
    public var selectedLanguage = UserDefaults.selectedLanguage
    public func SetLocalizableApi(url: String, completion: @escaping (Bool) -> ()){
        LanguageServiceManager.sharedInstance.getLanguagesFromServer(url: URL(string: url)!) { success in
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
    
    public func NotifyUpdateLaguage(){
        NotificationCenter.default.post(name: Notification.Name(Constants.Notifications.LanguageChangeNotification), object: nil)
    }
    public func SetLocalizableLanguage(languageCode: String){
        LocalizationManager.sharedInstance.setCurrentBundle(forLanguage: languageCode)
        UserDefaults.selectedLanguage = languageCode
        NotifyUpdateLaguage()
    }
    
}

public extension String{
    
    func Localized() -> String{
        
        let boundle = LocalizationManager.sharedInstance.currentBundle
        return NSLocalizedString(self, tableName: "", bundle: boundle, value: "", comment: "")
    }
}
