# Apifox MCP Server

[![smithery badge](https://smithery.ai/badge/@apifox/apifox-mcp-server)](https://smithery.ai/server/@apifox/apifox-mcp-server)

使用 Apifox MCP Server，可以将 Apifox 项目内的接口文档作为数据源提供给 Cursor 等支持 AI 编程的 IDE 工具以便让 AI 能够直接访问项目对应的接口文档数据。

开发者可以通过 AI 助手完成以下工作：根据接口文档生成或修改代码、搜索接口文档内容等等，至于通过这个接口文档数据能让 AI 干什么更多更强大的活，请发挥你和你们团队的想象力😜

## 🎯 如何使用

安装配置好 MCP 后，Apifox MCP Server 会自动读取 Apifox 整个项目里的所有接口文档的数据并缓存在本地电脑，AI 可以通过 MCP 读取项目内所有的接口的接口文档数据。

你只要告诉 AI 你想要通过 API 文档做什么即可，示例：

1. “通过 MCP 获取 API 文档，然后生成 Product 及其相关模型的定义代码”
2. “根据 API 文档，在 Product DTO 里添加 API 文档新增的几个字段”
3. “根据 API 文档给 Product 类的每个字段都加上注释”
4. “根据 API 文档，生成接口 /users 相关的所有 MVC 代码”

注意：接口文档数据默认是会缓存在本地的，如果 Apifox 内的数据有更新，请告诉 AI 刷新接口文档数据，否则 AI 读到的数据可能不是最新的。

## 🚀 安装方法

### 安装

#### Installing via Smithery

To install Apifox MCP Server for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@apifox/apifox-mcp-server):

```bash
npx -y @smithery/cli install @apifox/apifox-mcp-server --client claude
```

#### 前置条件

- 已安装 Node.js 环境（版本号 >= 18，推荐最新的 LTS 版本）
- 任意一个支持 MCP 的 IDE：
  - Cursor
  - VSCode + Cline 插件

#### 安装

1. **在 Apifox 生成 Access Token**
    a. 打开 Apifox，将鼠标悬停在页面右上角的头像上，点击 “账号设置 -> API 访问令牌”
    b. 创建新的 API 访问令牌，详见帮助文档
    c. 拿到 API 访问令牌，替换下面配置文件中的 `<access-token>`
2. **获取 Apifox 项目 ID**
    a. 打开 Apifox 里对应的项目
    b. 在左侧边栏点击“项目设置”，在“基本设置”页面即可复制项目 ID
    c. 拿到项目 ID，替换下面配置文件中的 `<project-id>`
3. **配置 IDE**

将下面 JSON 配置添加到 IDE 对应的 MCP 配置文件里：

```json
{
  "mcpServers": {
    "API 文档": {
      "command": "npx",
      "args": [
        "-y",
        "apifox-mcp-server@latest",
        "--project-id=<project-id>"
      ],
      "env": {
        "APIFOX_ACCESS_TOKEN": "<access-token>"
      }
    }
  }
}
```

如果使用 Windows 操作系统，而上文的配置文件无法正常工作，请使用如下配置文件：

```json
{
  "mcpServers": {
    "API 文档": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "apifox-mcp-server@latest",
        "--project-id=<project-id>"
      ],
      "env": {
        "APIFOX_ACCESS_TOKEN": "<access-token>"
      }
    }
  }
}
```

- Cursor：添加到全局的 `~/.cursor/mcp.json` 或项目内的 `.cursor/mcp.json`
- Cline：打开 Cline 面板 > MCP Server > Configure MCP Server

**注意：**
1. 请将上面的 `<access-token>` 和 `<project-id>` 替换为你个人的 Apifox API 访问令牌和 Apifox 项目 ID。
2. 配置文件里 MCP Server 名字建议填写类似“API 文档”或“xxx API 文档”这样的包含“API文档”字眼的名称，这样 AI 更容易正确的识别这个 MCP Server 的用途。不建议填写“Apifox”或“Apifox MCP”，这种写法 AI 不容易识别用途。
3. 如果需要使用到多个项目的 API 文档，在配置文件里添加配置多个 MCP Server 即可（不同项目有不同的`<project-id>`）， MCP Server 的名字填写“xxx API 文档”。
4. 如果团队习惯将 MCP 配置文件同步到代码仓库里，建议删除配置里的"APIFOX_ACCESS_TOKEN": "`<access-token>`"，改成每个成员在自己电脑里配置名为 APIFOX_ACCESS_TOKEN 的环境变量，以避免 APIFOX_ACCESS_TOKEN 泄漏问题。
5. 使用私有化部署版本的用户，请在 IDE 的 MCP 的配置文件添加参数："--apifox-api-base-url=`<私有化部署服务器的 API 地址，以 http:// 或 https:// 开头>`"。另外，请确保网络可以正常访问 `www.npm.com`。
6. 除了 Apifox 项目之外，也支持直接读取 Swagger/OAS 文件，请删除 `"--project-id=<project-id>"` 参数，添加 `"--oas=<oas-url-or-path>"` 参数。如：`npx apifox-mcp-server --oas https://petstore.swagger.io/v2/swagger.json` 或 `npx apifox-mcp-server --oas ～/data/petstore/swagger.json`

## ❓帮助与支持

Apifox MCP Server 还在内测阶段，欢迎各位给我们提建议和想法，请加内测群：

![QR Code](https://apifox-file-assets.your-api-server.com/static/markdown/20250317/mcp-contact.png)
