//
// Created by Rene Pirringer on 2019-01-10.
// Copyright (c) 2019 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest

/**
 Extension with a helper to test if a class properly implements the NSCoding protocol

A unit for this looks like this:

@available(iOS 11,*)
func test_is_encodable() {
	guard let result = encodeDecode(object: sut) else {
		XCTFail("sut is not encodable")
		return
	}
	assertThat(result, instanceOf(<SUT Class>.self))
	// also test some properties and variables that are encoded and decoded
}
*/
public extension XCTestCase {

	@available(iOS 11,*)
	func encodeDecode<T: NSCoding>(object: T) -> T? {
		guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) else {
			XCTFail("cannot encode object")
			return nil
		}
		if let result = ((try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T) as T??) {
			return result
		}
		return nil
	}

}
