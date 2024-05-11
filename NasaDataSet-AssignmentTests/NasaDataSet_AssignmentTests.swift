//
//  NasaDataSet_AssignmentTests.swift
//  NasaDataSet-AssignmentTests
//
//  Created by Hsu Hua on 2024/4/25.
//

import XCTest
import UIKit
@testable import NasaDataSet_Assignment

final class NasaDataSet_AssignmentTests: XCTestCase {
    
    var viewController: PlanetsViewController!
    var detailsViewController: DetailsViewController!
    
    override func setUp() {
        super.setUp()
        viewController = PlanetsViewController()
        detailsViewController = DetailsViewController()
        viewController.loadViewIfNeeded()
        detailsViewController.loadViewIfNeeded()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPlanets() async throws {
        // Arrange
        let apiManager = ApiManager.shared
        
        // Act
        do {
            let planets = try await apiManager.fetchPlanets()
            
            // Assert
            XCTAssertGreaterThan(planets.count, 0, "Number of planets fetched should be greater than 0")
            
            // Additional assertions if needed
            for planet in planets {
                XCTAssertFalse(planet.title.isEmpty, "Planet title should not be empty")
                XCTAssertNotNil(planet.url, "Planet URL should not be nil")
                XCTAssertEqual(planet.mediaType, "image", "Planet media type should be 'image'")
                XCTAssertNotNil(planet.hdurl, "Planet HDURL should not be nil")
            }
            
        } catch {
            XCTFail("Error fetching planets: \(error)")
        }
    }

    func testLoadImageSuccess() {
        // Arrange
        let imageLoader = ImageLoader.shared
        let imageURL = URL(string: "https://apod.nasa.gov/apod/image/2001/QuadrantidsChineseGreatWall_1067.jpg")!

        let expectation = self.expectation(description: "Image loaded successfully")
        
        // Act
        imageLoader.loadImage(from: imageURL) { result in
            // Assert
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "Image should not be nil")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Error loading image: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
        
    func testLoadImageFailure() {
        // Arrange
        let imageLoader = ImageLoader.shared
        let invalidImageURL = URL(string: "https://example.com/invalid_image.jpg")! // 這個 URL 應該返回 404
        
        let expectation = self.expectation(description: "Image loading should fail")
        
        // Act
        imageLoader.loadImage(from: invalidImageURL) { result in
            // Assert
            switch result {
            case .success(_):
                XCTFail("Loading image should fail")
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSetupActivityIndicator() {
        // Act
        
        detailsViewController.setupScrollView()
        
        // Assert
        XCTAssertNotNil(detailsViewController.activityIndicator.superview, "ActivityIndicator should be added to the view hierarchy")
        XCTAssertNotNil(detailsViewController.loadingLabel.superview, "LoadingLabel should be added to the view hierarchy")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// Mock ImageLoader for testing
class MockImageLoader: ImageLoader {
    var shouldFail = false
    
    override func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if shouldFail {
            completion(.failure(APIError.invalidURL))
        } else {
            completion(.success(UIImage()))
        }
    }
}
