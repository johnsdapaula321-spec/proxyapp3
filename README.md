# ⚡ Tesla Phrendly Proxy Commander

Global Edition - Universal Access

## 🚀 Deploy to Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/tesla-commander)

## 📋 Setup Instructions

### 1. Clone & Push to GitHub
```bash
git clone https://github.com/YOUR_USERNAME/tesla-commander.git
cd tesla-commander
# Make your changes
git add .
git commit -m "Initial commit"
git push origin main
```

### 2. Connect to Vercel
1. Go to [vercel.com](https://vercel.com)
2. Click "New Project"
3. Import your GitHub repo
4. Framework Preset: **Other**
5. Click **Deploy**

### 3. Set Environment Variables (Optional)
In Vercel Dashboard → Project Settings → Environment Variables:
- `SUPABASE_URL`: `https://jyoantyeawpksdwcyiiu.supabase.co`
- `SUPABASE_ANON_KEY`: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

### 4. Setup Supabase Database
1. Go to [supabase.com/dashboard](https://supabase.com/dashboard)
2. Open project: `jyoantyeawpksdwcyiiu`
3. Go to **SQL Editor**
4. Paste contents of `schema.sql`
5. Click **Run**

## 🔐 Admin Login
- **Name:** `admin`
- **WhatsApp:** `admin123`

## 🛠️ Tech Stack
- Frontend: Vanilla HTML/CSS/JS
- Backend: Supabase (PostgreSQL + Realtime)
- Hosting: Vercel
- PWA: Service Worker + Manifest

## 📁 File Structure
```
├── index.html          # Main app
├── manifest.json       # PWA manifest
├── schema.sql          # Supabase database schema
├── vercel.json         # Vercel configuration
├── package.json        # Node.js metadata
├── server.js           # Local dev server
├── start-server.bat    # Windows launcher
└── README.md           # This file
```

## 🔧 Local Development
```bash
# Option 1: Node.js
npm install -g serve
serve . --single

# Option 2: Python
python -m http.server 8000

# Option 3: Vercel CLI
npm i -g vercel
vercel dev
```

## ⚠️ Important Notes
- **Never** open `index.html` directly via `file:///` protocol
- Always serve via HTTP server (even locally)
- The app requires Supabase connection for full functionality

## 📄 License
MIT License - For team management use only.
