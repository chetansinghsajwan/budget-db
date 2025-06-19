def create_history_table(table_path: str, history_table_path: str | None, history_table_schema: str | None) -> str:

    table_name = table_path

    if history_table_path is None:
        if history_table_schema is None:
            history_table_path = table_name
        else:
            history_table_path = f"{history_table_schema}.{table_name}"

    key_cols = list()
    cols = list()

    sql = f"""
        -- create type dt_history_reason as enum ('update', 'delete');

        create table {history_table_path} (
            version integer generated always as identity,
            from timestamp not null,
            to timestamp not null,
            reason dt_history_reason not null,
            comment text default null,

            { ", ".join(f"value_{col} text" for col in cols) }

            primary key (version, { ", ".join(key_cols) }),
        );

        comment on table {history_table_path} is
        'This table stores the history of changes made to {table_name} table,
        including updates and deletions.';

        create or replace function tgfn_{table_name}_history()
        returns trigger
        language plpgsql as $$
        declare
            version integer;
            reason dt_history_reason;
            from timestamp;
            to timestamp;
            comment text;

        begin
            version := (
                select coalesce(max(version), 0) + 1
                from {history_table_path}
                where { " and ".join(f"value_{col} = old.{col}" for col in key_cols) }
            );

            from := (
                select coalesce(max(version), 0) + 1
                from {history_table_path}
                where { " and ".join(f"value_{col} = old.{col}" for col in key_cols) }
            );

            to := current_timestamp;
            comment := null;

            reason := case
                when tg_op = 'UPDATE' then 'update'
                when tg_op = 'DELETE' then 'delete'
                else raise exception 'Unexpected operation: %', tg_op;
            end;

            insert into {history_table_path} (
                version, from, to, reason, comment,
                { ", ".join(f"value_{col}" for col in cols) }
            ) values (
                version, from, to, reason, comment,
                { ", ".join(f"old.{col}" for col in cols) }
            );

            if tg_op = 'UPDATE' then
                return new;
            else if tg_op = 'DELETE' then
                return old;
            end if;
        end;

        create or replace trigger tg_{table_name};
    """

    return sql
