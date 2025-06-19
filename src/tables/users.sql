create table users (
    id integer generated always as identity primary key,
    name varchar(100) not null,
    email dt_email not null unique,
    phone dt_phone,
    gender dt_gender,
    age integer,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    deleted_at timestamp default null
);

comment on table users
is 'This table stores user information like name, email, phone, and age.';
