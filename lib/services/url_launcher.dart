import 'package:url_launcher/url_launcher.dart';

class UrlLauncher{
  static void sentEmail(String email)async{
    final Uri emailUi = Uri(
      scheme: 'https',
      host: 'mail.google.com',
      queryParameters: {
        'view': 'cm',
        'fs': '1',
        'to': email,
      }
    );

    if(await canLaunchUrl(emailUi)){
      await launchUrl(emailUi);
    }else{
      print('Could not lauch email client');
    }
  }
  static void urlLaunch(String link)async {
    final Uri url = Uri.parse(link);
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }else{
      throw 'Cannot launch this url';
    }
  }
}