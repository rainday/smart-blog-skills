#!/usr/bin/env bash
set -euo pipefail

# smart-blog 安裝腳本
# 一行安裝：curl -sL https://raw.githubusercontent.com/rainday/smart-blog-skills/main/install.sh | bash

main() {
    local SKILL_DIR
    local AGENT_DIR
    local RULES_DIR
    local PLATFORM
    local INSTALL_MODE  # full | rules
    local SCRIPT_DIR
    local TEMP_DIR=""

    echo ""
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║       smart-blog 安裝程式            ║"
    echo "  ║  防幻覺部落格引擎                    ║"
    echo "  ╚══════════════════════════════════════╝"
    echo ""

    # 選擇安裝平台
    echo "  選擇安裝平台："
    echo ""
    echo "    原生支援 ─────────────────────────────"
    echo "    1) Claude Code     全域安裝 ~/.claude/"
    echo "    2) Antigravity     專案安裝 .agent/"
    echo "    3) Codex CLI       專案安裝 .agents/"
    echo ""
    echo "    部分相容（安裝知識庫為 rules）────────"
    echo "    4) Cursor          .cursor/rules/"
    echo "    5) Cline           .clinerules/"
    echo "    6) Kilo Code       .kilocode/rules/"
    echo ""
    read -p "  請選擇 (1-6，預設 1): " choice
    choice="${choice:-1}"
    echo ""

    case "$choice" in
        1)
            PLATFORM="Claude Code"
            SKILL_DIR="${HOME}/.claude/skills"
            AGENT_DIR="${HOME}/.claude/agents"
            RULES_DIR=""
            INSTALL_MODE="full"
            ;;
        2)
            PLATFORM="Antigravity"
            SKILL_DIR=".agent/skills"
            AGENT_DIR=""
            RULES_DIR=""
            INSTALL_MODE="full"
            ;;
        3)
            PLATFORM="Codex CLI"
            SKILL_DIR=".agents/skills"
            AGENT_DIR=""
            RULES_DIR=""
            INSTALL_MODE="full"
            ;;
        4)
            PLATFORM="Cursor"
            SKILL_DIR=""
            AGENT_DIR=""
            RULES_DIR=".cursor/rules/smart-blog"
            INSTALL_MODE="rules"
            ;;
        5)
            PLATFORM="Cline"
            SKILL_DIR=""
            AGENT_DIR=""
            RULES_DIR=".clinerules/smart-blog"
            INSTALL_MODE="rules"
            ;;
        6)
            PLATFORM="Kilo Code"
            SKILL_DIR=""
            AGENT_DIR=""
            RULES_DIR=".kilocode/rules/smart-blog"
            INSTALL_MODE="rules"
            ;;
        *)
            echo "  ❌ 無效的選擇"
            exit 1
            ;;
    esac

    echo "→ 安裝目標：${PLATFORM}"
    if [ "$INSTALL_MODE" = "full" ]; then
        echo "  技能目錄：${SKILL_DIR}"
    else
        echo "  規則目錄：${RULES_DIR}"
    fi
    echo ""

    # 判斷來源（本地 clone 或 curl pipe）
    if [ -f "${BASH_SOURCE[0]:-}" ] && [ -d "$(dirname "${BASH_SOURCE[0]}")/blog" ]; then
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    else
        echo "→ 下載 smart-blog..."
        TEMP_DIR="$(mktemp -d)"
        trap 'rm -rf "${TEMP_DIR}"' EXIT
        git clone --depth 1 https://github.com/rainday/smart-blog-skills.git "${TEMP_DIR}/smart-blog" 2>/dev/null
        SCRIPT_DIR="${TEMP_DIR}/smart-blog"
    fi

    if [ "$INSTALL_MODE" = "full" ]; then
        # ── 完整安裝（Claude Code / Antigravity / Codex CLI）──

        echo "→ 建立目錄..."
        mkdir -p "${SKILL_DIR}/blog/references"
        mkdir -p "${SKILL_DIR}/blog/templates"
        for skill in smart-blog-write smart-blog-analyze smart-blog-rewrite smart-blog-outline smart-blog-brief; do
            mkdir -p "${SKILL_DIR}/${skill}"
        done
        if [ -n "$AGENT_DIR" ]; then
            mkdir -p "${AGENT_DIR}"
        fi

        echo "→ 安裝主技能..."
        cp "${SCRIPT_DIR}/blog/SKILL.md" "${SKILL_DIR}/blog/SKILL.md"

        echo "→ 安裝參考文件（8 個）..."
        cp "${SCRIPT_DIR}/blog/references/"*.md "${SKILL_DIR}/blog/references/"

        echo "→ 安裝內容模板（5 個）..."
        cp "${SCRIPT_DIR}/blog/templates/"*.md "${SKILL_DIR}/blog/templates/"

        echo "→ 安裝子技能（5 個）..."
        for skill_dir in "${SCRIPT_DIR}/skills/"*/; do
            skill_name="$(basename "${skill_dir}")"
            if [ -f "${skill_dir}SKILL.md" ]; then
                cp "${skill_dir}SKILL.md" "${SKILL_DIR}/${skill_name}/SKILL.md"
                echo "  + ${skill_name}"
            fi
        done

        if [ -n "$AGENT_DIR" ]; then
            echo "→ 安裝 Agent（2 個）..."
            for agent_file in "${SCRIPT_DIR}/agents/"*.md; do
                if [ -f "${agent_file}" ]; then
                    agent_name="$(basename "${agent_file}")"
                    cp "${agent_file}" "${AGENT_DIR}/${agent_name}"
                    echo "  + ${agent_name%.md}"
                fi
            done

            # 檢查 agent-browser
            echo ""
            if command -v agent-browser &>/dev/null; then
                echo "✅ agent-browser 已安裝"
            else
                echo "⚠️  agent-browser 未安裝（建議安裝以降低幻覺風險）"
                if command -v npm &>/dev/null; then
                    read -p "   要現在安裝嗎？(y/N) " -n 1 -r
                    echo ""
                    if [[ $REPLY =~ ^[Yy]$ ]]; then
                        echo "→ 安裝 agent-browser..."
                        npm install -g agent-browser
                    fi
                else
                    echo "   安裝方式：npm install -g agent-browser"
                fi
            fi
        fi

    else
        # ── 知識庫安裝（Cursor / Cline / Kilo Code）──

        echo "→ 建立目錄..."
        mkdir -p "${RULES_DIR}/references"
        mkdir -p "${RULES_DIR}/templates"

        echo "→ 安裝參考文件（8 個）..."
        cp "${SCRIPT_DIR}/blog/references/"*.md "${RULES_DIR}/references/"

        echo "→ 安裝內容模板（5 個）..."
        cp "${SCRIPT_DIR}/blog/templates/"*.md "${RULES_DIR}/templates/"

        echo "→ 安裝策略文件..."
        cp "${SCRIPT_DIR}/STRATEGY.md" "${RULES_DIR}/STRATEGY.md"
    fi

    echo ""
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║          安裝完成！                  ║"
    echo "  ╚══════════════════════════════════════╝"
    echo ""
    echo "  平台：${PLATFORM}"

    if [ "$INSTALL_MODE" = "full" ]; then
        echo "  已安裝："
        echo "    主技能:    blog/（路由器 + 8 參考文件 + 5 模板）"
        echo "    子技能:    5 個指令"
        if [ -n "$AGENT_DIR" ]; then
            echo "    Agent:     2 個（researcher + writer）"
        fi
        echo ""
        echo "  可用指令："
        echo "    /blog write <主題>     寫一篇新文章"
        echo "    /blog analyze <檔案>   分析文章品質（100 分）"
        echo "    /blog rewrite <檔案>   優化改寫文章"
        echo "    /blog outline <主題>   生成文章大綱"
        echo "    /blog brief <主題>     生成內容簡報"
    else
        echo "  已安裝（知識庫模式）："
        echo "    參考文件:  8 個（寫作規則、SEO 策略、模板指南等）"
        echo "    內容模板:  5 個（how-to、listicle、comparison 等）"
        echo "    策略文件:  STRATEGY.md"
        echo ""
        echo "  ⚠️  部分相容：skill 路由和 agent 需手動適配。"
        echo "  知識庫已載入為 rules，可在 ${PLATFORM} 中參考使用。"
    fi

    echo ""
    echo "  重啟 ${PLATFORM} 後即可使用。"
}

main "$@"
