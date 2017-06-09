//
//  File.swift
//  CoffeeSpyPrototype
//
//  Created by Roland Askew on 5/4/17.
//  Copyright © 2017 team godzilla. All rights reserved.
//

import Foundation
import UIKit

protocol ApiClientCallbackDelegate: class {
    func didFinishApiCall(sender: Any, results : [NSDictionary])
}
