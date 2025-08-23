import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  // Cria a instância do player de áudio
  final player = AudioPlayer();

  // Função para reproduzir o som de clique
  void playClickSound() async {
    // Define a velocidade de reprodução para 2.0 (duas vezes a velocidade normal)
    await player.setPlaybackRate(1.5);
    // O caminho do arquivo de áudio deve ser o mesmo que você colocou no pubspec.yaml
    await player.play(AssetSource('sounds/click.mp3'));
  }

  void increment() {
    setState(() {
      count++;
    });
    playClickSound(); // Chama a função para tocar o som
    print(count);
  }

  void decrement() {
    setState(() {
      count--;
    });
    playClickSound(); // Chama a função para tocar o som
    print(count);
  }

  bool get isEmpty => count == 0;
  bool get isMid => count == 10 && count < 20;
  bool get isFull => count == 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? 'Lotado!' : 'Pode entrar!',
              style: const TextStyle(
                fontSize: 45,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 100,
                  color: isFull ? Colors.red : Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            //SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isEmpty ? null: decrement,
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty ? Colors.white.withOpacity(0.2) : Colors.white,
                    fixedSize: const Size(100, 100),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Saiu',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),

                const SizedBox(width: 40),

                TextButton(
                  onPressed: isFull ? null: increment,
                  style: TextButton.styleFrom(
                    backgroundColor: isFull ? Colors.red.withOpacity(0.6) : Colors.white,
                    fixedSize: const Size(100, 100),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Entrou',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
