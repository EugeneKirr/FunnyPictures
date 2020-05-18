//
//  FunnyPicturesUITests.swift
//  FunnyPicturesUITests
//
//  Created by Eugene Kireichev on 17/05/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import XCTest

class FunnyPicturesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    let photoTag = "Nature"

    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPhotoViewerTabBarItemAsyncInteraction() {
        
        app.tables.staticTexts[photoTag].tap()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["gear"].tap()
        sleep(2)
        app.tabBars.buttons["house.fill"].tap()
        sleep(2)
        app.buttons["Next Photo"].tap()
        tabBarsQuery.buttons["gear"].tap()
        sleep(2)
        app.tabBars.buttons["house.fill"].tap()
        sleep(2)
    
    }
    
    func testPhotoViewerNavBarItemAsyncInteraction() {
        
        app.tables.staticTexts[photoTag].tap()
        app.navigationBars[photoTag].buttons["Menu"].tap()
        sleep(2)
        app.tables.staticTexts[photoTag].tap()
        app.navigationBars[photoTag].buttons["Menu"].tap()
        sleep(2)
        
    }
    
    func testCollectionViewerButtonAsyncInteraction() {
        
        app.tabBars.buttons["star.fill"].tap()
        sleep(2)
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        element.tap()
        sleep(2)
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        sleep(2)
        
    }
    
    func testMyCollectionTabBarItemAsyncInteraction() {
        
        sleep(2)
        app.tabBars.buttons["star.fill"].tap()
        app.tabBars.buttons["gear"].tap()
        sleep(2)
        app.tabBars.buttons["star.fill"].tap()
        app.tabBars.buttons["house.fill"].tap()
        sleep(2)
        
    }

}
