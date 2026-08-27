# 基隆景點瀏覽器 (Keelung Sights)

這是一個包含前後端的全端景點應用程式，使用 **Java Spring Boot** 提供 Web API，MongoDB Atlas 作為雲端資料庫，並透過 Bootstrap 與 Vanilla JS 實作響應式前端網頁 (RWD)。專案已完整容器化 (Dockerized) 並支援雲端部署。

## 📍 繳交網址資訊 (Submission URLs)

*   **GitHub Repo 網址：** ``
*   **雲端公開網址 (前端頁面)：** `https://keelung-sights-project-production.up.railway.app/`
*   **API 測試範例網址：** `https://keelung-sights-project-production.up.railway.app/api/sights/qidu`

---

## 📂 專案檔案結構包含
本專案符合部署所需之核心檔案：
*   `pom.xml`：Maven 專案的依賴套件清單與建置設定檔。
*   `Dockerfile`：定義如何建置 Docker Image，採用多階段建置 (Multi-stage build)，並設定動態 `$PORT`。
*   `.gitignore`：排除敏感與暫存檔案 (如 `.env`, `target/` 等)，確保真實密碼不被提交至 GitHub。
*   `mvnw` / `mvnw.cmd`：Maven Wrapper 執行檔，確保環境不需預裝 Maven 即可建置與運行專案。
*   `README.md`：專案說明文件 (本檔案)。

---

## 💻 本機執行方式 (Local Execution)

1.  **環境變數設定：**
    請在系統環境變數中，或在 IDE (如 IntelliJ) 的執行設定中，加入 `MONGODB_URI` 變數並填入 MongoDB Atlas 真實連線字串。
    *(請確保專案目錄下不要有包含真實密碼的 `.env` 檔案以免誤傳)*

2.  **啟動 Spring Boot 伺服器與初始化資料：**
    專案內建 `DataInitRunner`，啟動伺服器時會自動檢查資料庫，若為空則自動呼叫爬蟲進行資料播種。
    請在終端機執行以下指令啟動：
    ```bash
    ./mvnw spring-boot:run
    ```
    *(Windows 環境請使用 `mvnw spring-boot:run`)*

3.  **瀏覽應用程式：**
    *   **前端網頁：** 開啟瀏覽器前往 `http://localhost:8080`
    *   **API 測試：** 開啟瀏覽器前往 `http://localhost:8080/api/sights/qidu`

---

## 🐳 Docker 執行方式 (Docker Execution)

1.  **建立 Docker Image：**
    ```bash
    docker build -t keelung-sights .
    ```

2.  **運行 Docker Container：**
    容器啟動時已設定綁定連接埠。透過 `-e` 傳入 MongoDB 連線字串：
    ```bash
    docker run -p 8080:8080 -e MONGODB_URI="真實連線字串" keelung-sights
    ```
    執行後即可透過 `http://localhost:8080` 查看網頁。

---

## ☁️ 雲端環境變數設定 (Cloud Environment Variables)

*   **`MONGODB_URI`**：請填寫 MongoDB Atlas 的真實連線字串。
    *(註：Atlas 的 Network Access 需允許對應的 IP 或設為 `0.0.0.0/0` 讓雲端平台順利連線)*
*   **`PORT`**：雲端平台 (如 Railway/Render) 通常會自動給定此變數，`Dockerfile` 內部已配置好透過環境變數來綁定服務連接埠。

---

## 🚀 雲端部署步驟 (以 Render / Railway 為例)

本專案採前後端整合部署 (Frontend 以 Spring Boot 靜態資源掛載提供)，因此只需進行單一服務部署。

1.  **推送到 GitHub：** 確保所有原始碼 (含 `Dockerfile`) 已推送到你的 GitHub Repository，並**務必確認沒有包含任何 `.env` 密碼檔**。
2.  **建立雲端服務：** 登入 Render 或 Railway，選擇建立一個新的 **Web Service** (或 Service)，並綁定你的 GitHub Repo。
3.  **選擇環境：** 部署環境 (Runtime) 請選擇 **Docker**。
4.  **設定變數：** 在平台的 Environment Variables (環境變數) 區塊，新增 `MONGODB_URI` 並貼上連線字串。
5.  **完成部署：** 等待雲端平台自動建置 Image 並啟動服務。成功後，點擊平台提供的**公開網域**即可瀏覽景點前端頁面。
