create domain dm_email as varchar(254)
check (
    value ~ '^[a-z0-9.!#$%&''*+/=?^_`{|}~-]{1,64}@[a-z0-9-]+(\.[a-z0-9-]+)*\.[a-z]{2,}$'
    and length(value) <= 254
);

comment on domain dm_email is
'This domain is used to store email addresses in a standard format.

Constraints:
- Only lowercase characters (a-z, 0-9) and allowed special symbols.
- Maximum total length of 254 characters (per RFC 5321).
- Local part is limited to 64 characters.
- Supports multiple domain segments (e.g., user@mail.example.co.uk).

This ensures consistency and basic email validation at the database level.';
