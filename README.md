# 🏭 BDN Factory Manager

**Simple, Elderly-Friendly Pharmaceutical Factory Management System**

Built for BDN Pharmaceuticals — phenyl/chemical manufacturing.

---

## 📋 What This App Does

| Feature | What It Does | Auto-Calculates |
|---------|-------------|-----------------|
| 📊 Dashboard | See all important numbers at a glance | ✅ All numbers |
| 🧪 Raw Materials | Track chemicals and ingredients in stock | ✅ Stock levels, alerts |
| 🏭 Production | Log production batches | ✅ Cost, profit, status |
| ✅ Quality Check | Simple pass/fail quality testing | ✅ Status updates |
| 📦 Inventory | Track finished products ready to sell | ✅ Auto-updates from production |
| 🛒 Sales | Record customer orders | ✅ Total = Qty × Price |
| 👥 Customers | Track who buys from you | ✅ Outstanding balance |
| 💸 Expenses | Record all expenses | ✅ Monthly totals |
| 📊 Reports | Monthly profit/loss, daily reports | ✅ Revenue − Expenses |
| ⚙️ Settings | Manage users and backup data | — |

---

## 🚀 QUICK START (3 Steps)

### Step 1 — Install Requirements

```bash
# Install Ruby 3.3+ and PostgreSQL first, then:
gem install rails
```

### Step 2 — Setup the App

```bash
cd BDN-Pharmaceuticals
bundle install
rails db:create db:migrate db:seed
```

### Step 3 — Start the App

```bash
rails server
```

Open browser: **http://localhost:3000**

---

## 🔐 Default Login

| Field | Value |
|-------|-------|
| Email | `admin@bdn.com` |
| Password | `admin` |

**Change the password after first login!** (Settings → Change Password)

---

## 📱 Daily Workflow

### Every Morning:
1. Open http://localhost:3000
2. Check **Dashboard** for all numbers
3. Check for **RED ALERTS** (low stock warnings)

### To Start Production:
1. Click **Production** → **+ Start New Batch**
2. Fill in: Name, Product, Quantity, Cost → **START BATCH**

### When Production Done:
1. Change status → **Completed**
2. Quality Check → **CHECK NOW** → checkboxes → **PASSED/FAILED**
3. If passed → **Mark Ready** — inventory updates automatically!

### To Record a Sale:
1. Click **Sales** → **+ New Sale**
2. Select product, quantity → **total is calculated automatically**
3. Click **COMPLETE SALE**

### To Collect Payment:
1. Sales list → find order → **💰 Collect**
2. Enter amount → **SAVE** — outstanding calculated automatically

### To See Profit:
1. Click **Reports** → see Revenue, Expenses, Net Profit

---

## 🔔 Color Alerts

| Color | Meaning |
|-------|---------|
| 🔴 Red | LOW stock / Unpaid / Urgent |
| 🟡 Yellow | In Progress / Warning |
| 🟢 Green | Good / Completed / Paid |
| 🔵 Blue | Quality Checked |

---

## 💾 Backup Data

Settings → **⬇️ DOWNLOAD BACKUP NOW** — do this weekly!

---

## 🆘 Help

- **App won't start?** Run `rails server` in the app folder
- **Database error?** Run `rails db:migrate`
- **Forgot password?** Ask admin to create new user account

---

## 🛠️ Tech Stack

- Ruby on Rails 7.2 | PostgreSQL | Tailwind CSS
- Font: 18px minimum | Buttons: 50px minimum | High contrast design
