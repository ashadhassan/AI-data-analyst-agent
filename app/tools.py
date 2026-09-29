from langchain.tools import tool

from database import get_database_schema
from sql_validator import validate_sql
from database import execute_query

@tool
def get_schema() -> str:
    """
    Get the current database schema, including tables and columns.
    Use this when you need to understand the available data before writing SQL.
    """

    return get_database_schema()

if __name__ == "__main__":
    print(get_schema.invoke({}))


@tool
def execute_sql(query: str) -> str:
    """
    Execute a read-only SQL SELECT query against the MySQL database.
    The query is validated before execution.
    """

    is_valid, message = validate_sql(query)

    if not is_valid:
        return f"Query rejected: {message}"

    try:
        results = execute_query(query)

        if not results:
            return "Query executed successfully, but no results were found."

        return "\n".join(str(row) for row in results)

    except Exception as e:
        return f"Database error: {str(e)}"

