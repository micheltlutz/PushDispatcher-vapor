import Vapor

struct PushPayload: Content {
    let config: PushPayloadConfig
    let title: String
    let subTitle: String
    let deviceToken: String
}

struct PushPayloadConfig: Content {
    let key: String
    let keyIdentifier: String
    let teamIdentifier: String
    let topic: String
}
