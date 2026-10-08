# Script ODIM de Publicação Automática do Kart São Luís
Write-Host "🏁 [ODIM] Verificando repositório https://github.com/nativo360ads/kart-sao-luis..." -ForegroundColor Cyan

$repoUrl = "https://api.github.com/repos/nativo360ads/kart-sao-luis"
$tentativas = 0
$maxTentativas = 60

while ($tentativas -lt $maxTentativas) {
    try {
        $res = Invoke-WebRequest -Uri $repoUrl -UseBasicParsing -ErrorAction Stop
        if ($res.StatusCode -eq 200) {
            Write-Host "✅ Repositório encontrado no GitHub!" -ForegroundColor Green
            break
        }
    } catch {
        Write-Host "⏳ Aguardando a criação do repositório no GitHub... ($tentativas/$maxTentativas)" -ForegroundColor Yellow
        Start-Sleep -Seconds 2
        $tentativas++
    }
}

Write-Host "🚀 [ODIM] Enviando código para o GitHub (git push -u origin main)..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "🏆 [ODIM] SUCESSO TOTAL! Código publicado no GitHub!" -ForegroundColor Green
    Write-Host "🌐 Link do Repositório: https://github.com/nativo360ads/kart-sao-luis" -ForegroundColor Green
    Write-Host "🎮 Link do Jogo (GitHub Pages): https://nativo360ads.github.io/kart-sao-luis/" -ForegroundColor Green
} else {
    Write-Host "⚠️ [ODIM] Ocorreu um detalhe no push. Verifique se o repositório é público." -ForegroundColor Red
}
