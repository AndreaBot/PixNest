//
//  Support Data.swift
//  PixNestTests
//
//  Created by Andrea Bottino on 12/11/24.
//

import Foundation
@testable import PixNest

class URLSessionMock: URLSessionProtocol {
    func data(from: URL) async throws -> (Data, URLResponse) {
        let testData = Data(SupportData.testJSON.utf8)
        let response = URLResponse()
        return (testData, response)
    }
}

struct SupportData {
    
    //JSON response for "tree" and only one image requested
    static let testJSON = """
{
"total": 10000,
"total_pages": 10000,
"results": [

{
"id": "Bn2rzIYM53g",
"slug": "red-and-brown-leafy-tree-at-daytime-Bn2rzIYM53g",
"alternative_slugs": {
"en": "red-and-brown-leafy-tree-at-daytime-Bn2rzIYM53g",
"es": "arbol-frondoso-rojo-y-marron-durante-el-dia-Bn2rzIYM53g",
"ja": "昼間の赤と茶色の葉の茂った木-Bn2rzIYM53g",
"fr": "arbre-feuillu-rouge-et-brun-pendant-la-journee-Bn2rzIYM53g",
"it": "albero-a-foglia-rossa-e-marrone-di-giorno-Bn2rzIYM53g",
"ko": "낮에는-빨간색과-갈색-잎이-무성한-나무-Bn2rzIYM53g",
"de": "roter-und-brauner-laubbaum-am-tag-Bn2rzIYM53g",
"pt": "arvore-frondosa-vermelha-e-marrom-durante-o-dia-Bn2rzIYM53g"
},
"created_at": "2015-10-10T15:59:32Z",
"updated_at": "2024-11-08T00:09:47Z",
"promoted_at": "2015-10-10T15:59:32Z",
"width": 3024,
"height": 4032,
"color": "#40260c",
"blur_hash": "LKEU[Z^Qo~X94UM~W?WX%$kWt8s:",
"description": "Fall maple tree",
"alt_description": "red and brown leafy tree at daytime",
"breadcrumbs": [],
"urls": {
"raw": "https://images.unsplash.com/photo-1444492696363-332accfd40c0?ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3",
"full": "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=85",
"regular": "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=80&w=1080",
"small": "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=80&w=400",
"thumb": "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=80&w=200",
"small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1444492696363-332accfd40c0"
},
"links": {
"self": "https://api.unsplash.com/photos/red-and-brown-leafy-tree-at-daytime-Bn2rzIYM53g",
"html": "https://unsplash.com/photos/red-and-brown-leafy-tree-at-daytime-Bn2rzIYM53g",
"download": "https://unsplash.com/photos/Bn2rzIYM53g/download?ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA",
"download_location": "https://api.unsplash.com/photos/Bn2rzIYM53g/download?ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA"
},
"likes": 1532,
"liked_by_user": false,
"current_user_collections": [],
"sponsorship": null,
"topic_submissions": {
"nature": {
"status": "approved",
"approved_on": "2021-12-08T14:58:20Z"
}
},
"asset_type": "photo",
"user": {
"id": "o25aSDn-4q0",
"updated_at": "2024-11-12T10:25:36Z",
"username": "aaronburden",
"name": "Aaron Burden",
"first_name": "Aaron",
"last_name": "Burden",
"twitter_username": "theaaronburden",
"portfolio_url": "http://aaronburden.com",
"bio": null,
"location": "Baltimore, MD",
"links": {
"self": "https://api.unsplash.com/users/aaronburden",
"html": "https://unsplash.com/@aaronburden",
"photos": "https://api.unsplash.com/users/aaronburden/photos",
"likes": "https://api.unsplash.com/users/aaronburden/likes",
"portfolio": "https://api.unsplash.com/users/aaronburden/portfolio",
"following": "https://api.unsplash.com/users/aaronburden/following",
"followers": "https://api.unsplash.com/users/aaronburden/followers"
},
"profile_image": {
"small": "https://images.unsplash.com/profile-1578021854441-1f6abbca2a1dimage?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
"medium": "https://images.unsplash.com/profile-1578021854441-1f6abbca2a1dimage?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
"large": "https://images.unsplash.com/profile-1578021854441-1f6abbca2a1dimage?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
},
"instagram_username": "aaronburden",
"total_collections": 75,
"total_likes": 2967,
"total_photos": 1229,
"total_promoted_photos": 602,
"total_illustrations": 0,
"total_promoted_illustrations": 0,
"accepted_tos": true,
"for_hire": false,
"social": {
"instagram_username": "aaronburden",
"portfolio_url": "http://aaronburden.com",
"twitter_username": "theaaronburden",
"paypal_email": null
}
}
}
]
}
"""
    static let testUrls = URLS(small: "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=80&w=400",
                        full: "https://images.unsplash.com/photo-1444492696363-332accfd40c0?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA&ixlib=rb-4.0.3&q=85")
    
    static let testUser = User(name: "Aaron Burden",
                        profileImage: ProfileImage(medium: "https://images.unsplash.com/profile-1578021854441-1f6abbca2a1dimage?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64"),
                        links: Links(html: "https://unsplash.com/@aaronburden"))
    
    static let testLink = Link(downloadLocation: "https://api.unsplash.com/photos/Bn2rzIYM53g/download?ixid=M3w0NTE5MTl8MHwxfHNlYXJjaHwxfHx0cmVlfGVufDB8MXx8fDE3MzE0NDgxOTl8MA")
 
    
    static let testResult = [Result(urls: testUrls, user: testUser, links: testLink)]
    
    static let testSearchResult: SearchResult = SearchResult(total: 10_000,
                                                      totalPages: 10_000,
                                                      results: testResult)
    
   
}

