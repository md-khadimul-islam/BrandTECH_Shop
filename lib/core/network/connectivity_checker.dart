import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_checker.g.dart';

abstract class ConnectivityChecker {
  Future<bool> hasInternet();
}

class ConnectivityCheckerImpl implements ConnectivityChecker {
  final Connectivity _connectivity;

  const ConnectivityCheckerImpl(this._connectivity);

  @override
  Future<bool> hasInternet() async {
    final result = await _connectivity.checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  }
}

@riverpod
ConnectivityChecker connectivityChecker(Ref ref) {
  return ConnectivityCheckerImpl(Connectivity());
}
