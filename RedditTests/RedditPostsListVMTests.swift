//
//  RedditPostsListVMTests.swift
//  RedditPostsListVMTests
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import XCTest
@testable import Reddit

class RedditPostsListVMTests: XCTestCase {

    var sut: RedditPostsListVM!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut =  RedditPostsListVM()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testViewModelNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testDoesNotCreateRetainCycles() {
        weak var weakCellReference: RedditPostsListVM?
        autoreleasepool { () -> () in
            let strongReference = RedditPostsListVM()
            weakCellReference = strongReference
            XCTAssertNotNil(weakCellReference)
        }
        XCTAssertNil(weakCellReference)
    }

    func testFetchRequestCallbackOnSuccess() {
        sut.service = RedditPostsServiceSuccessStub()

        let exp = expectation(description: "Trigger should complete")
        sut.fetchPostsList { result  in
            if case .failure(let error) = result {
                XCTFail("error in retrival, \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }

    func testFetchRequestCallbackOnFailure() {
        sut.service = RedditPostsServiceFailureStub()

        let exp = expectation(description: "Trigger should complete")
        sut.fetchPostsList { result  in
            if case .success = result {
                XCTFail("Should not call sucess for failed apis)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }
    
    func testCellViewModelsProperty() {
        sut.service = RedditPostsServiceSuccessStub()
        let exp = expectation(description: "Trigger should complete")
        sut.fetchPostsList { _ in exp.fulfill()}
        waitForExpectations(timeout: 0.01)

        let expectedModel = sut.viewModelForItem(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(expectedModel?.title, "GOP Removes Page Praising Donald Trump's 'Historic' Peace Deal With Taliban")
        XCTAssertEqual(expectedModel?.score, "24.8K")
        XCTAssertEqual(expectedModel?.numComment, "1.2K")
        XCTAssertEqual(expectedModel?.thumbnail , "https://b.thumbs.redditmedia.com/RmJjCnId4iQLC2Ujz3Lf1Gb0rzYMrFPlhQHNLzaiBPA.jpg")
        XCTAssertEqual(expectedModel?.imgAspectRatio, 1.5)
    }

    func testPostsCountOnSuccess() {
        sut.service = RedditPostsServiceSuccessStub()
        let exp = expectation(description: "Trigger should complete")
        sut.fetchPostsList { _ in exp.fulfill()}
        waitForExpectations(timeout: 0.01)

        XCTAssertEqual(sut.postsCount(), 2)
    }
    
    func testPostsCountOnFailure() {
        sut.service = RedditPostsServiceFailureStub()
        let exp = expectation(description: "Trigger should complete")
        sut.fetchPostsList { _ in exp.fulfill()}
        waitForExpectations(timeout: 0.01)

        XCTAssertEqual(sut.postsCount(), 0)
    }
}
