create domain dt_phone as varchar(20)
check (
    value ~ '^\+[1-9][0-9]{0,2} [0-9]{4,14}$'
    and length(value) <= 17
);

comment on domain dt_phone is
'international phone number in e.164 format with a space after the country code.

format:
- leading plus sign (+)
- country code: 1 to 3 digits (no leading zero)
- single space separator
- subscriber number: 4 to 14 digits

total length limited to 17 characters.';
