# {{PACKAGE_NAME}}

Template minimalista em Astro para criar landing pages estáticas com rapidez. Inclui estrutura opinativa, tooling pronto e componentes placeholders para acelerar o kick-off de novos sites.

## ✨ Visão geral

> `{{PACKAGE_NAME}}` prioriza simplicidade: uma única página inicial, layout global configurado, tokens de cor definidos e ferramentas de qualidade prontas. O objetivo é permitir que você foque no conteúdo e no design enquanto mantém uma base consistente para deploys rápidos.

## 🧱 Stack principal

- [Astro](https://astro.build) para a camada de UI e roteamento
- [pnpm](https://pnpm.io/) como gerenciador de pacotes
- [Tailwind CSS 4](https://tailwindcss.com/blog/tailwindcss-v4-alpha) como base de estilos utilitários, importado em `src/styles/global.css`

## 🧩 Conteúdo padrão

- `src/pages/index.astro` usa o componente `StarterHero` como placeholder. Substitua essa seção assim que tiver o primeiro layout pronto.
- `src/layouts/Layout.astro` define tags de meta básicas (incluindo `noindex` para evitar indexação antes da hora) e importa os estilos globais.
- `src/styles/global.css` está pronto para receber seus tokens de cor tipografia e resets. Adicione variáveis conforme o branding do seu projeto.

## 🚀 Como usar este template

1. Clique em **Use this template** no GitHub ou rode `npx degit ribeiroevandro/astro-base-template meu-site`.
2. Instale as dependências:
   ```sh
   pnpm install
   ```
3. Inicie o ambiente local:
   ```sh
   pnpm dev
   ```
4. Acesse `http://localhost:4321` e edite os componentes em `src/`.

### Builds e preview

```sh
pnpm build   # Gera os artefatos em ./dist
pnpm preview # Sobe um servidor estático para inspecionar o build
```

## 📂 Estrutura

```text
/
├── docs/          # Guias internos e checklists
│   └── deploy.md  # Fluxo de deploy sugerido (Vercel + alternativos)
├── public/        # Assets estáticos entregues como estão
├── src/
│   ├── assets     # Logos, fontes e imagens
│   ├── components # Blocos reutilizáveis
│   ├── layouts    # Layouts compartilhados
│   └── pages      # Rotas Astro
└── package.json
```

## 🛠️ Personalização rápida

- **Tipografia/cores**: defina seus tokens em `src/styles/global.css` ou expanda o preset Tailwind.
- **SEO**: ajuste `siteName`, `defaultTitle` e `description` em `src/layouts/Layout.astro`. Remova `noindex` quando for publicar.
- **Placeholder**: troque `StarterHero.astro` por seções reais ou importe seu design system.
- **Automação de CI**: o script [`ignore-build.sh`](ignore-build.sh) identifica commits que não exigem novo build (docs, configs de editor). Configure-o na Vercel ou no provedor escolhido.

## 📦 Deploy

- Por padrão, recomendamos conectar o `main` à Vercel para obter deploys automáticos a cada push.
- Para promover manualmente: `vercel` / `vercel deploy --prod` depois de autenticar.
- Prefere outro provedor (Netlify, Deno Deploy, Railway, etc.)? Compile com `pnpm run build` e publique o conteúdo de `dist`.
- Detalhes completos, referências oficiais e checklist estão em [`docs/deploy.md`](docs/deploy.md).

## 🧹 Qualidade de código

- `.editorconfig` garante indentação de 2 espaços e EOL consistente.
- `pnpm lint` / `pnpm lint:fix` executa ESLint em `src/`.
- `pnpm format` / `pnpm format:fix` usa Prettier (com suporte a Astro e Tailwind).
- Sempre rode `pnpm build` antes de abrir PRs para garantir que o template continua compilando.

## ✅ Checklist antes de publicar o seu site

- Ajuste branding, cores e tipografia.
- Revise as metas no layout e configure favicons em `public/`.
- Atualize a cópia da home e crie páginas adicionais se necessário.
- Configure variáveis de ambiente (se for usar integrações) antes do deploy.
- Valide o resultado em `pnpm preview` e verifique o checklist em `docs/deploy.md`.

## 📄 Licença

Projeto aberto. Use à vontade como base para os seus sites em Astro e mantenha créditos quando possível.

