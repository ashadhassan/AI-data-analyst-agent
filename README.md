# AI Data Analyst Agent

An AI-powered data analytics application that allows users to ask business questions about a MySQL database using natural language instead of writing SQL queries manually.

The application uses a LangChain agent with a Groq LLM to understand user questions, retrieve the live database schema, generate SQL queries, validate and execute them through controlled Python tools, and return business-friendly answers through a web interface.

---

## 🚀 Features

- Ask business questions using natural language
- Automatically understand the live MySQL database schema
- Generate SQL queries using an LLM
- Execute SQL through controlled LangChain tools
- Validate SQL before execution
- Read-only database access
- Database-focused AI assistant
- Ignore unrelated questions and focus only on database-related requests
- Flask REST API backend
- Interactive HTML/CSS/JavaScript frontend
- Business-friendly natural-language responses
- Environment-based credential management

---

## 🏗️ Architecture

```text
User
  │
  ▼
HTML / CSS / JavaScript
  │
  │ POST /ask
  ▼
Flask API
  │
  ▼
LangChain Agent
  │
  ▼
Groq LLM
  │
  ├──────────────► get_schema tool
  │                     │
  │                     ▼
  │                   MySQL
  │                     │
  │                     ▼
  │                  Database Schema
  │                     │
  │                     └──────────► LLM
  │
  └──────────────► execute_sql tool
                            │
                            ▼
                       SQL Validator
                            │
                            ▼
                          MySQL
                            │
                            ▼
                       Query Results
                            │
                            ▼
                         Groq LLM
                            │
                            ▼
                     Business Answer
                            │
                            ▼
                         Flask
                            │
                            ▼
                    Web Application
```

---

## 🔄 How It Works

1. The user enters a business question through the web interface.
2. JavaScript sends the question to the Flask `/ask` endpoint.
3. Flask passes the question to the LangChain agent.
4. The Groq LLM analyzes the question.
5. If database information is required, the agent calls the `get_schema` tool.
6. The Python tool connects to MySQL and retrieves the current database schema.
7. The schema is provided to the LLM.
8. The LLM generates an appropriate SQL `SELECT` query.
9. The agent requests the `execute_sql` tool with the generated query.
10. The SQL validator checks that the query is safe and read-only.
11. The validated query is executed against MySQL.
12. The query results are returned to the LLM.
13. The LLM interprets the results.
14. Flask returns the final answer to the frontend.
15. JavaScript displays the answer to the user.

---

## 🧠 Role of LangChain

LangChain is used as the agent orchestration layer.

The LLM does not directly connect to the MySQL database.

Instead:

```text
LLM
 ↓
Requests a tool call
 ↓
LangChain
 ↓
Python Tool
 ↓
MySQL
```

The two main tools are:

### `get_schema`

Retrieves the available tables and columns from the live MySQL database.

### `execute_sql`

Executes the SQL query after it passes the application's SQL validation checks.

---

## 🤖 Role of Groq

Groq provides the LLM used by the LangChain agent.

The LLM is responsible for:

- Understanding natural-language questions
- Reasoning about the database schema
- Generating SQL queries
- Interpreting query results
- Producing business-friendly responses

The LLM does **not** receive direct database credentials.

---

## 🗄️ Database

The application uses MySQL as the business data source.

The sample database contains:

- `customers`
- `products`
- `orders`
- `order_items`

Example schema:

```text
customers
├── customer_id
├── customer_name
├── city
├── state
└── signup_date

products
├── product_id
├── product_name
├── category
└── price

orders
├── order_id
├── customer_id
├── order_date
└── status

order_items
├── order_item_id
├── order_id
├── product_id
├── quantity
└── unit_price
```

The application retrieves the live schema from MySQL at runtime rather than relying on a hard-coded schema inside the LLM.

`database/schema.sql` is provided as a database initialization/reference script.

---

## 📊 Example Questions

The application can answer questions such as:

```text
What are the top 3 products by revenue?

Which city has the most customers?

What is the average revenue per delivered order?

Which product category generates the most revenue?
```

For example:

```text
User:
What are the top 3 products by revenue?

AI:
The top 3 products by revenue are:

1. Smart Watch
2. Mechanical Keyboard
3. Bluetooth Speaker
```

---

## 🔐 Security

Security was considered at both the application and database levels.

### Read-only database access

The application uses a dedicated MySQL user with `SELECT` permissions instead of using an administrator account.

### SQL validation

Generated SQL is checked before execution.

The application is designed for read-only analytical queries and rejects database modification or destructive operations.

### Environment variables

Sensitive credentials are stored in `.env` rather than being hard-coded in the source code.

Example:

```env
GROQ_API_KEY=your_groq_api_key
DB_HOST=localhost
DB_USER=ai_agent
DB_PASSWORD=your_database_password
DB_NAME=ai_sales_analytics
```

The `.env` file must never be committed to GitHub.

---

## 🎯 AI Scope Control

The agent is intentionally restricted to database-related questions.

For example:

```text
What are the top 3 products by revenue?
```

The agent answers using the database.

For an unrelated question such as:

```text
Who is the PM of India?
```

the agent should respond that it can only answer questions related to the available database.

For a mixed question:

```text
What are the top 3 products by revenue and who is the PM of India?
```

the agent focuses only on the database-related portion.

This prevents unnecessary database tool calls for unrelated requests.

---

## 📁 Project Structure

```text
AI-data-analyst-agent/
│
├── app/
│   ├── agent.py
│   ├── api.py
│   ├── database.py
│   ├── tools.py
│   └── sql_validator.py
│
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── script.js
│
├── database/
│   └── schema.sql
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Python | Backend and database tools |
| LangChain | AI agent orchestration |
| Groq | Large Language Model |
| MySQL | Business database |
| Flask | REST API backend |
| HTML | Frontend structure |
| CSS | Frontend styling |
| JavaScript | Frontend interaction and API communication |
| Git/GitHub | Version control and project hosting |

---

## ⚙️ Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/AI-data-analyst-agent.git
```

Navigate to the project:

```bash
cd AI-data-analyst-agent
```

Create a virtual environment:

```bash
python -m venv venv
```

Activate it on Windows:

```bash
venv\Scripts\activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

---

## 🔑 Environment Configuration

Create a `.env` file in the project root:

```env
GROQ_API_KEY=your_groq_api_key
DB_HOST=localhost
DB_USER=ai_agent
DB_PASSWORD=your_database_password
DB_NAME=ai_sales_analytics
```

Never upload `.env` to GitHub.

---

## ▶️ Running the Application

Start the Flask backend:

```bash
python app/api.py
```

The API will run locally on:

```text
http://127.0.0.1:5000
```

During development, the frontend can be opened using a local development server.

---

## 🧪 Testing

The application was tested with:

- Database-related natural-language questions
- Aggregation queries
- Revenue calculations
- Multiple-table joins
- Delivered-order filtering
- Different database tables
- Mixed database and unrelated questions
- Read-only database permissions
- Frontend-to-Flask API communication

---

## 📌 Business Rules

The agent follows these project-specific rules:

- Revenue = `quantity × unit_price`
- Revenue calculations include only orders where:

```sql
status = 'Delivered'
```

- Only read-only database analysis is permitted.
- The agent must not invent tables or columns.

---

## 🔮 Future Improvements

Potential future enhancements include:

- Automatic charts and visualizations
- Result tables in the UI
- Query history
- Schema caching
- SQL AST-based validation
- Improved error recovery
- Authentication
- Production deployment
- Database connection pooling
- Support for additional databases

---

## 👨‍💻 Project Summary

This project demonstrates how an LLM can be integrated with a relational database through an agent-based architecture.

Instead of allowing the LLM to directly access the database, the application uses controlled tools and a read-only database account.

The architecture separates responsibilities:

```text
Groq LLM
→ Reasoning and SQL generation

LangChain
→ Agent orchestration and tool calling

Python
→ Database tools and SQL validation

MySQL
→ Data storage and query execution

Flask
→ Backend API

JavaScript
→ User interface and API communication
```

The result is a natural-language analytics application that allows users to interact with business data without manually writing SQL.
```

