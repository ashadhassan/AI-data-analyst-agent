import os
from dotenv import load_dotenv
from groq import Groq
from database import get_database_schema

load_dotenv()

api_key = os.getenv("GROQ_API_KEY")

if not api_key:
    raise ValueError("GROQ_API_KEY not found")

client = Groq(api_key=api_key)


def generate_sql(question):

    # Get the actual schema directly from MySQL
    schema = get_database_schema()

    prompt = f"""
You are an expert SQL analyst.

Generate a MySQL SELECT query to answer the user's business question.

DATABASE SCHEMA:
{schema}

BUSINESS RULES:
- Revenue = quantity × unit_price.
- Only orders with status = 'Delivered' should be included when calculating revenue.
- Use the correct relationships between tables.
- Do not invent tables or columns.

SQL RULES:
- Generate only a SELECT statement.
- Do not use INSERT, UPDATE, DELETE, DROP, ALTER, CREATE, or TRUNCATE.
- Use valid MySQL syntax.
- Return only the SQL query.
- Do not use markdown code fences.

USER QUESTION:
{question}
"""

    response = client.chat.completions.create(
        model="llama-3.1-8b-instant",
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0
    )

    sql = response.choices[0].message.content.strip()

    return sql


if __name__ == "__main__":

    question = "What are the top 3 products by revenue?"

    sql = generate_sql(question)

    print("\nGenerated SQL:\n")
    print(sql)