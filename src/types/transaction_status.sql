create type dt_transaction_status as enum ('pending', 'completed', 'failed');

comment on type dt_transaction_status is
'Represents the status of a transaction: pending, completed, or failed';
