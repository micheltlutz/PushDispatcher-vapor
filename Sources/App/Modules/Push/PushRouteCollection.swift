import Vapor
import APNS
import JWTKit

final class PushRouteCollection: RouteCollection {
    private let app: Application

    init(_ app: Application) {
        self.app = app
    }

    func boot(routes: RoutesBuilder) throws {
        let apiBuilder = routes.grouped("push")

        postMethods(apiBuilder)
    }

    private func configureAPNS(_ config: PushPayloadConfig) throws {
        let keyIdentifier = JWKIdentifier.init(string: config.keyIdentifier)

        // Configure APNS using JWT authentication.
        app.apns.configuration = try .init(
            authenticationMethod: .jwt(
                key: .private(filePath: config.key),
                keyIdentifier: keyIdentifier,
                teamIdentifier: config.teamIdentifier
            ),
            topic: config.topic,
            environment: .sandbox
        )
    }

    private func postMethods(_ builder: RoutesBuilder) {
        builder.post("send") { req -> HTTPStatus in
            let pushPayload = try req.content.decode(PushPayload.self)

            try self.configureAPNS(pushPayload.config)

            let _ = self.app.apns.send(
                .init(title: pushPayload.title,
                      subtitle: pushPayload.subTitle),
                to: pushPayload.deviceToken)

            return HTTPStatus.ok
        }
    }
}
