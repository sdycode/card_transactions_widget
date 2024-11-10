 
import 'package:transcation_history/lib.dart';
import 'firebase_options.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {}

  FlutterError.onError = (FlutterErrorDetails details) {
    runApp(MyApp(error: details.exception.toString()));
  };  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? error;

  const MyApp({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    // If an error exists, show a custom error page
    if (error != null) {
      return MaterialApp(
        home: ErrorScreen(errorMessage: "Some error occured"
            // error!
            ),
      );
    }
    // Otherwise, show your regular app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credit Card Transactions',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        updateRadius(context);
        return const TransactionsPage();
      }),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Occurred')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 20),
            const Text(
              'Something went wrong!',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the home page or original page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const TransactionsPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Go Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
