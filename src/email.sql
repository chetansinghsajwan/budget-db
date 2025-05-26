-- This SQL script creates a function to validate email addresses
-- Returns: 'OK' if valid, or an error message if invalid
create or replace function validate_email(email text)
returns varchar
language plpgsql as
$$
declare
    email_regex text := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    is_valid boolean;
begin
    -- Check if the email matches the regex
    is_valid := email ~ email_regex;

    if not is_valid then
        return 'Invalid email format: %', email;
    end if;

    return 'OK';
end;
$$;


-- This SQL script creates a trigger to validate email addresses
-- before inserting or updating a record in the users table
create or replace function email_insert_trigger_func()
returns trigger
language plpgsql as
$$
declare
    validation_result varchar;
begin
    validation_result := validate_email(new.email);

    if validation_result != 'OK' then
        raise exception '%', validation_result;
    end if;

    return new;
end;
$$;
