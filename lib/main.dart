import 'package:favourite_places_app/src/app_library.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      home: const HomePage(),
    );
  }
}
