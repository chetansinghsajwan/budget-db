create domain dt_transaction_tag as text
check (
    length(value) <= 20 and
    value ~ '^[a-zA-Z0-9_-]*$'
);

comment on domain dt_transaction_tag is
'Represents a short transaction tag (≤ 20 characters) allowing only
alphanumeric characters, hyphens, and underscores.';
