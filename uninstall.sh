#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "  smart-blog 解除安裝"
echo ""

# 選擇解除安裝平台
echo "  選擇解除安裝平台："
echo ""
echo "    原生支援 ─────────────────────────────"
echo "    1) Claude Code     ~/.claude/"
echo "    2) Antigravity     .agent/"
echo "    3) Codex CLI       .agents/"
echo ""
echo "    部分相容 ──────────────────────────────"
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
        UNINSTALL_MODE="full"
        RULES_DIR=""
        ;;
    2)
        PLATFORM="Antigravity"
        SKILL_DIR=".agent/skills"
        AGENT_DIR=""
        UNINSTALL_MODE="full"
        RULES_DIR=""
        ;;
    3)
        PLATFORM="Codex CLI"
        SKILL_DIR=".agents/skills"
        AGENT_DIR=""
        UNINSTALL_MODE="full"
        RULES_DIR=""
        ;;
    4)
        PLATFORM="Cursor"
        SKILL_DIR=""
        AGENT_DIR=""
        UNINSTALL_MODE="rules"
        RULES_DIR=".cursor/rules/smart-blog"
        ;;
    5)
        PLATFORM="Cline"
        SKILL_DIR=""
        AGENT_DIR=""
        UNINSTALL_MODE="rules"
        RULES_DIR=".clinerules/smart-blog"
        ;;
    6)
        PLATFORM="Kilo Code"
        SKILL_DIR=""
        AGENT_DIR=""
        UNINSTALL_MODE="rules"
        RULES_DIR=".kilocode/rules/smart-blog"
        ;;
    *)
        echo "  ❌ 無效的選擇"
        exit 1
        ;;
esac

echo "→ 解除安裝目標：${PLATFORM}"
echo ""

if [ "$UNINSTALL_MODE" = "full" ]; then
    # ── 完整移除（Claude Code / Antigravity / Codex CLI）──

    for skill in smart-blog-write smart-blog-analyze smart-blog-rewrite smart-blog-outline smart-blog-brief; do
        if [ -d "${SKILL_DIR}/${skill}" ]; then
            rm -rf "${SKILL_DIR}/${skill}"
            echo "  - 移除 ${skill}"
        fi
    done

    if [ -d "${SKILL_DIR}/blog" ]; then
        rm -rf "${SKILL_DIR}/blog"
        echo "  - 移除 blog/"
    fi

    if [ -n "$AGENT_DIR" ]; then
        for agent in blog-researcher blog-writer; do
            if [ -f "${AGENT_DIR}/${agent}.md" ]; then
                rm "${AGENT_DIR}/${agent}.md"
                echo "  - 移除 ${agent}"
            fi
        done
    fi

else
    # ── 知識庫移除（Cursor / Cline / Kilo Code）──

    if [ -d "${RULES_DIR}" ]; then
        rm -rf "${RULES_DIR}"
        echo "  - 移除 ${RULES_DIR}"
    else
        echo "  ⚠️  找不到 ${RULES_DIR}，可能未安裝。"
    fi
fi

echo ""
echo "  ✅ smart-blog 已從 ${PLATFORM} 移除。"
echo "  重啟後生效。"
