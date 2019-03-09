#!/bin/bash
# psuedo one off for dumping remote postgres to local.

PGPASSWORD="PASSWORDHERE" pg_dump -h <remotehost> -U postgres -p 5432 --no-tablespaces -F c -b -v -f dev.dump <schemaname>
unset PGPASSWORD
PGPASSWORD="PASSWORDHERE" pg_restore -h <localhost> -U postgres --clean --no-acl --no-owner -d postgres -v dev.dump
unset PGPASSWORD
rm dev.dump
