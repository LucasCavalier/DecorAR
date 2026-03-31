import 'package:flutter/material.dart';

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
  int _index = 1;

  void _navigateToTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ModelsScreen(),
      HomeScreen(onNavigate: _navigateToTab),
      AboutScreen(onVisualizeTap: () => _showComingSoon(context, 'Planta')),
    ];

    return Scaffold(
      body: DecorBackground(child: SafeArea(child: pages[_index])),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF09162E).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF4A69A8).withValues(alpha: 0.4)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: const Color(0xFF3A5DB0).withValues(alpha: 0.45),
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.weekend), label: 'Modelos'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
            NavigationDestination(icon: Icon(Icons.info), label: 'Sobre'),
          ],
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
  final ValueChanged<int> onNavigate;

  const HomeScreen({required this.onNavigate, super.key});

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
                  child: Icon(Icons.view_in_ar, size: 90, color: Color(0xFF7DD6FF)),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Transforme seu\nespaço em segundos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              ...const [
                _Bullet('visualize'),
                _Bullet('experimente'),
                _Bullet('decore com realidade aumentada'),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                'Modelos',
                onTap: () => onNavigate(0),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _actionButton(
                'Sobre',
                onTap: () => onNavigate(2),
              ),
            ),
          ],
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
      ('Planta', Icons.local_florist),
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
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ModelDetailsScreen(
                        modelName: item.$1,
                        modelIcon: item.$2,
                      ),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D3B5A), Color(0xFF0B233D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: const Color(0xFF4BC3FF).withValues(alpha: 0.35)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.$2, color: const Color(0xFF8CE8FF), size: 46),
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AboutScreen extends StatelessWidget {
  final VoidCallback onVisualizeTap;

  const AboutScreen({required this.onVisualizeTap, super.key});

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
              '''A DecorAR é uma empresa inovadora especializada em decoração de interiores com Realidade Aumentada (RA). Nosso objetivo é transformar a forma como as pessoas planejam e visualizam seus ambientes, permitindo que clientes vejam, em tempo real, móveis, cores e elementos decorativos no próprio espaço.

Combinando tecnologia e criatividade, a DecorAR oferece uma experiência moderna e interativa. Nesta primeira versão do aplicativo, estamos focados na construção de uma interface elegante e intuitiva, pronta para receber a integração de RA nas próximas etapas do projeto.

Nossa equipe acredita que cada ambiente deve refletir personalidade e conforto. Por isso, criamos um fluxo simples para explorar modelos, conhecer inspirações e iniciar a jornada de decoração com praticidade e confiança.''',
              style: TextStyle(
                color: Color(0xFFDCE9FF),
                height: 1.5,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _card(
          child: Column(
            children: [
              const Text(
                'Planta',
                style: TextStyle(
                  color: Color(0xFF73E3FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D3B60), Color(0xFF0A1D35)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.eco, color: Color(0xFF9CFF7C), size: 130),
                ),
              ),
              const SizedBox(height: 14),
              _actionButton(
                'Visualizar',
                onTap: onVisualizeTap,
              ),
            ],
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
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
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
      border: Border.all(color: const Color(0xFF5771BF).withValues(alpha: 0.45)),
    ),
    child: child,
  );
}

void _showComingSoon(BuildContext context, String modelName) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Visualização de $modelName em AR será ativada em breve.'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class ModelDetailsScreen extends StatelessWidget {
  final String modelName;
  final IconData modelIcon;

  const ModelDetailsScreen({
    required this.modelName,
    required this.modelIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecorBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const Text(
                      'Detalhes do modelo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 24),
                _card(
                  child: Column(
                    children: [
                      Icon(modelIcon, color: const Color(0xFF8CE8FF), size: 88),
                      const SizedBox(height: 16),
                      Text(
                        modelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Este item está pronto para visualização. Na próxima etapa, você poderá posicioná-lo no ambiente com Realidade Aumentada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFDCE9FF),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 22),
                      _actionButton(
                        'Visualizar',
                        onTap: () => _showComingSoon(context, modelName),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
