import Foundation

struct Secrets: Decodable {
    let projectID: String

    enum CodingKeys: String, CodingKey {
        case projectID = "PROJECT_ID"
    }

    static func load() -> Self {
        Secrets(projectID: AppConstant.walletConnectProjectId)
    }
}
