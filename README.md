# Aplicativo DecorAR (Flutter)

Protótipo visual em **Flutter + Dart** para um aplicativo de decoração de interiores inspirado na referência enviada.

> Nesta etapa foi implementada somente a interface (UI). A integração de Realidade Aumentada ainda não foi adicionada.

## Telas implementadas

- Tela inicial com hero, chamada principal e CTAs
- Tela de modelos (grid de itens)
- Tela sobre (texto institucional)
- Card de detalhe com botão "Visualizar"
- Navegação inferior entre as 3 áreas principais

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
