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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ModelsScreen(),
      const AboutScreen(),
    ];

    return Scaffold(
      body: DecorBackground(child: SafeArea(child: pages[_index])),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF09162E).withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF4A69A8).withOpacity(0.4)),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const IconThemeData(color: Colors.white);
              }
              return const IconThemeData(color: Colors.white70);
            }),
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(color: Colors.white);
              }
              return const TextStyle(color: Colors.white70);
            }),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor: const Color.fromARGB(255, 83, 128, 235).withOpacity(0.8),
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
                  child: Icon(Icons.view_in_ar, size: 90, color: Color(0xFF7DD6FF)),
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
                'A realidade aumentada é tudo isso e muito mais',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'A integração da Realidade Aumentada (RA) com a inovação tecnológica tem revolucionado a forma como pensamos a decoração de interiores. '
                'Essa combinação permite projetar, em tempo real, elementos decorativos diretamente no ambiente físico, proporcionando uma visualização precisa e dinâmica das mudanças desejadas. '
                'Com o uso de projeções avançadas, torna-se possível experimentar diferentes estilos, cores e mobiliários antes mesmo de qualquer alteração física.\n\n'

                'Ao unir criatividade e tecnologia, essa abordagem transforma o processo de decoração em uma experiência interativa e altamente eficiente. '
                'Usuários podem testar diversas composições visuais com facilidade, reduzindo incertezas e otimizando decisões. Além disso, a utilização da RA elimina a necessidade de suposições, '
                'tornando o planejamento mais assertivo e alinhado às expectativas.\n\n'

                'As vantagens são significativas: economia de tempo, redução de custos com erros de escolha e maior confiança no resultado final. '
                'Essa inovação não apenas facilita o processo de decorar, mas também amplia as possibilidades criativas, permitindo que cada ambiente seja planejado de forma personalizada, '
                'com precisão e praticidade.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
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
                    MaterialPageRoute(
                      builder: (context) => screen,
                    ),
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
                  child: const Center(
                    child: Icon(
                      Icons.circle_outlined,
                      color: Color(0xFF8CE8FF),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Espelho',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Modelo de espelho em Realidade Aumentada com '
                  'acabamento moderno e superfície altamente reflexiva. '
                  'Possui bordas minimalistas e design elegante, ideal '
                  'para composições sofisticadas em ambientes virtuais. '
                  'O objeto foi desenvolvido para aplicações em projetos '
                  'de interiores, decoração digital e experiências '
                  'imersivas, proporcionando profundidade visual e '
                  'sensação de amplitude aos espaços.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton('Projetar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatueScreen extends StatelessWidget {
  const StatueScreen({super.key});

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
                  child: const Center(
                    child: Icon(
                      Icons.account_balance,
                      color: Color(0xFFFFD27A),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Estátua',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Modelo de estátua em Realidade Aumentada inspirado '
                  'em esculturas clássicas e monumentos históricos. '
                  'Apresenta detalhes refinados, textura semelhante '
                  'à pedra esculpida e proporções realistas que '
                  'transmitem imponência e sofisticação. Ideal para '
                  'aplicações em ambientes culturais, museus virtuais, '
                  'projetos arquitetônicos e experiências interativas '
                  'voltadas à arte e ao patrimônio histórico.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton('Projetar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LampScreen extends StatelessWidget {
  const LampScreen({super.key});

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
                  child: const Center(
                    child: Icon(
                      Icons.lightbulb,
                      color: Color(0xFFFFF176),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Luminária',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Modelo de luminária em Realidade Aumentada com '
                  'design contemporâneo e iluminação suave. '
                  'Desenvolvida para criar atmosferas aconchegantes '
                  'e sofisticadas em ambientes virtuais, combina '
                  'formas elegantes com materiais modernos e acabamento '
                  'minimalista. Ideal para projetos de interiores, '
                  'visualização arquitetônica e experiências digitais '
                  'imersivas focadas em decoração e iluminação.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton('Projetar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1D35), // fundo azul escuro
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
          icon: const Icon(Icons.local_florist, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          },
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
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.eco,
                      color: Color(0xFF9CFF7C),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // TÍTULO
                const Center(
                  child: Text(
                    'Planta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // DESCRIÇÃO
                const Text(
                  'Modelo de planta em Realidade Aumentada inspirado '
                  'na exuberância natural dos philodendrons tropicais. '
                  'Apresenta folhas amplas, detalhadas e com textura '
                  'realista, destacando nervuras marcantes e tons '
                  'vibrantes de verde. O design combina estética '
                  'orgânica com elementos modernos para aplicações '
                  'decorativas e interativas em ambientes virtuais. '
                  'Ideal para experiências imersivas em projetos de '
                  'arquitetura, interiores, educação e visualização '
                  'digital. Seu visual elegante transmite frescor, '
                  'sofisticação e profundidade visual.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 22),

                _actionButton(
                  'Projetar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiamondScreen extends StatelessWidget {
  const DiamondScreen({super.key});

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
                  child: const Center(
                    child: Icon(
                      Icons.change_history,
                      color: Color(0xFF8CE8FF),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Diamante',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Modelo de diamante em Realidade Aumentada com '
                  'lapidação detalhada e brilho intenso. Possui '
                  'superfícies facetadas que refletem luz de forma '
                  'realista, criando efeitos visuais sofisticados e '
                  'imersivos. Ideal para aplicações em joalheria '
                  'digital, vitrines virtuais, experiências interativas '
                  'e projetos de visualização tridimensional de luxo.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton('Projetar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UfoScreen extends StatelessWidget {
  const UfoScreen({super.key});

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
                  child: const Center(
                    child: Icon(
                      Icons.blur_circular,
                      color: Color(0xFF9CFF7C),
                      size: 130,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'OVNI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Modelo de OVNI em Realidade Aumentada inspirado '
                  'em conceitos futuristas e ficção científica. '
                  'Apresenta estrutura metálica detalhada, iluminação '
                  'neon e design aerodinâmico com efeitos visuais '
                  'imersivos. Ideal para experiências interativas, '
                  'jogos, simulações espaciais e projetos digitais '
                  'voltados à exploração criativa e tecnologia futurista.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                _actionButton('Projetar'),
              ],
            ),
          ),
        ],
      ),
    );
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
              'A DecorAR foi fundada em 2026, pelo grupo TeamTwo, uma empresa inovadora especializada em decoração de interiores com Realidade Aumentada (RA). '
              'Nosso objetivo é transformar a forma como as pessoas planejam e visualizam seus ambientes, permitindo '
              'que clientes vejam, em tempo real, móveis, cores e elementos decorativos no próprio espaço.\n\n'
              'Combinando tecnologia e criatividade, a DecorAR oferece uma experiência moderna e interativa. Nesta primeira '
              'versão do aplicativo, estamos focados na construção de uma interface elegante e intuitiva, pronta para receber '
              'a integração de RA nas próximas etapas do projeto.\n\n'
              'Nossa equipe acredita que cada ambiente deve refletir personalidade e conforto. Por isso, criamos um fluxo simples '
              'para explorar modelos, conhecer inspirações e iniciar a jornada de decoração com praticidade e confiança.',
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

Widget _actionButton(String label) {
  return Container(
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
