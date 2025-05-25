//
//  ProductCardIO.swift
//  Products
//
//  Created by lorenc_D_K on 11.03.2025.
//

import Foundation

struct ProductCardInput {
    let article: String

    init(article: String) {
        self.article = article
    }
}

struct ProductCardOutput {
    let didChangeLike: (_ productId: UUID, _ isLiked: Bool) -> Void

    init(didChangeLike: @escaping (_: UUID, _: Bool) -> Void) {
        self.didChangeLike = didChangeLike
    }
}
