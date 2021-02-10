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
    
    var activeLayout: Layout = .grid

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
        var updated = dataSource.snapshot()
        updated.deleteSections([.restaurants])
        updated.appendSections([.restaurants])
        updated.appendItems(filteredRestaurants, toSection: .restaurants)
        dataSource.apply(updated, animatingDifferences: true, completion: nil)
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        /// set up search controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.title = "My Restaurants"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(systemName:
                                                                            "rectangle.grid.1x2"), style: .plain, target: self, action: #selector(toggleLayout(_:)))
        
        
        collectionView.backgroundColor = .systemGray5
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
        
        /// create snapshot object
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        /// add section
        snapshot.appendSections([.categories, .restaurants])
        /// add items to the added section
        snapshot.appendItems(Item.filterItem, toSection: .categories)
        snapshot.appendItems(Item.myrestaurants, toSection: .restaurants)
        /// update section array
        sections = snapshot.sectionIdentifiers
        /// apply data source
        dataSource.apply(snapshot)
        
    }
    
    func resetFilter() {
        var updated = dataSource.snapshot()
        updated.deleteSections([.restaurants])
        updated.appendSections([.restaurants])
        updated.appendItems(Item.myrestaurants, toSection: .restaurants)
        dataSource.apply(updated, animatingDifferences: true, completion: nil)
    }
    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {

            guard let category = Item.filterItem[indexPath.item].category?.name else {return }
            
            for index in 0...Item.myrestaurants.count - 1 {
                /// check category
                let item = Item.myrestaurants[index]
                guard let restrauntCategory = item.restaurant?.restaurantCategory else {return}
                for i in 0...restrauntCategory.count - 1 {
                    if restrauntCategory[i].name == category {
                        filteredRestaurants.append(item)
                    }
                }
                /// check mealTime
                guard let mealTimes = item.restaurant?.mealTime else {return}
                for i in 0...mealTimes.count - 1 {
                    if mealTimes[i].name == category {
                        filteredRestaurants.append(item)
                    }
                }
                
            }
            /// update snapshot here
            var updated = dataSource.snapshot()
            updated.deleteSections([.restaurants])
            updated.appendSections([.restaurants])
            updated.appendItems(filteredRestaurants, toSection: .restaurants)
            dataSource.apply(updated, animatingDifferences: true, completion: nil)
        }
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCategory = collectionView.indexPathsForSelectedItems?.count
        
        if selectedCategory == 0 {
            resetFilter()
        } else {
            // get category deselected
            if let category = Item.filterItem[indexPath.item].category?.name{
                    for index in 0...filteredRestaurants.count - 1 {
                        if filteredRestaurants.count == 0 {
                            resetFilter()
                            break
                        } else {
                                
                                let restaurant = filteredRestaurants[index].restaurant
                                
                                /// check meal time
                                guard let mealTime = restaurant?.mealTime else {return }
                                for i in 0...mealTime.count - 1{
                                    if mealTime[i].name == category {
                                        var updated = dataSource.snapshot()
                                        updated.deleteItems([filteredRestaurants[index]])
                                        dataSource.apply(updated, animatingDifferences: true, completion: nil)
                                    }
                                }
                                /// check category
                                guard let categories = restaurant?.restaurantCategory else {return}
                                for i in 0...categories.count - 1 {
                                    if categories[i].name == category {
                                        var updated = dataSource.snapshot()
                                        updated.deleteItems([filteredRestaurants[index]])
                                        dataSource.apply(updated, animatingDifferences: true, completion: nil)
                                        print("deleted? \(filteredRestaurants)")
                                    }
                                }
                        }
            }
                    }
                }
            }
    }
    
