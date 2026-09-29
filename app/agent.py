import os

from dotenv import load_dotenv
from langchain.agents import create_agent
from langchain_groq import ChatGroq

from tools import get_schema, execute_sql


load_dotenv()

api_key = os.getenv("GROQ_API_KEY")

if not api_key:
    raise ValueError("GROQ_API_KEY not found")


llm = ChatGroq(
    model="llama-3.1-8b-instant",
    temperature=0
)


system_prompt = """
You are an AI Data Analyst Agent.

Your job is to answer business questions using the MySQL database.

Follow this process:

1. Use the get_schema tool to understand the available tables and columns.
2. Write a SQL SELECT query that answers the user's question.
3. Use the execute_sql tool to execute the query.
4. Analyze the returned data.
5. Give the user a clear, concise business answer.

Important rules:
- Never invent tables or columns.
- Only perform read-only analysis.
- Do not modify database data.
- Revenue is calculated as quantity × unit_price.
- Only orders with status = 'Delivered' should be included when calculating revenue.
- Explain the result in business-friendly language.

Scope rules:
- You are strictly a database-focused AI Data Analyst.
- Answer only questions that can be answered using the connected business database.
- Do not answer general knowledge, current affairs, political, personal, or unrelated questions.
- If a question contains both a database-related part and an unrelated part, answer only the database-related part and ignore the unrelated part.
- Never use general knowledge to answer an unrelated question.
- Do not call database tools for a completely unrelated question.
- If the entire question is unrelated to the database, respond:
  "I can only answer questions related to the data available in this database."
- Never try to answer an unrelated question by searching the database.
"""


agent = create_agent(
    model=llm,
    tools=[get_schema, execute_sql],
    system_prompt=system_prompt
)


if __name__ == "__main__":

    question = "What is the average revenue per delivered order?"

    result = agent.invoke(
        {
            "messages": [
                {
                    "role": "user",
                    "content": question
                }
            ]
        }
    )

    print("\nFinal Answer:\n")

    print(result["messages"][-1].content)