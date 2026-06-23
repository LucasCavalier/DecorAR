# Aplicativo DecorAR (Flutter)

Protótipo visual em **Flutter + Dart** para um aplicativo de decoração de interiores baseado no design enviado e compartilhado durante a reunião de abertura dos trabalhos.

# Proposta e História

O **DecorAR** é um aplicativo voltado para design de interiores que utiliza realidade aumentada para transformar a forma como as pessoas planejam e visualizam seus ambientes. A proposta do app é permitir que o usuário projete móveis e elementos de decoração diretamente no espaço real, usando a câmera do celular, facilitando decisões antes da compra ou reorganização do ambiente.

A ideia do DecorAR surgiu da dificuldade comum enfrentada por muitas pessoas ao imaginar como um móvel ou objeto ficará em determinado espaço. Pensando nisso, o aplicativo foi desenvolvido para unir tecnologia e praticidade, oferecendo uma experiência interativa em que o usuário pode posicionar, ajustar e visualizar diferentes opções de mobília em tempo real.

Com isso, o DecorAR não apenas simplifica o processo de decoração, mas também reduz erros, otimiza o tempo e proporciona maior segurança na escolha dos itens, tornando o design de interiores mais acessível, intuitivo e eficiente.

> O projeto será dividido em duas etapas, a primeira etapa e a segunda etapa, segue abaixo as demais informações das mesmas.

> Até o fim da primeira etapa, que finda em (28/04/2026), será implementada somente a interface (UI). A integração de Realidade Aumentada será implementada na segunda etapa do projeto, que finda em (30/06/2026).

## Telas implementadas

- Tela inicial com hero, chamada principal e CTAs;
- Tela de modelos (grid de itens);
- Tela sobre (texto institucional);
- Tela projetar com botão "Projetar" do modelo escolhido;
- Navegação inferior entre as 3 áreas principais.

## Como executar o projeto:

1. Instale o Flutter SDK.
2. Na raiz do projeto, execute:

```bash
flutter pub get
flutter run
```

## Estrutura principal

```text
.
├── lib/
│   └── main.dart
├── pubspec.yaml
└── analysis_options.yaml
```

## Próximos passos (sugestões):

- Integrar visualização 3D real (ex.: SceneView/model-viewer via plataforma)
- Integrar recurso de ARKit/ARCore por plugin Flutter
- Substituir ícones por imagens/modelos reais do catálogo
- Conectar backend para listar objetos e ambientes



## Integrantes:

- Davi Augusto
- Gustavo Silvério
- Lucas Raposo
- João Batista
- Victor Lopes
- Francesco Sireno
