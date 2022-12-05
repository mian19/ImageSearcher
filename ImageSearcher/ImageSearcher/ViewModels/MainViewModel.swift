//
//  MainViewModel.swift
//  ImageSearcher
//
//  Created by Kyzu on 29.11.22.
//

import Foundation

class MainViewModel {
    var textFieldText = Dynamic("")
    var alertMessage = Dynamic(AlertMessage.ok)
    var currentSortRule = Dynamic(SortRule.relevance)
    var selectedRow = Dynamic(0)
    var tags = Dynamic([String]())
    var isTagsEmpty = Dynamic(true)
    var pageNumber = Dynamic(1)
    var photosWithInfo = Dynamic([Photo]())
    var networkDataFetcher = NetworkDataFetcher()
    
    
    func addTagButtonPressed(tag: String?) {
        guard var tag = tag else { return }
        tag = tag.replacingOccurrences(of: " ", with: "").lowercased()
        checkIsTagNew(newTag: tag)
        textFieldText.value = ""
    }
    
    func searchButtonPressed() {
        photosWithInfo.value = []
        if tags.value == [] {
            alertMessage.value = .needAddTag
            return
        }
        fetchNextPage()
    }
    
    func trashButtonPressed() {
        tags.value = []
        isTagsEmpty.value = true
        pageNumber.value = 1
    }
    
    func sortButtonPressed(sortRule: SortRule, selectedRow: Int) {
        currentSortRule.value = sortRule
        self.selectedRow.value = selectedRow
    }
    
    private func checkIsTagNew(newTag: String) {
        if newTag.count == 0 {
            alertMessage.value = .emptyTag
            return
        }
        if !tags.value.contains(newTag) {
            tags.value.insert(newTag, at: 0)
            isTagsEmpty.value = false
        } else {
            alertMessage.value = .alredyTag
        }
    }
    
    func fetchDataFromServer(searchTags: String, sortBy: String, pageNumber: Int) {
        self.networkDataFetcher.fetchImages(searchTags: searchTags, sortBy: sortBy, pageNumber: pageNumber) { [weak self] searchResults in
            guard let fetchedPhotos = searchResults else { return}
            if fetchedPhotos.photos.pages == 0 {
                self?.alertMessage.value = .emptyResult
            }
            self?.photosWithInfo.value += fetchedPhotos.photos.photo
        }
    }
    
    func fetchNextPage() {
        fetchDataFromServer(searchTags: tags.value.joined(separator: ","), sortBy: currentSortRule.value.getSortRule(), pageNumber: pageNumber.value)
    }
}
