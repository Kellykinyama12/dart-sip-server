import 'dart:io' show HttpServer, HttpRequest, WebSocket, WebSocketTransformer;
import 'dart:convert' show json;
import 'dart:async' show Timer;

main() {
  HttpServer.bind('localhost', 8000).then((HttpServer server) {
    print('[+]WebSocket listening at -- ws://localhost:8000/');
    server.listen((HttpRequest request) {
      WebSocketTransformer.upgrade(request).then((WebSocket ws) {
        ws.listen(
          (data) {
            print(
                '\t\t${request.connectionInfo?.remoteAddress} -- ${Map<String, String>.from(json.decode(data))}');
            Timer(Duration(seconds: 1), () {
              if (ws.readyState == WebSocket.open)
                // checking connection state helps to avoid unprecedented errors
                ws.add(json.encode({
                  'data': 'from server at ${DateTime.now().toString()}',
                }));
            });
          },
          onDone: () => print('[+]Done :)'),
          onError: (err) => print('[!]Error -- ${err.toString()}'),
          cancelOnError: true,
        );
      }, onError: (err) => print('[!]Error -- ${err.toString()}'));
    }, onError: (err) => print('[!]Error -- ${err.toString()}'));
  }, onError: (err) => print('[!]Error -- ${err.toString()}'));
}
