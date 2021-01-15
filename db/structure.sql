SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: headings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.headings (
    id bigint NOT NULL,
    member_id uuid NOT NULL,
    text text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    txt_tsearch tsvector GENERATED ALWAYS AS (setweight(to_tsvector('english'::regconfig, COALESCE(text, ''::text)), 'A'::"char")) STORED
);


--
-- Name: COLUMN headings.member_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.headings.member_id IS 'Member UUID';


--
-- Name: COLUMN headings.text; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.headings.text IS 'Heading text';


--
-- Name: headings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.headings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: headings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.headings_id_seq OWNED BY public.headings.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.members (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    short_url text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN members.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.members.name IS 'Name';


--
-- Name: COLUMN members.url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.members.url IS 'Website URL';


--
-- Name: COLUMN members.short_url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.members.short_url IS 'Shortened website URL';


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    login character varying NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.login IS 'User login';


--
-- Name: COLUMN users.password_digest; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.password_digest IS 'User password';


--
-- Name: headings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headings ALTER COLUMN id SET DEFAULT nextval('public.headings_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: headings headings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headings
    ADD CONSTRAINT headings_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_headings_on_member_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_headings_on_member_id ON public.headings USING btree (member_id);


--
-- Name: index_headings_on_txt_tsearch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_headings_on_txt_tsearch ON public.headings USING gin (txt_tsearch);


--
-- Name: index_users_on_login; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_login ON public.users USING btree (login);


--
-- Name: headings fk_rails_60260ba0a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.headings
    ADD CONSTRAINT fk_rails_60260ba0a3 FOREIGN KEY (member_id) REFERENCES public.members(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210113001231'),
('20210113005639'),
('20210114033923'),
('20210115041330'),
('20210115042707'),
('20210115050732'),
('20210115051447');


