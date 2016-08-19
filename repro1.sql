-- Create the primary database and the pglogical extensions
CREATE DATABASE repro_primary;
\c repro_primary
CREATE EXTENSION pglogical_origin;
CREATE EXTENSION pglogical;

-- Create the provider node
SELECT pglogical.create_node(
    node_name := 'repro_provider',
    dsn := 'dbname=repro_primary host=localhost port=5432'
    );

-- Create the replica database
CREATE DATABASE repro_replica;
\c repro_replica
CREATE EXTENSION pglogical_origin;
CREATE EXTENSION pglogical;

-- Create the subscriber node
SELECT pglogical.create_node(
    node_name := 'repro_subscriber',
    dsn := 'dbname=repro_replica'
);

-- Create a subscription
SELECT pglogical.create_subscription(
    subscription_name := 'repro_subscription',
    provider_dsn := 'dbname=repro_primary host=localhost port=5432',
    synchronize_structure := TRUE
);

-- NEXT:
-- 1. Check the logs to see that there are no errors so far (there should not be)
-- 2. Restart postgres
-- 3. Execute repro2.sql
