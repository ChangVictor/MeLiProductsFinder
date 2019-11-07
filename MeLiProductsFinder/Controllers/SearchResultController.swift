//
//  SearchResultsController.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 21/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class SearchResultsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var itemViewModel = [ItemViewModel]()
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let footerId = "footerId"

    private var searchResultViewModel = SearchResultViewModel()

    private var searchTerm: String?
    private var resultAmount = 0
    private var isPaginating: Bool = false
    private var isDonePaginating: Bool = false
    
    private let searchBar = UISearchBar()
    private var timer: Timer?
    
    // MARK: - Controller's Lifecycle

    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

        searchResultViewModel.fetchItemsFromService(self.searchTerm ?? "") {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        collectionView.register(ResultsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        setupNavigationStyle()
        setupSearchBar()
        setupLayout()
        setupViewModel()
        setupToolbar()
        setupKeyboardGestures()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Methods

    fileprivate func setupViewModel() {
        
        searchResultViewModel.isSearchTextFieldValid = { [unowned self] searchTerm in
            self.searchResultViewModel.shouldTriggerSearch(searchTerm)
            }
        searchResultViewModel.onItemsFetched = { [unowned self] itemViewModel, resultAmount in
            self.itemViewModel = itemViewModel ?? []
            self.resultAmount = resultAmount ?? 0
            DispatchQueue.main.async {
                self.searchTerm = self.searchBar.text
                self.collectionView.reloadData()
            }
        }
        searchResultViewModel.onFetchError = { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.alertMessage(message: "Ocurrio un problema!\nPor favor vuelva a intentarlo mas tarde", title: "Oops!")
                    Logger.print(error)
                }
            }
        }
    }
    
    fileprivate func setupLayout() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView!.collectionViewLayout = layout
    }
    
    fileprivate func setupNavigationStyle() {
        
        navigationItem.titleView = searchBar
        collectionView.backgroundColor = .meliLightGrey
        navigationController?.navigationBar.barTintColor = .meliYellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.meliBlack]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .meliBlack
        navigationItem.backBarButtonItem?.tintColor = .meliBlack
    }
    
    fileprivate func setupSearchBar() {
        
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        extendedLayoutIncludesOpaqueBars = true
        searchBar.layer.cornerRadius = 30
        searchBar.clipsToBounds = true
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .meliWhite
        searchBar.placeholder = "Buscar en Mercado Libre"
        searchBar.text = self.searchTerm
    }
    
    fileprivate func setupKeyboardGestures() {
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        tapGestureReconizer.cancelsTouchesInView = false
        collectionView.keyboardDismissMode = .onDrag
        view.addGestureRecognizer(tapGestureReconizer)
    }
    
    @objc fileprivate func handleKeyboardDismiss() {
        view.endEditing(true)
    }
    
    fileprivate func setupToolbar() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 40)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismisKeyboard))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        searchBar.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc fileprivate func dismisKeyboard() {
        searchBar.searchTextField.resignFirstResponder()
        print("done button pressed")
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    convenience init(searchTerm: String) {
        self.init()
        self.searchTerm = searchTerm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinitializing SearchResultController...")
    }
}

    // MARK: - Delegates & Datasource

extension SearchResultsController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 4, height: 180)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemViewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let item = itemViewModel[indexPath.item]
        cell.itemViewModel = item
        
        //MARK: Pagination
        if indexPath.item == itemViewModel.count - 10 && !isPaginating {
            Logger.print("Fetching more items...")
            isPaginating = true
            guard let searchTerm = self.searchTerm else { return cell }
            searchResultViewModel.paginateMoreItems(searchTerm) { [weak self] (itemViewModel) in
                guard let itemCount = itemViewModel?.count else { return }
                if itemCount == 0 {
                    self?.isDonePaginating = true
                }
                Logger.print("\(itemCount) items fetched")
                sleep(2)
                self?.itemViewModel += itemViewModel ?? []
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                self?.isPaginating = false
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = DetailController()
        detailController.itemViewModel = itemViewModel[indexPath.item]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
      switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ResultsHeader
            headerView.resultsQuantity = self.resultAmount
            return headerView
        
        case UICollectionView.elementKindSectionFooter:
           let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
           return footer
        
        default:
            assert(false, "Unexpected element kind")
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height: CGFloat = self.resultAmount == 0 ? 0 : 50
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
}

extension SearchResultsController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.searchResultViewModel.searchTerm = searchText
        })
    }
}

extension SearchResultsController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !collectionView.isDecelerating {
            view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

