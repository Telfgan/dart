Запросы
CREATE TABLE refresh_tokens
(
    id uuid PRIMARY KEY,
    user_id integer NOT NULL REFERENCES users(id),
    device_uid uuid NOT NULL,
    expires timestamp NOT NULL
);

create table users
(
    id serial PRIMARY KEY,
    login text UNIQUE NOT NULL,
    password_hash text NOT NULL,
	password_salt text NOT NULL,
    name text NOT NULL,
	refresh_token text
);

create table notes
(
    id serial primary key,
    name text not null,
    text text not null,
    category_id int not null references categories(id),
	user_id int not null references users(id),
    created_at timestamp not null,
    edited_at timestamp null,
	is_deleted bool not null default false
);

create table categories
(
    id serial primary key,
    name text not null unique
);

create or replace function note_edit()
returns trigger as $$ begin
    new.edited_at := now();
    return new;
end; $$ language plpgsql;

create trigger note_update
before update of name, text on notes
for each row
execute function note_edit();

create table notes_history
(
	created_at timestamp primary key default now(),
	text text not null
);