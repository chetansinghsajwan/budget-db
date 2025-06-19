create table transactions (
    id integer generated always as identity,
    user_id integer not null references users(id),
    amount money not null,
    type dt_transaction_type not null,
    status dt_transaction_status not null,
    tags dt_transaction_tag[] default null,
    description text default null,
    transaction_at timestamp default null,
    trashed_at timestamp default null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,

    primary key (id, user_id),
);

comment on table transactions is
'This table stores transaction records, including user ID, amount, type, status, tags, description, and timestamps for various events.';

comment on column transactions.user_id is
'The ID of the user associated with the transaction.';

comment on column transactions.amount is
'The monetary amount of the transaction.';

comment on column transactions.type is
'The type of transaction, either credit or debit.';

comment on column transactions.status is
'The status of the transaction, indicating whether it is pending, completed, or failed.';

comment on column transactions.tags is
'An array of tags associated with the transaction for categorization.';

comment on column transactions.description is
'A description of the transaction, providing additional context.';

comment on column transactions.transaction_at is
'The timestamp when the transaction occurred.';

comment on column transactions.trashed_at is
'The timestamp when the transaction was marked as trashed, if applicable.';

comment on column transactions.created_at is
'The timestamp when the transaction record was created.';

comment on column transactions.updated_at is
'The timestamp when the transaction record was last updated.';
