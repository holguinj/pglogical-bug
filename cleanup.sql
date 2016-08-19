-- Drop the subscription
\c repro_replica
SELECT pglogical.drop_subscription(
    subscription_name := 'repro_subscription'
);

-- Drop the subscriber
SELECT pglogical.drop_node(node_name := 'repro_subscriber');

-- Drop the provider
\c repro_primary
SELECT pglogical.drop_node(node_name := 'repro_provider');

-- Drop both databases
\c postgres
DROP DATABASE repro_replica;
DROP DATABASE repro_primary;
