# Guia de Deploy

Documenta os caminhos oficiais de implantação do projeto (`GitHub → Vercel` por padrão) e alternativas suportadas pelo Astro. Use este guia como checklist sempre que configurar ou revisar um pipeline de deploy.

## Visão geral do fluxo atual

- O repositório está conectado à Vercel: cada `git push` para o branch monitorado gera automaticamente um build e um deploy com URL própria (preview ou produção).\
  Referência: [Projects and deployments – Vercel Docs](https://vercel.com/docs/getting-started-with-vercel/projects-deployments)
- Para mudanças manuais/local, é possível rodar `vercel deploy` (ou apenas `vercel`) na raiz do projeto; a CLI dispara o mesmo fluxo que o push via Git.\
  Referência: [Get started with Astro on Vercel](https://vercel.com/docs/frameworks/frontend/astro)

## Deploy contínuo na Vercel

### Pré-requisitos

1. Repositório hospedado no GitHub, GitLab ou Bitbucket.
2. Projeto criado na Vercel com integração ao repositório.
3. Variáveis de ambiente configuradas no painel (caso necessárias).

### Passo a passo via dashboard

1. Importar o projeto na Vercel usando o repositório existente.
2. Confirmar o comando de build (`pnpm run build`) e a pasta de saída (`dist`).
3. Cada push gera automaticamente um deployment com URL própria; PRs recebem preview links.\
   Referência: [Projects and deployments – Vercel Docs](https://vercel.com/docs/getting-started-with-vercel/projects-deployments)
4. Para gerenciar builds (promover, reimplantar, cancelar), use a aba **Deployments** do dashboard.\
   Referência: [Managing deployments – Vercel Docs](https://vercel.com/docs/deployments/managing-deployments)

### Passo a passo via CLI

1. Instale a CLI (`pnpm add -g vercel` ou use `npx vercel`).
2. Execute `vercel` na raiz e siga o assistente para associar o projeto.
3. Use `vercel deploy --prod` para promover manualmente um build local.\
   Referência: [Get started with Astro on Vercel](https://vercel.com/docs/frameworks/frontend/astro)

### Checks e promoção para produção

- Ative **Deployment Checks** (lint, testes, preview) no painel. O domínio de produção recebe automaticamente o deploy após todos os checks passarem.\
  Referência: [Deployment checks – Vercel Docs](https://vercel.com/docs/deployment-checks)
- Para estratégias de rollout seguro, habilite **Rolling Releases** antes de apontar todo o tráfego para o novo build.

### Boas práticas operacionais

- Defina plano de resposta a incidentes, canais de comunicação e estratégia de rollback.
- Configure cache (ex.: Turborepo) no caso de monorepo para evitar builds desnecessários.
- Revise DNS (se usar Vercel DNS) para migrações sem downtime.\
  Referência: [Production checklist – Vercel Docs](https://vercel.com/docs/production-checklist)

## Ajustes específicos para Astro na Vercel

- Sites Astro puramente estáticos exigem zero configuração extra; basta aceitar o build padrão.
- Para habilitar recursos da Vercel (Image Optimization, Web Analytics etc.) em rotas server-side ou híbridas, instale o adaptador `@astrojs/vercel`.\
  Referência: [Astro on Vercel – Using Vercel features](https://vercel.com/docs/frameworks/frontend/astro)
- Rotas individuais podem ser pre-renderizadas com `export const prerender = true`, mantendo SSR apenas onde necessário.

### Otimizando builds com `ignore-build.sh`

- Use o script [`ignore-build.sh`](../ignore-build.sh) para bloquear builds quando o commit altera apenas arquivos irrelevantes para o deploy (ex.: documentação, configs do editor).
- Ele verifica mudanças em `src/`, `public/`, arquivos de dependências e configs críticas (Astro, TypeScript). Se nada relevante mudou, retorna `0`, permitindo cancelar o job no provedor de CI.
- Integre-o como etapa inicial dos pipelines (GitHub Actions, Vercel Ignored Build Step etc.) para economizar tempo de build e evitar deploys redundantes.

## Deploy em outros providers suportados pelo Astro

Quando precisar hospedar em outro serviço, use o comando `pnpm run build` e publique o conteúdo de `dist`. A Astro Docs mantém guias específicos; abaixo um resumo dos principais:

| Provider | Como funciona | Referência oficial |
| --- | --- | --- |
| Netlify CLI | Após configurar `netlify init`, cada `git push` gera build automático; a CLI adiciona deploy key e também permite deploy manual. | [Astro Docs – Deploy Netlify](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/netlify.mdx) |
| Deno Deploy | Commits no branch configurado acionam o workflow GitHub Actions (`deploy.yml`). Status pode ser acompanhado pelo tab **Actions** ou dashboard da Deno. | [Astro Docs – Deploy Deno](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/deno.mdx) |
| DeployHQ | Dá para automatizar deploy a cada `git push` ou agendar janelas específicas. Após configurar, o serviço builda e envia o conteúdo. | [Astro Docs – DeployHQ](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/deployhq.mdx) |
| Clever Cloud | Push para `main` (ou `git push clever <branch>:main`) dispara o deploy, mantendo o fluxo alinhado ao branch principal. | [Astro Docs – Clever Cloud](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/clever-cloud.mdx) |
| Kinsta | Conecte o repo no MyKinsta; configure deploy automático a cada push ou rode manualmente via painel. | [Astro Docs – Kinsta](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/kinsta.mdx) |
| Railway | Use o template Astro no Railway para iniciar rápido; depois você pode “ejetar” para o seu próprio repo e manter deploy contínuo. | [Astro Docs – Railway](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/railway.mdx) |
| Zeabur | Após o deploy inicial, qualquer push em qualquer branch conectado dispara build automático. | [Astro Docs – Zeabur](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/zeabur.mdx) |
| Cleavr | Configure VC Profile, repo e branch; em seguida use a aba **Deployments** do Cleavr para publicar. | [Astro Docs – Cleavr](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/cleavr.mdx) |
| Buddy | Depois do build, adicione ação de deploy apontando `Source path` para `dist`. Suporta FTP, cloud etc. | [Astro Docs – Buddy](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/buddy.mdx) |
| Surge | Instale `surge`, rode `pnpm run build` e publique `dist` via CLI; dá para mapear domínios customizados. | [Astro Docs – Surge](https://github.com/withastro/docs/blob/main/src/content/docs/en/guides/deploy/surge.mdx) |

> Dica: consulte sempre o guia oficial correspondente porque cada provedor pode exigir variáveis de ambiente, adaptadores ou comandos extras específicos.

## Checklist rápido antes do merge

1. `pnpm run build` localmente para validar.
2. Conferir status dos Deployment Checks na Vercel.
3. Revisar logs do build (Vercel ou provedor alternativo).
4. Validar URL de preview (ou ambiente de homologação).
5. Promover para produção apenas após QA + aprovação.

Com este fluxo você garante deploys repetíveis tanto na Vercel quanto em outros provedores suportados pelo Astro.

