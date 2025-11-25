<h1 align="center">Be - mue mood journal app</h1>

---

<h2>🌟 Features</h2>

<ul>
  <li>🔐 <b>Authentication</b> — Secure login and registration using JWT</li>
  <li>🧠 <b>AI Journal Analysis</b> — Detect emotions and sentiment from user journals with groq</li>
  <li>☁️ <b>Recomendation quote</b> — Quote recomendation from your journal</li>
</ul>

---

<h2>🧩 Tech Stack</h2>

<table>
  <tr><th>Category</th><th>Technology</th></tr>
  <tr><td><b>Language</b></td><td>JavaScript (Node.js)</td></tr>
  <tr><td><b>Framework</b></td><td>Express.js</td></tr>
  <tr><td><b>Database</b></td><td>Mysql</td></tr>
  <tr><td><b>ORM</b></td><td>Prisma</td></tr>
  <tr><td><b>Auth</b></td><td>JWT (JSON Web Token)</td></tr>
  <tr><td><b>Email Service</b></td><td>Nodemailer</td></tr>
</table>

---

<h2>☁️ Integrations</h2>

<ul>
  <li>🧠 <b>Groq API</b> — AI-based for analysis journal</li>
  <li>📧 <b>Nodemailer</b> — Email service for secure password reset functionality</li>
</ul>

---

<h2>⚙️ Project Structure</h2>

<pre>
src/
 ┣ base_classes/
 ┃ ┣ base-error.js
 ┃ ┗ base-route.js
 ┣ config/
 ┣ domains/
 ┃ ┣ auth/
 ┃ ┣ journals/
 ┃ ┣ quotes/
 ┣ errors/
 ┣ middlewares/
 ┣ utils/
 ┣ app.js
 ┗ server.js
</pre>

---

<h2>🔐 Environment Variables</h2>

<pre><code>
DATABASE_URL="mysql://root@localhost:3306/mood_journal_app"

EMAIL_USERNAME=
EMAIL_PASSWORD=
JWT_SECRET=
PORT="4002"
  
FE_URL=
BE_URL="http://localhost:3002"
GROQ_API_KEY=
</code></pre>

---

<h2>🚀 Getting Started</h2>

### Clone the Project

```
git clone https://github.com/Xeron23/journaling_humic.git
cd journaling_humic
```


# Install dependencies

```
npm install
```
### Setup environment

Create a .env file and fill it with your configuration


### Configure Prisma
```
npx prisma generate
npx prisma migrate dev
```

### Start the development server

```
npm run dev
```
