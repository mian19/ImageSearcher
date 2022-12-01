//
//  ViewController.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {

    var viewModel: MainViewModel!
    weak var coordinator: AppCoordinator?
    
    var addTagButton: UIButton!
    var searchButton: UIButton!
    var tagTextField: TagTextField!
    var sortButton: UIButton!
    var trashButton: UIButton!
    var tagsCollectionView: TagsCollectionView!
    var imagesCollectionView: ImagesCollectionView!
    var sortPickerView: UIPickerView!
    var sortView: SortView!
    var blurEffectView: UIVisualEffectView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        bindViewModel()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .medium)]
        title = "Flickr Client"

    }
    
    private func setViews() {
        view.backgroundColor = UIColor.init(rgb: 0x0e0e0e)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(focus))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
        
        setTagTextField()
        setAddTagButton()
        setSearchButton()
        setSortButton()
        setTrashButton()
        setTagsCollectionView()
        setImagesCollectionView()
    }
    
    private func setTagTextField() {
        tagTextField = TagTextField()
        view.addSubview(tagTextField)
        tagTextField.delegate = self
        
        tagTextField.heightAnchor.constraint(equalToConstant: 40.adjustSize()).isActive = true
        tagTextField.widthAnchor.constraint(equalToConstant: 300.adjustSize()).isActive = true
        tagTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.adjustSize()).isActive = true
        tagTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    
    private func setAddTagButton() {
        addTagButton = UIButton.actionButton(imageName: "plus")
        view.addSubview(addTagButton)
        
        addTagButton.addTarget(self, action: #selector(onAddTagButton), for: .touchUpInside)
        
        addTagButton.heightAnchor.constraint(equalToConstant: 25.adjustSize()).isActive = true
        addTagButton.widthAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        addTagButton.leadingAnchor.constraint(equalTo: tagTextField.trailingAnchor, constant: 15.adjustSize()).isActive = true
        addTagButton.centerYAnchor.constraint(equalTo: tagTextField.centerYAnchor).isActive = true
    }
    
    private func setSearchButton() {
        searchButton = UIButton.actionButton(imageName: "magnifyingglass")
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(onSearchButton), for: .touchUpInside)
        
        searchButton.heightAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.adjustSize()).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: tagTextField.centerYAnchor).isActive = true
    }
    
    private func setSortButton() {
        var imageName = ""
        if #available(iOS 15, *) {
            imageName = "line.3.horizontal"
        } else {
            imageName = "line.horizontal.3"
        }
        sortButton = UIButton.actionButton(imageName: imageName)
        view.addSubview(sortButton)
        sortButton.isHidden = true
        sortButton.addTarget(self, action: #selector(onSortButton), for: .touchUpInside)
        
        sortButton.heightAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        sortButton.widthAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        sortButton.leadingAnchor.constraint(equalTo: tagTextField.leadingAnchor).isActive = true
        sortButton.topAnchor.constraint(equalTo: tagTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setTrashButton() {
        trashButton = UIButton.actionButton(imageName: "trash")
        view.addSubview(trashButton)
        trashButton.isHidden = true
        trashButton.addTarget(self, action: #selector(onTrashButton), for: .touchUpInside)
        
        trashButton.heightAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        trashButton.widthAnchor.constraint(equalTo: addTagButton.heightAnchor).isActive = true
        trashButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor).isActive = true
        trashButton.topAnchor.constraint(equalTo: tagTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setTagsCollectionView() {
        tagsCollectionView = TagsCollectionView()
        view.addSubview(tagsCollectionView)
        tagsCollectionView.vcDelegate = self
        
        tagsCollectionView.topAnchor.constraint(equalTo: trashButton.topAnchor).isActive = true
        tagsCollectionView.leadingAnchor.constraint(equalTo: sortButton.trailingAnchor, constant: 10).isActive = true
        tagsCollectionView.heightAnchor.constraint(equalTo: sortButton.heightAnchor).isActive = true
        tagsCollectionView.trailingAnchor.constraint(equalTo: trashButton.leadingAnchor, constant: -10).isActive = true
    }
    
    private func setImagesCollectionView() {
        imagesCollectionView = ImagesCollectionView()
        view.addSubview(imagesCollectionView)
        imagesCollectionView.vcDelegate = self
        
        imagesCollectionView.topAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor, constant: 10).isActive = true
        imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
    
    //MARK: - Bindings
    
    func bindViewModel() {
        viewModel?.textFieldText.bind({(textFieldText) in
            DispatchQueue.main.async {
                self.tagTextField.text = textFieldText
            }
        })
        
        viewModel?.tags.bind({(tags) in
            DispatchQueue.main.async {
                self.tagsCollectionView.reloadData()
            }
        })
        
        viewModel?.alertMessage.bind({ (alertMessage) in
            DispatchQueue.main.async {
                self.alert(message: alertMessage)
            }
        })
        
        viewModel?.isTagsEmpty.bind({ (isTags) in
            DispatchQueue.main.async {
                if isTags != self.trashButton.isHidden {
                self.trashButton.isHidden.toggle()
                self.sortButton.isHidden.toggle()
                }
            }
        })
        
        viewModel?.photosWithInfo.bind({ (photosWithInfo) in
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        })
    }
    
    //MARK: - Actions
    
    @objc private func focus() {
        view.endEditing(true)
    }
    
    @objc private func onSortButton() {
        focus()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        sortView = SortView(pickerDelegate: self, selectedRow: viewModel?.selectedRow.value ?? 0)
        view.addSubview(sortView)
        sortView.center = view.center
        let tapOnBlur = UITapGestureRecognizer(target: self, action: #selector(onBlurEffectView))
        blurEffectView.addGestureRecognizer(tapOnBlur)
    }
    
    @objc private func onAddTagButton() {
        viewModel?.addTagButtonPressed(tag: tagTextField.text)
    }
    
    @objc private func onSearchButton() {
        viewModel.searchButtonPressed()
        focus()
    }
    
    @objc private func onTrashButton() {
        viewModel?.trashButtonPressed()
    }
    
    @objc private func onBlurEffectView() {
        blurEffectView.removeFromSuperview()
        sortView.removeFromSuperview()
    }

}

//MARK: - work with sortPickerView
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        SortRule.allCases.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SortRule.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return  NSAttributedString(string: SortRule.allCases[row].rawValue, attributes: [.foregroundColor : UIColor.init(rgb: 0xffffff)])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.sortButtonPressed(sortRule: SortRule.allCases[row], selectedRow: row)
    }
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onAddTagButton()
        return true
    }
}
