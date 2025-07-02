use role accountadmin;
use database devops_db;
use schema common;

CREATE OR REPLACE SECRET git_secret_demo
  TYPE = password
  USERNAME = 'user_name'
  PASSWORD = 'access_token'
;

CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/Ramadevic/MM-POC.git')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret_demo)
  ENABLED = TRUE
;

GRANT USAGE ON SECRET git_secret_demo TO ROLE accountadmin;

CREATE OR REPLACE GIT REPOSITORY git_snowflake_extensions
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret_demo
  ORIGIN = 'https://github.com/Ramadevic/MM-POC.git';
;

LIST @devops_db.common.git_repo/branches/main;

ALTER GIT REPOSITORY devops_db.common.git_repo FETCH;

SHOW GIT BRANCHES IN devops_db.common.git_repo;

DESCRIBE GIT REPOSITORY devops_db.common.git_repo;


EXECUTE IMMEDIATE FROM @devops_db.common.git_repo/branches/main/.github/workflows/snowflake_demo.sql;
