import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetChecker {
  Future<bool> get isConnected;
}

class InternetCheckerImpl extends InternetChecker {
  InternetConnectionChecker internetConnectionChecker;
  InternetCheckerImpl({
    required this.internetConnectionChecker,
  });
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
