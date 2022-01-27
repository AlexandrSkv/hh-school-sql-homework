CREATE TABLE area_name
(
    area_id serial primary key,
    title text not null
);

CREATE TABLE employer
(
    employer_id serial primary key,
    employer_name text not null,
    area_id integer not null
);

CREATE TABLE vacancy
(
    vacancy_id serial primary key,
    employer_id integer not null references employer (employer_id),
    area_id integer not null references area_name(area_id),
    position_name text not null,
    compensation_from integer,
    compensation_to integer,
    date date not null
);

CREATE TABLE specialties
(
    special_id serial primary key,
    title text not null
);

CREATE TABLE resumes
(
    resume_id serial primary key,
    first_name text not null,
    last_name text not null,
    contact text not null,
    position text not null,
    salary integer
);

CREATE TABLE resume_special
(
    resume_id integer not null references resumes(resume_id),
    special_id integer not null references specialties(special_id)
);

CREATE TABLE responses
(
    response_id serial primary key,
    vacancy_id integer not null references vacancy(vacancy_id),
    resume_id integer not null references resumes(resume_id),
    date date not null,
    letter text
);