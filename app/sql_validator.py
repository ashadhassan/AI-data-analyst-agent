import re


FORBIDDEN_KEYWORDS = [
    "INSERT",
    "UPDATE",
    "DELETE",
    "DROP",
    "ALTER",
    "CREATE",
    "TRUNCATE",
    "RENAME",
    "GRANT",
    "REVOKE"
]


def validate_sql(sql):
    """
    Basic safety validation for LLM-generated SQL.
    Only SELECT statements are allowed.
    """

    sql = sql.strip()

    if not sql:
        return False, "SQL query is empty."

    # Remove a trailing semicolon for validation
    cleaned_sql = sql.rstrip(";").strip()

    # Only one SQL statement is allowed
    if ";" in cleaned_sql:
        return False, "Multiple SQL statements are not allowed."

    # Query must start with SELECT
    if not re.match(r"^SELECT\b", cleaned_sql, re.IGNORECASE):
        return False, "Only SELECT queries are allowed."

    # Check for dangerous SQL keywords
    for keyword in FORBIDDEN_KEYWORDS:
        if re.search(rf"\b{keyword}\b", cleaned_sql, re.IGNORECASE):
            return False, f"Forbidden SQL keyword detected: {keyword}"

    return True, "SQL query is safe."

if __name__ == "__main__":

    test_queries = [
        "SELECT * FROM customers",
        "DELETE FROM customers",
        "UPDATE customers SET city = 'Bengaluru'",
        "DROP TABLE customers",
        "SELECT * FROM products;"
    ]

    for query in test_queries:

        valid, message = validate_sql(query)

        print("\nQuery:")
        print(query)

        print("Valid:", valid)
        print("Message:", message)