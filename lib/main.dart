import 'package:flutter/material.dart';
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

const String kPlantMarkerCode = 'DECORAR_PLANTA';

void main() {
  runApp(const DecorArApp());
}

class DecorArApp extends StatelessWidget {
  const DecorArApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DecorAR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4BC3FF)),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ModelsScreen(),
      const AboutScreen(),
    ];

    //Barra de navegação
    return Scaffold(
      body: DecorBackground(child: SafeArea(child: pages[_index])),
      bottomNavigationBar: Container(
        //margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(9, 21, 54, 0).withOpacity(0.9),
          //borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromRGBO(9, 21, 54, 0).withOpacity(0.4)),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: Colors.white);
              }
              return const IconThemeData(color: Colors.white70);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(color: Colors.white);
              }
              return const TextStyle(color: Colors.white70);
            }),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor:
                const Color.fromARGB(255, 83, 128, 235).withOpacity(0.8),
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
              NavigationDestination(icon: Icon(Icons.weekend), label: 'Modelos'),
              NavigationDestination(icon: Icon(Icons.info), label: 'Sobre'),
            ],
          ),
        ),
      ),
    );
  }
}

class DecorBackground extends StatelessWidget {
  final Widget child;

  const DecorBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF060D1E), Color(0xFF0B1941), Color(0xFF170F30)],
        ),
      ),
      child: child,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'DecorAR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF295C94), Color(0xFF101B36)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.view_in_ar,
                    size: 90,
                    color: Color(0xFF7DD6FF),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Transforme seu espaço em segundos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              ...const [
                _Bullet('Visualize'),
                _Bullet('Experimente'),
                _Bullet('Inove'),
                _Bullet('Decore'),
              ],
              const SizedBox(height: 20),
              const Text(
                'Realidade aumentada com marcador visual',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nesta versão, o aplicativo utiliza um QR Code como marcador visual para iniciar a experiência de Realidade Aumentada. '
                'O fluxo foi pensado para facilitar a demonstração: primeiro o usuário acessa o modelo Planta, depois aponta a câmera para o marcador e, por fim, visualiza a planta virtual no ambiente real.\n\n'
                'Tecnicamente, esse QR Code funciona como uma imagem de referência ou marker. Em uma evolução futura, o projeto pode usar o recurso oficial Augmented Images do ARCore, criando um banco de imagens aumentadas para detectar e ancorar objetos virtuais diretamente sobre uma imagem física.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ModelsScreen extends StatelessWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Espelho', Icons.circle_outlined),
      ('Estátua', Icons.account_balance),
      ('Luminária', Icons.lightbulb),
      ('Planta', Icons.eco),
      ('Diamante', Icons.change_history),
      ('OVNI', Icons.blur_circular),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const Center(
          child: Text(
            'Modelos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.9,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];

              return GestureDetector(
                onTap: () {
                  Widget screen;

                  switch (item.$1) {
                    case 'Espelho':
                      screen = const MirrorScreen();
                      break;
                    case 'Estátua':
                      screen = const StatueScreen();
                      break;
                    case 'Luminária':
                      screen = const LampScreen();
                      break;
                    case 'Planta':
                      screen = const PlantScreen();
                      break;
                    case 'Diamante':
                      screen = const DiamondScreen();
                      break;
                    case 'OVNI':
                      screen = const UfoScreen();
                      break;
                    default:
                      return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D3B5A), Color(0xFF0B233D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: const Color(0xFF4BC3FF).withOpacity(0.35),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$2,
                        color: const Color(0xFF8CE8FF),
                        size: 46,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MirrorScreen extends StatelessWidget {
  const MirrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'Espelho',
      icon: Icons.circle_outlined,
      iconColor: const Color(0xFF8CE8FF),
      description:
          'Modelo de espelho preparado para experiências de decoração digital. Nesta entrega, a projeção em RA foi implementada apenas para o modelo Planta.',
      onProject: null,
    );
  }
}

class StatueScreen extends StatelessWidget {
  const StatueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'Estátua',
      icon: Icons.account_balance,
      iconColor: const Color(0xFFFFD27A),
      description:
          'Modelo de estátua inspirado em esculturas clássicas. Nesta entrega, a projeção em RA foi implementada apenas para o modelo Planta.',
      onProject: null,
    );
  }
}

class LampScreen extends StatelessWidget {
  const LampScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'Luminária',
      icon: Icons.lightbulb,
      iconColor: const Color(0xFFFFF176),
      description:
          'Modelo de luminária para simulação de decoração. Nesta entrega, a projeção em RA foi implementada apenas para o modelo Planta.',
      onProject: null,
    );
  }
}

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'Planta',
      icon: Icons.eco,
      iconColor: const Color(0xFF9CFF7C),
      description:
          'Modelo de planta em Realidade Aumentada. Para iniciar a experiência, o aplicativo fará a leitura de um QR Code utilizado como marcador visual. '
          'Após a confirmação do marcador, a câmera de RA será aberta e a planta virtual poderá ser posicionada na frente da câmera.',
      buttonLabel: 'Ler marcador',
      onProject: () async {
        final status = await Permission.camera.request();

        if (!context.mounted) return;

        if (status.isGranted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QrMarkerScannerScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Permissão da câmera é necessária para ler o marcador e usar a Realidade Aumentada.',
              ),
            ),
          );
        }
      },
    );
  }
}

class DiamondScreen extends StatelessWidget {
  const DiamondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'Diamante',
      icon: Icons.change_history,
      iconColor: const Color(0xFF8CE8FF),
      description:
          'Modelo de diamante para visualização tridimensional. Nesta entrega, a projeção em RA foi implementada apenas para o modelo Planta.',
      onProject: null,
    );
  }
}

class UfoScreen extends StatelessWidget {
  const UfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelDetailScreen(
      title: 'OVNI',
      icon: Icons.blur_circular,
      iconColor: const Color(0xFF9CFF7C),
      description:
          'Modelo futurista para experiências interativas. Nesta entrega, a projeção em RA foi implementada apenas para o modelo Planta.',
      onProject: null,
    );
  }
}

class ModelDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String description;
  final VoidCallback? onProject;
  final String buttonLabel;

  const ModelDetailScreen({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.description,
    required this.onProject,
    this.buttonLabel = 'Projetar',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1D35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3B60),
        title: const Text(
          'Projetar Modelo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D3B60), Color(0xFF0A1D35)],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton(
                  buttonLabel,
                  onTap: onProject ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Nesta versão, a Realidade Aumentada foi implementada apenas para o modelo Planta.',
                            ),
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QrMarkerScannerScreen extends StatefulWidget {
  const QrMarkerScannerScreen({super.key});

  @override
  State<QrMarkerScannerScreen> createState() => _QrMarkerScannerScreenState();
}

class _QrMarkerScannerScreenState extends State<QrMarkerScannerScreen> {
  final MobileScannerController scannerController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool markerEncontrado = false;
  String mensagem = 'Aponte a câmera para o QR Code da planta.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3B60),
        title: const Text(
          'Ler marcador',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            await scannerController.stop();
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: _onDetect,
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF9CFF7C), width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.72),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF092949).withOpacity(0.88),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: const Text(
                'Código esperado: DECORAR_PLANTA\nUse o QR Code gerado junto com o projeto.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFDCE9FF), fontSize: 14, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (markerEncontrado) return;

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();

      if (value == null || value.isEmpty) continue;

      if (value.toUpperCase() == kPlantMarkerCode) {
        markerEncontrado = true;

        if (mounted) {
          setState(() {
            mensagem = 'Marcador reconhecido. Abrindo Realidade Aumentada...';
          });
        }

        await scannerController.stop();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PlantArScreen()),
        );

        return;
      }

      if (mounted) {
        setState(() {
          mensagem = 'QR Code lido, mas ele não é o marcador da planta.';
        });
      }
    }
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }
}

class PlantArScreen extends StatefulWidget {
  const PlantArScreen({super.key});

  @override
  State<PlantArScreen> createState() => _PlantArScreenState();
}

class _PlantArScreenState extends State<PlantArScreen> {
  ArCoreController? arCoreController;
  bool plantaInserida = false;
  String mensagem = 'Abrindo câmera de Realidade Aumentada...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3B60),
        title: const Text(
          'Planta em RA',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enablePlaneRenderer: false,
            enableTapRecognizer: false,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.70),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: _adicionarPlantaNaFrente,
                  icon: const Icon(Icons.eco),
                  label: const Text('Mostrar planta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D3B60),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _removerPlanta,
                  icon: const Icon(Icons.delete),
                  label: const Text('Remover planta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF46225C),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    setState(() {
      mensagem = 'RA iniciada. Toque em "Mostrar planta" para exibir o modelo.';
    });
  }

  void _adicionarPlantaNaFrente() {
    if (arCoreController == null) {
      setState(() {
        mensagem = 'A RA ainda não foi carregada. Aguarde alguns segundos.';
      });
      return;
    }

    if (plantaInserida) {
      _removerPlantaSemMensagem();
    }

    _adicionarVaso();
    _adicionarTerra();
    _adicionarCaule();
    _adicionarFolha(
      name: 'folha_1',
      position: vector.Vector3(-0.13, -0.18, -1.2),
      scale: vector.Vector3(1.00, 0.55, 0.25),
    );
    _adicionarFolha(
      name: 'folha_2',
      position: vector.Vector3(0.13, -0.18, -1.2),
      scale: vector.Vector3(1.00, 0.55, 0.25),
    );
    _adicionarFolha(
      name: 'folha_3',
      position: vector.Vector3(0.00, -0.06, -1.2),
      scale: vector.Vector3(0.90, 0.60, 0.25),
    );
    _adicionarFolha(
      name: 'folha_4',
      position: vector.Vector3(-0.08, 0.03, -1.2),
      scale: vector.Vector3(0.75, 0.50, 0.25),
    );
    _adicionarFolha(
      name: 'folha_5',
      position: vector.Vector3(0.08, 0.03, -1.2),
      scale: vector.Vector3(0.75, 0.50, 0.25),
    );

    setState(() {
      plantaInserida = true;
      mensagem = 'Planta virtual adicionada na frente da câmera.';
    });
  }

  void _adicionarVaso() {
    final materialVaso = ArCoreMaterial(
      color: const Color(0xFF8D4B2A),
      metallic: 0.0,
      roughness: 0.7,
    );

    final vaso = ArCoreCylinder(
      materials: [materialVaso],
      radius: 0.12,
      height: 0.20,
    );

    final node = ArCoreNode(
      name: 'planta_vaso',
      shape: vaso,
      position: vector.Vector3(0, -0.50, -1.2),
    );

    arCoreController?.addArCoreNode(node);
  }

  void _adicionarTerra() {
    final materialTerra = ArCoreMaterial(
      color: const Color(0xFF3A2417),
      metallic: 0.0,
      roughness: 0.9,
    );

    final terra = ArCoreSphere(
      materials: [materialTerra],
      radius: 0.09,
    );

    final node = ArCoreNode(
      name: 'planta_terra',
      shape: terra,
      position: vector.Vector3(0, -0.39, -1.2),
      scale: vector.Vector3(1.2, 0.18, 1.2),
    );

    arCoreController?.addArCoreNode(node);
  }

  void _adicionarCaule() {
    final materialCaule = ArCoreMaterial(
      color: const Color(0xFF4E8B3A),
      metallic: 0.0,
      roughness: 0.5,
    );

    final caule = ArCoreCylinder(
      materials: [materialCaule],
      radius: 0.025,
      height: 0.34,
    );

    final node = ArCoreNode(
      name: 'planta_caule',
      shape: caule,
      position: vector.Vector3(0, -0.25, -1.2),
    );

    arCoreController?.addArCoreNode(node);
  }

  void _adicionarFolha({
    required String name,
    required vector.Vector3 position,
    required vector.Vector3 scale,
  }) {
    final materialFolha = ArCoreMaterial(
      color: const Color(0xFF2ECC71),
      metallic: 0.0,
      roughness: 0.4,
    );

    final folha = ArCoreSphere(
      materials: [materialFolha],
      radius: 0.13,
    );

    final node = ArCoreNode(
      name: name,
      shape: folha,
      position: position,
      scale: scale,
    );

    arCoreController?.addArCoreNode(node);
  }

  void _removerPlanta() {
    if (!plantaInserida) {
      setState(() {
        mensagem = 'Nenhuma planta foi inserida ainda.';
      });
      return;
    }

    _removerPlantaSemMensagem();

    setState(() {
      plantaInserida = false;
      mensagem = 'Planta removida. Toque em "Mostrar planta" para inserir novamente.';
    });
  }

  void _removerPlantaSemMensagem() {
    arCoreController?.removeNode(nodeName: 'planta_vaso');
    arCoreController?.removeNode(nodeName: 'planta_terra');
    arCoreController?.removeNode(nodeName: 'planta_caule');
    arCoreController?.removeNode(nodeName: 'folha_1');
    arCoreController?.removeNode(nodeName: 'folha_2');
    arCoreController?.removeNode(nodeName: 'folha_3');
    arCoreController?.removeNode(nodeName: 'folha_4');
    arCoreController?.removeNode(nodeName: 'folha_5');
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const Center(
          child: Text(
            'Sobre',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'A DecorAR foi fundada em 2026 pelo grupo TeamTwo, com foco em decoração de interiores usando Realidade Aumentada.\n\n'
              'Nesta etapa, o aplicativo utiliza um marcador visual por QR Code para validar o modelo Planta antes de abrir a câmera de RA. '
              'Esse fluxo representa um protótipo funcional de uso de imagem de referência. Em uma versão futura, o app poderá evoluir para Augmented Images do ARCore, '
              'permitindo ancorar o objeto virtual diretamente sobre uma imagem física cadastrada no banco de imagens aumentadas.',
              style: TextStyle(
                color: Color(0xFFDCE9FF),
                height: 1.5,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: const Color(0xFF4BC3FF),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _actionButton(String label, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F4B87), Color(0xFF46225C)],
        ),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      gradient: const LinearGradient(
        colors: [Color(0xFF092949), Color(0xFF1E0F34)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: const Color(0xFF5771BF).withOpacity(0.45)),
    ),
    child: child,
  );
}
