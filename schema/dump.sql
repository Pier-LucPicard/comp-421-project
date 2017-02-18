--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Canada.1252' LC_CTYPE = 'English_Canada.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: scheme; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA scheme;


ALTER SCHEMA scheme OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- Name: t; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE t AS (
	name character varying(50),
	age integer
);


ALTER TYPE t OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comment (
    cid integer NOT NULL,
    pid integer NOT NULL,
    email character varying(320),
    text text NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE comment OWNER TO postgres;

--
-- Name: comment_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_cid_seq OWNER TO postgres;

--
-- Name: comment_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_cid_seq OWNED BY comment.cid;


--
-- Name: comment_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_pid_seq OWNER TO postgres;

--
-- Name: comment_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_pid_seq OWNED BY comment.pid;


--
-- Name: commentreaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE commentreaction (
    cid integer NOT NULL,
    email character varying(320) NOT NULL,
    type character varying(7),
    CONSTRAINT commentreaction_type_check CHECK (((type)::text = ANY ((ARRAY['angry'::character varying, 'happy'::character varying, 'sad'::character varying, 'like'::character varying, 'excited'::character varying])::text[])))
);


ALTER TABLE commentreaction OWNER TO postgres;

--
-- Name: commentreaction_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commentreaction_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE commentreaction_cid_seq OWNER TO postgres;

--
-- Name: commentreaction_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE commentreaction_cid_seq OWNED BY commentreaction.cid;


--
-- Name: conversation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversation (
    convo_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE conversation OWNER TO postgres;

--
-- Name: conversation_convo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE conversation_convo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conversation_convo_id_seq OWNER TO postgres;

--
-- Name: conversation_convo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE conversation_convo_id_seq OWNED BY conversation.convo_id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE follows (
    follower character varying(320),
    followed_by character varying(320),
    since timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE follows OWNER TO postgres;

--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE location (
    city character varying(50) NOT NULL,
    country character varying(50) NOT NULL
);


ALTER TABLE location OWNER TO postgres;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE message (
    msg_id integer NOT NULL,
    email character varying(320),
    convo_id integer NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    content character varying(2000) NOT NULL
);


ALTER TABLE message OWNER TO postgres;

--
-- Name: message_convo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE message_convo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_convo_id_seq OWNER TO postgres;

--
-- Name: message_convo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE message_convo_id_seq OWNED BY message.convo_id;


--
-- Name: message_msg_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE message_msg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_msg_id_seq OWNER TO postgres;

--
-- Name: message_msg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE message_msg_id_seq OWNED BY message.msg_id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization (
    org_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(500),
    phone_number character varying(20) NOT NULL,
    address character varying(100) NOT NULL,
    city character varying(50),
    country character varying(50)
);


ALTER TABLE organization OWNER TO postgres;

--
-- Name: organization_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organization_org_id_seq OWNER TO postgres;

--
-- Name: organization_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organization_org_id_seq OWNED BY organization.org_id;


--
-- Name: partof; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE partof (
    email character varying(320) NOT NULL,
    convo_id integer NOT NULL
);


ALTER TABLE partof OWNER TO postgres;

--
-- Name: partof_convo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE partof_convo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partof_convo_id_seq OWNER TO postgres;

--
-- Name: partof_convo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE partof_convo_id_seq OWNED BY partof.convo_id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post (
    pid integer NOT NULL,
    wall_id integer NOT NULL,
    email character varying(320),
    date timestamp without time zone DEFAULT now() NOT NULL,
    text character varying(2000) NOT NULL,
    url character varying(2000)
);


ALTER TABLE post OWNER TO postgres;

--
-- Name: post_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_pid_seq OWNER TO postgres;

--
-- Name: post_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_pid_seq OWNED BY post.pid;


--
-- Name: post_wall_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_wall_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_wall_id_seq OWNER TO postgres;

--
-- Name: post_wall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_wall_id_seq OWNED BY post.wall_id;


--
-- Name: postreaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE postreaction (
    pid integer NOT NULL,
    email character varying(320) NOT NULL,
    type character varying(7),
    CONSTRAINT postreaction_type_check CHECK (((type)::text = ANY ((ARRAY['angry'::character varying, 'happy'::character varying, 'sad'::character varying, 'like'::character varying, 'excited'::character varying])::text[])))
);


ALTER TABLE postreaction OWNER TO postgres;

--
-- Name: postreaction_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE postreaction_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE postreaction_pid_seq OWNER TO postgres;

--
-- Name: postreaction_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE postreaction_pid_seq OWNED BY postreaction.pid;


--
-- Name: school; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE school (
    org_id integer NOT NULL
);


ALTER TABLE school OWNER TO postgres;

--
-- Name: school_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE school_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE school_org_id_seq OWNER TO postgres;

--
-- Name: school_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE school_org_id_seq OWNED BY school.org_id;


--
-- Name: studyperiod; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE studyperiod (
    email character varying(320) NOT NULL,
    org_id integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    edu_level character varying(100) NOT NULL,
    CONSTRAINT studyperiod_check CHECK ((from_date <= to_date))
);


ALTER TABLE studyperiod OWNER TO postgres;

--
-- Name: studyperiod_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE studyperiod_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE studyperiod_org_id_seq OWNER TO postgres;

--
-- Name: studyperiod_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE studyperiod_org_id_seq OWNED BY studyperiod.org_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    email character varying(320) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    birthday date NOT NULL,
    password character varying(20) NOT NULL,
    gender character varying(1) NOT NULL,
    CONSTRAINT users_email_check CHECK (((email)::text ~ '^[a-zA-Z0-9\-.]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$'::text)),
    CONSTRAINT users_gender_check CHECK ((((gender)::text = 'm'::text) OR ((gender)::text = 'f'::text)))
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: wall; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wall (
    wall_id integer NOT NULL,
    descr character varying(500),
    permission smallint DEFAULT 0 NOT NULL,
    email character varying(320)
);


ALTER TABLE wall OWNER TO postgres;

--
-- Name: wall_wall_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE wall_wall_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wall_wall_id_seq OWNER TO postgres;

--
-- Name: wall_wall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE wall_wall_id_seq OWNED BY wall.wall_id;


--
-- Name: workperiod; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workperiod (
    email character varying(320) NOT NULL,
    org_id integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    job_title character varying(100) NOT NULL,
    CONSTRAINT workperiod_check CHECK ((from_date <= to_date))
);


ALTER TABLE workperiod OWNER TO postgres;

--
-- Name: workperiod_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE workperiod_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workperiod_org_id_seq OWNER TO postgres;

--
-- Name: workperiod_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE workperiod_org_id_seq OWNED BY workperiod.org_id;


--
-- Name: workplace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workplace (
    org_id integer NOT NULL
);


ALTER TABLE workplace OWNER TO postgres;

--
-- Name: workplace_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE workplace_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workplace_org_id_seq OWNER TO postgres;

--
-- Name: workplace_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE workplace_org_id_seq OWNED BY workplace.org_id;


SET search_path = scheme, pg_catalog;

--
-- Name: tab; Type: TABLE; Schema: scheme; Owner: postgres
--

CREATE TABLE tab (
    age integer NOT NULL
);


ALTER TABLE tab OWNER TO postgres;

--
-- Name: tt; Type: TABLE; Schema: scheme; Owner: postgres
--

CREATE TABLE tt (
    age integer
);


ALTER TABLE tt OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: comment cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment ALTER COLUMN cid SET DEFAULT nextval('comment_cid_seq'::regclass);


--
-- Name: comment pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment ALTER COLUMN pid SET DEFAULT nextval('comment_pid_seq'::regclass);


--
-- Name: commentreaction cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commentreaction ALTER COLUMN cid SET DEFAULT nextval('commentreaction_cid_seq'::regclass);


--
-- Name: conversation convo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation ALTER COLUMN convo_id SET DEFAULT nextval('conversation_convo_id_seq'::regclass);


--
-- Name: message msg_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message ALTER COLUMN msg_id SET DEFAULT nextval('message_msg_id_seq'::regclass);


--
-- Name: message convo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message ALTER COLUMN convo_id SET DEFAULT nextval('message_convo_id_seq'::regclass);


--
-- Name: organization org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization ALTER COLUMN org_id SET DEFAULT nextval('organization_org_id_seq'::regclass);


--
-- Name: partof convo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partof ALTER COLUMN convo_id SET DEFAULT nextval('partof_convo_id_seq'::regclass);


--
-- Name: post pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post ALTER COLUMN pid SET DEFAULT nextval('post_pid_seq'::regclass);


--
-- Name: post wall_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post ALTER COLUMN wall_id SET DEFAULT nextval('post_wall_id_seq'::regclass);


--
-- Name: postreaction pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postreaction ALTER COLUMN pid SET DEFAULT nextval('postreaction_pid_seq'::regclass);


--
-- Name: school org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school ALTER COLUMN org_id SET DEFAULT nextval('school_org_id_seq'::regclass);


--
-- Name: studyperiod org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studyperiod ALTER COLUMN org_id SET DEFAULT nextval('studyperiod_org_id_seq'::regclass);


--
-- Name: wall wall_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wall ALTER COLUMN wall_id SET DEFAULT nextval('wall_wall_id_seq'::regclass);


--
-- Name: workperiod org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workperiod ALTER COLUMN org_id SET DEFAULT nextval('workperiod_org_id_seq'::regclass);


--
-- Name: workplace org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace ALTER COLUMN org_id SET DEFAULT nextval('workplace_org_id_seq'::regclass);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: comment_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comment_cid_seq', 1, false);


--
-- Name: comment_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comment_pid_seq', 1, false);


--
-- Data for Name: commentreaction; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: commentreaction_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('commentreaction_cid_seq', 1, false);


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO conversation VALUES (1, 'Automated Support');
INSERT INTO conversation VALUES (2, 'help-desk Human Resources');
INSERT INTO conversation VALUES (3, 'zero administration Product Management');
INSERT INTO conversation VALUES (4, 'fault-tolerant Legal');
INSERT INTO conversation VALUES (5, 'Virtual Human Resources');
INSERT INTO conversation VALUES (6, 'bottom-line Training');
INSERT INTO conversation VALUES (7, 'Seamless Legal');
INSERT INTO conversation VALUES (8, 'foreground Support');
INSERT INTO conversation VALUES (9, 'time-frame Product Management');
INSERT INTO conversation VALUES (10, 'cohesive Engineering');
INSERT INTO conversation VALUES (11, 'support Research and Development');
INSERT INTO conversation VALUES (12, 'Adaptive Accounting');
INSERT INTO conversation VALUES (13, 'Future-proofed Business Development');
INSERT INTO conversation VALUES (14, 'User-friendly Services');
INSERT INTO conversation VALUES (15, 'policy Marketing');
INSERT INTO conversation VALUES (16, 'exuding Marketing');
INSERT INTO conversation VALUES (17, 'superstructure Accounting');
INSERT INTO conversation VALUES (18, 'Intuitive Legal');
INSERT INTO conversation VALUES (19, 'superstructure Support');
INSERT INTO conversation VALUES (20, 'object-oriented Marketing');
INSERT INTO conversation VALUES (21, 'bottom-line Support');
INSERT INTO conversation VALUES (22, 'Profound Engineering');
INSERT INTO conversation VALUES (23, 'attitude-oriented Research and Development');
INSERT INTO conversation VALUES (24, '3rd generation Business Development');
INSERT INTO conversation VALUES (25, 'Face to face Human Resources');
INSERT INTO conversation VALUES (26, 'asymmetric Training');
INSERT INTO conversation VALUES (27, 'Advanced Product Management');
INSERT INTO conversation VALUES (28, 'asynchronous Services');
INSERT INTO conversation VALUES (29, 'internet solution Accounting');
INSERT INTO conversation VALUES (30, 'zero defect Marketing');
INSERT INTO conversation VALUES (31, 'synergy Human Resources');
INSERT INTO conversation VALUES (32, 'grid-enabled Business Development');
INSERT INTO conversation VALUES (33, 'incremental Legal');
INSERT INTO conversation VALUES (34, 'hardware Accounting');
INSERT INTO conversation VALUES (35, 'heuristic Product Management');
INSERT INTO conversation VALUES (36, '24/7 Business Development');
INSERT INTO conversation VALUES (37, 'directional Support');
INSERT INTO conversation VALUES (38, 'pricing structure Engineering');
INSERT INTO conversation VALUES (39, 'approach Legal');
INSERT INTO conversation VALUES (40, 'Synergized Research and Development');


--
-- Name: conversation_convo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('conversation_convo_id_seq', 40, true);


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO location VALUES ('Xinglong', 'China');
INSERT INTO location VALUES ('Zhanlong', 'China');
INSERT INTO location VALUES ('Chalandrítsa', 'Greece');
INSERT INTO location VALUES ('Iława', 'Poland');
INSERT INTO location VALUES ('Muzhijie', 'China');
INSERT INTO location VALUES ('Volary', 'Czech Republic');
INSERT INTO location VALUES ('Ayapa', 'Honduras');
INSERT INTO location VALUES ('Palhais', 'Portugal');
INSERT INTO location VALUES ('Hōjō', 'Japan');
INSERT INTO location VALUES ('Brant', 'Canada');
INSERT INTO location VALUES ('Đông Thành', 'Vietnam');
INSERT INTO location VALUES ('Caobi', 'China');
INSERT INTO location VALUES ('Mueang Suang', 'Thailand');
INSERT INTO location VALUES ('Huanshan', 'China');
INSERT INTO location VALUES ('Vinež', 'Croatia');
INSERT INTO location VALUES ('Wuxue Shi', 'China');
INSERT INTO location VALUES ('Pokotylivka', 'Ukraine');
INSERT INTO location VALUES ('Kỳ Anh', 'Vietnam');
INSERT INTO location VALUES ('Al Fandaqūmīyah', 'Palestinian Territory');
INSERT INTO location VALUES ('Oslomej', 'Macedonia');
INSERT INTO location VALUES ('Gubuk Daya', 'Indonesia');
INSERT INTO location VALUES ('Khalkhāl', 'Iran');
INSERT INTO location VALUES ('Suicheng', 'China');
INSERT INTO location VALUES ('Altares', 'Portugal');
INSERT INTO location VALUES ('Jaroměř', 'Czech Republic');


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO message VALUES (1, 'fpierce5j@bizjournals.com', 39, '2017-02-18 16:55:09.714617', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (2, 'fpierce5j@bizjournals.com', 39, '2017-02-18 16:55:09.717895', 'Donec ut dolor.');
INSERT INTO message VALUES (3, 'fpierce5j@bizjournals.com', 39, '2017-02-18 16:55:09.719254', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (4, 'fpierce5j@bizjournals.com', 39, '2017-02-18 16:55:09.720581', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO message VALUES (5, 'jreyesc@princeton.edu', 39, '2017-02-18 16:55:09.721858', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO message VALUES (6, 'jreyesc@princeton.edu', 39, '2017-02-18 16:55:09.723114', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (7, 'jreyesc@princeton.edu', 39, '2017-02-18 16:55:09.724407', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (8, 'speters7@google.co.uk', 39, '2017-02-18 16:55:09.725369', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (9, 'speters7@google.co.uk', 39, '2017-02-18 16:55:09.72632', 'Duis mattis egestas metus.');
INSERT INTO message VALUES (10, 'speters7@google.co.uk', 39, '2017-02-18 16:55:09.727277', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (11, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.728221', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (12, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.729165', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
INSERT INTO message VALUES (13, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.730114', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.');
INSERT INTO message VALUES (14, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.731182', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (15, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.732158', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (16, 'halexander2p@washingtonpost.com', 39, '2017-02-18 16:55:09.733104', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO message VALUES (17, 'kcollins3x@myspace.com', 39, '2017-02-18 16:55:09.734053', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (18, 'kcollins3x@myspace.com', 39, '2017-02-18 16:55:09.734997', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.');
INSERT INTO message VALUES (19, 'kcollins3x@myspace.com', 39, '2017-02-18 16:55:09.735948', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (20, 'kcollins3x@myspace.com', 39, '2017-02-18 16:55:09.736909', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (21, 'kcollins3x@myspace.com', 39, '2017-02-18 16:55:09.737854', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (22, 'mcampbell1u@alibaba.com', 31, '2017-02-18 16:55:09.738796', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO message VALUES (23, 'mcampbell1u@alibaba.com', 31, '2017-02-18 16:55:09.739736', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (24, 'mcampbell1u@alibaba.com', 31, '2017-02-18 16:55:09.740706', 'In congue.');
INSERT INTO message VALUES (25, 'mcampbell1u@alibaba.com', 31, '2017-02-18 16:55:09.741644', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (26, 'mcampbell1u@alibaba.com', 31, '2017-02-18 16:55:09.7426', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (27, 'aallen54@indiatimes.com', 31, '2017-02-18 16:55:09.743537', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (28, 'aallen54@indiatimes.com', 31, '2017-02-18 16:55:09.744478', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (29, 'aallen54@indiatimes.com', 31, '2017-02-18 16:55:09.74542', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (30, 'jmarshall58@gmpg.org', 31, '2017-02-18 16:55:09.7464', 'Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (31, 'jmarshall58@gmpg.org', 31, '2017-02-18 16:55:09.747688', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (32, 'jmarshall58@gmpg.org', 31, '2017-02-18 16:55:09.748744', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (33, 'jmarshall58@gmpg.org', 31, '2017-02-18 16:55:09.749788', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (34, 'jharper39@netscape.com', 31, '2017-02-18 16:55:09.750805', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (35, 'jharper39@netscape.com', 31, '2017-02-18 16:55:09.751831', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (36, 'jharper39@netscape.com', 31, '2017-02-18 16:55:09.752855', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (37, 'jfrazier47@who.int', 31, '2017-02-18 16:55:09.753881', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (38, 'jfrazier47@who.int', 31, '2017-02-18 16:55:09.754901', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (39, 'jfrazier47@who.int', 31, '2017-02-18 16:55:09.755923', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (40, 'jfrazier47@who.int', 31, '2017-02-18 16:55:09.756955', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (41, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.75798', 'Sed accumsan felis.');
INSERT INTO message VALUES (42, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.758987', 'Proin risus.');
INSERT INTO message VALUES (43, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.760003', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO message VALUES (44, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.761012', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (45, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.762155', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (46, 'tromero4k@topsy.com', 9, '2017-02-18 16:55:09.763205', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
INSERT INTO message VALUES (47, 'kpierce2i@webnode.com', 9, '2017-02-18 16:55:09.764233', 'In congue.');
INSERT INTO message VALUES (48, 'kpierce2i@webnode.com', 9, '2017-02-18 16:55:09.765238', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (49, 'kpierce2i@webnode.com', 9, '2017-02-18 16:55:09.766255', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
INSERT INTO message VALUES (50, 'twebb42@quantcast.com', 9, '2017-02-18 16:55:09.767276', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (51, 'twebb42@quantcast.com', 9, '2017-02-18 16:55:09.768289', 'Nulla justo.');
INSERT INTO message VALUES (52, 'twebb42@quantcast.com', 9, '2017-02-18 16:55:09.769298', 'Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (53, 'tgomez33@joomla.org', 9, '2017-02-18 16:55:09.770312', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (54, 'tgomez33@joomla.org', 9, '2017-02-18 16:55:09.771328', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (55, 'tgomez33@joomla.org', 9, '2017-02-18 16:55:09.772356', 'Nulla justo.');
INSERT INTO message VALUES (56, 'tgomez33@joomla.org', 9, '2017-02-18 16:55:09.773373', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (57, 'tgomez33@joomla.org', 9, '2017-02-18 16:55:09.774385', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO message VALUES (58, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.778104', 'Donec vitae nisi.');
INSERT INTO message VALUES (59, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.779174', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (60, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.78015', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (61, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.781117', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (62, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.782081', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
INSERT INTO message VALUES (63, 'clittle5i@forbes.com', 9, '2017-02-18 16:55:09.783028', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (64, 'arose56@yandex.ru', 4, '2017-02-18 16:55:09.783971', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (65, 'arose56@yandex.ru', 4, '2017-02-18 16:55:09.784909', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (66, 'arose56@yandex.ru', 4, '2017-02-18 16:55:09.785877', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (67, 'ldiaz2u@umich.edu', 4, '2017-02-18 16:55:09.786819', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (68, 'ldiaz2u@umich.edu', 4, '2017-02-18 16:55:09.787775', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (69, 'ldiaz2u@umich.edu', 4, '2017-02-18 16:55:09.788725', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (70, 'ldiaz2u@umich.edu', 4, '2017-02-18 16:55:09.789677', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (71, 'ldiaz2u@umich.edu', 4, '2017-02-18 16:55:09.792663', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (72, 'rnelson36@addthis.com', 4, '2017-02-18 16:55:09.794298', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (73, 'rnelson36@addthis.com', 4, '2017-02-18 16:55:09.795596', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (74, 'rnelson36@addthis.com', 4, '2017-02-18 16:55:09.797625', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO message VALUES (75, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.798676', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (76, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.799652', 'Nulla justo.');
INSERT INTO message VALUES (77, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.80061', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (78, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.801559', 'In congue.');
INSERT INTO message VALUES (79, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.802513', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (80, 'dporter2k@vinaora.com', 4, '2017-02-18 16:55:09.803452', 'In congue.');
INSERT INTO message VALUES (81, 'bwelch17@list-manage.com', 4, '2017-02-18 16:55:09.8044', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO message VALUES (82, 'bwelch17@list-manage.com', 4, '2017-02-18 16:55:09.805363', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (83, 'bwelch17@list-manage.com', 4, '2017-02-18 16:55:09.806322', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (84, 'cstevens4d@list-manage.com', 11, '2017-02-18 16:55:09.807271', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO message VALUES (85, 'cstevens4d@list-manage.com', 11, '2017-02-18 16:55:09.808216', 'Donec ut dolor.');
INSERT INTO message VALUES (86, 'cstevens4d@list-manage.com', 11, '2017-02-18 16:55:09.809443', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (87, 'jcarter4i@sitemeter.com', 11, '2017-02-18 16:55:09.810695', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (88, 'jcarter4i@sitemeter.com', 11, '2017-02-18 16:55:09.811776', 'Nulla justo.');
INSERT INTO message VALUES (89, 'jcarter4i@sitemeter.com', 11, '2017-02-18 16:55:09.812877', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.');
INSERT INTO message VALUES (90, 'jcarter4i@sitemeter.com', 11, '2017-02-18 16:55:09.813956', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (91, 'jcarter4i@sitemeter.com', 11, '2017-02-18 16:55:09.815025', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO message VALUES (92, 'caustin2e@nih.gov', 11, '2017-02-18 16:55:09.816041', 'Donec vitae nisi.');
INSERT INTO message VALUES (93, 'caustin2e@nih.gov', 11, '2017-02-18 16:55:09.817067', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (94, 'caustin2e@nih.gov', 11, '2017-02-18 16:55:09.818093', 'Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (95, 'caustin2e@nih.gov', 11, '2017-02-18 16:55:09.819104', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (96, 'caustin2e@nih.gov', 11, '2017-02-18 16:55:09.820123', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
INSERT INTO message VALUES (97, 'jstanley3w@census.gov', 11, '2017-02-18 16:55:09.821138', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (98, 'jstanley3w@census.gov', 11, '2017-02-18 16:55:09.822161', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (99, 'jstanley3w@census.gov', 11, '2017-02-18 16:55:09.823177', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO message VALUES (100, 'mmartin2y@gravatar.com', 11, '2017-02-18 16:55:09.824192', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (101, 'mmartin2y@gravatar.com', 11, '2017-02-18 16:55:09.825461', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (102, 'mmartin2y@gravatar.com', 11, '2017-02-18 16:55:09.826476', 'In congue.');
INSERT INTO message VALUES (103, 'mmartin2y@gravatar.com', 11, '2017-02-18 16:55:09.827434', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (104, 'bsanders2s@liveinternet.ru', 12, '2017-02-18 16:55:09.828369', 'Donec ut dolor.');
INSERT INTO message VALUES (105, 'bsanders2s@liveinternet.ru', 12, '2017-02-18 16:55:09.829314', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.');
INSERT INTO message VALUES (106, 'bsanders2s@liveinternet.ru', 12, '2017-02-18 16:55:09.830282', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO message VALUES (107, 'bsanders2s@liveinternet.ru', 12, '2017-02-18 16:55:09.831231', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (108, 'mphillips2g@jigsy.com', 12, '2017-02-18 16:55:09.832182', 'In congue.');
INSERT INTO message VALUES (109, 'mphillips2g@jigsy.com', 12, '2017-02-18 16:55:09.833125', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (110, 'mphillips2g@jigsy.com', 12, '2017-02-18 16:55:09.83406', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO message VALUES (111, 'nnichols1z@twitter.com', 12, '2017-02-18 16:55:09.835002', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (112, 'nnichols1z@twitter.com', 12, '2017-02-18 16:55:09.836028', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (113, 'nnichols1z@twitter.com', 12, '2017-02-18 16:55:09.836967', 'Donec ut dolor.');
INSERT INTO message VALUES (114, 'nnichols1z@twitter.com', 12, '2017-02-18 16:55:09.8379', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (115, 'nnichols1z@twitter.com', 12, '2017-02-18 16:55:09.83883', 'Donec ut dolor.');
INSERT INTO message VALUES (116, 'eromerom@narod.ru', 12, '2017-02-18 16:55:09.83976', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (117, 'eromerom@narod.ru', 12, '2017-02-18 16:55:09.840913', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (118, 'eromerom@narod.ru', 12, '2017-02-18 16:55:09.842165', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO message VALUES (119, 'eromerom@narod.ru', 12, '2017-02-18 16:55:09.843152', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (120, 'eromerom@narod.ru', 12, '2017-02-18 16:55:09.844115', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (121, 'akennedy43@quantcast.com', 12, '2017-02-18 16:55:09.845063', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (122, 'akennedy43@quantcast.com', 12, '2017-02-18 16:55:09.846014', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO message VALUES (123, 'akennedy43@quantcast.com', 12, '2017-02-18 16:55:09.846965', 'In congue.');
INSERT INTO message VALUES (124, 'akennedy43@quantcast.com', 12, '2017-02-18 16:55:09.847912', 'Sed accumsan felis.');
INSERT INTO message VALUES (125, 'akennedy43@quantcast.com', 12, '2017-02-18 16:55:09.848845', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (126, 'jgray15@google.cn', 16, '2017-02-18 16:55:09.849785', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (127, 'jgray15@google.cn', 16, '2017-02-18 16:55:09.850717', 'Donec ut dolor.');
INSERT INTO message VALUES (128, 'jgray15@google.cn', 16, '2017-02-18 16:55:09.851698', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (129, 'jgray15@google.cn', 16, '2017-02-18 16:55:09.852649', 'Proin risus.');
INSERT INTO message VALUES (130, 'drichardson4j@illinois.edu', 16, '2017-02-18 16:55:09.853585', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (131, 'drichardson4j@illinois.edu', 16, '2017-02-18 16:55:09.854523', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (132, 'drichardson4j@illinois.edu', 16, '2017-02-18 16:55:09.855456', 'Donec ut dolor.');
INSERT INTO message VALUES (133, 'drichardson4j@illinois.edu', 16, '2017-02-18 16:55:09.856735', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO message VALUES (134, 'cbailey1d@europa.eu', 16, '2017-02-18 16:55:09.857779', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (135, 'cbailey1d@europa.eu', 16, '2017-02-18 16:55:09.858846', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (136, 'cbailey1d@europa.eu', 16, '2017-02-18 16:55:09.859804', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (137, 'cbailey1d@europa.eu', 16, '2017-02-18 16:55:09.860746', 'Sed accumsan felis.');
INSERT INTO message VALUES (138, 'cbailey1d@europa.eu', 16, '2017-02-18 16:55:09.861681', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (139, 'alarsonp@virginia.edu', 16, '2017-02-18 16:55:09.862627', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (140, 'alarsonp@virginia.edu', 16, '2017-02-18 16:55:09.863557', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO message VALUES (141, 'alarsonp@virginia.edu', 16, '2017-02-18 16:55:09.864484', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (142, 'jhowardq@fema.gov', 16, '2017-02-18 16:55:09.865412', 'Sed accumsan felis.');
INSERT INTO message VALUES (143, 'jhowardq@fema.gov', 16, '2017-02-18 16:55:09.866345', 'Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (144, 'jhowardq@fema.gov', 16, '2017-02-18 16:55:09.867283', 'Quisque ut erat.');
INSERT INTO message VALUES (145, 'jhowardq@fema.gov', 16, '2017-02-18 16:55:09.868211', 'Quisque ut erat.');
INSERT INTO message VALUES (146, 'jhowardq@fema.gov', 16, '2017-02-18 16:55:09.869146', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO message VALUES (147, 'rbanks2a@yandex.ru', 33, '2017-02-18 16:55:09.870078', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO message VALUES (148, 'rbanks2a@yandex.ru', 33, '2017-02-18 16:55:09.871046', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO message VALUES (149, 'rbanks2a@yandex.ru', 33, '2017-02-18 16:55:09.872066', 'Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (150, 'lcollins4b@ocn.ne.jp', 33, '2017-02-18 16:55:09.873023', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (151, 'lcollins4b@ocn.ne.jp', 33, '2017-02-18 16:55:09.873972', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (152, 'lcollins4b@ocn.ne.jp', 33, '2017-02-18 16:55:09.874915', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO message VALUES (153, 'lcollins4b@ocn.ne.jp', 33, '2017-02-18 16:55:09.875851', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (154, 'lcollins4b@ocn.ne.jp', 33, '2017-02-18 16:55:09.876783', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (155, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.877716', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (156, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.878647', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO message VALUES (157, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.879582', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (158, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.880512', 'Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (159, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.88148', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (160, 'ppatterson2v@gmpg.org', 33, '2017-02-18 16:55:09.882423', 'In congue.');
INSERT INTO message VALUES (161, 'awoods3z@cocolog-nifty.com', 33, '2017-02-18 16:55:09.883372', 'Nulla justo.');
INSERT INTO message VALUES (162, 'awoods3z@cocolog-nifty.com', 33, '2017-02-18 16:55:09.884302', 'Donec vitae nisi.');
INSERT INTO message VALUES (163, 'awoods3z@cocolog-nifty.com', 33, '2017-02-18 16:55:09.885236', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO message VALUES (164, 'awoods3z@cocolog-nifty.com', 33, '2017-02-18 16:55:09.886168', 'Donec ut dolor.');
INSERT INTO message VALUES (165, 'gwhite2j@jimdo.com', 33, '2017-02-18 16:55:09.887169', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO message VALUES (166, 'gwhite2j@jimdo.com', 33, '2017-02-18 16:55:09.888142', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO message VALUES (167, 'gwhite2j@jimdo.com', 33, '2017-02-18 16:55:09.889099', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (168, 'gwhite2j@jimdo.com', 33, '2017-02-18 16:55:09.890274', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO message VALUES (169, 'bfernandezb@amazon.de', 24, '2017-02-18 16:55:09.891261', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (170, 'bfernandezb@amazon.de', 24, '2017-02-18 16:55:09.892206', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (171, 'bfernandezb@amazon.de', 24, '2017-02-18 16:55:09.893141', 'Sed accumsan felis.');
INSERT INTO message VALUES (172, 'cfuller1i@wunderground.com', 24, '2017-02-18 16:55:09.894072', 'Quisque ut erat.');
INSERT INTO message VALUES (173, 'cfuller1i@wunderground.com', 24, '2017-02-18 16:55:09.894997', 'Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (174, 'cfuller1i@wunderground.com', 24, '2017-02-18 16:55:09.895941', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (175, 'cfuller1i@wunderground.com', 24, '2017-02-18 16:55:09.896865', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (176, 'cfuller1i@wunderground.com', 24, '2017-02-18 16:55:09.897809', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (177, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.898773', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
INSERT INTO message VALUES (178, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.899723', 'Donec ut dolor.');
INSERT INTO message VALUES (179, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.900654', 'Proin risus.');
INSERT INTO message VALUES (180, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.901591', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (181, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.902536', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (182, 'wwarren5e@digg.com', 24, '2017-02-18 16:55:09.903745', 'In congue.');
INSERT INTO message VALUES (183, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.904799', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (184, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.905879', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO message VALUES (185, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.906924', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (186, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.907964', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO message VALUES (187, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.908997', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (188, 'esmith3@squidoo.com', 24, '2017-02-18 16:55:09.909994', 'Donec ut dolor.');
INSERT INTO message VALUES (189, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.911002', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (190, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.912008', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
INSERT INTO message VALUES (191, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.913036', 'Nullam molestie nibh in lectus.');
INSERT INTO message VALUES (192, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.914036', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (193, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.915037', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO message VALUES (194, 'gporter3v@dailymail.co.uk', 24, '2017-02-18 16:55:09.916026', 'Duis mattis egestas metus.');
INSERT INTO message VALUES (195, 'bwest5g@tamu.edu', 3, '2017-02-18 16:55:09.917025', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO message VALUES (196, 'bwest5g@tamu.edu', 3, '2017-02-18 16:55:09.918178', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (197, 'bwest5g@tamu.edu', 3, '2017-02-18 16:55:09.919246', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
INSERT INTO message VALUES (198, 'bwest5g@tamu.edu', 3, '2017-02-18 16:55:09.920251', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
INSERT INTO message VALUES (199, 'bwest5g@tamu.edu', 3, '2017-02-18 16:55:09.921259', 'Donec vitae nisi.');
INSERT INTO message VALUES (200, 'hbutler41@mozilla.org', 3, '2017-02-18 16:55:09.922285', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (201, 'hbutler41@mozilla.org', 3, '2017-02-18 16:55:09.923294', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (202, 'hbutler41@mozilla.org', 3, '2017-02-18 16:55:09.924305', 'Donec ut dolor.');
INSERT INTO message VALUES (203, 'hbutler41@mozilla.org', 3, '2017-02-18 16:55:09.925312', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (204, 'hbutler41@mozilla.org', 3, '2017-02-18 16:55:09.926316', 'Donec ut dolor.');
INSERT INTO message VALUES (205, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.927321', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
INSERT INTO message VALUES (206, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.928324', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO message VALUES (207, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.929317', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
INSERT INTO message VALUES (208, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.930319', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (209, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.931326', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO message VALUES (210, 'jspencer4n@shop-pro.jp', 3, '2017-02-18 16:55:09.932363', 'Duis mattis egestas metus.');
INSERT INTO message VALUES (211, 'randrews49@uol.com.br', 3, '2017-02-18 16:55:09.933361', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (212, 'randrews49@uol.com.br', 3, '2017-02-18 16:55:09.93441', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.');
INSERT INTO message VALUES (213, 'randrews49@uol.com.br', 3, '2017-02-18 16:55:09.935422', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO message VALUES (214, 'melliottz@g.co', 3, '2017-02-18 16:55:09.936425', 'Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO message VALUES (215, 'melliottz@g.co', 3, '2017-02-18 16:55:09.937436', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO message VALUES (216, 'melliottz@g.co', 3, '2017-02-18 16:55:09.938443', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO message VALUES (217, 'melliottz@g.co', 3, '2017-02-18 16:55:09.93945', 'Vestibulum rutrum rutrum neque.');
INSERT INTO message VALUES (218, 'melliottz@g.co', 3, '2017-02-18 16:55:09.940453', 'Aliquam quis turpis eget elit sodales scelerisque.');


--
-- Name: message_convo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('message_convo_id_seq', 1, false);


--
-- Name: message_msg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('message_msg_id_seq', 218, true);


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO organization VALUES (1, 'Herzog-Kihn', 'Sharable interactive alliance', '351-(649)992-0240', '367 Roxbury Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (2, 'DuBuque-Botsford', 'Organic multi-state architecture', '86-(663)842-0330', '9 Division Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (3, 'Hoppe-Strosin', 'Enhanced exuding time-frame', '62-(630)973-5928', '243 Melby Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (4, 'Nader-Effertz', 'Grass-roots needs-based matrices', '46-(298)227-2430', '31 Manufacturers Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (5, 'Borer Inc', 'Multi-lateral needs-based challenge', '420-(678)792-9653', '503 Bluestem Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (6, 'Krajcik, Grant and Champlin', 'Multi-lateral holistic initiative', '962-(373)309-0978', '98 Sage Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (7, 'Torp, Simonis and Blanda', 'Extended optimizing open architecture', '351-(557)947-3373', '2566 Garrison Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (8, 'Aufderhar LLC', 'Front-line multi-state local area network', '972-(471)230-7127', '5035 Kim Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (9, 'Heathcote-Kuhn', 'Quality-focused 6th generation success', '63-(877)173-6990', '06 Towne Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (10, 'Marvin and Sons', 'Synergistic tertiary website', '86-(440)532-8452', '59338 Pond Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (11, 'Harber Group', 'Organic non-volatile archive', '420-(186)212-8637', '34973 Kingsford Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (12, 'Wuckert-Little', 'Profit-focused eco-centric help-desk', '84-(348)212-7539', '69493 Myrtle Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (13, 'Gusikowski, Kuhic and Dooley', 'Compatible 5th generation contingency', '86-(140)477-2811', '49 Rigney Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (14, 'Erdman, Hagenes and Hagenes', 'User-friendly client-server access', '30-(518)524-6509', '0824 Dryden Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (15, 'Kuhic-McClure', 'Synergistic methodical internet solution', '212-(130)252-5684', '15 Valley Edge Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (16, 'Hamill-Gorczany', 'Reactive uniform challenge', '57-(747)797-4071', '5047 Milwaukee Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (17, 'Douglas-Shields', 'Managed scalable process improvement', '62-(432)252-1636', '6199 Monica Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (18, 'Hyatt Inc', 'Exclusive homogeneous standardization', '380-(657)418-2594', '3 Northridge Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (19, 'Yost Group', 'Optional leading edge attitude', '86-(464)924-7470', '7 Stang Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (20, 'Schmitt-Hills', 'Realigned contextually-based product', '33-(946)307-9536', '98661 Merrick Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (21, 'Douglas and Sons', 'Profit-focused empowering model', '1-(253)411-5724', '7 Little Fleur Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (22, 'Kertzmann-Oberbrunner', 'Digitized responsive algorithm', '63-(670)540-2416', '68536 Helena Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (23, 'Eichmann, Wehner and Ritchie', 'Horizontal fresh-thinking ability', '86-(725)624-3130', '1 Larry Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (24, 'Little Group', 'Reactive interactive workforce', '86-(544)496-0896', '945 Carpenter Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (25, 'Bailey LLC', 'Monitored interactive encryption', '1-(212)956-2180', '131 Fairfield Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (26, 'Lockman-Considine', 'Organized homogeneous algorithm', '54-(491)566-3198', '7920 Killdeer Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (27, 'Runolfsson, Roberts and Schmidt', 'Self-enabling homogeneous ability', '216-(846)203-6824', '94968 Cottonwood Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (28, 'Homenick LLC', 'Re-contextualized dynamic encryption', '86-(529)604-8447', '27129 Shelley Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (29, 'Rempel-Bogisich', 'Mandatory full-range conglomeration', '86-(973)356-0827', '5 Union Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (30, 'Cremin Group', 'Up-sized disintermediate productivity', '46-(142)426-7477', '848 Thierer Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (31, 'Borer LLC', 'Total bottom-line focus group', '503-(483)297-2880', '3699 Goodland Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (32, 'Kassulke and Sons', 'User-friendly local challenge', '60-(904)754-3377', '2007 Ronald Regan Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (33, 'Monahan and Sons', 'Public-key well-modulated Graphical User Interface', '48-(382)574-5321', '20 Longview Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (34, 'Hoeger, Cummings and Berge', 'Re-contextualized methodical installation', '54-(984)681-5931', '444 Norway Maple Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (35, 'Orn, Roob and Erdman', 'Distributed didactic matrix', '57-(450)548-3933', '8 Utah Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (36, 'Harvey and Sons', 'Future-proofed non-volatile customer loyalty', '998-(491)433-3087', '862 Claremont Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (37, 'Mertz, Anderson and Rolfson', 'Multi-channelled local function', '387-(492)122-2923', '1 Melody Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (38, 'Daniel, Krajcik and Marquardt', 'Multi-layered holistic utilisation', '976-(165)997-9893', '57 Surrey Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (39, 'Dach Group', 'Synergistic web-enabled paradigm', '351-(415)368-1504', '1075 Pawling Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (40, 'Ryan-Lakin', 'Face to face non-volatile groupware', '86-(737)841-7115', '254 Morning Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (41, 'Harvey-Mann', 'Organic executive service-desk', '7-(409)929-8841', '579 Lakewood Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (42, 'Koepp Group', 'Digitized reciprocal customer loyalty', '81-(348)223-7405', '81155 Chinook Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (43, 'Roberts LLC', 'Total 5th generation model', '375-(577)311-8355', '9754 Vermont Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (44, 'Pollich Inc', 'Upgradable system-worthy concept', '86-(660)131-5477', '56281 2nd Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (45, 'Tremblay Inc', 'Synchronised zero defect knowledge base', '1-(253)296-1525', '97 Crownhardt Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (46, 'Carter-Walsh', 'Digitized logistical database', '62-(441)487-0516', '26 2nd Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (47, 'Parisian Group', 'Team-oriented multi-state initiative', '506-(226)764-7966', '6928 Mifflin Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (48, 'Balistreri LLC', 'Mandatory local intranet', '55-(384)759-0373', '595 Northland Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (49, 'Pouros-Collier', 'Cloned local analyzer', '86-(808)106-0245', '8228 Mitchell Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (50, 'Bruen and Sons', 'Business-focused 4th generation encryption', '86-(974)589-4423', '82 Onsgard Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (51, 'Pfannerstill, Runolfsdottir and Rolfson', 'Programmable fresh-thinking attitude', '62-(691)214-4277', '8828 Gina Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (52, 'Heathcote Inc', 'Up-sized homogeneous help-desk', '86-(239)686-4181', '4 Toban Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (53, 'Sporer Group', 'Reactive bottom-line capability', '55-(329)142-4738', '28 Hanson Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (54, 'Sporer and Sons', 'Quality-focused tertiary throughput', '86-(438)426-3910', '5 Hermina Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (55, 'Sanford, Harber and Towne', 'Face to face bi-directional open system', '62-(300)232-8766', '6141 Golf Course Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (56, 'Casper, Thiel and Nader', 'Future-proofed holistic monitoring', '86-(366)563-2256', '3944 Parkside Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (57, 'Pagac, Bergnaum and Luettgen', 'Future-proofed next generation groupware', '81-(176)877-1960', '573 Buell Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (58, 'Ullrich LLC', 'Monitored tertiary application', '1-(559)903-8562', '19638 Maple Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (59, 'Becker-Langworth', 'Future-proofed local instruction set', '86-(496)213-0410', '29798 Browning Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (60, 'Oberbrunner Inc', 'Optimized bandwidth-monitored website', '63-(147)817-9576', '537 Kim Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (61, 'MacGyver-Gulgowski', 'Multi-channelled hybrid data-warehouse', '212-(750)641-8387', '820 Lake View Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (62, 'Hegmann, Zieme and Hessel', 'Customer-focused incremental utilisation', '86-(803)557-1159', '1742 Veith Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (63, 'Kulas, Stoltenberg and Johnson', 'Multi-tiered global concept', '62-(241)159-1097', '294 Manley Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (64, 'Davis and Sons', 'Fundamental holistic firmware', '351-(524)901-6039', '0373 Dawn Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (65, 'Kris-Ferry', 'Universal zero administration hardware', '86-(135)759-7328', '9 Golf View Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (66, 'Doyle and Sons', 'Proactive contextually-based initiative', '81-(136)608-6071', '949 Sachtjen Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (67, 'Will Inc', 'Reduced real-time firmware', '62-(173)283-1587', '19 East Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (68, 'Hodkiewicz Inc', 'Up-sized dynamic customer loyalty', '63-(386)772-3026', '6 Nevada Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (69, 'Hirthe, Torp and Jones', 'Distributed scalable definition', '62-(790)660-1444', '96 Norway Maple Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (70, 'Barrows Group', 'Automated executive service-desk', '351-(314)247-2911', '2399 Canary Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (71, 'Welch Inc', 'Future-proofed context-sensitive projection', '86-(673)240-1407', '20376 Farmco Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (72, 'Hane-Heidenreich', 'Organized full-range focus group', '351-(444)279-5804', '1855 Main Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (73, 'Kuphal and Sons', 'Right-sized radical access', '62-(871)365-8755', '26488 Di Loreto Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (74, 'Murray-White', 'Adaptive 5th generation internet solution', '56-(963)534-8385', '2653 Kensington Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (75, 'Nolan, Davis and Kunze', 'Enhanced optimizing challenge', '86-(120)860-6344', '39579 Nevada Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (76, 'Langosh Inc', 'Implemented optimizing data-warehouse', '86-(204)993-5780', '767 Bluejay Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (77, 'Schinner-White', 'Future-proofed web-enabled framework', '1-(914)395-2857', '146 Mallard Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (78, 'Kilback, Lueilwitz and Morar', 'Virtual executive circuit', '63-(409)519-4064', '367 Tennessee Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (79, 'Zboncak, Ebert and Nicolas', 'Automated well-modulated firmware', '86-(686)849-4616', '433 Mallory Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (80, 'Crooks-Predovic', 'Persevering zero tolerance firmware', '86-(525)287-6836', '88098 Veith Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (81, 'Kessler, Runolfsdottir and Walker', 'Ameliorated dedicated service-desk', '7-(229)126-9953', '4373 Tomscot Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (82, 'Koelpin-Lockman', 'Optimized real-time software', '62-(392)517-2543', '133 Nancy Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (83, 'Connelly-Osinski', 'Open-source background framework', '58-(798)725-5238', '4849 New Castle Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (84, 'Hickle Group', 'Synergized bi-directional benchmark', '380-(185)137-6590', '48 Prentice Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (85, 'Parisian LLC', 'Innovative uniform service-desk', '595-(260)732-0205', '76976 Moose Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (86, 'Kshlerin, Olson and Schulist', 'Future-proofed web-enabled attitude', '234-(350)515-3378', '0 Chinook Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (87, 'Parisian, Stark and Blanda', 'Streamlined object-oriented support', '380-(124)316-2793', '3892 Kim Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (88, 'Wuckert-Carter', 'Operative empowering policy', '380-(906)807-9458', '47 Corry Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (89, 'Kreiger, Ortiz and Weimann', 'Networked logistical focus group', '62-(824)205-1287', '35 Huxley Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (90, 'Howell LLC', 'Switchable impactful access', '55-(980)448-0526', '78 Pawling Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (91, 'Schoen Inc', 'Profit-focused upward-trending analyzer', '86-(874)440-8316', '6 Corry Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (92, 'Brekke and Sons', 'Enhanced multi-state synergy', '55-(761)536-6164', '70673 Old Shore Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (93, 'Schiller Group', 'Multi-lateral real-time adapter', '55-(328)377-0734', '040 Mallory Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (94, 'Harris, Bosco and Zieme', 'Customizable bottom-line function', '353-(438)672-5671', '2 Pond Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (95, 'Klocko, Nolan and Ebert', 'Multi-layered motivating productivity', '374-(960)765-6571', '5452 Lien Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (96, 'Batz-Wehner', 'Operative dedicated circuit', '62-(716)152-2711', '127 Nobel Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (97, 'Turner, Flatley and Mueller', 'Grass-roots fresh-thinking intranet', '255-(141)405-5592', '4879 Prentice Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (98, 'Turner-Reichel', 'De-engineered directional secured line', '54-(653)731-1249', '613 Village Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (99, 'Howe, Wilkinson and Medhurst', 'Intuitive client-server leverage', '86-(542)253-2536', '9 Prairie Rose Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (100, 'Chalmers University of Technology', 'generate best-of-breed infomediaries', '86-(980)548-5182', '5 Meadow Valley Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (101, 'Université Abou Bekr Belkaid, Tlemcen', 'scale world-class paradigms', '976-(418)883-3046', '33 Holmberg Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (102, 'California State University, Fullerton', 'iterate compelling vortals', '92-(327)688-5602', '43 Crescent Oaks Court', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (103, 'Nagoya City University', 'innovate vertical web services', '48-(822)991-0245', '10 Lake View Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (104, 'Agricultural University of Cracow', 'benchmark out-of-the-box functionalities', '30-(867)711-2546', '0 Donald Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (105, 'Armstrong University', 'embrace global platforms', '33-(792)305-3295', '539 Merrick Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (106, 'Wittenborg University', 'streamline innovative e-services', '55-(498)189-3689', '2 Springs Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (107, 'Sekolah Tinggi Akuntansi Negara (STAN)', 'integrate out-of-the-box bandwidth', '7-(270)211-7305', '2 Forest Dale Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (108, 'Trinity International University', 'implement intuitive channels', '86-(440)203-8972', '45 Oak Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (109, 'Science University of Tokyo', 'integrate dot-com content', '27-(607)461-5150', '18283 Mariners Cove Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (110, 'Universidad Nacional de Rosario', 'innovate transparent functionalities', '420-(654)440-1703', '81238 Florence Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (111, 'University College of Nabi Akram', 'leverage robust solutions', '33-(351)104-5414', '7 Valley Edge Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (112, 'Ashikaga Institute of Technology', 'optimize next-generation models', '63-(802)530-9478', '0 Hayes Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (113, 'Universidad Central Dominicana de Estudio Profesionales', 'implement sticky e-business', '351-(612)888-3457', '90128 Hollow Ridge Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (114, 'Moscow State University M.V. Lomonosov', 'synergize sticky paradigms', '351-(441)109-6335', '36016 Arizona Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (115, 'Universidad Adventista de Chile', 'evolve front-end e-services', '237-(653)439-7253', '0 Springview Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (116, 'Pädagogische Hochschule Erfurt/Mühlhausen', 'seize e-business partnerships', '48-(945)613-8157', '8597 Oneill Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (117, 'Universidade Federal de Juiz de Fora', 'engage leading-edge infomediaries', '51-(899)358-1624', '11 Oak Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (118, 'Lakehead University', 'revolutionize 24/7 web services', '27-(624)985-2870', '93416 Meadow Ridge Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (119, 'Douglas College', 'embrace transparent metrics', '55-(137)929-3060', '8014 Vernon Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (120, 'Bengal Engineering College', 'expedite 24/7 e-tailers', '1-(253)542-5537', '23 Farwell Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (121, 'Philippine Military Academy', 'synthesize distributed vortals', '351-(143)954-6286', '355 Starling Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (122, 'Gombe State University', 'unleash world-class vortals', '62-(661)715-8825', '9 Hoffman Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (123, 'Hirosaki Gakuin University', 'implement world-class networks', '355-(998)282-9567', '85613 Ridge Oak Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (124, 'Universidad de Hermosillo', 'brand customized e-markets', '86-(624)248-4825', '977 Bay Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (125, 'Hebrew University of Jerusalem', 'monetize best-of-breed web services', '7-(274)323-1676', '9591 Springs Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (126, 'Loyola College in Maryland', 'synthesize next-generation content', '93-(190)645-9159', '717 Brentwood Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (127, 'Universidad Técnica de Ambato', 'envisioneer magnetic channels', '374-(843)793-7409', '52 Eagan Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (128, 'University of Swaziland', 'grow B2B interfaces', '86-(113)261-5809', '22 Welch Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (129, 'Technische Universität Bergakademie Freiberg', 'deliver world-class action-items', '86-(125)274-4090', '6969 David Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (130, 'Stanford University', 'recontextualize customized experiences', '351-(137)695-6097', '664 Redwing Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (131, 'Institut National des Sciences Appliquées de Toulouse', 'aggregate real-time mindshare', '55-(833)546-7160', '3854 Dwight Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (132, 'American University Extension, Okinawa', 'empower turn-key initiatives', '244-(393)504-4243', '90015 Morningstar Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (133, 'National Institute of Technology Kurukshetra', 'leverage strategic web services', '7-(117)325-5217', '74 Beilfuss Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (134, 'Institut National Polytechnique de Grenoble', 'productize leading-edge infrastructures', '62-(543)802-5225', '317 Hanover Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (135, 'Guangxi University', 'enhance customized models', '1-(752)734-8969', '5 Redwing Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (136, 'Instituto Universitario de Ciencias de la Salud Fundación H.A. Barceló', 'reinvent B2C supply-chains', '48-(253)411-4886', '1439 Hagan Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (137, 'International University of Health and Welfare', 'scale mission-critical functionalities', '1-(915)240-4366', '6504 Green Ridge Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (138, 'Ballsbridge University ', 'leverage viral schemas', '351-(138)691-2436', '32189 Steensland Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (139, 'Universität Bayreuth', 'embrace turn-key eyeballs', '256-(724)152-0055', '235 Rusk Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (140, 'Adamson University', 'transition front-end communities', '1-(816)645-3444', '446 David Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (141, 'Meru University of Science and Technology', 'implement back-end web services', '86-(651)413-3443', '46494 Russell Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (142, 'Mohammad Ali Jinnah University, Karachi', 'scale magnetic networks', '880-(181)185-0911', '94721 Pankratz Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (143, 'University of the West of England, Bristol', 'harness efficient action-items', '7-(936)531-8571', '9 Gulseth Junction', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (144, 'Shanghai Second Polytechnic University', 'disintermediate scalable schemas', '55-(675)406-2444', '74785 Tennyson Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (145, 'Toyo University', 'expedite killer e-services', '62-(642)999-8051', '1538 Bluejay Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (146, 'Temple University Japan', 'envisioneer best-of-breed niches', '84-(174)248-5901', '64930 Canary Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (147, 'American University of Antigua', 'expedite distributed initiatives', '33-(284)325-4738', '945 Moland Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (148, 'Sardar Vallabhai Patel University of Agriculture Amd Technology', 'syndicate 24/7 action-items', '7-(142)401-1392', '4357 Shasta Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (149, 'Emeq Yizrael College', 'strategize collaborative e-services', '234-(588)729-5552', '727 Summerview Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (150, 'Oklahoma State University - Oklahoma City', 'synergize distributed solutions', '86-(679)103-3558', '4301 Gulseth Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (151, 'Ahfad University for Women', 'reinvent B2C models', '55-(521)408-5567', '1211 Division Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (152, 'Seoul National University', 'seize sexy users', '502-(767)391-6505', '85 Evergreen Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (153, 'Nizhny Novgorod State Architectural - Building University', 'whiteboard front-end applications', '351-(497)205-1534', '10614 Corry Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (154, 'University of Toronto', 'incentivize proactive eyeballs', '86-(261)970-3196', '1539 Northwestern Place', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (155, 'University of Medicine and Pharmacy of Cluj-Napoca', 'engineer cutting-edge paradigms', '53-(351)646-1946', '5 Lukken Center', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (156, 'Islamic Azad University, Tabriz', 'unleash leading-edge mindshare', '48-(666)612-6101', '4 Oxford Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (157, 'Facultés Universitaires Catholiques de Mons', 'integrate dot-com platforms', '86-(634)592-5990', '9 Texas Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (158, 'Babcock University', 'target e-business portals', '63-(741)165-5915', '354 Moulton Trail', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (159, 'Viterbo State University', 'drive wireless models', '86-(474)852-7146', '51047 Buhler Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (160, 'Universidad Adventista de Colombia', 'morph world-class networks', '7-(425)440-8697', '90 Golf Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (161, 'Universidad de La Rioja', 'engineer revolutionary e-markets', '63-(871)525-0720', '01 Everett Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (162, 'SASTRA Deemed University', 'seize strategic infrastructures', '251-(829)302-7592', '8 Ohio Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (163, 'Universidad Andina Simón Bolivar', 'reinvent turn-key interfaces', '60-(389)313-9379', '69 Grayhawk Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (164, 'Murmansk State Technical University', 'redefine cross-platform markets', '7-(402)810-8936', '600 Erie Lane', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (165, 'University of Cebu', 'engineer impactful convergence', '420-(440)512-8928', '4 Schurz Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (166, 'The University of Nottingham Ningbo China', 'e-enable viral e-commerce', '63-(134)156-6514', '4 Calypso Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (167, 'Harare Institute of Technology', 'mesh sexy networks', '86-(907)855-3460', '5 1st Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (168, 'Oulu Polytechnic', 'innovate vertical e-tailers', '66-(947)928-5514', '6742 Cottonwood Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (169, 'University of Gloucestershire', 'incentivize killer users', '86-(268)551-0516', '96 Utah Drive', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (170, 'Daiichi College of Pharmaceutical Sciences', 'incentivize next-generation ROI', '420-(484)317-0304', '917 Kings Parkway', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (171, 'Université de Toulouse', 'embrace front-end systems', '86-(658)832-9233', '3 West Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (172, 'Yangzhou University', 'productize frictionless channels', '60-(422)279-2690', '3 Oxford Hill', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (173, 'Wudanshan Taoist College ', 'embrace out-of-the-box ROI', '57-(480)688-9227', '3 Anderson Plaza', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (174, 'Abilene Christian University', 'generate B2C bandwidth', '62-(813)157-0993', '599 Burning Wood Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (175, 'Saskatchewan Indian Federated College', 'orchestrate ubiquitous methodologies', '86-(992)786-3769', '90 Linden Park', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (176, 'Millennia Atlantic University', 'facilitate revolutionary initiatives', '380-(907)926-3582', '35099 Hollow Ridge Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (177, 'Universidad de El Salvador', 'monetize plug-and-play web-readiness', '86-(495)128-7743', '043 6th Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (178, 'Christian-Albrechts-Universität Kiel', 'benchmark cross-platform schemas', '86-(720)131-5408', '2991 Leroy Crossing', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (179, 'Kaunas Medical Academy', 'extend extensible interfaces', '86-(760)378-1859', '6218 5th Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (180, 'Columbia Southern University', 'morph revolutionary mindshare', '221-(605)175-6460', '573 Kingsford Pass', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (181, 'Instituto Superior de Ciênicas e Tecnologia de Moçambique', 'synergize out-of-the-box mindshare', '1-(525)599-2538', '069 Derek Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (182, 'Kwansei Gakuin University', 'reintermediate synergistic communities', '66-(248)441-4161', '5996 Katie Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (183, 'Pittsburg State University', 'transform open-source systems', '86-(214)292-2930', '67625 Doe Crossing Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (184, 'University of Missouri - Kansas City', 'utilize web-enabled systems', '63-(348)182-7586', '28 Laurel Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (185, 'Universidad Nacional José Faustino Sánchez Carrión', 'matrix web-enabled e-markets', '48-(129)305-7437', '3 Continental Point', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (186, 'Erciyes University', 'brand holistic infomediaries', '86-(546)542-9266', '16853 Monica Alley', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (187, 'Universidad de Montemorelos', 'matrix compelling e-services', '381-(274)745-1740', '0 Surrey Avenue', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (188, 'Renmin University of China', 'enable 24/7 supply-chains', '48-(195)294-0238', '47 Mockingbird Street', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (189, 'University of Dodoma', 'empower dot-com channels', '1-(842)910-6001', '0774 Union Circle', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (190, 'Shahputra College', 'synergize collaborative markets', '51-(766)589-2337', '22 Raven Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (191, 'De La Salle University', 'productize frictionless models', '218-(832)702-9858', '097 Tennessee Road', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (192, 'Technological Education Institute of Mesologgi', 'incentivize one-to-one platforms', '7-(595)301-4193', '1409 Southridge Terrace', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (193, 'Suzuka University of Medical Science', 'deliver sticky systems', '53-(533)341-1096', '3 Forest Run Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (194, 'Universidad de San Andres', 'morph leading-edge partnerships', '33-(404)585-8433', '1 Rowland Way', 'Đông Thành', 'Vietnam');
INSERT INTO organization VALUES (195, 'Islamic Azad University, Mahshar', 'visualize scalable infrastructures', '30-(489)236-4514', '6088 Jay Pass', 'Đông Thành', 'Vietnam');


--
-- Name: organization_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organization_org_id_seq', 195, true);


--
-- Data for Name: partof; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO partof VALUES ('rbrooks2x@joomla.org', 1);
INSERT INTO partof VALUES ('speterson3n@geocities.com', 1);
INSERT INTO partof VALUES ('bdean55@go.com', 1);
INSERT INTO partof VALUES ('jfox3h@businessinsider.com', 1);
INSERT INTO partof VALUES ('jstevens25@theglobeandmail.com', 1);
INSERT INTO partof VALUES ('jarmstrong2c@uiuc.edu', 2);
INSERT INTO partof VALUES ('tprice27@discovery.com', 2);
INSERT INTO partof VALUES ('ecox1m@eventbrite.com', 2);
INSERT INTO partof VALUES ('fkennedy22@ow.ly', 2);
INSERT INTO partof VALUES ('jgonzalez3g@google.com.au', 2);
INSERT INTO partof VALUES ('bwest5g@tamu.edu', 3);
INSERT INTO partof VALUES ('hbutler41@mozilla.org', 3);
INSERT INTO partof VALUES ('jspencer4n@shop-pro.jp', 3);
INSERT INTO partof VALUES ('randrews49@uol.com.br', 3);
INSERT INTO partof VALUES ('melliottz@g.co', 3);
INSERT INTO partof VALUES ('arose56@yandex.ru', 4);
INSERT INTO partof VALUES ('ldiaz2u@umich.edu', 4);
INSERT INTO partof VALUES ('rnelson36@addthis.com', 4);
INSERT INTO partof VALUES ('dporter2k@vinaora.com', 4);
INSERT INTO partof VALUES ('bwelch17@list-manage.com', 4);
INSERT INTO partof VALUES ('crice51@163.com', 5);
INSERT INTO partof VALUES ('nsullivano@google.co.jp', 5);
INSERT INTO partof VALUES ('lmedina4@washington.edu', 5);
INSERT INTO partof VALUES ('kross3j@ow.ly', 5);
INSERT INTO partof VALUES ('kbennett1g@reuters.com', 5);
INSERT INTO partof VALUES ('sthompson1x@cafepress.com', 6);
INSERT INTO partof VALUES ('tbryant4o@reddit.com', 6);
INSERT INTO partof VALUES ('aromero19@fastcompany.com', 6);
INSERT INTO partof VALUES ('jsimpson3a@microsoft.com', 6);
INSERT INTO partof VALUES ('mnichols5a@yellowpages.com', 6);
INSERT INTO partof VALUES ('fpeterson21@wordpress.com', 7);
INSERT INTO partof VALUES ('ewright1h@wordpress.com', 7);
INSERT INTO partof VALUES ('jwillis48@acquirethisname.com', 7);
INSERT INTO partof VALUES ('jtorres4c@youtube.com', 7);
INSERT INTO partof VALUES ('csimmons4q@mashable.com', 7);
INSERT INTO partof VALUES ('lreyes1n@theglobeandmail.com', 8);
INSERT INTO partof VALUES ('gjames50@woothemes.com', 8);
INSERT INTO partof VALUES ('jporter1s@mapy.cz', 8);
INSERT INTO partof VALUES ('ccruz8@geocities.com', 8);
INSERT INTO partof VALUES ('clopez3d@ebay.com', 8);
INSERT INTO partof VALUES ('tromero4k@topsy.com', 9);
INSERT INTO partof VALUES ('kpierce2i@webnode.com', 9);
INSERT INTO partof VALUES ('twebb42@quantcast.com', 9);
INSERT INTO partof VALUES ('tgomez33@joomla.org', 9);
INSERT INTO partof VALUES ('clittle5i@forbes.com', 9);
INSERT INTO partof VALUES ('mkelly5f@google.com.br', 10);
INSERT INTO partof VALUES ('clane1b@cocolog-nifty.com', 10);
INSERT INTO partof VALUES ('dstanley1p@deliciousdays.com', 10);
INSERT INTO partof VALUES ('ksanders40@rediff.com', 10);
INSERT INTO partof VALUES ('pwhite4s@about.me', 10);
INSERT INTO partof VALUES ('cstevens4d@list-manage.com', 11);
INSERT INTO partof VALUES ('jcarter4i@sitemeter.com', 11);
INSERT INTO partof VALUES ('caustin2e@nih.gov', 11);
INSERT INTO partof VALUES ('jstanley3w@census.gov', 11);
INSERT INTO partof VALUES ('mmartin2y@gravatar.com', 11);
INSERT INTO partof VALUES ('bsanders2s@liveinternet.ru', 12);
INSERT INTO partof VALUES ('mphillips2g@jigsy.com', 12);
INSERT INTO partof VALUES ('nnichols1z@twitter.com', 12);
INSERT INTO partof VALUES ('eromerom@narod.ru', 12);
INSERT INTO partof VALUES ('akennedy43@quantcast.com', 12);
INSERT INTO partof VALUES ('tjames2l@salon.com', 13);
INSERT INTO partof VALUES ('csmith4z@addtoany.com', 13);
INSERT INTO partof VALUES ('jromerol@hexun.com', 13);
INSERT INTO partof VALUES ('rreid5d@sourceforge.net', 13);
INSERT INTO partof VALUES ('cbarnes1t@is.gd', 13);
INSERT INTO partof VALUES ('jwhite3t@instagram.com', 14);
INSERT INTO partof VALUES ('eperez16@homestead.com', 14);
INSERT INTO partof VALUES ('jtaylor53@topsy.com', 14);
INSERT INTO partof VALUES ('fstanley31@opera.com', 14);
INSERT INTO partof VALUES ('sday1w@bloglovin.com', 14);
INSERT INTO partof VALUES ('apeters5b@craigslist.org', 15);
INSERT INTO partof VALUES ('rblack4w@networksolutions.com', 15);
INSERT INTO partof VALUES ('jscott14@dyndns.org', 15);
INSERT INTO partof VALUES ('slopez3p@nature.com', 15);
INSERT INTO partof VALUES ('blane1k@imageshack.us', 15);
INSERT INTO partof VALUES ('jgray15@google.cn', 16);
INSERT INTO partof VALUES ('drichardson4j@illinois.edu', 16);
INSERT INTO partof VALUES ('cbailey1d@europa.eu', 16);
INSERT INTO partof VALUES ('alarsonp@virginia.edu', 16);
INSERT INTO partof VALUES ('jhowardq@fema.gov', 16);
INSERT INTO partof VALUES ('ssimpson4y@netscape.com', 17);
INSERT INTO partof VALUES ('jmartinez4l@pagesperso-orange.fr', 17);
INSERT INTO partof VALUES ('rgriffin2r@businessinsider.com', 17);
INSERT INTO partof VALUES ('mhunter1o@smh.com.au', 17);
INSERT INTO partof VALUES ('cmyers3q@about.com', 17);
INSERT INTO partof VALUES ('nhudsonj@discovery.com', 18);
INSERT INTO partof VALUES ('rmartinez1q@blog.com', 18);
INSERT INTO partof VALUES ('apatterson2b@infoseek.co.jp', 18);
INSERT INTO partof VALUES ('rcrawford2f@istockphoto.com', 18);
INSERT INTO partof VALUES ('dmendoza45@jiathis.com', 18);
INSERT INTO partof VALUES ('kbakere@mit.edu', 19);
INSERT INTO partof VALUES ('wkim3y@usgs.gov', 19);
INSERT INTO partof VALUES ('dsmith4x@twitpic.com', 19);
INSERT INTO partof VALUES ('tkim2d@blogs.com', 19);
INSERT INTO partof VALUES ('phoward6@boston.com', 19);
INSERT INTO partof VALUES ('lhill1y@mayoclinic.com', 20);
INSERT INTO partof VALUES ('tsnyder4a@live.com', 20);
INSERT INTO partof VALUES ('schavezk@devhub.com', 20);
INSERT INTO partof VALUES ('agilbert4r@hud.gov', 20);
INSERT INTO partof VALUES ('rjordant@1688.com', 20);
INSERT INTO partof VALUES ('mrussell9@macromedia.com', 21);
INSERT INTO partof VALUES ('ahenderson4u@reverbnation.com', 21);
INSERT INTO partof VALUES ('kmoreno4v@multiply.com', 21);
INSERT INTO partof VALUES ('eking3i@homestead.com', 21);
INSERT INTO partof VALUES ('jjenkins24@squidoo.com', 21);
INSERT INTO partof VALUES ('charrison59@answers.com', 22);
INSERT INTO partof VALUES ('egutierrezv@comcast.net', 22);
INSERT INTO partof VALUES ('jgibson4m@hc360.com', 22);
INSERT INTO partof VALUES ('swashingtonh@jiathis.com', 22);
INSERT INTO partof VALUES ('pparker1a@engadget.com', 22);
INSERT INTO partof VALUES ('thicks57@github.com', 23);
INSERT INTO partof VALUES ('jwatson32@mlb.com', 23);
INSERT INTO partof VALUES ('mmorales1l@boston.com', 23);
INSERT INTO partof VALUES ('jlawrence37@goo.gl', 23);
INSERT INTO partof VALUES ('sgarza4g@columbia.edu', 23);
INSERT INTO partof VALUES ('bfernandezb@amazon.de', 24);
INSERT INTO partof VALUES ('cfuller1i@wunderground.com', 24);
INSERT INTO partof VALUES ('wwarren5e@digg.com', 24);
INSERT INTO partof VALUES ('esmith3@squidoo.com', 24);
INSERT INTO partof VALUES ('gporter3v@dailymail.co.uk', 24);
INSERT INTO partof VALUES ('cgarrett3s@twitter.com', 25);
INSERT INTO partof VALUES ('abennett28@intel.com', 25);
INSERT INTO partof VALUES ('tfoster3m@blogger.com', 25);
INSERT INTO partof VALUES ('ajenkins3o@go.com', 25);
INSERT INTO partof VALUES ('cdixond@dot.gov', 25);
INSERT INTO partof VALUES ('pjacobs2m@domainmarket.com', 26);
INSERT INTO partof VALUES ('ispencer1c@wikia.com', 26);
INSERT INTO partof VALUES ('alawson2o@upenn.edu', 26);
INSERT INTO partof VALUES ('lsnyder5@ifeng.com', 26);
INSERT INTO partof VALUES ('ddiaz13@w3.org', 26);
INSERT INTO partof VALUES ('rdanielsf@prweb.com', 27);
INSERT INTO partof VALUES ('wscotti@yahoo.co.jp', 27);
INSERT INTO partof VALUES ('bchapman34@youtu.be', 27);
INSERT INTO partof VALUES ('jgeorge3u@nifty.com', 27);
INSERT INTO partof VALUES ('estone4e@ehow.com', 27);
INSERT INTO partof VALUES ('mmcdonald35@forbes.com', 28);
INSERT INTO partof VALUES ('wjones1@weather.com', 28);
INSERT INTO partof VALUES ('ckim5h@mtv.com', 28);
INSERT INTO partof VALUES ('mrivera20@shop-pro.jp', 28);
INSERT INTO partof VALUES ('chawkins1f@deviantart.com', 28);
INSERT INTO partof VALUES ('asanchezn@symantec.com', 29);
INSERT INTO partof VALUES ('cwilliams3f@buzzfeed.com', 29);
INSERT INTO partof VALUES ('lperryr@mtv.com', 29);
INSERT INTO partof VALUES ('gwest3b@irs.gov', 29);
INSERT INTO partof VALUES ('tlawsonx@artisteer.com', 29);
INSERT INTO partof VALUES ('djenkins3k@ycombinator.com', 30);
INSERT INTO partof VALUES ('delliotta@usnews.com', 30);
INSERT INTO partof VALUES ('hlopez1v@gmpg.org', 30);
INSERT INTO partof VALUES ('dfernandezs@seattletimes.com', 30);
INSERT INTO partof VALUES ('mevansy@msu.edu', 30);
INSERT INTO partof VALUES ('mcampbell1u@alibaba.com', 31);
INSERT INTO partof VALUES ('aallen54@indiatimes.com', 31);
INSERT INTO partof VALUES ('jmarshall58@gmpg.org', 31);
INSERT INTO partof VALUES ('jharper39@netscape.com', 31);
INSERT INTO partof VALUES ('jfrazier47@who.int', 31);
INSERT INTO partof VALUES ('amurphy12@liveinternet.ru', 32);
INSERT INTO partof VALUES ('epatterson46@utexas.edu', 32);
INSERT INTO partof VALUES ('dcole11@google.com.hk', 32);
INSERT INTO partof VALUES ('charvey38@hao123.com', 32);
INSERT INTO partof VALUES ('dkelley3c@hhs.gov', 32);
INSERT INTO partof VALUES ('rbanks2a@yandex.ru', 33);
INSERT INTO partof VALUES ('lcollins4b@ocn.ne.jp', 33);
INSERT INTO partof VALUES ('ppatterson2v@gmpg.org', 33);
INSERT INTO partof VALUES ('awoods3z@cocolog-nifty.com', 33);
INSERT INTO partof VALUES ('gwhite2j@jimdo.com', 33);
INSERT INTO partof VALUES ('rnichols3r@pinterest.com', 34);
INSERT INTO partof VALUES ('bhenderson18@washington.edu', 34);
INSERT INTO partof VALUES ('gandrews26@xing.com', 34);
INSERT INTO partof VALUES ('tromero2w@bbc.co.uk', 34);
INSERT INTO partof VALUES ('pbutler4f@shutterfly.com', 34);
INSERT INTO partof VALUES ('srussellu@nydailynews.com', 35);
INSERT INTO partof VALUES ('nmitchell2h@jiathis.com', 35);
INSERT INTO partof VALUES ('mramirez44@wikimedia.org', 35);
INSERT INTO partof VALUES ('dwatsonw@unesco.org', 35);
INSERT INTO partof VALUES ('bfrazier4t@usnews.com', 35);
INSERT INTO partof VALUES ('rfowler2n@toplist.cz', 36);
INSERT INTO partof VALUES ('asullivan3l@msu.edu', 36);
INSERT INTO partof VALUES ('jfuller5c@latimes.com', 36);
INSERT INTO partof VALUES ('ftorres0@freewebs.com', 36);
INSERT INTO partof VALUES ('saustin52@unblog.fr', 36);
INSERT INTO partof VALUES ('sdean30@google.ru', 37);
INSERT INTO partof VALUES ('arodriguez1r@berkeley.edu', 37);
INSERT INTO partof VALUES ('jreid3e@vinaora.com', 37);
INSERT INTO partof VALUES ('jcooper4p@domainmarket.com', 37);
INSERT INTO partof VALUES ('chayesg@nps.gov', 37);
INSERT INTO partof VALUES ('creyes1j@disqus.com', 38);
INSERT INTO partof VALUES ('crose2z@mozilla.org', 38);
INSERT INTO partof VALUES ('hperez10@loc.gov', 38);
INSERT INTO partof VALUES ('ibowman1e@diigo.com', 38);
INSERT INTO partof VALUES ('cmcdonald4h@exblog.jp', 38);
INSERT INTO partof VALUES ('fpierce5j@bizjournals.com', 39);
INSERT INTO partof VALUES ('jreyesc@princeton.edu', 39);
INSERT INTO partof VALUES ('speters7@google.co.uk', 39);
INSERT INTO partof VALUES ('halexander2p@washingtonpost.com', 39);
INSERT INTO partof VALUES ('kcollins3x@myspace.com', 39);
INSERT INTO partof VALUES ('rgraham29@wordpress.com', 40);
INSERT INTO partof VALUES ('jolson2q@microsoft.com', 40);
INSERT INTO partof VALUES ('awhite2t@com.com', 40);
INSERT INTO partof VALUES ('hbradley23@taobao.com', 40);
INSERT INTO partof VALUES ('jhowell2@google.fr', 40);


--
-- Name: partof_convo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('partof_convo_id_seq', 1, false);


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: post_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_pid_seq', 1, false);


--
-- Name: post_wall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_wall_id_seq', 1, false);


--
-- Data for Name: postreaction; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: postreaction_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('postreaction_pid_seq', 1, false);


--
-- Data for Name: school; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO school VALUES (100);
INSERT INTO school VALUES (101);
INSERT INTO school VALUES (102);
INSERT INTO school VALUES (103);
INSERT INTO school VALUES (104);
INSERT INTO school VALUES (105);
INSERT INTO school VALUES (106);
INSERT INTO school VALUES (107);
INSERT INTO school VALUES (108);
INSERT INTO school VALUES (109);
INSERT INTO school VALUES (110);
INSERT INTO school VALUES (111);
INSERT INTO school VALUES (112);
INSERT INTO school VALUES (113);
INSERT INTO school VALUES (114);
INSERT INTO school VALUES (115);
INSERT INTO school VALUES (116);
INSERT INTO school VALUES (117);
INSERT INTO school VALUES (118);
INSERT INTO school VALUES (119);
INSERT INTO school VALUES (120);
INSERT INTO school VALUES (121);
INSERT INTO school VALUES (122);
INSERT INTO school VALUES (123);
INSERT INTO school VALUES (124);
INSERT INTO school VALUES (125);
INSERT INTO school VALUES (126);
INSERT INTO school VALUES (127);
INSERT INTO school VALUES (128);
INSERT INTO school VALUES (129);
INSERT INTO school VALUES (130);
INSERT INTO school VALUES (131);
INSERT INTO school VALUES (132);
INSERT INTO school VALUES (133);
INSERT INTO school VALUES (134);
INSERT INTO school VALUES (135);
INSERT INTO school VALUES (136);
INSERT INTO school VALUES (137);
INSERT INTO school VALUES (138);
INSERT INTO school VALUES (139);
INSERT INTO school VALUES (140);
INSERT INTO school VALUES (141);
INSERT INTO school VALUES (142);
INSERT INTO school VALUES (143);
INSERT INTO school VALUES (144);
INSERT INTO school VALUES (145);
INSERT INTO school VALUES (146);
INSERT INTO school VALUES (147);
INSERT INTO school VALUES (148);
INSERT INTO school VALUES (149);
INSERT INTO school VALUES (150);
INSERT INTO school VALUES (151);
INSERT INTO school VALUES (152);
INSERT INTO school VALUES (153);
INSERT INTO school VALUES (154);
INSERT INTO school VALUES (155);
INSERT INTO school VALUES (156);
INSERT INTO school VALUES (157);
INSERT INTO school VALUES (158);
INSERT INTO school VALUES (159);
INSERT INTO school VALUES (160);
INSERT INTO school VALUES (161);
INSERT INTO school VALUES (162);
INSERT INTO school VALUES (163);
INSERT INTO school VALUES (164);
INSERT INTO school VALUES (165);
INSERT INTO school VALUES (166);
INSERT INTO school VALUES (167);
INSERT INTO school VALUES (168);
INSERT INTO school VALUES (169);
INSERT INTO school VALUES (170);
INSERT INTO school VALUES (171);
INSERT INTO school VALUES (172);
INSERT INTO school VALUES (173);
INSERT INTO school VALUES (174);
INSERT INTO school VALUES (175);
INSERT INTO school VALUES (176);
INSERT INTO school VALUES (177);
INSERT INTO school VALUES (178);
INSERT INTO school VALUES (179);
INSERT INTO school VALUES (180);
INSERT INTO school VALUES (181);
INSERT INTO school VALUES (182);
INSERT INTO school VALUES (183);
INSERT INTO school VALUES (184);
INSERT INTO school VALUES (185);
INSERT INTO school VALUES (186);
INSERT INTO school VALUES (187);
INSERT INTO school VALUES (188);
INSERT INTO school VALUES (189);
INSERT INTO school VALUES (190);
INSERT INTO school VALUES (191);
INSERT INTO school VALUES (192);
INSERT INTO school VALUES (193);
INSERT INTO school VALUES (194);
INSERT INTO school VALUES (195);


--
-- Name: school_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('school_org_id_seq', 1, false);


--
-- Data for Name: studyperiod; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: studyperiod_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('studyperiod_org_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES ('ftorres0@freewebs.com', 'Frances', 'Torres', '1978-07-22', '9FlByMN8mP', 'f');
INSERT INTO users VALUES ('wjones1@weather.com', 'Walter', 'Jones', '1980-11-13', 'nzwM5B', 'm');
INSERT INTO users VALUES ('jhowell2@google.fr', 'Joseph', 'Howell', '1986-02-09', 'Laz8we', 'm');
INSERT INTO users VALUES ('esmith3@squidoo.com', 'Eric', 'Smith', '1999-12-11', '8DszlNtRRIMH', 'm');
INSERT INTO users VALUES ('lmedina4@washington.edu', 'Lisa', 'Medina', '1983-08-12', '3lAo2nd2', 'f');
INSERT INTO users VALUES ('lsnyder5@ifeng.com', 'Lawrence', 'Snyder', '1990-05-28', 'D5hqwkPyneH', 'm');
INSERT INTO users VALUES ('phoward6@boston.com', 'Patrick', 'Howard', '1999-01-27', 'z8K4mIHzqtO', 'm');
INSERT INTO users VALUES ('speters7@google.co.uk', 'Sharon', 'Peters', '1990-01-25', 'LQKdOmLeVVOH', 'f');
INSERT INTO users VALUES ('ccruz8@geocities.com', 'Carolyn', 'Cruz', '1991-10-12', 'SXImuII9xmi', 'f');
INSERT INTO users VALUES ('mrussell9@macromedia.com', 'Michael', 'Russell', '1989-06-22', 'u8omqdgw2JGR', 'm');
INSERT INTO users VALUES ('delliotta@usnews.com', 'Debra', 'Elliott', '1996-05-08', 'MbEdSZo8oo', 'f');
INSERT INTO users VALUES ('bfernandezb@amazon.de', 'Bruce', 'Fernandez', '1985-05-05', 'ZtJFH0N25HP', 'm');
INSERT INTO users VALUES ('jreyesc@princeton.edu', 'Janet', 'Reyes', '1993-02-10', 'eEjXcDt', 'f');
INSERT INTO users VALUES ('cdixond@dot.gov', 'Charles', 'Dixon', '1972-08-03', '7Alo6vqqL1Dv', 'm');
INSERT INTO users VALUES ('kbakere@mit.edu', 'Kevin', 'Baker', '1973-08-19', 'RrRkcjJuuv', 'm');
INSERT INTO users VALUES ('rdanielsf@prweb.com', 'Ryan', 'Daniels', '1982-08-16', 'w68zxp', 'm');
INSERT INTO users VALUES ('chayesg@nps.gov', 'Chris', 'Hayes', '1972-05-01', 'qPmh1JGHy', 'm');
INSERT INTO users VALUES ('swashingtonh@jiathis.com', 'Steve', 'Washington', '1971-11-23', 'Aew19B', 'm');
INSERT INTO users VALUES ('wscotti@yahoo.co.jp', 'Willie', 'Scott', '1972-02-06', '3FYkvBRa', 'm');
INSERT INTO users VALUES ('nhudsonj@discovery.com', 'Nicole', 'Hudson', '1998-09-29', '4CY2xwDXvW', 'f');
INSERT INTO users VALUES ('schavezk@devhub.com', 'Stephanie', 'Chavez', '1979-08-19', 'GnJSbAqrq', 'f');
INSERT INTO users VALUES ('jromerol@hexun.com', 'James', 'Romero', '1997-07-17', 'WAI1ux28', 'm');
INSERT INTO users VALUES ('eromerom@narod.ru', 'Eric', 'Romero', '1974-09-06', 'HBOlmTv15c', 'm');
INSERT INTO users VALUES ('asanchezn@symantec.com', 'Andrea', 'Sanchez', '1976-04-04', 'EHYWBsTrK', 'f');
INSERT INTO users VALUES ('nsullivano@google.co.jp', 'Nicholas', 'Sullivan', '1985-08-21', 'AN6P3sA0', 'm');
INSERT INTO users VALUES ('alarsonp@virginia.edu', 'Alice', 'Larson', '1977-01-26', '5xvt5b', 'f');
INSERT INTO users VALUES ('jhowardq@fema.gov', 'James', 'Howard', '1982-05-17', 'SFca5N', 'm');
INSERT INTO users VALUES ('lperryr@mtv.com', 'Larry', 'Perry', '1970-07-22', 'SxFP4BYtt7D', 'm');
INSERT INTO users VALUES ('dfernandezs@seattletimes.com', 'Daniel', 'Fernandez', '1996-06-25', 'R0jbbr', 'm');
INSERT INTO users VALUES ('rjordant@1688.com', 'Robin', 'Jordan', '1985-12-09', 'DmHTmwyLH1Ke', 'f');
INSERT INTO users VALUES ('srussellu@nydailynews.com', 'Sarah', 'Russell', '1985-08-03', 'oiLrx9Tr', 'f');
INSERT INTO users VALUES ('egutierrezv@comcast.net', 'Eugene', 'Gutierrez', '1993-01-17', 'ZefX02h7jV', 'm');
INSERT INTO users VALUES ('dwatsonw@unesco.org', 'Deborah', 'Watson', '1970-11-25', '6s6oJ1c2eA', 'f');
INSERT INTO users VALUES ('tlawsonx@artisteer.com', 'Teresa', 'Lawson', '1971-06-04', 'merHqrGaK', 'f');
INSERT INTO users VALUES ('mevansy@msu.edu', 'Mary', 'Evans', '1995-09-14', 'VilJiUZu4n', 'f');
INSERT INTO users VALUES ('melliottz@g.co', 'Martin', 'Elliott', '1988-12-03', 'iI4pph2', 'm');
INSERT INTO users VALUES ('hperez10@loc.gov', 'Helen', 'Perez', '1974-11-28', '5miG2nPqVzM', 'f');
INSERT INTO users VALUES ('dcole11@google.com.hk', 'Debra', 'Cole', '1995-06-21', 'BEumf0', 'f');
INSERT INTO users VALUES ('amurphy12@liveinternet.ru', 'Alan', 'Murphy', '1974-09-20', 'EwvHG1WK', 'm');
INSERT INTO users VALUES ('ddiaz13@w3.org', 'Diana', 'Diaz', '1983-11-19', '1yWiG5OR', 'f');
INSERT INTO users VALUES ('jscott14@dyndns.org', 'Julie', 'Scott', '1992-03-16', 'cj8Ng3', 'f');
INSERT INTO users VALUES ('jgray15@google.cn', 'Justin', 'Gray', '1979-06-16', 'V32ePKbpwf7G', 'm');
INSERT INTO users VALUES ('eperez16@homestead.com', 'Earl', 'Perez', '1987-10-20', 'aAOXRl4Oeb', 'm');
INSERT INTO users VALUES ('bwelch17@list-manage.com', 'Billy', 'Welch', '1976-04-14', 'udZNYvEx', 'm');
INSERT INTO users VALUES ('bhenderson18@washington.edu', 'Billy', 'Henderson', '1989-03-22', 'aWrGPL2iX', 'm');
INSERT INTO users VALUES ('aromero19@fastcompany.com', 'Anthony', 'Romero', '1988-08-17', 'cfHxpIdeS', 'm');
INSERT INTO users VALUES ('pparker1a@engadget.com', 'Peter', 'Parker', '1986-07-14', 'W0gzJzua', 'm');
INSERT INTO users VALUES ('clane1b@cocolog-nifty.com', 'Charles', 'Lane', '1992-01-14', 'hp9rNuWgOoU', 'm');
INSERT INTO users VALUES ('ispencer1c@wikia.com', 'Irene', 'Spencer', '1972-10-26', 'WYjVoveWK', 'f');
INSERT INTO users VALUES ('cbailey1d@europa.eu', 'Craig', 'Bailey', '1989-11-15', 'X2JJImjDLql9', 'm');
INSERT INTO users VALUES ('ibowman1e@diigo.com', 'Irene', 'Bowman', '1990-09-22', '0DRoWYb837HB', 'f');
INSERT INTO users VALUES ('chawkins1f@deviantart.com', 'Carolyn', 'Hawkins', '1987-07-11', 'S1ZRT9RWjBEq', 'f');
INSERT INTO users VALUES ('kbennett1g@reuters.com', 'Kenneth', 'Bennett', '1994-06-25', 'yXGPKTwp', 'm');
INSERT INTO users VALUES ('ewright1h@wordpress.com', 'Edward', 'Wright', '1973-03-08', 'mfOfI2SFc', 'm');
INSERT INTO users VALUES ('cfuller1i@wunderground.com', 'Carol', 'Fuller', '1987-04-05', 'TtJZliB', 'f');
INSERT INTO users VALUES ('creyes1j@disqus.com', 'Christine', 'Reyes', '1973-03-27', 'aWCxOy', 'f');
INSERT INTO users VALUES ('blane1k@imageshack.us', 'Barbara', 'Lane', '1986-07-18', 'iFeiDIDka', 'f');
INSERT INTO users VALUES ('mmorales1l@boston.com', 'Mildred', 'Morales', '1991-11-11', 'wpKeODa', 'f');
INSERT INTO users VALUES ('ecox1m@eventbrite.com', 'Ernest', 'Cox', '1998-06-26', 'Oz5YiZ', 'm');
INSERT INTO users VALUES ('lreyes1n@theglobeandmail.com', 'Louise', 'Reyes', '1974-12-07', 'DrZKjylXeUV', 'f');
INSERT INTO users VALUES ('mhunter1o@smh.com.au', 'Melissa', 'Hunter', '1983-08-04', 'IBsrld09ii', 'f');
INSERT INTO users VALUES ('dstanley1p@deliciousdays.com', 'Diana', 'Stanley', '1981-08-09', '0gXfuS5RZQtn', 'f');
INSERT INTO users VALUES ('rmartinez1q@blog.com', 'Ralph', 'Martinez', '1973-08-29', 'GXk5SB7jqL', 'm');
INSERT INTO users VALUES ('arodriguez1r@berkeley.edu', 'Alice', 'Rodriguez', '1995-06-01', 'JzJUd451huBr', 'f');
INSERT INTO users VALUES ('jporter1s@mapy.cz', 'Johnny', 'Porter', '1972-02-18', 'CktY54gGEBf', 'm');
INSERT INTO users VALUES ('cbarnes1t@is.gd', 'Carlos', 'Barnes', '1976-01-30', '1wpYTlhyR', 'm');
INSERT INTO users VALUES ('mcampbell1u@alibaba.com', 'Marie', 'Campbell', '1973-06-12', 'na4vIuBjzK', 'f');
INSERT INTO users VALUES ('hlopez1v@gmpg.org', 'Harry', 'Lopez', '1992-04-20', '2rC9RzlIAf', 'm');
INSERT INTO users VALUES ('sday1w@bloglovin.com', 'Stephanie', 'Day', '1983-01-05', '5Kc67nagwH', 'f');
INSERT INTO users VALUES ('sthompson1x@cafepress.com', 'Susan', 'Thompson', '1999-06-06', '70GN5T', 'f');
INSERT INTO users VALUES ('lhill1y@mayoclinic.com', 'Louis', 'Hill', '1980-04-15', 'ure31cSfD', 'm');
INSERT INTO users VALUES ('nnichols1z@twitter.com', 'Nancy', 'Nichols', '1996-01-24', 'yMYKEOE', 'f');
INSERT INTO users VALUES ('mrivera20@shop-pro.jp', 'Mildred', 'Rivera', '1996-06-06', 'RBaLGFfF', 'f');
INSERT INTO users VALUES ('fpeterson21@wordpress.com', 'Fred', 'Peterson', '1982-08-21', 'gcTRdGpsR', 'm');
INSERT INTO users VALUES ('fkennedy22@ow.ly', 'Frances', 'Kennedy', '1994-04-10', 'BwFiMMec', 'f');
INSERT INTO users VALUES ('hbradley23@taobao.com', 'Heather', 'Bradley', '1975-03-06', '7JMPDGUKDl', 'f');
INSERT INTO users VALUES ('jjenkins24@squidoo.com', 'Jane', 'Jenkins', '1999-06-12', 'qSHYgViMGZNq', 'f');
INSERT INTO users VALUES ('jstevens25@theglobeandmail.com', 'James', 'Stevens', '1988-07-14', 'GVc4jctfQ8e', 'm');
INSERT INTO users VALUES ('gandrews26@xing.com', 'Gregory', 'Andrews', '1975-10-11', 'GqMX8b1cNum', 'm');
INSERT INTO users VALUES ('tprice27@discovery.com', 'Theresa', 'Price', '1973-08-02', 'kT7jti7ym', 'f');
INSERT INTO users VALUES ('abennett28@intel.com', 'Annie', 'Bennett', '1995-09-21', 'UvIFANSVHkkn', 'f');
INSERT INTO users VALUES ('rgraham29@wordpress.com', 'Ralph', 'Graham', '1984-12-24', 'jl3MacsJUr', 'm');
INSERT INTO users VALUES ('rbanks2a@yandex.ru', 'Raymond', 'Banks', '1984-12-05', 'KQKFv51nnG', 'm');
INSERT INTO users VALUES ('apatterson2b@infoseek.co.jp', 'Anna', 'Patterson', '1975-12-21', 'B3SBUbaoa', 'f');
INSERT INTO users VALUES ('jarmstrong2c@uiuc.edu', 'Jack', 'Armstrong', '1989-10-27', 'Zt1nomes', 'm');
INSERT INTO users VALUES ('tkim2d@blogs.com', 'Teresa', 'Kim', '1978-03-05', 'tKOd8z', 'f');
INSERT INTO users VALUES ('caustin2e@nih.gov', 'Catherine', 'Austin', '1979-03-11', 'MR480Dfs8D', 'f');
INSERT INTO users VALUES ('rcrawford2f@istockphoto.com', 'Randy', 'Crawford', '1982-11-28', 'saHSzHjRA76', 'm');
INSERT INTO users VALUES ('mphillips2g@jigsy.com', 'Melissa', 'Phillips', '1992-12-20', 'eCsZZzqkn', 'f');
INSERT INTO users VALUES ('nmitchell2h@jiathis.com', 'Nicole', 'Mitchell', '1999-08-28', 'PYymUbumFh', 'f');
INSERT INTO users VALUES ('kpierce2i@webnode.com', 'Kimberly', 'Pierce', '1993-01-01', 's7dFHabwG', 'f');
INSERT INTO users VALUES ('gwhite2j@jimdo.com', 'Gerald', 'White', '1970-04-30', 'MYkaKPSH36kd', 'm');
INSERT INTO users VALUES ('dporter2k@vinaora.com', 'Doris', 'Porter', '1977-06-20', '7q7X8fRq', 'f');
INSERT INTO users VALUES ('tjames2l@salon.com', 'Terry', 'James', '1990-11-13', 'hTYl23GcwZ0a', 'm');
INSERT INTO users VALUES ('pjacobs2m@domainmarket.com', 'Peter', 'Jacobs', '1993-04-20', 'orKK774ILIu', 'm');
INSERT INTO users VALUES ('rfowler2n@toplist.cz', 'Ralph', 'Fowler', '1981-08-23', 'zySrPbG8MeY', 'm');
INSERT INTO users VALUES ('alawson2o@upenn.edu', 'Ashley', 'Lawson', '1990-04-02', 'suHAyQml', 'f');
INSERT INTO users VALUES ('halexander2p@washingtonpost.com', 'Heather', 'Alexander', '1996-06-11', 'uUhMGIAlI', 'f');
INSERT INTO users VALUES ('jolson2q@microsoft.com', 'Jean', 'Olson', '1981-05-10', 'awrPBp9', 'f');
INSERT INTO users VALUES ('rgriffin2r@businessinsider.com', 'Ruth', 'Griffin', '1994-05-01', 'kTB8rHCu7KBG', 'f');
INSERT INTO users VALUES ('bsanders2s@liveinternet.ru', 'Bruce', 'Sanders', '1993-05-01', 'DIh5xb', 'm');
INSERT INTO users VALUES ('awhite2t@com.com', 'Ann', 'White', '1976-11-07', 'XodRpP', 'f');
INSERT INTO users VALUES ('ldiaz2u@umich.edu', 'Lillian', 'Diaz', '1971-02-07', '22hPdcnh0NHb', 'f');
INSERT INTO users VALUES ('ppatterson2v@gmpg.org', 'Philip', 'Patterson', '1972-05-18', 'TBc0KPUNx', 'm');
INSERT INTO users VALUES ('tromero2w@bbc.co.uk', 'Thomas', 'Romero', '1984-04-08', 'FyRbOLo', 'm');
INSERT INTO users VALUES ('rbrooks2x@joomla.org', 'Rebecca', 'Brooks', '1982-05-21', 'QeGg4wvggBz', 'f');
INSERT INTO users VALUES ('mmartin2y@gravatar.com', 'Mildred', 'Martin', '1978-02-23', 'f9vkR9f8yHY', 'f');
INSERT INTO users VALUES ('crose2z@mozilla.org', 'Clarence', 'Rose', '1988-05-01', 'Dtsjj1YMW6Qa', 'm');
INSERT INTO users VALUES ('sdean30@google.ru', 'Scott', 'Dean', '1975-04-14', 'xtNC6iprM', 'm');
INSERT INTO users VALUES ('fstanley31@opera.com', 'Fred', 'Stanley', '1972-03-17', 's3wFhBt', 'm');
INSERT INTO users VALUES ('jwatson32@mlb.com', 'Joseph', 'Watson', '1993-12-05', 'U6hQTN', 'm');
INSERT INTO users VALUES ('tgomez33@joomla.org', 'Tammy', 'Gomez', '1986-04-24', 'obKhOGIP28U', 'f');
INSERT INTO users VALUES ('bchapman34@youtu.be', 'Brenda', 'Chapman', '1989-07-09', 'V4feBcKM', 'f');
INSERT INTO users VALUES ('mmcdonald35@forbes.com', 'Michelle', 'Mcdonald', '1983-05-26', 'rPaX1npLDTXY', 'f');
INSERT INTO users VALUES ('rnelson36@addthis.com', 'Ronald', 'Nelson', '1977-07-04', 'oy3FvW0dc', 'm');
INSERT INTO users VALUES ('jlawrence37@goo.gl', 'Joyce', 'Lawrence', '1993-12-21', '6s6zmFuH0l8m', 'f');
INSERT INTO users VALUES ('charvey38@hao123.com', 'Carolyn', 'Harvey', '1986-07-27', 'Sh0XzgP', 'f');
INSERT INTO users VALUES ('jharper39@netscape.com', 'Jennifer', 'Harper', '1992-12-29', 'jgj81C4Pc', 'f');
INSERT INTO users VALUES ('jsimpson3a@microsoft.com', 'Jean', 'Simpson', '1983-04-25', 'EW8OxH', 'f');
INSERT INTO users VALUES ('gwest3b@irs.gov', 'Gerald', 'West', '1979-04-11', 'MGq8Xlg2ThRF', 'm');
INSERT INTO users VALUES ('dkelley3c@hhs.gov', 'Dennis', 'Kelley', '1973-01-24', 'wP4hGYdJ', 'm');
INSERT INTO users VALUES ('clopez3d@ebay.com', 'Carol', 'Lopez', '1991-02-04', 'AUD1NKj', 'f');
INSERT INTO users VALUES ('jreid3e@vinaora.com', 'Janet', 'Reid', '1973-08-17', 'cePYwoTrj', 'f');
INSERT INTO users VALUES ('cwilliams3f@buzzfeed.com', 'Carolyn', 'Williams', '1991-08-28', 'fnF4DCE0rZI', 'f');
INSERT INTO users VALUES ('jgonzalez3g@google.com.au', 'Jerry', 'Gonzalez', '1980-07-01', 'Swm5XPR', 'm');
INSERT INTO users VALUES ('jfox3h@businessinsider.com', 'Joshua', 'Fox', '1986-12-27', 'GlFQoZsJgpO', 'm');
INSERT INTO users VALUES ('eking3i@homestead.com', 'Edward', 'King', '1998-06-23', 'drkfUD', 'm');
INSERT INTO users VALUES ('kross3j@ow.ly', 'Kimberly', 'Ross', '1983-02-18', 'ZszwiM', 'f');
INSERT INTO users VALUES ('djenkins3k@ycombinator.com', 'Daniel', 'Jenkins', '1988-03-13', 'Vxxsu4xH', 'm');
INSERT INTO users VALUES ('asullivan3l@msu.edu', 'Amanda', 'Sullivan', '1981-01-28', 'a5PfMwv', 'f');
INSERT INTO users VALUES ('tfoster3m@blogger.com', 'Todd', 'Foster', '1991-06-03', 'GknJIkMWS', 'm');
INSERT INTO users VALUES ('speterson3n@geocities.com', 'Sandra', 'Peterson', '1986-04-30', 'HNP4jGT', 'f');
INSERT INTO users VALUES ('ajenkins3o@go.com', 'Anne', 'Jenkins', '1971-09-11', 'BtY6NCsAENO', 'f');
INSERT INTO users VALUES ('slopez3p@nature.com', 'Steve', 'Lopez', '1993-04-12', 'N4Qrn9w', 'm');
INSERT INTO users VALUES ('cmyers3q@about.com', 'Cynthia', 'Myers', '1987-03-14', 'nQC4bMjK5', 'f');
INSERT INTO users VALUES ('rnichols3r@pinterest.com', 'Rose', 'Nichols', '1983-12-15', 'b9rvFUBBqDs', 'f');
INSERT INTO users VALUES ('cgarrett3s@twitter.com', 'Cheryl', 'Garrett', '1984-05-19', 'cp7WZUO', 'f');
INSERT INTO users VALUES ('jwhite3t@instagram.com', 'Jane', 'White', '1975-05-16', 'tUDshNB', 'f');
INSERT INTO users VALUES ('jgeorge3u@nifty.com', 'John', 'George', '1970-01-09', 'jG1ATSwie', 'm');
INSERT INTO users VALUES ('gporter3v@dailymail.co.uk', 'Gregory', 'Porter', '1970-08-30', 'mI0o1Hm', 'm');
INSERT INTO users VALUES ('jstanley3w@census.gov', 'Jeremy', 'Stanley', '1990-03-12', 'qwrAZGBAtUC', 'm');
INSERT INTO users VALUES ('kcollins3x@myspace.com', 'Kenneth', 'Collins', '1996-12-06', 'KG7Ux8K4', 'm');
INSERT INTO users VALUES ('wkim3y@usgs.gov', 'Willie', 'Kim', '1977-11-09', 'sXicwULJ64J', 'm');
INSERT INTO users VALUES ('awoods3z@cocolog-nifty.com', 'Andrea', 'Woods', '1995-06-15', 'FIBP29HzB', 'f');
INSERT INTO users VALUES ('ksanders40@rediff.com', 'Keith', 'Sanders', '1974-01-23', 'JTjBQqUNf', 'm');
INSERT INTO users VALUES ('hbutler41@mozilla.org', 'Helen', 'Butler', '1996-10-07', 'TzG5HJxNo89', 'f');
INSERT INTO users VALUES ('twebb42@quantcast.com', 'Tammy', 'Webb', '1984-09-19', '0SUb08h4ZNc', 'f');
INSERT INTO users VALUES ('akennedy43@quantcast.com', 'Ann', 'Kennedy', '1974-06-13', 'M2DkLnLBh7', 'f');
INSERT INTO users VALUES ('mramirez44@wikimedia.org', 'Margaret', 'Ramirez', '1980-11-17', 'KWv3xk', 'f');
INSERT INTO users VALUES ('dmendoza45@jiathis.com', 'Dennis', 'Mendoza', '1999-11-08', 'sYpHR6Sqg', 'm');
INSERT INTO users VALUES ('epatterson46@utexas.edu', 'Ernest', 'Patterson', '1997-10-11', 'q85qtHVqoAy', 'm');
INSERT INTO users VALUES ('jfrazier47@who.int', 'Jean', 'Frazier', '1991-08-10', '4YZhaCWrqRNj', 'f');
INSERT INTO users VALUES ('jwillis48@acquirethisname.com', 'Joseph', 'Willis', '1989-10-26', 'hfn0Y1LEXr', 'm');
INSERT INTO users VALUES ('randrews49@uol.com.br', 'Robin', 'Andrews', '1974-12-10', '8Rh7JVjZm', 'f');
INSERT INTO users VALUES ('tsnyder4a@live.com', 'Terry', 'Snyder', '1971-01-20', 'oGdacDv', 'm');
INSERT INTO users VALUES ('lcollins4b@ocn.ne.jp', 'Louis', 'Collins', '1983-09-28', 'jpQsYsqwq', 'm');
INSERT INTO users VALUES ('jtorres4c@youtube.com', 'Jennifer', 'Torres', '1991-04-09', 'QAqjWRX6', 'f');
INSERT INTO users VALUES ('cstevens4d@list-manage.com', 'Carol', 'Stevens', '1980-11-04', '7kgVtEMBvtj4', 'f');
INSERT INTO users VALUES ('estone4e@ehow.com', 'Edward', 'Stone', '1998-02-25', '8hP9AEx', 'm');
INSERT INTO users VALUES ('pbutler4f@shutterfly.com', 'Patrick', 'Butler', '1974-02-20', 'n2Lncuy', 'm');
INSERT INTO users VALUES ('sgarza4g@columbia.edu', 'Sean', 'Garza', '1985-07-20', 'GtBe8Kz', 'm');
INSERT INTO users VALUES ('cmcdonald4h@exblog.jp', 'Chris', 'Mcdonald', '1972-11-04', '6LAN14dyKsyr', 'm');
INSERT INTO users VALUES ('jcarter4i@sitemeter.com', 'Jose', 'Carter', '1980-08-07', 'zyIqFB', 'm');
INSERT INTO users VALUES ('drichardson4j@illinois.edu', 'Diane', 'Richardson', '1994-03-25', 'rG9K3BQFUIX', 'f');
INSERT INTO users VALUES ('tromero4k@topsy.com', 'Tammy', 'Romero', '1987-08-11', 'fo5BQhT4ik', 'f');
INSERT INTO users VALUES ('jmartinez4l@pagesperso-orange.fr', 'Judith', 'Martinez', '1970-12-18', 'Sz1Irhpaa2G', 'f');
INSERT INTO users VALUES ('jgibson4m@hc360.com', 'Jessica', 'Gibson', '1972-09-27', 'VWryUh5', 'f');
INSERT INTO users VALUES ('jspencer4n@shop-pro.jp', 'Jason', 'Spencer', '1978-02-20', 'JeEApMvIt4', 'm');
INSERT INTO users VALUES ('tbryant4o@reddit.com', 'Thomas', 'Bryant', '1978-01-02', '1b7gEXaCb', 'm');
INSERT INTO users VALUES ('jcooper4p@domainmarket.com', 'Jonathan', 'Cooper', '1994-05-02', 'pXgdbAQAxnD8', 'm');
INSERT INTO users VALUES ('csimmons4q@mashable.com', 'Cynthia', 'Simmons', '1988-06-10', 'NlcSfzp59Bed', 'f');
INSERT INTO users VALUES ('agilbert4r@hud.gov', 'Anna', 'Gilbert', '1993-12-19', 'LsYWLG6R8utG', 'f');
INSERT INTO users VALUES ('pwhite4s@about.me', 'Paul', 'White', '1975-03-11', 'm5ppja6JsX', 'm');
INSERT INTO users VALUES ('bfrazier4t@usnews.com', 'Brian', 'Frazier', '1999-05-31', 'HEpiEz2AGM', 'm');
INSERT INTO users VALUES ('ahenderson4u@reverbnation.com', 'Antonio', 'Henderson', '1994-09-25', 'Tajyi6n7yKCL', 'm');
INSERT INTO users VALUES ('kmoreno4v@multiply.com', 'Kathryn', 'Moreno', '1975-10-25', '4AOUmO', 'f');
INSERT INTO users VALUES ('rblack4w@networksolutions.com', 'Robert', 'Black', '1994-06-01', 'DIFG6Qon0ih', 'm');
INSERT INTO users VALUES ('dsmith4x@twitpic.com', 'Daniel', 'Smith', '1982-02-06', 'd0iAV16h', 'm');
INSERT INTO users VALUES ('ssimpson4y@netscape.com', 'Steve', 'Simpson', '1975-09-07', 'v39QsIwr7fA', 'm');
INSERT INTO users VALUES ('csmith4z@addtoany.com', 'Christine', 'Smith', '1979-04-03', 'S5VAD0', 'f');
INSERT INTO users VALUES ('gjames50@woothemes.com', 'Gerald', 'James', '1989-12-15', 'MH9S4PjMrN', 'm');
INSERT INTO users VALUES ('crice51@163.com', 'Craig', 'Rice', '1977-06-02', 'eOf19K0kf', 'm');
INSERT INTO users VALUES ('saustin52@unblog.fr', 'Sandra', 'Austin', '1974-12-24', 'JnYif5aWm1K', 'f');
INSERT INTO users VALUES ('jtaylor53@topsy.com', 'Jessica', 'Taylor', '1981-08-23', 'PRMhZi', 'f');
INSERT INTO users VALUES ('aallen54@indiatimes.com', 'Ashley', 'Allen', '1995-05-21', 'oqhgUGzuhLc', 'f');
INSERT INTO users VALUES ('bdean55@go.com', 'Brian', 'Dean', '1985-06-29', 'MBrepvXfr', 'm');
INSERT INTO users VALUES ('arose56@yandex.ru', 'Alan', 'Rose', '1976-12-11', 'prxRSR6R', 'm');
INSERT INTO users VALUES ('thicks57@github.com', 'Timothy', 'Hicks', '1985-04-06', 'yhH1LUglz', 'm');
INSERT INTO users VALUES ('jmarshall58@gmpg.org', 'Jeremy', 'Marshall', '1988-12-06', '5vdpOfe', 'm');
INSERT INTO users VALUES ('charrison59@answers.com', 'Carol', 'Harrison', '1975-12-02', 'Lpqv7l', 'f');
INSERT INTO users VALUES ('mnichols5a@yellowpages.com', 'Martha', 'Nichols', '1973-09-11', 'MzBzmHjB', 'f');
INSERT INTO users VALUES ('apeters5b@craigslist.org', 'Antonio', 'Peters', '1999-08-12', 'mKMgXcK', 'm');
INSERT INTO users VALUES ('jfuller5c@latimes.com', 'Janet', 'Fuller', '1996-07-19', 'k3nbNpSTDWQ', 'f');
INSERT INTO users VALUES ('rreid5d@sourceforge.net', 'Roy', 'Reid', '1983-12-02', '5nF2rkkn', 'm');
INSERT INTO users VALUES ('wwarren5e@digg.com', 'Wanda', 'Warren', '1975-01-31', 'WSRmGfR3', 'f');
INSERT INTO users VALUES ('mkelly5f@google.com.br', 'Mary', 'Kelly', '1999-10-02', 'LAEyRpmcRF', 'f');
INSERT INTO users VALUES ('bwest5g@tamu.edu', 'Barbara', 'West', '1972-06-24', '2ytAFBEl', 'f');
INSERT INTO users VALUES ('ckim5h@mtv.com', 'Carolyn', 'Kim', '1982-01-22', 'ayOwlWh', 'f');
INSERT INTO users VALUES ('clittle5i@forbes.com', 'Carolyn', 'Little', '1999-01-07', '1YT6ZItDK6Dk', 'f');
INSERT INTO users VALUES ('fpierce5j@bizjournals.com', 'Fred', 'Pierce', '1973-02-01', 'pDf91au', 'm');


--
-- Data for Name: wall; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: wall_wall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('wall_wall_id_seq', 1, false);


--
-- Data for Name: workperiod; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: workperiod_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('workperiod_org_id_seq', 1, false);


--
-- Data for Name: workplace; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO workplace VALUES (1);
INSERT INTO workplace VALUES (2);
INSERT INTO workplace VALUES (3);
INSERT INTO workplace VALUES (4);
INSERT INTO workplace VALUES (5);
INSERT INTO workplace VALUES (6);
INSERT INTO workplace VALUES (7);
INSERT INTO workplace VALUES (8);
INSERT INTO workplace VALUES (9);
INSERT INTO workplace VALUES (10);
INSERT INTO workplace VALUES (11);
INSERT INTO workplace VALUES (12);
INSERT INTO workplace VALUES (13);
INSERT INTO workplace VALUES (14);
INSERT INTO workplace VALUES (15);
INSERT INTO workplace VALUES (16);
INSERT INTO workplace VALUES (17);
INSERT INTO workplace VALUES (18);
INSERT INTO workplace VALUES (19);
INSERT INTO workplace VALUES (20);
INSERT INTO workplace VALUES (21);
INSERT INTO workplace VALUES (22);
INSERT INTO workplace VALUES (23);
INSERT INTO workplace VALUES (24);
INSERT INTO workplace VALUES (25);
INSERT INTO workplace VALUES (26);
INSERT INTO workplace VALUES (27);
INSERT INTO workplace VALUES (28);
INSERT INTO workplace VALUES (29);
INSERT INTO workplace VALUES (30);
INSERT INTO workplace VALUES (31);
INSERT INTO workplace VALUES (32);
INSERT INTO workplace VALUES (33);
INSERT INTO workplace VALUES (34);
INSERT INTO workplace VALUES (35);
INSERT INTO workplace VALUES (36);
INSERT INTO workplace VALUES (37);
INSERT INTO workplace VALUES (38);
INSERT INTO workplace VALUES (39);
INSERT INTO workplace VALUES (40);
INSERT INTO workplace VALUES (41);
INSERT INTO workplace VALUES (42);
INSERT INTO workplace VALUES (43);
INSERT INTO workplace VALUES (44);
INSERT INTO workplace VALUES (45);
INSERT INTO workplace VALUES (46);
INSERT INTO workplace VALUES (47);
INSERT INTO workplace VALUES (48);
INSERT INTO workplace VALUES (49);
INSERT INTO workplace VALUES (50);
INSERT INTO workplace VALUES (51);
INSERT INTO workplace VALUES (52);
INSERT INTO workplace VALUES (53);
INSERT INTO workplace VALUES (54);
INSERT INTO workplace VALUES (55);
INSERT INTO workplace VALUES (56);
INSERT INTO workplace VALUES (57);
INSERT INTO workplace VALUES (58);
INSERT INTO workplace VALUES (59);
INSERT INTO workplace VALUES (60);
INSERT INTO workplace VALUES (61);
INSERT INTO workplace VALUES (62);
INSERT INTO workplace VALUES (63);
INSERT INTO workplace VALUES (64);
INSERT INTO workplace VALUES (65);
INSERT INTO workplace VALUES (66);
INSERT INTO workplace VALUES (67);
INSERT INTO workplace VALUES (68);
INSERT INTO workplace VALUES (69);
INSERT INTO workplace VALUES (70);
INSERT INTO workplace VALUES (71);
INSERT INTO workplace VALUES (72);
INSERT INTO workplace VALUES (73);
INSERT INTO workplace VALUES (74);
INSERT INTO workplace VALUES (75);
INSERT INTO workplace VALUES (76);
INSERT INTO workplace VALUES (77);
INSERT INTO workplace VALUES (78);
INSERT INTO workplace VALUES (79);
INSERT INTO workplace VALUES (80);
INSERT INTO workplace VALUES (81);
INSERT INTO workplace VALUES (82);
INSERT INTO workplace VALUES (83);
INSERT INTO workplace VALUES (84);
INSERT INTO workplace VALUES (85);
INSERT INTO workplace VALUES (86);
INSERT INTO workplace VALUES (87);
INSERT INTO workplace VALUES (88);
INSERT INTO workplace VALUES (89);
INSERT INTO workplace VALUES (90);
INSERT INTO workplace VALUES (91);
INSERT INTO workplace VALUES (92);
INSERT INTO workplace VALUES (93);
INSERT INTO workplace VALUES (94);
INSERT INTO workplace VALUES (95);
INSERT INTO workplace VALUES (96);
INSERT INTO workplace VALUES (97);
INSERT INTO workplace VALUES (98);
INSERT INTO workplace VALUES (99);


--
-- Name: workplace_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('workplace_org_id_seq', 1, false);


SET search_path = scheme, pg_catalog;

--
-- Data for Name: tab; Type: TABLE DATA; Schema: scheme; Owner: postgres
--



--
-- Data for Name: tt; Type: TABLE DATA; Schema: scheme; Owner: postgres
--



SET search_path = public, pg_catalog;

--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (cid);


--
-- Name: commentreaction commentreaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commentreaction
    ADD CONSTRAINT commentreaction_pkey PRIMARY KEY (cid, email);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (convo_id);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (city, country);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (msg_id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (org_id);


--
-- Name: partof partof_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_pkey PRIMARY KEY (email, convo_id);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (pid);


--
-- Name: postreaction postreaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postreaction
    ADD CONSTRAINT postreaction_pkey PRIMARY KEY (pid, email);


--
-- Name: school school_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school
    ADD CONSTRAINT school_pkey PRIMARY KEY (org_id);


--
-- Name: studyperiod studyperiod_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studyperiod
    ADD CONSTRAINT studyperiod_pkey PRIMARY KEY (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: wall wall_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wall
    ADD CONSTRAINT wall_pkey PRIMARY KEY (wall_id);


--
-- Name: workperiod workperiod_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workperiod
    ADD CONSTRAINT workperiod_pkey PRIMARY KEY (email);


--
-- Name: workplace workplace_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace
    ADD CONSTRAINT workplace_pkey PRIMARY KEY (org_id);


--
-- Name: comment comment_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: comment comment_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pid_fkey FOREIGN KEY (pid) REFERENCES post(pid);


--
-- Name: commentreaction commentreaction_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commentreaction
    ADD CONSTRAINT commentreaction_cid_fkey FOREIGN KEY (cid) REFERENCES comment(cid);


--
-- Name: commentreaction commentreaction_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commentreaction
    ADD CONSTRAINT commentreaction_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: follows follows_followed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_followed_by_fkey FOREIGN KEY (followed_by) REFERENCES users(email);


--
-- Name: follows follows_follower_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_follower_fkey FOREIGN KEY (follower) REFERENCES users(email);


--
-- Name: message message_convo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_convo_id_fkey FOREIGN KEY (convo_id) REFERENCES conversation(convo_id);


--
-- Name: message message_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: organization organization_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_city_fkey FOREIGN KEY (city, country) REFERENCES location(city, country);


--
-- Name: partof partof_convo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_convo_id_fkey FOREIGN KEY (convo_id) REFERENCES conversation(convo_id);


--
-- Name: partof partof_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partof
    ADD CONSTRAINT partof_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: post post_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: post post_wall_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_wall_id_fkey FOREIGN KEY (wall_id) REFERENCES wall(wall_id);


--
-- Name: postreaction postreaction_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postreaction
    ADD CONSTRAINT postreaction_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: postreaction postreaction_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postreaction
    ADD CONSTRAINT postreaction_pid_fkey FOREIGN KEY (pid) REFERENCES post(pid);


--
-- Name: school school_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school
    ADD CONSTRAINT school_org_id_fkey FOREIGN KEY (org_id) REFERENCES organization(org_id);


--
-- Name: studyperiod studyperiod_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studyperiod
    ADD CONSTRAINT studyperiod_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: studyperiod studyperiod_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studyperiod
    ADD CONSTRAINT studyperiod_org_id_fkey FOREIGN KEY (org_id) REFERENCES school(org_id);


--
-- Name: wall wall_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wall
    ADD CONSTRAINT wall_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: workperiod workperiod_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workperiod
    ADD CONSTRAINT workperiod_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: workperiod workperiod_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workperiod
    ADD CONSTRAINT workperiod_org_id_fkey FOREIGN KEY (org_id) REFERENCES workplace(org_id);


--
-- Name: workplace workplace_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace
    ADD CONSTRAINT workplace_org_id_fkey FOREIGN KEY (org_id) REFERENCES organization(org_id);


--
-- PostgreSQL database dump complete
--

