# TESTE_RA

Página web simples para visualizar o modelo **Heartleaf Philodendron** em 3D e abrir em **Realidade Aumentada (RA)**.

## O que foi criado

- Visualizador 3D com [`<model-viewer>`](https://modelviewer.dev/)
- Botão **Ver em RA** com suporte a:
  - **WebXR** (navegadores compatíveis)
  - **Scene Viewer** (Android)
  - **Quick Look** (iOS, usando `.usdz`)
- Embed do Sketchfab como referência.

## Estrutura

```text
.
├── index.html
├── styles.css
└── assets/
    ├── heartleaf-philodendron.glb   # adicione seu arquivo aqui
    └── heartleaf-philodendron.usdz  # opcional (iOS Quick Look)
```

## Como usar

1. Crie a pasta de assets e coloque o arquivo `.glb`:

   ```bash
   mkdir -p assets
   # copie seu arquivo .glb para:
   # assets/heartleaf-philodendron.glb
   ```

2. (Opcional) gere/adicione um `.usdz` para melhorar suporte no iOS:

   ```text
   assets/heartleaf-philodendron.usdz
   ```

3. Rode um servidor local:

   ```bash
   python3 -m http.server 8080
   ```

4. Abra:

   ```text
   http://localhost:8080
   ```

## Observações

- Se o botão de RA não aparecer, o dispositivo/navegador pode não oferecer suporte.
- Em iOS, o fluxo de RA normalmente depende do arquivo `.usdz`.
