import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/app.dart';
import 'package:gank_flutter/simple_bloc_observer.dart';
import 'package:gank_flutter/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(
    DevicePreview(
      enabled: false,
      // enabled: !kReleaseMode,
      usePreferences: true,
      areSettingsEnabled: true,
      style: DevicePreviewStyle(
        hasFrameShadow: true,
        background: BoxDecoration(color: theme.backgroundColor),
        toolBar: DevicePreviewToolBarStyle.dark(),
      ),
      builder: (context) => App(),
    ),
  );
}
