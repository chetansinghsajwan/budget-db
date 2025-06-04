create type dt_transaction_type as enum ('credit', 'debit');

comment on type dt_transaction_type is
'Defines the type of transaction: either a credit or a debit';
