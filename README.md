# PushDispatcher - Vapor

>The purpose of this application is to facilitate the testing of push notifications in your application, in the absence of functional options using the .p8 file and without the need to have access to the console of some triggering service. In this project you use **Postman** to send the payload. I'm developing an application for macOS too but I haven't finished it yet.

## Dependencies

- [Vapor 4](https://docs.vapor.codes/4.0/)
	- Run in Linux or macOS
- [Postman](https://www.postman.com/)

## Run

### With Xcode

- Open `Package.swift`
- Wait for Xcode Fetching SPM dependencies
- Run App
- In your console on Xcode you recieve this info:
`[ NOTICE ] Server starting on http://127.0.0.1:8080`

### With Terminal (macOS or Linux)

Run command `vapor run serve` in root project folder
- In your Terminal you recieve this info:
`[ NOTICE ] Server starting on http://127.0.0.1:8080`

## Common errors

if you recieve this error in console:

```
[ NOTICE ] Server starting on http://127.0.0.1:8080
[ WARNING ] bind(descriptor:ptr:bytes:): Address already in use (errno: 48)
Swift/ErrorType.swift:200: Fatal error: Error raised at top level: bind(descriptor:ptr:bytes:): Address already in use (errno: 48)
2022-01-25 15:45:20.004457-0300 Run[57078:478764] Swift/ErrorType.swift:200: Fatal error: Error raised at top level: bind(descriptor:ptr:bytes:): Address already in use (errno: 48)
```

Run in terminal `lsof -i :8080` this command shows the processes running on port 8080 see the ones with the name Run and kill the processes

- `sudo kill 4944` for example


## Testing with Postman

- Default endpoint: `http://127.0.0.1:8080/push/send`
- The body is raw / json

- **key**: path to the private key file (.p8)
- **keyIdentifier**: is part of your .p8 file in name - [Get a key identifier](https://help.apple.com/developer-account/#/dev646934554)
- **teamIdentifier**: Team ID - [Locate your Team ID](https://help.apple.com/developer-account/#/dev55c3c710c)
- **topic**: Bundle ID, App ID - [Register an App ID](https://help.apple.com/developer-account/#/dev1b35d6f83)

**Example payload**:


```
{
    "config": {
        "key": "/Users/myuser/AuthKey_XPTO.p8",
        "keyIdentifier": "XPTO",
        "teamIdentifier": "YXPTWREW99",
        "topic": "br.com.myapp"
    },
    "title": "Push Test Dispatcher",
    "subTitle": "Push body description",
    "deviceToken": "64ff01ef9af8a40c8bf4499d10489ef9a93a1ccd987933c767d52073df015e31"

}
```


> I hope it helps