//
//  SettingsViewController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

protocol SectionsDelegate: AnyObject {
    func setSectionName(_ section: String)
}

struct AppKey {
    static let sectionName = "Section"
    static let sectionIndex = ""
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SectionsDelegate?
    
    var settingView = SettingsView()
    
    override func loadView() {
        view = settingView
    }
    
    let topStories = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "Realestate", "Science", "Sports", "Sundayreview", "Technology", "Theater", "T-magazine", "Travel", "Upshot", "Us","World"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        settingView.pickerView.dataSource = self
        settingView.pickerView.delegate = self
        saveSection()
    }
    
    func saveSection() {
        if let sectionName = UserDefaults.standard.object(forKey: AppKey.sectionName) as? String,
        let index = UserDefaults.standard.object(forKey: AppKey.sectionIndex) as? Int  {
            navigationController?.title = sectionName
            settingView.pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topStories.count
    }
    
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topStories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let section = topStories[row]
        delegate?.setSectionName(section)
        UserDefaults.standard.set(section, forKey: AppKey.sectionName)
        UserDefaults.standard.set(row, forKey: AppKey.sectionIndex)
    }
}
