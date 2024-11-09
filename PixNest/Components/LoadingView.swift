//
//  spinner.swift
//  PixNest
//
//  Created by Andrea Bottino on 28/10/2024.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .accent))
      .scaleEffect(2.0, anchor: .center)
  }
}

