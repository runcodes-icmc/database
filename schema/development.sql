--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE USER runcodes;
CREATE DATABASE runcodes;
\c runcodes
GRANT ALL PRIVILEGES ON DATABASE runcodes TO runcodes;

CREATE SEQUENCE alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alerts_id_seq OWNER TO runcodes;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE alerts (
    id integer DEFAULT nextval('alerts_id_seq'::regclass) NOT NULL,
    type integer NOT NULL,
    offering_id integer,
    recipients integer NOT NULL,
    user_email character varying(255) NOT NULL,
    valid date NOT NULL,
    title character varying(100) NOT NULL,
    message character varying(255) NOT NULL,
    CONSTRAINT ck_alerts_recipient CHECK ((recipients = ANY (ARRAY[0, 1, 2]))),
    CONSTRAINT ck_alerts_type CHECK ((type = ANY (ARRAY[0, 1, 2, 3])))
);


ALTER TABLE public.alerts OWNER TO runcodes;

--
-- Name: allowed_files_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE allowed_files_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allowed_files_id_seq OWNER TO runcodes;

--
-- Name: allowed_files; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE allowed_files (
    id integer DEFAULT nextval('allowed_files_id_seq'::regclass) NOT NULL,
    name character varying(200) NOT NULL,
    extension character varying(20) NOT NULL,
    compilable boolean,
    compile_command character varying(255),
    run_command character varying(255),
    available boolean DEFAULT true
);


ALTER TABLE public.allowed_files OWNER TO runcodes;

--
-- Name: allowed_files_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE allowed_files_exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allowed_files_exercises_id_seq OWNER TO runcodes;

--
-- Name: allowed_files_exercises; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE allowed_files_exercises (
    id integer DEFAULT nextval('allowed_files_exercises_id_seq'::regclass) NOT NULL,
    exercise_id integer NOT NULL,
    allowed_file_id integer
);


ALTER TABLE public.allowed_files_exercises OWNER TO runcodes;

--
-- Name: blacklist_mails_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE blacklist_mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blacklist_mails_id_seq OWNER TO runcodes;

--
-- Name: blacklist_mails; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE blacklist_mails (
    id integer DEFAULT nextval('blacklist_mails_id_seq'::regclass) NOT NULL,
    type smallint,
    address character varying(200)
);


ALTER TABLE public.blacklist_mails OWNER TO runcodes;

--
-- Name: commits_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE commits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commits_id_seq OWNER TO runcodes;

--
-- Name: commits; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE commits (
    id integer DEFAULT nextval('commits_id_seq'::regclass) NOT NULL,
    user_email character varying(255) NOT NULL,
    exercise_id integer NOT NULL,
    commit_time timestamp without time zone DEFAULT now() NOT NULL,
    status integer NOT NULL,
    hash character varying(150),
    corrects integer DEFAULT 0,
    score numeric(10,2) DEFAULT 0.0,
    compiled boolean,
    compiled_message text,
    compilation_started timestamp without time zone,
    compilation_finished timestamp without time zone,
    compiled_signal character varying(50) DEFAULT ''::character varying,
    compiled_error text DEFAULT ''::text,
    ip character varying(30) DEFAULT NULL::character varying,
    aws_key character varying(150) DEFAULT NULL::character varying
);


ALTER TABLE public.commits OWNER TO runcodes;

--
-- Name: commits_exercise_cases_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE commits_exercise_cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commits_exercise_cases_id_seq OWNER TO runcodes;

--
-- Name: commits_exercise_cases; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE commits_exercise_cases (
    id integer DEFAULT nextval('commits_exercise_cases_id_seq'::regclass) NOT NULL,
    commit_id integer NOT NULL,
    exercise_case_id integer NOT NULL,
    cputime numeric(15,4) NOT NULL,
    memused integer NOT NULL,
    output text NOT NULL,
    output_type integer NOT NULL,
    status integer NOT NULL,
    status_message text,
    error text DEFAULT ''::text
);


ALTER TABLE public.commits_exercise_cases OWNER TO runcodes;

--
-- Name: compilation_files_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE compilation_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compilation_files_id_seq OWNER TO runcodes;

--
-- Name: compilation_files; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE compilation_files (
    id integer DEFAULT nextval('compilation_files_id_seq'::regclass) NOT NULL,
    exercise_id integer NOT NULL,
    path character varying(150) NOT NULL
);


ALTER TABLE public.compilation_files OWNER TO runcodes;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO runcodes;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE courses (
    id integer DEFAULT nextval('courses_id_seq'::regclass) NOT NULL,
    code character varying(16) NOT NULL,
    title character varying(255) NOT NULL,
    university_id integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.courses OWNER TO runcodes;

--
-- Name: cria_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE cria_schools_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cria_schools_id_seq OWNER TO runcodes;

--
-- Name: cria_schools; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE cria_schools (
    id integer DEFAULT nextval('cria_schools_id_seq'::regclass) NOT NULL,
    name character varying(300) NOT NULL,
    supervisor character varying(500) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    edition integer NOT NULL,
    password character varying(10) NOT NULL,
    email character varying(500) NOT NULL,
    next_student_number integer DEFAULT 100,
    removed boolean DEFAULT false
);


ALTER TABLE public.cria_schools OWNER TO runcodes;

--
-- Name: cria_students_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE cria_students_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cria_students_id_seq OWNER TO runcodes;

--
-- Name: cria_students; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE cria_students (
    id integer DEFAULT nextval('cria_students_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    cria_school_id integer NOT NULL,
    edition integer NOT NULL,
    password character varying(10) NOT NULL,
    number integer DEFAULT 999,
    email character varying(150) NOT NULL,
    removed boolean DEFAULT false
);


ALTER TABLE public.cria_students OWNER TO runcodes;

--
-- Name: disk_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE disk_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disk_reports_id_seq OWNER TO runcodes;

--
-- Name: disk_reports; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE disk_reports (
    id integer DEFAULT nextval('disk_reports_id_seq'::regclass) NOT NULL,
    datetime timestamp with time zone,
    disk character varying(100),
    used real,
    free real,
    size real
);


ALTER TABLE public.disk_reports OWNER TO runcodes;

--
-- Name: droplets; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE droplets (
    id integer NOT NULL,
    ip inet,
    active boolean NOT NULL,
    memsize integer NOT NULL,
    hdsize integer NOT NULL,
    place character varying(100) NOT NULL,
    os character varying(100) NOT NULL
);


ALTER TABLE public.droplets OWNER TO runcodes;

--
-- Name: droplets_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE droplets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.droplets_id_seq OWNER TO runcodes;

--
-- Name: droplets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: runcodes
--

ALTER SEQUENCE droplets_id_seq OWNED BY droplets.id;


--
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enrollments_id_seq OWNER TO runcodes;

--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE enrollments (
    id integer DEFAULT nextval('enrollments_id_seq'::regclass) NOT NULL,
    offering_id integer NOT NULL,
    user_email character varying(255) NOT NULL,
    role integer NOT NULL,
    banned boolean DEFAULT false,
    CONSTRAINT ck_enrollments_role_type_user CHECK ((role = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.enrollments OWNER TO runcodes;

--
-- Name: exercise_case_files_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE exercise_case_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_case_files_id_seq OWNER TO runcodes;

--
-- Name: exercise_case_files; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE exercise_case_files (
    id integer DEFAULT nextval('exercise_case_files_id_seq'::regclass) NOT NULL,
    exercise_case_id integer NOT NULL,
    path character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.exercise_case_files OWNER TO runcodes;

--
-- Name: exercise_cases_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE exercise_cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_cases_id_seq OWNER TO runcodes;

--
-- Name: exercise_cases; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE exercise_cases (
    id integer DEFAULT nextval('exercise_cases_id_seq'::regclass) NOT NULL,
    exercise_id integer NOT NULL,
    input text,
    input_type integer NOT NULL,
    output text,
    output_type integer NOT NULL,
    show_input boolean,
    show_expected_output boolean,
    maxmemsize integer NOT NULL,
    cputime integer NOT NULL,
    stacksize integer NOT NULL,
    show_user_output boolean,
    file_size integer NOT NULL,
    abs_error double precision,
    last_update timestamp without time zone DEFAULT now(),
    input_md5 character varying(40) DEFAULT NULL::character varying,
    output_md5 character varying(40) DEFAULT NULL::character varying
);


ALTER TABLE public.exercise_cases OWNER TO runcodes;

--
-- Name: exercise_files_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE exercise_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_files_id_seq OWNER TO runcodes;

--
-- Name: exercise_files; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE exercise_files (
    id integer DEFAULT nextval('exercise_files_id_seq'::regclass) NOT NULL,
    exercise_id integer NOT NULL,
    path character varying(150) NOT NULL
);


ALTER TABLE public.exercise_files OWNER TO runcodes;

--
-- Name: exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercises_id_seq OWNER TO runcodes;

--
-- Name: exercises; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE exercises (
    id integer DEFAULT nextval('exercises_id_seq'::regclass) NOT NULL,
    offering_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    deadline timestamp without time zone DEFAULT now() NOT NULL,
    user_email character varying(255) NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    open_date timestamp without time zone DEFAULT now(),
    show_before_opening boolean,
    cases_change timestamp without time zone,
    removed boolean DEFAULT false,
    ghost boolean DEFAULT false,
    real_id integer,
    public boolean DEFAULT false,
    markdown boolean DEFAULT false
);


ALTER TABLE public.exercises OWNER TO runcodes;

--
-- Name: ganglia; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE ganglia (
    ip character varying(15),
    name character varying(255),
    reported numeric(100,0),
    boottime numeric(100,0),
    machinetype character varying(255),
    osname character varying(255),
    osrelease character varying(255),
    proctotal integer,
    cpunum integer,
    cpuspeed double precision,
    cpuidle double precision,
    ioreads double precision,
    iowrites double precision,
    ionread double precision,
    ionwrite double precision,
    memtotal double precision,
    memcached double precision,
    membuffers double precision,
    memfree double precision,
    swaptotal double precision,
    swapfree double precision,
    disktotal double precision,
    diskfree double precision,
    loadone double precision,
    loadfive double precision,
    loadfifteen double precision,
    pktsin double precision,
    pktsout double precision,
    bytesin double precision,
    bytesout double precision,
    isjail boolean DEFAULT false
);


ALTER TABLE public.ganglia OWNER TO runcodes;

--
-- Name: jail_status; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE jail_status (
    jailname character varying(255) NOT NULL,
    status integer,
    tsmp timestamp without time zone,
    ipaddress character varying(39),
    ssh_port integer,
    ssh_status integer
);


ALTER TABLE public.jail_status OWNER TO runcodes;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO runcodes;

--
-- Name: logs; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE logs (
    id integer DEFAULT nextval('logs_id_seq'::regclass) NOT NULL,
    user_email character varying(255) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    ip character varying(15) NOT NULL,
    action text NOT NULL
);


ALTER TABLE public.logs OWNER TO runcodes;

--
-- Name: mail_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE mail_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mail_logs_id_seq OWNER TO runcodes;

--
-- Name: mail_logs; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE mail_logs (
    id integer DEFAULT nextval('mail_logs_id_seq'::regclass) NOT NULL,
    sent_to character varying(150),
    subject character varying(200),
    message text,
    hash character varying(80),
    opened integer DEFAULT 0,
    sent_date timestamp without time zone DEFAULT now(),
    first_opened_time timestamp without time zone
);


ALTER TABLE public.mail_logs OWNER TO runcodes;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO runcodes;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE messages (
    id integer DEFAULT nextval('messages_id_seq'::regclass) NOT NULL,
    recipes text,
    subject text,
    message text,
    attachments text,
    template text
);


ALTER TABLE public.messages OWNER TO runcodes;

--
-- Name: offerings_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE offerings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offerings_id_seq OWNER TO runcodes;

--
-- Name: offerings; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE offerings (
    id integer DEFAULT nextval('offerings_id_seq'::regclass) NOT NULL,
    course_id integer NOT NULL,
    year integer NOT NULL,
    term integer NOT NULL,
    classroom character varying(45),
    end_date date NOT NULL,
    visible_to_enroll boolean DEFAULT true,
    enrollment_code character varying(10),
    max_students integer DEFAULT 0,
    max_exercises integer DEFAULT 0
);


ALTER TABLE public.offerings OWNER TO runcodes;

--
-- Name: public_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE public_exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_exercises_id_seq OWNER TO runcodes;

--
-- Name: public_exercises; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE public_exercises (
    id integer DEFAULT nextval('public_exercises_id_seq'::regclass) NOT NULL,
    exercise_id integer NOT NULL,
    level integer,
    obs text,
    keywords character varying(255)
);


ALTER TABLE public.public_exercises OWNER TO runcodes;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO runcodes;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE questions (
    id integer DEFAULT nextval('questions_id_seq'::regclass) NOT NULL,
    title character varying(350),
    text text,
    tags character varying(350)
);


ALTER TABLE public.questions OWNER TO runcodes;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO runcodes;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE tickets (
    id integer DEFAULT nextval('tickets_id_seq'::regclass) NOT NULL,
    users_email character varying(255) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    type integer NOT NULL,
    status integer NOT NULL,
    solved boolean,
    priority integer NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.tickets OWNER TO runcodes;

--
-- Name: universities_id_seq; Type: SEQUENCE; Schema: public; Owner: runcodes
--

CREATE SEQUENCE universities_id_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.universities_id_seq OWNER TO runcodes;

--
-- Name: universities; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE universities (
    id integer DEFAULT nextval('universities_id_seq'::regclass) NOT NULL,
    abbreviation character varying(20) NOT NULL,
    name character varying(210) NOT NULL,
    student_identifier_text character varying(40),
    type integer DEFAULT 1,
    state character varying(5) DEFAULT 'BR'::character varying
);


ALTER TABLE public.universities OWNER TO runcodes;

--
-- Name: users; Type: TABLE; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE TABLE users (
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(40) NOT NULL,
    type integer NOT NULL,
    creation timestamp without time zone DEFAULT now() NOT NULL,
    confirmed boolean DEFAULT false,
    university_id integer,
    identifier character varying(50),
    source integer DEFAULT 0,
    CONSTRAINT ck_users_type_user CHECK ((type = ANY (ARRAY[0, 1, 2, 3, 4])))
);


ALTER TABLE public.users OWNER TO runcodes;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY droplets ALTER COLUMN id SET DEFAULT nextval('droplets_id_seq'::regclass);


--
-- Name: blacklist_mails_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY blacklist_mails
    ADD CONSTRAINT blacklist_mails_pkey PRIMARY KEY (id);


--
-- Name: compilation_files_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY compilation_files
    ADD CONSTRAINT compilation_files_pkey PRIMARY KEY (id);


--
-- Name: cria_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY cria_schools
    ADD CONSTRAINT cria_schools_pkey PRIMARY KEY (id);


--
-- Name: cria_students_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY cria_students
    ADD CONSTRAINT cria_students_pkey PRIMARY KEY (id);


--
-- Name: disk_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY disk_reports
    ADD CONSTRAINT disk_reports_pkey PRIMARY KEY (id);


--
-- Name: jail_status_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY jail_status
    ADD CONSTRAINT jail_status_pkey PRIMARY KEY (jailname);


--
-- Name: mail_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY mail_logs
    ADD CONSTRAINT mail_logs_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: pk_actionlogs; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT pk_actionlogs PRIMARY KEY (id);


--
-- Name: pk_alerts; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT pk_alerts PRIMARY KEY (id);


--
-- Name: pk_commits; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT pk_commits PRIMARY KEY (id);


--
-- Name: pk_commits_exercise_case; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY commits_exercise_cases
    ADD CONSTRAINT pk_commits_exercise_case PRIMARY KEY (id);


--
-- Name: pk_courses; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT pk_courses PRIMARY KEY (id);


--
-- Name: pk_droplets; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY droplets
    ADD CONSTRAINT pk_droplets PRIMARY KEY (id);


--
-- Name: pk_enrollments; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT pk_enrollments PRIMARY KEY (id);


--
-- Name: pk_exercise_case_files; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY exercise_case_files
    ADD CONSTRAINT pk_exercise_case_files PRIMARY KEY (id);


--
-- Name: pk_exercise_cases; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY exercise_cases
    ADD CONSTRAINT pk_exercise_cases PRIMARY KEY (id);


--
-- Name: pk_exercise_files; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY exercise_files
    ADD CONSTRAINT pk_exercise_files PRIMARY KEY (id);


--
-- Name: pk_exercises; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY exercises
    ADD CONSTRAINT pk_exercises PRIMARY KEY (id);


--
-- Name: pk_exercises_allowed_files; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY allowed_files_exercises
    ADD CONSTRAINT pk_exercises_allowed_files PRIMARY KEY (id);


--
-- Name: pk_files; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY allowed_files
    ADD CONSTRAINT pk_files PRIMARY KEY (id);


--
-- Name: pk_offerings; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT pk_offerings PRIMARY KEY (id);


--
-- Name: pk_tickets; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT pk_tickets PRIMARY KEY (id);


--
-- Name: pk_users; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT pk_users PRIMARY KEY (email);


--
-- Name: public_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY public_exercises
    ADD CONSTRAINT public_exercises_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: un_offerings_offerings; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT un_offerings_offerings UNIQUE (course_id, year, term, classroom);


--
-- Name: unique_enrollments; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT unique_enrollments UNIQUE (offering_id, user_email);


--
-- Name: universities_pkey; Type: CONSTRAINT; Schema: public; Owner: runcodes; Tablespace: 
--

ALTER TABLE ONLY universities
    ADD CONSTRAINT universities_pkey PRIMARY KEY (id);


--
-- Name: courses_university_id_idx; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX courses_university_id_idx ON courses USING btree (university_id);


--
-- Name: idx_commits_commit_time; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_commit_time ON commits USING btree (commit_time);


--
-- Name: idx_commits_exercise_cases_commit_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_exercise_cases_commit_id ON commits_exercise_cases USING btree (commit_id);


--
-- Name: idx_commits_exercise_cases_exercise_case_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_exercise_cases_exercise_case_id ON commits_exercise_cases USING btree (exercise_case_id);


--
-- Name: idx_commits_exercise_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_exercise_id ON commits USING btree (exercise_id);


--
-- Name: idx_commits_status; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_status ON commits USING btree (status);


--
-- Name: idx_commits_user_email; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_user_email ON commits USING btree (user_email);


--
-- Name: idx_commits_user_email_hash; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_commits_user_email_hash ON commits USING hash (user_email);


--
-- Name: idx_enrollments_offering_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_enrollments_offering_id ON enrollments USING btree (offering_id);


--
-- Name: idx_enrollments_user_email; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_enrollments_user_email ON enrollments USING btree (user_email);


--
-- Name: idx_exercise_cases_exercise_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_exercise_cases_exercise_id ON exercise_cases USING btree (exercise_id);


--
-- Name: idx_exercises_deadline; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_exercises_deadline ON exercises USING btree (deadline);


--
-- Name: idx_exercises_offering_id; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_exercises_offering_id ON exercises USING btree (offering_id);


--
-- Name: idx_exercises_open_date; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_exercises_open_date ON exercises USING btree (open_date);


--
-- Name: idx_mail_logs_hash; Type: INDEX; Schema: public; Owner: runcodes; Tablespace: 
--

CREATE INDEX idx_mail_logs_hash ON mail_logs USING hash (hash);


--
-- Name: fk_alerts_offerings_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT fk_alerts_offerings_id FOREIGN KEY (offering_id) REFERENCES offerings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_alerts_users_email; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT fk_alerts_users_email FOREIGN KEY (user_email) REFERENCES users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_allowed_files_exercises_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY allowed_files_exercises
    ADD CONSTRAINT fk_allowed_files_exercises_id FOREIGN KEY (allowed_file_id) REFERENCES allowed_files(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_commits_exercise_cases_commits_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY commits_exercise_cases
    ADD CONSTRAINT fk_commits_exercise_cases_commits_id FOREIGN KEY (commit_id) REFERENCES commits(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_commits_exercise_cases_exercise_cases_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY commits_exercise_cases
    ADD CONSTRAINT fk_commits_exercise_cases_exercise_cases_id FOREIGN KEY (exercise_case_id) REFERENCES exercise_cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_commits_exercises_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT fk_commits_exercises_id FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_commits_users_email; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT fk_commits_users_email FOREIGN KEY (user_email) REFERENCES users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_compilation_files_exercise; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY compilation_files
    ADD CONSTRAINT fk_compilation_files_exercise FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE;


--
-- Name: fk_enrollments_offerings_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT fk_enrollments_offerings_id FOREIGN KEY (offering_id) REFERENCES offerings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_enrollments_users_email; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY enrollments
    ADD CONSTRAINT fk_enrollments_users_email FOREIGN KEY (user_email) REFERENCES users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_exercise_case_files_exercise; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY exercise_case_files
    ADD CONSTRAINT fk_exercise_case_files_exercise FOREIGN KEY (exercise_case_id) REFERENCES exercise_cases(id) ON DELETE CASCADE;


--
-- Name: fk_exercise_case_files_exercise_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY exercise_case_files
    ADD CONSTRAINT fk_exercise_case_files_exercise_id FOREIGN KEY (exercise_case_id) REFERENCES exercise_cases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_exercise_cases_exercise_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY exercise_cases
    ADD CONSTRAINT fk_exercise_cases_exercise_id FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_exercise_files_exercise_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY exercise_files
    ADD CONSTRAINT fk_exercise_files_exercise_id FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_exercises_allowed_files_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY allowed_files_exercises
    ADD CONSTRAINT fk_exercises_allowed_files_id FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_exercises_offerings_id; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY exercises
    ADD CONSTRAINT fk_exercises_offerings_id FOREIGN KEY (offering_id) REFERENCES offerings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_offerings_courses_code; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY offerings
    ADD CONSTRAINT fk_offerings_courses_code FOREIGN KEY (course_id) REFERENCES courses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_tickets_users_email; Type: FK CONSTRAINT; Schema: public; Owner: runcodes
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT fk_tickets_users_email FOREIGN KEY (users_email) REFERENCES users(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: alerts_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE alerts_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE alerts_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE alerts_id_seq TO runcodes;
GRANT ALL ON SEQUENCE alerts_id_seq TO postgres;


--
-- Name: alerts; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE alerts FROM PUBLIC;
REVOKE ALL ON TABLE alerts FROM runcodes;
GRANT ALL ON TABLE alerts TO runcodes;
GRANT ALL ON TABLE alerts TO postgres;


--
-- Name: allowed_files_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE allowed_files_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE allowed_files_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE allowed_files_id_seq TO runcodes;
GRANT ALL ON SEQUENCE allowed_files_id_seq TO postgres;


--
-- Name: allowed_files; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE allowed_files FROM PUBLIC;
REVOKE ALL ON TABLE allowed_files FROM runcodes;
GRANT ALL ON TABLE allowed_files TO runcodes;
GRANT ALL ON TABLE allowed_files TO postgres;


--
-- Name: allowed_files_exercises_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE allowed_files_exercises_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE allowed_files_exercises_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE allowed_files_exercises_id_seq TO runcodes;
GRANT ALL ON SEQUENCE allowed_files_exercises_id_seq TO postgres;


--
-- Name: allowed_files_exercises; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE allowed_files_exercises FROM PUBLIC;
REVOKE ALL ON TABLE allowed_files_exercises FROM runcodes;
GRANT ALL ON TABLE allowed_files_exercises TO runcodes;
GRANT ALL ON TABLE allowed_files_exercises TO postgres;


--
-- Name: blacklist_mails_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE blacklist_mails_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE blacklist_mails_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE blacklist_mails_id_seq TO runcodes;
GRANT ALL ON SEQUENCE blacklist_mails_id_seq TO postgres;


--
-- Name: blacklist_mails; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE blacklist_mails FROM PUBLIC;
REVOKE ALL ON TABLE blacklist_mails FROM runcodes;
GRANT ALL ON TABLE blacklist_mails TO runcodes;
GRANT ALL ON TABLE blacklist_mails TO postgres;


--
-- Name: commits_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE commits_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE commits_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE commits_id_seq TO runcodes;
GRANT ALL ON SEQUENCE commits_id_seq TO postgres;


--
-- Name: commits; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE commits FROM PUBLIC;
REVOKE ALL ON TABLE commits FROM runcodes;
GRANT ALL ON TABLE commits TO runcodes;
GRANT ALL ON TABLE commits TO postgres;


--
-- Name: commits_exercise_cases_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE commits_exercise_cases_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE commits_exercise_cases_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE commits_exercise_cases_id_seq TO runcodes;
GRANT ALL ON SEQUENCE commits_exercise_cases_id_seq TO postgres;


--
-- Name: commits_exercise_cases; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE commits_exercise_cases FROM PUBLIC;
REVOKE ALL ON TABLE commits_exercise_cases FROM runcodes;
GRANT ALL ON TABLE commits_exercise_cases TO runcodes;
GRANT ALL ON TABLE commits_exercise_cases TO postgres;


--
-- Name: compilation_files_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE compilation_files_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE compilation_files_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE compilation_files_id_seq TO runcodes;
GRANT ALL ON SEQUENCE compilation_files_id_seq TO postgres;


--
-- Name: compilation_files; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE compilation_files FROM PUBLIC;
REVOKE ALL ON TABLE compilation_files FROM runcodes;
GRANT ALL ON TABLE compilation_files TO runcodes;
GRANT ALL ON TABLE compilation_files TO postgres;


--
-- Name: courses_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE courses_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE courses_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE courses_id_seq TO runcodes;
GRANT ALL ON SEQUENCE courses_id_seq TO postgres;


--
-- Name: courses; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE courses FROM PUBLIC;
REVOKE ALL ON TABLE courses FROM runcodes;
GRANT ALL ON TABLE courses TO runcodes;
GRANT ALL ON TABLE courses TO postgres;


--
-- Name: cria_schools_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE cria_schools_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE cria_schools_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE cria_schools_id_seq TO runcodes;
GRANT ALL ON SEQUENCE cria_schools_id_seq TO postgres;


--
-- Name: cria_schools; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE cria_schools FROM PUBLIC;
REVOKE ALL ON TABLE cria_schools FROM runcodes;
GRANT ALL ON TABLE cria_schools TO runcodes;
GRANT ALL ON TABLE cria_schools TO postgres;


--
-- Name: cria_students_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE cria_students_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE cria_students_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE cria_students_id_seq TO runcodes;
GRANT ALL ON SEQUENCE cria_students_id_seq TO postgres;


--
-- Name: cria_students; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE cria_students FROM PUBLIC;
REVOKE ALL ON TABLE cria_students FROM runcodes;
GRANT ALL ON TABLE cria_students TO runcodes;
GRANT ALL ON TABLE cria_students TO postgres;


--
-- Name: disk_reports_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE disk_reports_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE disk_reports_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE disk_reports_id_seq TO runcodes;
GRANT ALL ON SEQUENCE disk_reports_id_seq TO postgres;


--
-- Name: disk_reports; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE disk_reports FROM PUBLIC;
REVOKE ALL ON TABLE disk_reports FROM runcodes;
GRANT ALL ON TABLE disk_reports TO runcodes;
GRANT ALL ON TABLE disk_reports TO postgres;


--
-- Name: droplets; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE droplets FROM PUBLIC;
REVOKE ALL ON TABLE droplets FROM runcodes;
GRANT ALL ON TABLE droplets TO runcodes;
GRANT ALL ON TABLE droplets TO postgres;


--
-- Name: droplets_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE droplets_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE droplets_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE droplets_id_seq TO runcodes;
GRANT ALL ON SEQUENCE droplets_id_seq TO postgres;


--
-- Name: enrollments_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE enrollments_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE enrollments_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE enrollments_id_seq TO runcodes;
GRANT ALL ON SEQUENCE enrollments_id_seq TO postgres;


--
-- Name: enrollments; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE enrollments FROM PUBLIC;
REVOKE ALL ON TABLE enrollments FROM runcodes;
GRANT ALL ON TABLE enrollments TO runcodes;
GRANT ALL ON TABLE enrollments TO postgres;


--
-- Name: exercise_case_files_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE exercise_case_files_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE exercise_case_files_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE exercise_case_files_id_seq TO runcodes;
GRANT ALL ON SEQUENCE exercise_case_files_id_seq TO postgres;


--
-- Name: exercise_case_files; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE exercise_case_files FROM PUBLIC;
REVOKE ALL ON TABLE exercise_case_files FROM runcodes;
GRANT ALL ON TABLE exercise_case_files TO runcodes;
GRANT ALL ON TABLE exercise_case_files TO postgres;


--
-- Name: exercise_cases_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE exercise_cases_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE exercise_cases_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE exercise_cases_id_seq TO runcodes;
GRANT ALL ON SEQUENCE exercise_cases_id_seq TO postgres;


--
-- Name: exercise_cases; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE exercise_cases FROM PUBLIC;
REVOKE ALL ON TABLE exercise_cases FROM runcodes;
GRANT ALL ON TABLE exercise_cases TO runcodes;
GRANT ALL ON TABLE exercise_cases TO postgres;


--
-- Name: exercise_files_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE exercise_files_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE exercise_files_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE exercise_files_id_seq TO runcodes;
GRANT ALL ON SEQUENCE exercise_files_id_seq TO postgres;


--
-- Name: exercise_files; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE exercise_files FROM PUBLIC;
REVOKE ALL ON TABLE exercise_files FROM runcodes;
GRANT ALL ON TABLE exercise_files TO runcodes;
GRANT ALL ON TABLE exercise_files TO postgres;


--
-- Name: exercises_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE exercises_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE exercises_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE exercises_id_seq TO runcodes;
GRANT ALL ON SEQUENCE exercises_id_seq TO postgres;


--
-- Name: exercises; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE exercises FROM PUBLIC;
REVOKE ALL ON TABLE exercises FROM runcodes;
GRANT ALL ON TABLE exercises TO runcodes;
GRANT ALL ON TABLE exercises TO postgres;


--
-- Name: ganglia; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE ganglia FROM PUBLIC;
REVOKE ALL ON TABLE ganglia FROM runcodes;
GRANT ALL ON TABLE ganglia TO runcodes;
GRANT ALL ON TABLE ganglia TO postgres;


--
-- Name: jail_status; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE jail_status FROM PUBLIC;
REVOKE ALL ON TABLE jail_status FROM runcodes;
GRANT ALL ON TABLE jail_status TO runcodes;
GRANT ALL ON TABLE jail_status TO postgres;


--
-- Name: logs_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE logs_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE logs_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE logs_id_seq TO runcodes;
GRANT ALL ON SEQUENCE logs_id_seq TO postgres;


--
-- Name: logs; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE logs FROM PUBLIC;
REVOKE ALL ON TABLE logs FROM runcodes;
GRANT ALL ON TABLE logs TO runcodes;
GRANT ALL ON TABLE logs TO postgres;


--
-- Name: mail_logs_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE mail_logs_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mail_logs_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE mail_logs_id_seq TO runcodes;
GRANT ALL ON SEQUENCE mail_logs_id_seq TO postgres;


--
-- Name: mail_logs; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE mail_logs FROM PUBLIC;
REVOKE ALL ON TABLE mail_logs FROM runcodes;
GRANT ALL ON TABLE mail_logs TO runcodes;
GRANT ALL ON TABLE mail_logs TO postgres;


--
-- Name: messages_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE messages_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE messages_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE messages_id_seq TO runcodes;
GRANT ALL ON SEQUENCE messages_id_seq TO postgres;


--
-- Name: messages; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE messages FROM PUBLIC;
REVOKE ALL ON TABLE messages FROM runcodes;
GRANT ALL ON TABLE messages TO runcodes;
GRANT ALL ON TABLE messages TO postgres;


--
-- Name: offerings_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE offerings_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE offerings_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE offerings_id_seq TO runcodes;
GRANT ALL ON SEQUENCE offerings_id_seq TO postgres;


--
-- Name: offerings; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE offerings FROM PUBLIC;
REVOKE ALL ON TABLE offerings FROM runcodes;
GRANT ALL ON TABLE offerings TO runcodes;
GRANT ALL ON TABLE offerings TO postgres;


--
-- Name: public_exercises_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE public_exercises_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE public_exercises_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE public_exercises_id_seq TO runcodes;
GRANT ALL ON SEQUENCE public_exercises_id_seq TO postgres;


--
-- Name: public_exercises; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE public_exercises FROM PUBLIC;
REVOKE ALL ON TABLE public_exercises FROM runcodes;
GRANT ALL ON TABLE public_exercises TO runcodes;
GRANT ALL ON TABLE public_exercises TO postgres;


--
-- Name: questions_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE questions_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE questions_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE questions_id_seq TO runcodes;
GRANT ALL ON SEQUENCE questions_id_seq TO postgres;


--
-- Name: questions; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE questions FROM PUBLIC;
REVOKE ALL ON TABLE questions FROM runcodes;
GRANT ALL ON TABLE questions TO runcodes;
GRANT ALL ON TABLE questions TO postgres;


--
-- Name: tickets_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE tickets_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tickets_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE tickets_id_seq TO runcodes;
GRANT ALL ON SEQUENCE tickets_id_seq TO postgres;


--
-- Name: tickets; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE tickets FROM PUBLIC;
REVOKE ALL ON TABLE tickets FROM runcodes;
GRANT ALL ON TABLE tickets TO runcodes;
GRANT ALL ON TABLE tickets TO postgres;


--
-- Name: universities_id_seq; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON SEQUENCE universities_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE universities_id_seq FROM runcodes;
GRANT ALL ON SEQUENCE universities_id_seq TO runcodes;
GRANT ALL ON SEQUENCE universities_id_seq TO postgres;


--
-- Name: universities; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE universities FROM PUBLIC;
REVOKE ALL ON TABLE universities FROM runcodes;
GRANT ALL ON TABLE universities TO runcodes;
GRANT ALL ON TABLE universities TO postgres;


--
-- Name: users; Type: ACL; Schema: public; Owner: runcodes
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM runcodes;
GRANT ALL ON TABLE users TO runcodes;
GRANT ALL ON TABLE users TO postgres;


--
-- PostgreSQL database dump complete
--

--
-- Sample Data
--

INSERT INTO universities (id, abbreviation, name, student_identifier_text, type, state)
VALUES (1, 'USP', 'Universidade de São Paulo', 'Número USP', 1, 'SP');

INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (1, 'Python 3', 'py', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (2, 'C', 'c', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (3, 'C++', 'cpp', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (4, 'Haskell', 'hs', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (5, 'Makefile', 'zip', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (6, 'Fortran', 'f', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (7, 'Java 17', 'java', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (8, 'Pascal', 'pas', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (9, 'Portugol 2.6', 'por', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (10, 'R', 'r', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (11, 'Rust', 'rs', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (12, 'Zip', 'zip', false, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (13, 'PDF', 'pdf', false, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (14, 'Golang', 'go', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (15, 'Octave', 'm', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (16, 'C#', 'cs', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (17, 'Lua', 'lua', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (18, 'Prolog', 'pl', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (19, 'C (OpenMP)', 'omp.c', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (20, 'C++ (OpenMP)', 'omp.cpp', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (21, 'C (OpenMP + MPI)', 'mpi.c', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (22, 'C++ (OpenMP + MPI)', 'mpi.cpp', true, '', '', true);
INSERT INTO public.allowed_files (id, name, extension, compilable, compile_command, run_command, available) VALUES (23, 'Verilog', 'v', true, '', '', true);

-- Passwords: ?6MgoQik
INSERT INTO users (email, name, password, type, confirmed, university_id, identifier)
VALUES 
    ('admin@admin', 'Admin', '3eb6ae46d04fe39ab15ef6d9df0b40c91a9685e8', 3, true, NULL, NULL);
