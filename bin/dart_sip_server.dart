import 'sipServer.dart';
import 'wsSipServer.dart';

//Function(dynamic resp)
void main() {
  // ignore: unused_local_variable
  SipServer sipServer = SipServer("192.168.0.91", 5080);
  wsSipServer wsServer =
      wsSipServer("192.168.0.91", 8088, "192.168.0.91", 5080);
}
