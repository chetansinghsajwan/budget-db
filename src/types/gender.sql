create type dt_gender as enum ('male', 'female', 'non-binary', 'other');

comment on type dt_gender is
'This enum type is used to store gender types.'
