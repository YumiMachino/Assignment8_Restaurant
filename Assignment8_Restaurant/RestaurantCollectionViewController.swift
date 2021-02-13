//
//  RestaurantCollectionViewController.swift
//  Assignment8_Restaurant
//
//  Created by Yumi Machino on 2021/02/06.
//

import UIKit

class RestaurantCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    // MARK: Section Definitions
    enum Section: Hashable {
        case categories
        case restaurants
    }
    
    var sections = [Section]()
    
    /// collection view layout type setting
    enum Layout {
        case grid
        case column
    }
    
    var activeLayout: Layout = .grid {
        didSet {
            switch self.activeLayout {
            case .grid:
                self.layoutButton.image = UIImage(systemName: "rectangle.grid.1x2")
            case .column:
                self.layoutButton.image = UIImage(systemName: "square.grid.2x2")
            }
            collectionView.contentOffset.y = 0
        }
    }
    //    var activeLayout: Layout = .grid
    
    lazy var layoutButton : UIBarButtonItem = {
        let btn = UIBarButtonItem(image:  UIImage(systemName: "rectangle.grid.1x2"), style: .done, target: self, action: #selector(toggleLayout(_:)))
        return btn
    }()
    
    /// store filtered restaurant items
    lazy var filteredRestaurants: [Item] = []
    
    /// Set up DataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    /// create a searchController
    let searchController = UISearchController()
    
    func updateSearchResults(for searchController: UISearchController) {
        /// search by restaurant name
        
        if let searchString = searchController.searchBar.text, !searchString.isEmpty {
            filteredRestaurants = Item.myrestaurants.filter({ ($0.restaurant?.restaurantName.localizedCaseInsensitiveContains(searchString))!
            })
        } else {
            filteredRestaurants = Item.myrestaurants
        }
        /// update snapshot here
        createSnapshot(from: filteredRestaurants)
        filteredRestaurants = []
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// set up search controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.title = "My Restaurants"
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.leftBarButtonItem = layoutButton
        
        
        collectionView.backgroundColor = .white
        /// set collectionView layout
        collectionView.setCollectionViewLayout(generateGridLayout(), animated: false, completion: nil)
        
        ///  Register cell classes
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier)
        
        collectionView.allowsMultipleSelection = true
        configureDataSource()
        
    }
    
    @objc
    func toggleLayout(_ sender: UIBarButtonItem){
        // active layout change
        if activeLayout == .grid {
            activeLayout = .column
            collectionView.setCollectionViewLayout(generateColumnLayout(), animated: true)
            
        } else if activeLayout == .column {
            activeLayout = .grid
            collectionView.setCollectionViewLayout(generateGridLayout(), animated: true)
        }
    }
    
    
    /// create initial layout
    private func generateGridLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let spacing: CGFloat = 8
            let section = self.sections[sectionIndex]
            switch section {
            case .categories:
                // Section 1: Filter items
                /// create 1 filter items: make use of estimate width
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: spacing * 1.5,
                                                             leading: spacing,
                                                             bottom: spacing,
                                                             trailing: spacing * 1.5)
                /// create a group
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200),
                                                       heightDimension: .estimated(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 2)
                /// create a section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
                
            case .restaurants:
                // Section 2: Restaurant items
                /// relative to group
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // set insets against group size
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing / 2, bottom: 0, trailing: spacing / 2)
                
                /// define a group in a row
                /// ralative to section
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/4))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                group.contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: spacing, bottom: spacing / 2, trailing: spacing)
                /// create a section
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
        return layout
    }
    
    private func generateColumnLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let spacing: CGFloat = 8
            let section = self.sections[sectionIndex]
            switch section {
            case .categories:
                // Section 1: Filter items
                /// create 1 filter items: make use of estimate width
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: spacing * 1.5,
                                                             leading: spacing,
                                                             bottom: spacing,
                                                             trailing: spacing * 1.5)
                /// create a group
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200),
                                                       heightDimension: .estimated(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 2)
                /// create a section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
                
            case .restaurants:
                // Section 2: Restaurant items
                /// relative to group
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // set insets against group size
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing / 2, bottom: 0, trailing: spacing / 2)
                
                /// define a group in a row
                /// ralative to section
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: spacing, bottom: spacing / 2, trailing: spacing)
                /// create a section
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
        return layout
    }
    
    
    
    /// initialize the dataSource
    func configureDataSource() {
        
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
                cell.configureCell(item.category!)
                
                return cell
            case .restaurants:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
                cell.configureCell(restaurant: item.restaurant!)
                
                return cell
            }
        })
        createSnapshot(from: Item.myrestaurants)
    }
    
    /// capture snapshot
    private func createSnapshot(from filteredItem: [Item]) {
        /// create snapshot object
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        /// add section
        snapshot.appendSections([.categories, .restaurants])
        /// add items to the added section
        snapshot.appendItems(Item.filterItem, toSection: .categories)
        snapshot.appendItems(filteredItem, toSection: .restaurants)
        /// update section array
        sections = snapshot.sectionIdentifiers
        /// apply data source
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    func resetFilter() {
        var updated = dataSource.snapshot()
        updated.deleteSections([.restaurants])
        updated.appendSections([.restaurants])
        updated.appendItems(Item.myrestaurants, toSection: .restaurants)
        filteredRestaurants = []
        dataSource.apply(updated, animatingDifferences: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            guard let category = Item.filterItem[indexPath.item].category?.name else {return }
            /// category check
            for index in 0...Item.myrestaurants.count - 1 {
                /// check category
                let item = Item.myrestaurants[index]
                
                guard let restrauntCategory = item.restaurant?.restaurantCategory else {return}
                for i in 0...restrauntCategory.count - 1 {
                    if restrauntCategory[i].name == category {
                        filteredRestaurants.append(item)
                    }
                }
            }
            
            print("filtered restaurants: \(filteredRestaurants)")
            /// check mealTime
            if indexPath.item == 7 || indexPath.item == 8 || indexPath.item == 9 {
                guard let category = Item.filterItem[indexPath.item].category?.name else {return }
                var removedCount = 0
                let oldFilteredRestaurants = filteredRestaurants
                for i in 0...oldFilteredRestaurants.count - 1 {
                    print("index; \(i)")
                    guard let mealTimes = oldFilteredRestaurants[i].restaurant?.mealTime else {return}
                    for n in 0...mealTimes.count - 1 {
                        if mealTimes[n].name != category {
                            print("removed")
                            filteredRestaurants.remove(at: i - removedCount)
                            removedCount += 1
                            break
                        }
                        break
                    }
                }
            }
            /// update snapshot here
            createSnapshot(from: filteredRestaurants)
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCategory = collectionView.indexPathsForSelectedItems?.count
        
        if selectedCategory == 0 {
            resetFilter()
        } else {
            /// get category deselected
            if let category = Item.filterItem[indexPath.item].category?.name{
                
                var removedCount = 0
                let oldFilteredRestaurants = filteredRestaurants
                print("oldFilterItems: \(oldFilteredRestaurants)")
                for index in 0...oldFilteredRestaurants.count - 1 {
                    print("index: \(index)")
                    if filteredRestaurants.count == 0 || oldFilteredRestaurants.count == 0 {
                        resetFilter()
                        break
                    } else {
                        let restaurantTobeDeleted = oldFilteredRestaurants[index].restaurant
                        /// check category
                        if let categories = restaurantTobeDeleted?.restaurantCategory {
                            for i in 0...categories.count - 1 {
                                if categories[i].name == category {
                                    
                                    filteredRestaurants.remove(at: index - removedCount)
                                    removedCount += 1
                                    createSnapshot(from: filteredRestaurants)
                                    break
                                    
                                }
                            }
                        }
                }
            }
                
                if indexPath.item == 7 || indexPath.item == 8 || indexPath.item == 9 {
                    print("ssssss")
                    print(collectionView.indexPathsForSelectedItems!)
                    guard let selectedCategory = collectionView.indexPathsForSelectedItems else {return}
                    for n in 0...Item.myrestaurants.count - 1{
                        let restaurant = Item.myrestaurants[n]
                        guard let categories = restaurant.restaurant?.restaurantCategory else {return}
                        for j in 0...categories.count - 1 {
                            for k in 0...selectedCategory.count - 1 {
                                if categories[j].name == Item.filterItem[selectedCategory[k].row].category?.name && !filteredRestaurants.contains(Item.myrestaurants[n]) {
                                    filteredRestaurants.append(Item.myrestaurants[n])
                                    createSnapshot(from: filteredRestaurants)
                                    break
                                }
                            }
                           
                        }
                    }
                }
            }
        }
        
    }
}
