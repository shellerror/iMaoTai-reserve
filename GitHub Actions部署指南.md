# 🚀 GitHub Actions 部署指南

## ✅ 已完成
- [x] Git 仓库已初始化
- [x] .gitignore 已配置（保护敏感信息）
- [x] 代码已提交到本地仓库

---

## 📋 完整部署步骤

### 步骤 1：创建 GitHub 仓库

1. **访问 GitHub**
   - 打开浏览器，访问 https://github.com/new

2. **创建新仓库**
   - Repository name: `iMaoTai-reserve`（或其他名称）
   - Description: `i茅台自动预约工具`
   - ✅ Public 或 Private（建议 Private）
   - ❌ 不要勾选 "Add a README file"
   - ❌ 不要勾选 ".gitignore"

3. **点击 "Create repository"**

---

### 步骤 2：推送代码到 GitHub

**方式 A：使用 HTTPS（推荐）**

在项目目录运行：

```bash
cd D:\MyCode\iMaoTai-reserve-master

# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/iMaoTai-reserve.git

# 推送代码
git branch -M main
git push -u origin main
```

**方式 B：使用 SSH**

```bash
# 添加远程仓库（使用 SSH）
git remote add origin git@github.com:YOUR_USERNAME/iMaoTai-reserve.git

# 推送代码
git branch -M main
git push -u origin main
```

---

### 步骤 3：配置 GitHub Secrets

**重要**：必须配置 Secrets，否则 Actions 无法运行。

1. **打开仓库设置**
   - 访问你的 GitHub 仓库
   - 点击 `Settings` → `Secrets and variables` → `Actions`

2. **点击 "New repository secret"**

3. **添加以下 3 个 Secrets**：

| Secret 名称 | 值 | 说明 |
|------------|-----|------|
| `GAODE_KEY` | `03ceb0e2c1fca9eeea071de8e6e009be` | 高德地图 API Key |
| `PRIVATE_AES_KEY` | `imt_secret_key_2024_beijing` | AES 加密密钥 |
| `SCKEY` | `SCT313052TNYN1tqf7f3LPiql1ZCAkLEOl` | Server酱推送 Key |

4. **每个 Secret 的添加步骤**：
   - Name: 输入 Secret 名称（例如：`GAODE_KEY`）
   - Value: 粘贴对应的值
   - 点击 "Add secret"

---

### 步骤 4：上传 credentials 配置文件

由于 `.gitignore` 排除了 `myConfig/credentials`，需要手动上传。

**方式 A：通过 GitHub 网页（推荐）**

1. 在仓库页面点击 "Add file" → "Create new file"

2. 文件名输入：`myConfig/credentials`

3. 粘贴以下内容（替换为你的实际配置）：

```ini
[uWR4tJYwwGVeVsmJj9R14g==]
hidemobile = 133****5975
enddate = 99999999
province = 浙江省
city = 杭州市
lat = 30.023061
lng = 120.029889
userid = W96eIlsWXyCd6ublmyJ9EA==
token = eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJtdCIsImV4cCI6MTc1NzM4OTQzMSwidXNlcklkIjoxMDY1MzY5Mjc0LCJkZXZpY2VJZCI6IjJGMjA3NUQwLUI2NkMtNDI4Ny1BOTAzLURCRkY2MzU4MzQyQSIsImlhdCI6MTc1NDc5NzQzMX0.PkBvuf8-4I7t_F89NodbgAGN7H6hF5oRgYyNSdT2vCw

[jFBvOaeHYivLlO74LP9NVg==]
hidemobile = 189****2497
enddate = 99999999
province = 浙江省
city = 杭州市
lat = 30.023061
lng = 120.029889
userid = wPyBsPLCEGHWLpMIjGt+gQ==
token = eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJtdCIsImV4cCI6MTc1NzM4OTQ3NywidXNlcklkIjoxMTI2Nzk0MTU0LCJkZXZpY2VJZCI6IjJGMjA3NUQwLUI2NkMtNDI4Ny1BOTAzLURCRkY2MzU4MzQyQSIsImlhdCI6MTc1NDc5NzQ3N30.KJswDoRfeen2ObwnIOIafJyTYHfvG3iMn-fb-HP5PSU

[lB/zQ3iLjI30fEsphHfmuQ==]
hidemobile = 188****8274
enddate = 99999999
province = 广东省
city = 广州市
lat = 23.168865
lng = 113.350989
userid = YMPfy469fm2zgkwD8YCT9w==
token = eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJtdCIsImV4cCI6MTc3MjgxMTYxMiwidXNlcklkIjoxMTg4NjY3NjgyLCJkZXZpY2VJZCI6IjJGMjA3NUQwLUI2NkMtNDI4Ny1BOTAzLURCRkY2MzU4MzQyQSIsImlhdCI6MTc3MDIxOTYxMn0.mlQh0z3RTfuGoKxlmVxy5j0phk3xqbQz4iDhj9bjVUM
```

4. 点击 "Commit changes"

**方式 B：使用 Git 命令（临时移除 gitignore）**

```bash
# 临时移除 gitignore
sed -i 's/myConfig\/credentials//g' .gitignore

# 添加并提交 credentials
git add myConfig/credentials
git commit -m "Add credentials"
git push

# 恢复 gitignore
git checkout .gitignore
```

---

### 步骤 5：启用 GitHub Actions

1. **打开 Actions 页面**
   - 在仓库页面点击 `Actions` 标签

2. **启用 Workflows**
   - 如果提示 "I understand my workflows, go ahead and enable them"
   - 点击按钮确认启用

3. **查看 Workflow**
   - 左侧会显示 `imaotai-action` workflow
   - 点击查看详情

---

## ⏰ GitHub Actions 运行时间

根据 `.github/workflows/autoReserve.yml` 配置：

```yaml
schedule:
  - cron: '10 0,1 * * *'  # 每天 00:10 和 01:10（UTC）
```

**北京时间运行时间**：
- **上午 09:10**（UTC+8）
- **上午 10:10**（UTC+8）

---

## 🔍 验证部署

### 1. 检查 Secrets

```
Settings → Secrets and variables → Actions
```
确认 3 个 Secrets 都已配置。

### 2. 查看 Actions 运行历史

```
Actions → imaotai-action → 查看运行记录
```

### 3. 手动触发运行（可选）

编辑 `.github/workflows/autoReserve.yml`，临时修改为：

```yaml
schedule:
  - cron: '*/5 * * * *'  # 每5分钟运行一次（测试用）
```

提交后等待 5 分钟，查看 Actions 是否运行。

**测试完成后记得改回**：
```yaml
schedule:
  - cron: '10 0,1 * * *'  # 每天 00:10 和 01:10 UTC
```

---

## 📊 查看运行日志

1. 打开 `Actions` 页面
2. 点击最近的运行记录
3. 点击具体的 job
4. 查看详细日志

**成功运行的日志示例**：
```
Run python main.py
  Session ID 获取成功: 508
  预约:手机:133xxxx5975;Code:200;Body:...
  预约成功！
```

---

## 🛠️ 常见问题

### Q1: Actions 运行失败
**原因**：Secrets 未配置或配置错误

**解决**：
1. 检查 Settings → Secrets and variables → Actions
2. 确认 3 个 Secrets 都已正确配置
3. 查看 Actions 日志，找到具体错误信息

### Q2: 提示 "ValueError: Padding is incorrect"
**原因**：credentials 文件加密密钥不匹配

**解决**：
1. 确认 `PRIVATE_AES_KEY` Secret 的值
2. 必须与配置账号时使用的密钥一致
3. 重新上传 credentials 文件

### Q3: 推送失败
**原因**：Server酱 认证失败

**解决**：
1. 检查 `SCKEY` 是否正确
2. Server酱 普通通道已关闭，需要使用 Turbo版或改用 PushPlus

### Q4: Token 过期
**原因**：i茅台 Token 有效期有限

**解决**：
1. 重新运行 `python login.py` 更新 Token
2. 更新 GitHub 上的 credentials 文件

---

## 🎉 部署完成！

✅ GitHub Actions 已配置
✅ 每天上午 09:10 和 10:10 自动运行
✅ 预约结果推送到微信
✅ 无需本地电脑开机

---

## 📝 管理命令

| 操作 | 命令/位置 |
|------|----------|
| 查看 Actions | 仓库 → Actions 标签 |
| 手动触发 | Workflow → Run workflow |
| 禁用 Actions | Settings → Actions → Disable workflows |
| 修改配置 | 编辑 `.github/workflows/autoReserve.yml` |
| 更新代码 | `git add . && git commit -m "update" && git push` |

---

## ⚠️ 重要提醒

1. **credentials 文件包含敏感信息**，避免公开仓库
2. **定期检查 Token** 是否过期，必要时更新
3. **关注 GitHub Actions 额度**：
   - 公开仓库：无限制
   - 私有仓库：每月 2000 分钟免费

---

祝预约成功！🍶
