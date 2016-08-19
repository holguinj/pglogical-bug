-- Add a table on the primary database
\c repro_primary
CREATE TABLE example(id BIGSERIAL PRIMARY KEY);

-- Add a dummy row
INSERT INTO example DEFAULT VALUES;

-- Add all tables to the replication set
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public'], TRUE);

-- Now check the logs again, and you should see tons of messages like this:

-- DETAIL:  There are no running transactions.
-- LOG:  exported logical decoding snapshot: "0008610D-1" with 0 transaction IDs
-- ERROR:  relation "public.pg_class" does not exist
-- STATEMENT:  COPY "public"."pg_class" TO stdout
-- ERROR:  table copy failed
-- DETAIL:  Query 'COPY "public"."pg_class" TO stdout': ERROR:  relation "public.pg_class" does not exist
