import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewService {
  final NetworkService networkService;

  const WebViewService({required this.networkService});

  Future<void> openInWebView(String url) async {
    logDebug('WebViewService -> openInWebView($url)');
    if (!await networkService.checkNetworkConnection()) return;

    try {
      if (await canLaunch(url)) {
        launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
        );
      } else {
        logDebug('WebViewService exception: could not launch $url');
      }
    } on Exception catch (e) {
      logDebug('WebViewService exception: ${e.runtimeType}');
      throw 'WebViewService exception: could not launch $url';
    }
  }
}
