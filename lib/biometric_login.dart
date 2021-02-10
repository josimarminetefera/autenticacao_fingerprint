import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsLogin {
  final localAuth = LocalAuthentication();

  Future<bool> auth() async {
    const iosStrings = const IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please reenable your Touch ID',
    );

    const androidStrings = const AndroidAuthMessages(
      signInTitle: "Título",
      fingerprintHint: "teste",
      fingerprintRequiredTitle: "opa opa opa ",
      fingerprintNotRecognized: "este aqui é outro",
      fingerprintSuccess: "sucesso",
      cancelButton: 'cancelar',
      goToSettingsButton: 'configurações',
      goToSettingsDescription: 'Toque no sensor de digital',

    );

    return await localAuth.authenticateWithBiometrics(
      localizedReason: 'Faça a autenticação para usar o aplicativo',
      useErrorDialogs: false,
      iOSAuthStrings: iosStrings,
      androidAuthStrings: androidStrings,
    );
  }

  Future<bool> isBiometricsAuth() => localAuth.canCheckBiometrics;
}
