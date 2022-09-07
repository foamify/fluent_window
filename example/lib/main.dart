import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_window/fluent_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await Window.initialize();

  Window.setEffect(effect: WindowEffect.transparent);

  windowManager.waitUntilReadyToShow(
    const WindowOptions(title: "Fluent Window Example"),
        () async {
      await windowManager.setAsFrameless();
      await windowManager.setHasShadow(true);
      await windowManager.show();
    },
  );

  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return WindowFrame(
          active: true,
          frameless: true,
          movable: true,
          enableWin10Borders: true,
          enableWindowButtons: true,
          enableCustomButtons: true,
          enableResize: true,
          resizeAboveButtons: true,
          dark: true,
          child: child ?? const SizedBox(),
        );
      },
      title: 'Fluent Window Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return NavigationView(
      appBar: NavigationAppBar(
        title: FutureBuilder(
          future: windowManager.getTitle(),
          builder: (_, AsyncSnapshot<String> asyncSnapshot) =>
              AppTitle(title: asyncSnapshot.data ?? "", focusColor: Colors.black),
        ),
        /// For custom movable
        /*actions: Row(
          children: [
            (MediaQuery.of(context).size.width - 54 > 0)
                ? DragToMoveArea(
                    child: SizedBox(
                      height: buttonSize.height,
                      width: MediaQuery.of(context).size.width - 52,
                    ),
                  )
                : const SizedBox(),
          ],
        ),*/
      ),
      pane: NavigationPane(
        // Menu Button disabled
        menuButton: const SizedBox(),
        displayMode: PaneDisplayMode.compact,
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        color: Colors.white,
      ),
    );
  }
}
