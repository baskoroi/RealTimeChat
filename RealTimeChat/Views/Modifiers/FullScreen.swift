//
//  FullScreen.swift
//  RealTimeChat
//
//  Created by Baskoro Indrayana on 07/30/20.
//  Copyright © 2020 Baskoro Indrayana. All rights reserved.
//

import SwiftUI

public struct FullScreen: ViewModifier {
    public func body(content: Content) -> some View {
        return content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}
