#!/bin/bash

# FreqUI 开发服务器启动脚本

echo "🚀 启动 FreqUI 开发服务器..."
echo ""

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ 错误: 未找到 Node.js，请先安装 Node.js"
    exit 1
fi

# 检查 pnpm
if ! command -v pnpm &> /dev/null; then
    echo "❌ 错误: 未找到 pnpm，请先安装 pnpm"
    echo "   运行: curl -fsSL https://get.pnpm.io/install.sh | sh -"
    exit 1
fi

# 确保在正确的目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# 检查 node_modules 是否存在
if [ ! -d "node_modules" ]; then
    echo "📦 首次运行，正在安装依赖..."
    source ~/.bashrc
    pnpm install
    echo ""
fi

# 检查 freqtrade 是否运行
echo "🔍 检查 freqtrade API 连接..."
if curl -s http://127.0.0.1:8080/api/v1/ping > /dev/null 2>&1; then
    echo "✅ Freqtrade API 正在运行"
else
    echo "⚠️  警告: 无法连接到 freqtrade API (http://127.0.0.1:8080)"
    echo "   请确保 freqtrade 容器正在运行"
    echo "   运行: cd /home/ec2-user/ft_userdata && docker compose up -d"
    echo ""
    read -p "是否继续启动开发服务器？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo ""
echo "🌐 启动开发服务器..."
echo "   访问地址: http://127.0.0.1:3000"
echo "   按 Ctrl+C 停止服务器"
echo ""

# 加载 pnpm 到 PATH（如果需要）
source ~/.bashrc

# 启动开发服务器
pnpm run dev

