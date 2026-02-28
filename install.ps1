#!/usr/bin/env pwsh
# smart-blog Windows 安裝腳本

$ErrorActionPreference = "Stop"

function Write-Color($Color, $Text) {
    Write-Host $Text -ForegroundColor $Color
}

function Main {
    Write-Color Cyan @"

  ╔══════════════════════════════════════╗
  ║       smart-blog 安裝程式            ║
  ║  防幻覺部落格引擎                    ║
  ╚══════════════════════════════════════╝

"@

    # 選擇安裝平台
    Write-Color White "  選擇安裝平台："
    Write-Color White ""
    Write-Color White "    原生支援 ─────────────────────────────"
    Write-Color White "    1) Claude Code     全域安裝 ~/.claude/"
    Write-Color White "    2) Antigravity     專案安裝 .agent/"
    Write-Color White "    3) Codex CLI       專案安裝 .agents/"
    Write-Color White ""
    Write-Color White "    部分相容（安裝知識庫為 rules）────────"
    Write-Color White "    4) Cursor          .cursor/rules/"
    Write-Color White "    5) Cline           .clinerules/"
    Write-Color White "    6) Kilo Code       .kilocode/rules/"
    Write-Color White ""
    $choice = Read-Host "  請選擇 (1-6，預設 1)"
    if (-not $choice) { $choice = "1" }
    Write-Host ""

    switch ($choice) {
        "1" {
            $Platform = "Claude Code"
            $SkillDir = Join-Path $env:USERPROFILE ".claude" "skills"
            $AgentDir = Join-Path $env:USERPROFILE ".claude" "agents"
            $RulesDir = ""
            $InstallMode = "full"
        }
        "2" {
            $Platform = "Antigravity"
            $SkillDir = Join-Path "." ".agent" "skills"
            $AgentDir = ""
            $RulesDir = ""
            $InstallMode = "full"
        }
        "3" {
            $Platform = "Codex CLI"
            $SkillDir = Join-Path "." ".agents" "skills"
            $AgentDir = ""
            $RulesDir = ""
            $InstallMode = "full"
        }
        "4" {
            $Platform = "Cursor"
            $SkillDir = ""
            $AgentDir = ""
            $RulesDir = Join-Path "." ".cursor" "rules" "smart-blog"
            $InstallMode = "rules"
        }
        "5" {
            $Platform = "Cline"
            $SkillDir = ""
            $AgentDir = ""
            $RulesDir = Join-Path "." ".clinerules" "smart-blog"
            $InstallMode = "rules"
        }
        "6" {
            $Platform = "Kilo Code"
            $SkillDir = ""
            $AgentDir = ""
            $RulesDir = Join-Path "." ".kilocode" "rules" "smart-blog"
            $InstallMode = "rules"
        }
        default {
            Write-Color Red "  ❌ 無效的選擇"
            exit 1
        }
    }

    Write-Color White "→ 安裝目標：$Platform"
    if ($InstallMode -eq "full") {
        Write-Color White "  技能目錄：$SkillDir"
    } else {
        Write-Color White "  規則目錄：$RulesDir"
    }
    Write-Host ""

    $ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent (Resolve-Path $MyInvocation.InvocationName) }

    if ($InstallMode -eq "full") {
        # ── 完整安裝（Claude Code / Antigravity / Codex CLI）──

        Write-Color White "→ 建立目錄..."
        New-Item -ItemType Directory -Force -Path (Join-Path $SkillDir "blog" "references") | Out-Null
        New-Item -ItemType Directory -Force -Path (Join-Path $SkillDir "blog" "templates") | Out-Null

        foreach ($skill in @("smart-blog-write", "smart-blog-analyze", "smart-blog-rewrite", "smart-blog-outline", "smart-blog-brief")) {
            New-Item -ItemType Directory -Force -Path (Join-Path $SkillDir $skill) | Out-Null
        }

        if ($AgentDir) {
            New-Item -ItemType Directory -Force -Path $AgentDir | Out-Null
        }

        Write-Color White "→ 安裝主技能..."
        Copy-Item (Join-Path $ScriptDir "blog" "SKILL.md") (Join-Path $SkillDir "blog" "SKILL.md") -Force

        Write-Color White "→ 安裝參考文件（8 個）..."
        Copy-Item (Join-Path $ScriptDir "blog" "references" "*.md") (Join-Path $SkillDir "blog" "references") -Force

        Write-Color White "→ 安裝內容模板（5 個）..."
        Copy-Item (Join-Path $ScriptDir "blog" "templates" "*.md") (Join-Path $SkillDir "blog" "templates") -Force

        Write-Color White "→ 安裝子技能（5 個）..."
        Get-ChildItem -Directory (Join-Path $ScriptDir "skills") | ForEach-Object {
            $skillName = $_.Name
            $src = Join-Path $_.FullName "SKILL.md"
            $dst = Join-Path $SkillDir $skillName "SKILL.md"
            if (Test-Path $src) {
                Copy-Item $src $dst -Force
                Write-Color Green "  + $skillName"
            }
        }

        if ($AgentDir) {
            Write-Color White "→ 安裝 Agent（2 個）..."
            Get-ChildItem -File (Join-Path $ScriptDir "agents" "*.md") | ForEach-Object {
                Copy-Item $_.FullName (Join-Path $AgentDir $_.Name) -Force
                Write-Color Green "  + $($_.BaseName)"
            }

            # 檢查 agent-browser
            Write-Color White ""
            try {
                $null = Get-Command agent-browser -ErrorAction Stop
                Write-Color Green "✅ agent-browser 已安裝"
            } catch {
                Write-Color Yellow "⚠️  agent-browser 未安裝（建議安裝以降低幻覺風險）"
                try {
                    $null = Get-Command npm -ErrorAction Stop
                    $response = Read-Host "   要現在安裝嗎？(y/N)"
                    if ($response -match '^[Yy]$') {
                        Write-Color White "→ 安裝 agent-browser..."
                        & npm install -g agent-browser
                    }
                } catch {
                    Write-Color White "   安裝方式：npm install -g agent-browser"
                }
            }
        }

    } else {
        # ── 知識庫安裝（Cursor / Cline / Kilo Code）──

        Write-Color White "→ 建立目錄..."
        New-Item -ItemType Directory -Force -Path (Join-Path $RulesDir "references") | Out-Null
        New-Item -ItemType Directory -Force -Path (Join-Path $RulesDir "templates") | Out-Null

        Write-Color White "→ 安裝參考文件（8 個）..."
        Copy-Item (Join-Path $ScriptDir "blog" "references" "*.md") (Join-Path $RulesDir "references") -Force

        Write-Color White "→ 安裝內容模板（5 個）..."
        Copy-Item (Join-Path $ScriptDir "blog" "templates" "*.md") (Join-Path $RulesDir "templates") -Force

        Write-Color White "→ 安裝策略文件..."
        Copy-Item (Join-Path $ScriptDir "STRATEGY.md") (Join-Path $RulesDir "STRATEGY.md") -Force
    }

    Write-Color Cyan @"

  ╔══════════════════════════════════════╗
  ║          安裝完成！                  ║
  ╚══════════════════════════════════════╝

"@

    Write-Color White "  平台：$Platform"

    if ($InstallMode -eq "full") {
        Write-Color White "  已安裝："
        Write-Color Green "    主技能:  blog/（路由器 + 8 參考文件 + 5 模板）"
        Write-Color Green "    子技能:  5 個指令"
        if ($AgentDir) {
            Write-Color Green "    Agent:   2 個（researcher + writer）"
        }
        Write-Color White ""
        Write-Color White "  可用指令："
        Write-Color Cyan  "    /blog write <主題>     寫一篇新文章"
        Write-Color Cyan  "    /blog analyze <檔案>   分析文章品質（100 分）"
        Write-Color Cyan  "    /blog rewrite <檔案>   優化改寫文章"
        Write-Color Cyan  "    /blog outline <主題>   生成文章大綱"
        Write-Color Cyan  "    /blog brief <主題>     生成內容簡報"
    } else {
        Write-Color White "  已安裝（知識庫模式）："
        Write-Color Green "    參考文件:  8 個（寫作規則、SEO 策略、模板指南等）"
        Write-Color Green "    內容模板:  5 個（how-to、listicle、comparison 等）"
        Write-Color Green "    策略文件:  STRATEGY.md"
        Write-Color White ""
        Write-Color Yellow "  ⚠️  部分相容：skill 路由和 agent 需手動適配。"
        Write-Color White "  知識庫已載入為 rules，可在 $Platform 中參考使用。"
    }

    Write-Color White ""
    Write-Color Yellow "  重啟 $Platform 後即可使用。"
}

Main
