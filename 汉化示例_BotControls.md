# BotControls 组件汉化示例

这是一个实际的汉化示例，展示如何将 `src/components/ftbot/BotControls.vue` 组件中的英文文本替换为中文。

## 修改步骤

### 1. 打开文件
```bash
cd /home/ec2-user/frequi
# 使用你喜欢的编辑器打开
vim src/components/ftbot/BotControls.vue
# 或者
code src/components/ftbot/BotControls.vue
```

### 2. 需要修改的文本对照表

| 原英文文本 | 中文翻译 |
|-----------|---------|
| `'Stop Bot'` | `'停止机器人'` |
| `'Stop the bot loop from running?'` | `'确定要停止机器人运行吗？'` |
| `'Pause - Stop Entering'` | `'暂停 - 停止入场'` |
| `'Freqtrade will continue to handle open trades, but will not enter new trades or increase position sizes.'` | `'Freqtrade 将继续处理已开仓的交易，但不会开新仓或增加仓位。'` |
| `'Reload'` | `'重新加载'` |
| `'Reload configuration (including strategy)?'` | `'重新加载配置（包括策略）？'` |
| `'ForceExit all'` | `'强制平仓所有'` |
| `'Really forceexit ALL trades?'` | `'确定要强制平仓所有交易吗？'` |
| `title="Start Trading"` | `title="开始交易"` |
| `title="Stop Trading - Also stops handling open trades."` | `title="停止交易 - 同时停止处理已开仓的交易。"` |
| `title="Pause (StopBuy) - Freqtrade will continue to handle open trades, but will not enter new trades or increase position sizes."` | `title="暂停（停止买入）- Freqtrade 将继续处理已开仓的交易，但不会开新仓或增加仓位。"` |
| `title="Reload Config - reloads configuration including strategy, resetting all settings changed on the fly."` | `title="重新加载配置 - 重新加载配置包括策略，重置所有运行时修改的设置。"` |
| `title="Force exit all"` | `title="强制平仓所有"` |
| `title="Force enter - Immediately enter a trade at an optional price. Exits are then handled according to strategy rules."` | `title="强制入场 - 立即以可选价格开仓。平仓将根据策略规则处理。"` |
| `title="Start Trading mode"` | `title="开始交易模式"` |

### 3. 完整的汉化后代码示例

以下是修改后的关键部分（script 部分）：

```typescript
const handleStopBot = () => {
  const msg: MsgBoxObject = {
    title: '停止机器人',
    message: '确定要停止机器人运行吗？',
    accept: () => {
      botStore.activeBot.stopBot();
    },
  };
  msgBox.value?.show(msg);
};

const handleStopBuy = () => {
  const msg: MsgBoxObject = {
    title: '暂停 - 停止入场',
    message:
      'Freqtrade 将继续处理已开仓的交易，但不会开新仓或增加仓位。',
    accept: () => {
      botStore.activeBot.stopBuy();
    },
  };
  msgBox.value?.show(msg);
};

const handleReloadConfig = () => {
  const msg: MsgBoxObject = {
    title: '重新加载',
    message: '重新加载配置（包括策略）？',
    accept: () => {
      console.log('reload...');
      botStore.activeBot.reloadConfig();
    },
  };
  msgBox.value?.show(msg);
};

const handleForceExit = () => {
  const msg: MsgBoxObject = {
    title: '强制平仓所有',
    message: '确定要强制平仓所有交易吗？',
    accept: () => {
      const payload: ForceSellPayload = {
        tradeid: 'all',
      };
      botStore.activeBot.forceexit(payload);
    },
  };
  msgBox.value?.show(msg);
};
```

模板部分（template）：

```vue
<template>
  <div class="flex flex-row gap-1">
    <Button
      size="large"
      severity="secondary"
      :disabled="!botStore.activeBot.isTrading || isRunning"
      title="开始交易"
      @click="botStore.activeBot.startBot()"
    >
      <template #icon>
        <i-mdi-play />
      </template>
    </Button>
    <Button
      size="large"
      severity="secondary"
      :disabled="!botStore.activeBot.isTrading || !isRunning"
      title="停止交易 - 同时停止处理已开仓的交易。"
      @click="handleStopBot()"
    >
      <template #icon>
        <i-mdi-stop />
      </template>
    </Button>
    <Button
      size="large"
      severity="secondary"
      :disabled="!botStore.activeBot.isTrading || !isRunning"
      title="暂停（停止买入）- Freqtrade 将继续处理已开仓的交易，但不会开新仓或增加仓位。"
      @click="handleStopBuy()"
    >
      <template #icon>
        <i-mdi-pause />
      </template>
    </Button>
    <Button
      size="large"
      severity="secondary"
      :disabled="!botStore.activeBot.isTrading"
      title="重新加载配置 - 重新加载配置包括策略，重置所有运行时修改的设置。"
      @click="handleReloadConfig()"
    >
      <template #icon>
        <i-mdi-reload />
      </template>
    </Button>
    <Button
      severity="secondary"
      size="large"
      :disabled="!botStore.activeBot.isTrading"
      title="强制平仓所有"
      @click="handleForceExit()"
    >
      <template #icon>
        <i-mdi-close-box-multiple />
      </template>
    </Button>
    <Button
      v-if="botStore.activeBot.botState && botStore.activeBot.botState.force_entry_enable"
      size="large"
      severity="secondary"
      :disabled="!botStore.activeBot.isTrading || !isRunning"
      title="强制入场 - 立即以可选价格开仓。平仓将根据策略规则处理。"
      @click="forceEnter = true"
    >
      <template #icon>
        <i-mdi-plus-box-multiple-outline />
      </template>
    </Button>
    <!-- ... 其他按钮 ... -->
  </div>
</template>
```

## 测试修改

1. 保存文件后，开发服务器会自动重新加载（如果正在运行 `pnpm run dev`）
2. 在浏览器中刷新页面：`http://127.0.0.1:3000`
3. 检查按钮的 tooltip（鼠标悬停时显示的提示）和对话框文本是否已变为中文

## 注意事项

1. **保持引号一致：** 确保使用相同的引号类型（单引号或双引号）
2. **注意特殊字符：** 中文标点符号（，。？）与英文标点（,.?）不同
3. **文本长度：** 中文可能比英文长或短，注意 UI 布局是否受影响
4. **术语一致性：** 在整个项目中保持术语翻译的一致性

## 下一步

完成这个组件的汉化后，可以继续汉化其他组件：
- `src/components/ftbot/BotStatus.vue`
- `src/components/ftbot/TradeList.vue`
- `src/views/DashboardView.vue`
- 等等...

参考 `开发环境配置和汉化指南.md` 了解更多信息。

