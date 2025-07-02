name: Deploy to Snowflake

on:
  push:
    branches:
      - main  # Change if you're deploying from a different branch

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Install Snowflake CLI using GitHub Action
        uses: snowflakedb/snowflake-cli-action@v1.5
        with:
          cli-version: '3.6.0'  # Optional: remove or update for the latest version

      - name: Run snowflake-deploy.sql using Snowflake CLI
        env:
          SNOWFLAKE_ACCOUNT: ${{ secrets.SNOWSQL_ACCOUNT }}
          SNOWFLAKE_USER: ${{ secrets.SNOWSQL_USER }}
          SNOWFLAKE_PASSWORD: ${{ secrets.SNOWSQL_PWD }}
        run: |
          snow sql \
            -q "USE ROLE ACCOUNTADMIN; USE WAREHOUSE DEVOPS_WH; USE DATABASE DEVOPS_DB; USE SCHEMA COMMON;" \
            -f .github/workflows/snowflake-deploy.sql
