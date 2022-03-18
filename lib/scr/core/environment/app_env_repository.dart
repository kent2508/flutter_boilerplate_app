import 'package:vpb_flutter_boilerplate/scr/core/environment/app_environment.dart';

class AppEvnRepository {
  AppEvnRepository(this.appEvironment) {
    if (appEvironment == AppEnvironment.Dev) {
      baseUrl = 'Your base url dev environment';
    } else {
      baseUrl = 'Your base url pro environment';
    }
  }
  AppEnvironment appEvironment;
  // your params config specified environment is here
  late String baseUrl;
}
