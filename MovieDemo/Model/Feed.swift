//
//  Feed.swift
//  MovieDemo
//
//  Created by Sandeep on 11/02/24.
//

import Foundation

struct FeedResponse: Codable {
    let feed: FeedResponseDetail

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.feed = try container.decode(FeedResponseDetail.self, forKey: .feed)

    }
}

struct FeedResponseDetail: Codable {
    let author: FeedAuthor
    let entry: [Feed]
    let updated: FeedLabel
    let rights: FeedLabel
    let title: FeedLabel
    let icon: FeedLabel
    let link: [FeedLink]
    let id: FeedLabel
}

struct FeedAuthor: Codable {
    let name: FeedLabel
    let uri: FeedLabel
}

struct Feed: Codable,Identifiable {
    let id: String
    let imName: FeedLabel
    let rights: FeedLabel?
    let imImage: [FeedImage]
    let summary: FeedLabel
    let imRentalPrice: FeedPrice?
    let imPrice: FeedPrice
    let imContentType: FeedContentType
    let title: FeedLabel
    let link: [FeedLink]
    let imArtist: FeedLabel
    let category: FeedCategory
    let imReleaseDate: FeedReleaseDate

    var previewLink: FeedLink? {
        link.first(where: { $0.attributes.imAssetType == "preview" })
    }
    enum CodingKeys: String, CodingKey {
        case imName = "im:name"
        case rights
        case imImage = "im:image"
        case summary
        case imRentalPrice = "im:rentalPrice"
        case imPrice = "im:price"
        case imContentType = "im:contentType"
        case title
        case link
        case id
        case imArtist = "im:artist"
        case category
        case imReleaseDate = "im:releaseDate"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(FeedIdLabel.self, forKey: .id).attributes?.imId ?? UUID().uuidString

        self.imName = try container.decode(FeedLabel.self, forKey: .imName)
        self.rights = try? container.decode(FeedLabel.self, forKey: .rights)
        self.imImage = try container.decode([FeedImage].self, forKey: .imImage)
        self.summary = try container.decode(FeedLabel.self, forKey: .summary)
        self.imRentalPrice = try? container.decode(FeedPrice.self, forKey: .imRentalPrice)
        self.imPrice = try container.decode(FeedPrice.self, forKey: .imPrice)
        self.imContentType = try container.decode(FeedContentType.self, forKey: .imContentType)
        self.title = try container.decode(FeedLabel.self, forKey: .title)
        self.link = try container.decode([FeedLink].self, forKey: .link)
        self.imArtist = try container.decode(FeedLabel.self, forKey: .imArtist)
        self.category = try container.decode(FeedCategory.self, forKey: .category)
        self.imReleaseDate = try container.decode(FeedReleaseDate.self, forKey: .imReleaseDate)
    }

}
extension Feed {
    static func dummy() -> Feed? {
        let jsonString = """
        {
                        "im:name": {
                            "label": "Wonka"
                        },
                        "rights": {
                            "label": "© 2023 Warner Bros. Entertainment Inc."
                        },
                        "im:image": [
                            {
                                "label": "https://is1-ssl.mzstatic.com/image/thumb/Video126/v4/68/e3/82/68e382d0-e9ab-94dd-a02a-b323cb1b0173/cbb1cb8b-cd01-40c5-ace2-3993224e8380_Wonka_APO_V_DD_KA_TT_2000x3000_300dpi_EN-srgb.lsr/39x60bb.png",
                                "attributes": {
                                    "height": "60"
                                }
                            },
                            {
                                "label": "https://is1-ssl.mzstatic.com/image/thumb/Video126/v4/68/e3/82/68e382d0-e9ab-94dd-a02a-b323cb1b0173/cbb1cb8b-cd01-40c5-ace2-3993224e8380_Wonka_APO_V_DD_KA_TT_2000x3000_300dpi_EN-srgb.lsr/39x60bb.png",
                                "attributes": {
                                    "height": "60"
                                }
                            },
                            {
                                "label": "https://is1-ssl.mzstatic.com/image/thumb/Video126/v4/68/e3/82/68e382d0-e9ab-94dd-a02a-b323cb1b0173/cbb1cb8b-cd01-40c5-ace2-3993224e8380_Wonka_APO_V_DD_KA_TT_2000x3000_300dpi_EN-srgb.lsr/113x170bb.png",
                                "attributes": {
                                    "height": "170"
                                }
                            }
                        ],
                        "summary": {
                            "label": "Based on the extraordinary character at the center of Charlie and the Chocolate Factory, the jewel in the Roald Dahl crown and one of the best‐selling children’s books of all time, “Wonka” tells the wondrous story of how the world’s greatest inventor, magician and chocolate‐maker became the beloved Willy Wonka we know today. This irresistibly vivid and inventive big screen spectacle will introduce audiences to a young Willy Wonka, chock‐full of ideas and determined to change the world one delectable bite at a time—proving that the best things in life begin with a dream, and if you’re lucky enough to meet Willy Wonka, anything is possible."
                        },
                        "im:rentalPrice": {
                            "label": "$19.99",
                            "attributes": {
                                "amount": "19.99",
                                "currency": "USD"
                            }
                        },
                        "im:price": {
                            "label": "$24.99",
                            "attributes": {
                                "amount": "24.99",
                                "currency": "USD"
                            }
                        },
                        "im:contentType": {
                            "attributes": {
                                "term": "Movie",
                                "label": "Movie"
                            }
                        },
                        "title": {
                            "label": "Wonka - Paul King"
                        },
                        "link": [
                            {
                                "attributes": {
                                    "rel": "alternate",
                                    "type": "text/html",
                                    "href": "https://itunes.apple.com/us/movie/wonka/id1714948342?uo=2"
                                }
                            },
                            {
                                "im:duration": {
                                    "label": "163167.0"
                                },
                                "attributes": {
                                    "title": "Preview",
                                    "rel": "enclosure",
                                    "type": "video/x-m4v",
                                    "href": "https://video-ssl.itunes.apple.com/itunes-assets/Video116/v4/8d/71/08/8d7108bb-6265-01e0-ae06-1db8eee59a66/mzvf_8165833802997629892.640x354.h264lc.U.p.m4v",
                                    "im:assetType": "preview"
                                }
                            }
                        ],
                        "id": {
                            "label": "https://itunes.apple.com/us/movie/wonka/id1714948342?uo=2",
                            "attributes": {
                                "im:id": "1714948342"
                            }
                        },
                        "im:artist": {
                            "label": "Paul King"
                        },
                        "category": {
                            "attributes": {
                                "im:id": "4410",
                                "term": "Kids & Family",
                                "scheme": "https://itunes.apple.com/us/genre/movies-kids-family/id4410?uo=2",
                                "label": "Kids & Family"
                            }
                        },
                        "im:releaseDate": {
                            "label": "2023-12-15T00:00:00-07:00",
                            "attributes": {
                                "label": "December 15, 2023"
                            }
                        }
                    }
        """

        let decoder = JSONDecoder()  // Placeholder for Decoder

        // Convert the string to Data
        if let jsonData = jsonString.data(using: .utf8) {
            return try? decoder.decode(Feed.self, from: jsonData)
        } else {
            print("Failed to convert JSON string to Data.")
            return nil
        }
    }
}


struct FeedLabel: Codable {
    let label: String
}
struct FeedIdLabel: Codable {
    let label: String
    let attributes: FeedIdLabelAttributes?
}

struct FeedIdLabelAttributes: Codable {
    let imId: String?

    enum CodingKeys: String, CodingKey {
        case imId = "im:id"
    }
}
struct FeedImage: Codable {
    let label: String
    let attributes: FeedImageAttributes
    var url: URL? {
        guard !label.isEmpty else { return nil }
        return URL(string: label)
    }
}

struct FeedImageAttributes: Codable {
    let height: String
}

struct FeedPrice: Codable {
    let label: String
    let attributes: FeedPriceAttributes
}

struct FeedPriceAttributes: Codable {
    let amount: String
    let currency: String
}

struct FeedContentType: Codable {
    let attributes: FeedContentTypeAttributes
}

struct FeedContentTypeAttributes: Codable {
    let term: String
    let label: String
}

struct FeedLink: Codable {
    let attributes: FeedLinkAttributes
}

struct FeedLinkAttributes: Codable {
    let rel: String
    let type: String?
    let href: String
    let title: String?
    let imAssetType: String?

    enum CodingKeys: String, CodingKey {
        case rel, type, href, title
        case imAssetType = "im:assetType"
    }
}

struct FeedCategory: Codable {
    let attributes: FeedCategoryAttributes
}

struct FeedCategoryAttributes: Codable {
    let imId: String
    let term: String
    let scheme: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case imId = "im:id"
        case term, scheme, label
    }
}

struct FeedReleaseDate: Codable {
    let label: String
    let attributes: FeedReleaseDateAttributes
}

struct FeedReleaseDateAttributes: Codable {
    let label: String
}


