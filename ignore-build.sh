#!/bin/bash

echo "🔍 Verificando mudanças relevantes para o deploy..."

# Lista de arquivos e pastas que devem acionar o build
# Apenas itens que realmente afetam o build final do site
RELEVANT_PATHS=(
  "src/"
  "public/"
  "package.json"
  "pnpm-lock.yaml"
  "astro.config.mjs"
  "tsconfig.json"
)

# Opcional: Descomente se usar essas ferramentas
# "tailwind.config.mjs"
# "postcss.config.js"
# ".env.production"

# Verifica se houve mudanças em algum dos caminhos relevantes
for path in "${RELEVANT_PATHS[@]}"; do
  if git diff HEAD^ HEAD --quiet -- "$path"; then
    # Sem mudanças neste caminho
    continue
  else
    # Encontrou mudanças
    echo "✅ Mudanças detectadas em: $path"
    echo "✅ Build pode prosseguir"
    exit 1
  fi
done

# Se chegou aqui, não houve mudanças relevantes
echo "🛑 Nenhuma mudança relevante detectada"
echo "📝 Mudanças apenas em documentação ou arquivos de configuração do editor"
echo "🛑 Build cancelado"
exit 0
