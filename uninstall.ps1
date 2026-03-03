#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host "`n  smart-blog 解除安裝`n"

# 選擇解除安裝平台
Write-Host "  選擇解除安裝平台："
Write-Host ""
Write-Host "    原生支援 ─────────────────────────────"
Write-Host "    1) Claude Code     ~/.claude/"
Write-Host "    2) Antigravity     .agent/"
Write-Host "    3) Codex CLI       .agents/"
Write-Host ""
Write-Host "    部分相容 ──────────────────────────────"
Write-Host "    4) Cursor          .cursor/rules/"
Write-Host "    5) Cline           .clinerules/"
Write-Host "    6) Kilo Code       .kilocode/rules/"
Write-Host ""
$choice = Read-Host "  請選擇 (1-6，預設 1)"
if (-not $choice) { $choice = "1" }
Write-Host ""

switch ($choice) {
    "1" {
        $Platform = "Claude Code"
        $SkillDir = Join-Path $env:USERPROFILE ".claude" "skills"
        $AgentDir = Join-Path $env:USERPROFILE ".claude" "agents"
        $UninstallMode = "full"
        $RulesDir = ""
    }
    "2" {
        $Platform = "Antigravity"
        $SkillDir = Join-Path "." ".agent" "skills"
        $AgentDir = ""
        $UninstallMode = "full"
        $RulesDir = ""
    }
    "3" {
        $Platform = "Codex CLI"
        $SkillDir = Join-Path "." ".agents" "skills"
        $AgentDir = ""
        $UninstallMode = "full"
        $RulesDir = ""
    }
    "4" {
        $Platform = "Cursor"
        $SkillDir = ""
        $AgentDir = ""
        $UninstallMode = "rules"
        $RulesDir = Join-Path "." ".cursor" "rules" "smart-blog"
    }
    "5" {
        $Platform = "Cline"
        $SkillDir = ""
        $AgentDir = ""
        $UninstallMode = "rules"
        $RulesDir = Join-Path "." ".clinerules" "smart-blog"
    }
    "6" {
        $Platform = "Kilo Code"
        $SkillDir = ""
        $AgentDir = ""
        $UninstallMode = "rules"
        $RulesDir = Join-Path "." ".kilocode" "rules" "smart-blog"
    }
    default {
        Write-Host "  ❌ 無效的選擇" -ForegroundColor Red
        exit 1
    }
}

Write-Host "→ 解除安裝目標：$Platform"
Write-Host ""

if ($UninstallMode -eq "full") {
    # ── 完整移除（Claude Code / Antigravity / Codex CLI）──

    foreach ($skill in @("smart-blog-write", "smart-blog-analyze", "smart-blog-rewrite", "smart-blog-outline", "smart-blog-brief")) {
        $path = Join-Path $SkillDir $skill
        if (Test-Path $path) {
            Remove-Item -Recurse -Force $path
            Write-Host "  - 移除 $skill" -ForegroundColor Yellow
        }
    }

    $blogPath = Join-Path $SkillDir "blog"
    if (Test-Path $blogPath) {
        Remove-Item -Recurse -Force $blogPath
        Write-Host "  - 移除 blog/" -ForegroundColor Yellow
    }

    if ($AgentDir) {
        foreach ($agent in @("blog-researcher", "blog-writer")) {
            $path = Join-Path $AgentDir "$agent.md"
            if (Test-Path $path) {
                Remove-Item -Force $path
                Write-Host "  - 移除 $agent" -ForegroundColor Yellow
            }
        }
    }

} else {
    # ── 知識庫移除（Cursor / Cline / Kilo Code）──

    if (Test-Path $RulesDir) {
        Remove-Item -Recurse -Force $RulesDir
        Write-Host "  - 移除 $RulesDir" -ForegroundColor Yellow
    } else {
        Write-Host "  ⚠️  找不到 $RulesDir，可能未安裝。" -ForegroundColor Yellow
    }
}

Write-Host "`n  ✅ smart-blog 已從 $Platform 移除。" -ForegroundColor Green
Write-Host "  重啟後生效。`n" -ForegroundColor Yellow
