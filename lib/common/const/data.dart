import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';



// 에뮬레이터 기준 10.0.2.2:3000 가 기본 local host
final emulatorIp = '192.168.0.25:3000';

// 시뮬레이터 기준 127.0.0.1:3000 가 기본 local host
final simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS   // io패키지의 Platfrom 클래스를 인스턴스화 하지않고 스태틱 메서드만 사용.
    ? simulatorIp // ios 는 시뮬레이터
    : emulatorIp; // and는 애뮬레이터

final storage = FlutterSecureStorage();