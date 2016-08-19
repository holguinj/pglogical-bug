# Reproducing `relation "public.pg_class" does not exist` on pglogical

## Background
Reproducing [Issue 32](https://github.com/2ndQuadrant/pglogical/issues/32) is
complicated enough to reproduce that I decided it was easiest to write a few
scripts to do it automatically.
A description of the bug is included in the issue.

## Assumptions:
* Postgres 9.4 and pglogical are installed
* the default user for connections from localhost is a superuser
* postgresql.conf is set up to allow replication (`wal_level`, `max_worker_processes`, etc.)
* pg_hba.conf allows replication from the default user on localhost

## Steps:
1. Execute `repro1.sql`, which creates a couple of databases, pglogical nodes, and a subscription
2. Check the logs for reference; there should be no errors yet
3. Restart the postgres service
4. Execute `repro2.sql`, which adds a table and calls `pglogical.replication_set_add_all_tables`
5. Check the logs again and you should see many instances of the `relation "public.pg_class" does not exist` error.

## Cleanup:
Execute `cleanup.sql` to drop the subscription, nodes, and databases.
