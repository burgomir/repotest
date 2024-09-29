--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: AccountType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."AccountType" AS ENUM (
    'PREMIUM',
    'COMMON'
);


ALTER TYPE public."AccountType" OWNER TO postgres;

--
-- Name: FileType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."FileType" AS ENUM (
    'VIDEO',
    'IMAGE'
);


ALTER TYPE public."FileType" OWNER TO postgres;

--
-- Name: ProfitType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProfitType" AS ENUM (
    'quest',
    'referralQuest',
    'rank',
    'referralProfit',
    'bossKill',
    'click',
    'farming'
);


ALTER TYPE public."ProfitType" OWNER TO postgres;

--
-- Name: TaskType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TaskType" AS ENUM (
    'SUBSCRIBE_TELEGRAM',
    'COMMENT_GROUP',
    'OTHER'
);


ALTER TYPE public."TaskType" OWNER TO postgres;

--
-- Name: progressType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."progressType" AS ENUM (
    'Referral',
    'Rank'
);


ALTER TYPE public."progressType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: bonuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bonuses (
    id text NOT NULL
);


ALTER TABLE public.bonuses OWNER TO postgres;

--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    host text,
    url text,
    status_code integer,
    method text,
    "user" text,
    context text,
    message text,
    level text,
    "time" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: medias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medias (
    id text NOT NULL,
    file_name text NOT NULL,
    file_path text NOT NULL,
    size text NOT NULL,
    mime_type text NOT NULL,
    original_name text NOT NULL,
    file_type public."FileType" NOT NULL,
    quest_id text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.medias OWNER TO postgres;

--
-- Name: orcs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orcs (
    id text NOT NULL
);


ALTER TABLE public.orcs OWNER TO postgres;

--
-- Name: player_bonuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_bonuses (
    id text NOT NULL,
    player_id text NOT NULL,
    bonus_id text NOT NULL,
    available boolean NOT NULL
);


ALTER TABLE public.player_bonuses OWNER TO postgres;

--
-- Name: player_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_progress (
    id text NOT NULL,
    progress double precision NOT NULL,
    type public."progressType" NOT NULL,
    player_id text NOT NULL
);


ALTER TABLE public.player_progress OWNER TO postgres;

--
-- Name: player_rank_profit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_rank_profit (
    id text NOT NULL,
    profit double precision NOT NULL,
    is_collected boolean DEFAULT false NOT NULL,
    rank_id text,
    player_id text NOT NULL
);


ALTER TABLE public.player_rank_profit OWNER TO postgres;

--
-- Name: player_ranks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_ranks (
    id text NOT NULL,
    player_id text NOT NULL,
    rank_id text NOT NULL,
    achieved_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.player_ranks OWNER TO postgres;

--
-- Name: player_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_tokens (
    id text NOT NULL,
    refresh_token text NOT NULL,
    player_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.player_tokens OWNER TO postgres;

--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id text NOT NULL,
    honey_latest double precision DEFAULT 0 NOT NULL,
    honey_max double precision DEFAULT 0 NOT NULL,
    balance double precision DEFAULT 0 NOT NULL,
    total_referral_profit double precision DEFAULT 0 NOT NULL,
    last_login timestamp(3) without time zone,
    last_logout timestamp(3) without time zone,
    level_id text,
    referred_by_id text,
    tg_id text NOT NULL,
    is_premium boolean NOT NULL,
    user_name text NOT NULL,
    nick_name text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    farming_date timestamp(3) without time zone,
    farming_end_date timestamp(3) without time zone
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_orcs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_orcs (
    id text NOT NULL,
    player_id text NOT NULL,
    "bossStreak" integer DEFAULT 0,
    last_boss_date timestamp(3) without time zone,
    hp integer NOT NULL
);


ALTER TABLE public.players_orcs OWNER TO postgres;

--
-- Name: players_quests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_quests (
    id text NOT NULL,
    player_id text NOT NULL,
    quest_id text NOT NULL,
    is_completed boolean NOT NULL,
    completed_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone
);


ALTER TABLE public.players_quests OWNER TO postgres;

--
-- Name: players_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_tasks (
    id text NOT NULL,
    player_id text NOT NULL,
    task_id text NOT NULL,
    is_completed boolean NOT NULL,
    completed_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone
);


ALTER TABLE public.players_tasks OWNER TO postgres;

--
-- Name: profit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profit (
    id text NOT NULL,
    player_id text NOT NULL,
    profit double precision NOT NULL,
    profit_type public."ProfitType" NOT NULL
);


ALTER TABLE public.profit OWNER TO postgres;

--
-- Name: quest_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quest_tasks (
    id text NOT NULL,
    quest_id text NOT NULL,
    description text NOT NULL,
    link text NOT NULL,
    type public."TaskType" NOT NULL
);


ALTER TABLE public.quest_tasks OWNER TO postgres;

--
-- Name: quests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quests (
    id text NOT NULL,
    link text NOT NULL,
    reward double precision NOT NULL,
    terms text NOT NULL,
    description text NOT NULL,
    "totalLimit" integer DEFAULT 0 NOT NULL,
    "currentLimit" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.quests OWNER TO postgres;

--
-- Name: ranks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ranks (
    id text NOT NULL,
    bonus_amount double precision NOT NULL,
    description text NOT NULL,
    rank integer NOT NULL,
    name text NOT NULL,
    required_amount double precision NOT NULL
);


ALTER TABLE public.ranks OWNER TO postgres;

--
-- Name: referrals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referrals (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    referrer_id text NOT NULL,
    referral_id text NOT NULL
);


ALTER TABLE public.referrals OWNER TO postgres;

--
-- Name: referrals_early_bonuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referrals_early_bonuses (
    id text NOT NULL,
    account_type public."AccountType",
    honey double precision NOT NULL,
    multiplier double precision,
    player_id text
);


ALTER TABLE public.referrals_early_bonuses OWNER TO postgres;

--
-- Name: referrals_profit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referrals_profit (
    id text NOT NULL,
    honey double precision NOT NULL,
    player_id text NOT NULL
);


ALTER TABLE public.referrals_profit OWNER TO postgres;

--
-- Name: referrals_quests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referrals_quests (
    id text NOT NULL,
    referral_count integer NOT NULL,
    reward double precision NOT NULL,
    description text NOT NULL,
    level integer NOT NULL
);


ALTER TABLE public.referrals_quests OWNER TO postgres;

--
-- Name: referrals_quests_profit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referrals_quests_profit (
    id text NOT NULL,
    referral_count integer NOT NULL,
    reward double precision NOT NULL,
    claimed boolean DEFAULT false NOT NULL,
    player_id text NOT NULL,
    referral_quest_id text NOT NULL
);


ALTER TABLE public.referrals_quests_profit OWNER TO postgres;

--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
146e2776-44c9-4102-bafc-d66d2d6c314e	ae665fa8f82b5200968677cd5025a0673accc06b834cf636895731daecc0f121	2024-08-21 13:21:08.542856+00	20240821132108_y	\N	\N	2024-08-21 13:21:08.432099+00	1
\.


--
-- Data for Name: bonuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bonuses (id) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, host, url, status_code, method, "user", context, message, level, "time", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: medias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medias (id, file_name, file_path, size, mime_type, original_name, file_type, quest_id, created_at, updated_at) FROM stdin;
63d0df48-73a5-486e-a179-06d68123012d	icon0.png	http://92.112.192.116:9000/bee-verse/icon0.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240731%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240731T084651Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=58dac2092d34b3fb908a5c53dd353349a7ae8c4e6dfe5e35397f3c415ce0e806	0	image/png	icon0.png	IMAGE	1f542c73-89e5-4ab3-bcd0-244ca6bfcccf	2024-07-31 08:46:51.77	2024-07-31 08:46:51.77
b190babd-ddf2-4304-bf05-dbb28420feea	icon1.png	http://92.112.192.116:9000/bee-verse/icon1.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240731%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240731T084651Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8e1a015af53fc67ce3e08a8688ef0d26f477878655a41884e657ea3c2f3a7d68	0	image/png	icon1.png	IMAGE	92596306-cf8a-4210-8e6f-b8a4d6acc2b7	2024-07-31 08:46:51.78	2024-07-31 08:46:51.78
3b584aae-0756-48ef-acdc-bf94b6911534	icon2.png	http://92.112.192.116:9000/bee-verse/icon2.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240731%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240731T084651Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6bfbbd1663e59214102552b734604917e5541fd268bb5c15f83f4afd630b22fc	0	image/png	icon2.png	IMAGE	0529c270-58c2-42c3-9465-684bd6d33564	2024-07-31 08:46:51.789	2024-07-31 08:46:51.789
63d1dd48-73a5-486e-a179-06d68123012d	icon3.png	http://92.112.192.116:9000/bee-verse/icon2.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240731%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240731T084651Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6bfbbd1663e59214102552b734604917e5541fd268bb5c15f83f4afd630b22fc	0	image/png	icon0.png	IMAGE	96c6e4f7-cb0f-46e2-8b32-c948d58d302b	2024-07-31 08:46:51.77	2024-07-31 08:46:51.77
cg90babd-ddf2-4304-bf05-dbb28420feea	icon4.png	http://92.112.192.116:9000/bee-verse/icon2.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20240731%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240731T084651Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6bfbbd1663e59214102552b734604917e5541fd268bb5c15f83f4afd630b22fc	0	image/png	icon1.png	IMAGE	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	2024-07-31 08:46:51.78	2024-07-31 08:46:51.78
\.


--
-- Data for Name: orcs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orcs (id) FROM stdin;
\.


--
-- Data for Name: player_bonuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_bonuses (id, player_id, bonus_id, available) FROM stdin;
\.


--
-- Data for Name: player_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_progress (id, progress, type, player_id) FROM stdin;
35fc28e3-390e-4b25-a7f9-367de473fe0a	10000	Rank	fa3bb8cd-9908-4339-96a8-d61927544541
51a6c5d4-c5c5-4ba1-bf4d-6fec850e873c	10000	Rank	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8
a7c17f1d-d308-4ba1-91bc-88155f2e2fc7	400	Rank	e3db2078-4a85-44a4-bf97-e165be03f56d
0d9f4f0f-0fc1-4605-bffd-f34e9212450b	10000	Rank	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e
46a35109-525a-4fcf-b69e-943371e15be5	10000	Rank	4c84519b-ac34-4171-91c3-0c664a03e2cb
5034fd89-be39-4e4f-a1ec-9c881c7cebf4	10000	Rank	be3f0321-d6fb-4442-8146-1eeee301be02
45da981c-954a-4e37-a048-0b57f658f3dc	1162300	Rank	5c88a435-14b9-4c7d-ae97-08c38822e5ad
025b9ade-0b85-4f70-bf38-fcbbb80accd2	10000	Rank	27aa7650-6bf0-496c-971b-013fe6af4bbb
3a3cef10-2503-4a78-b917-31cab2825cb8	20000	Rank	c442f7d2-81bd-48b2-91dc-4c64d172c548
3bdbc330-4350-40e2-9c16-151a2f1c56b5	10000	Rank	acd9b172-5bab-4a2a-987d-5b09bcfd94cd
34d65814-4517-45bf-b4a7-14549e771ffb	10000	Rank	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1
14cdf559-6b82-4453-b263-cd19fb89f332	10000	Rank	4fac8997-e95e-4fc7-af66-ad553fd9666f
92c011e4-63e5-4c61-971b-0a89ec59be3d	10000	Rank	77d18071-abfc-4f46-828b-27543aa92f25
047de35c-fec2-4555-8354-e9a5b18b154a	10000	Rank	d22a81a3-c6d1-43ea-a70d-14a4723d3a73
a9b948a5-e22c-4200-acaf-904c29a84240	296425	Rank	7b85a40d-2149-44be-a888-438cc50012f7
3f7d2761-018e-43a4-b310-8febe153c508	10000	Rank	32b069c3-007e-49c7-84fd-1231b4a2db4a
2a33f977-79a4-499f-b20e-812223356543	10000	Rank	44023214-fb54-41f8-b586-783d108dbaca
d298d7c8-1a7f-4ded-bc43-88ecc6ff2cb1	151133	Rank	7c191628-7c7a-4b36-85ca-4c6eb8333aaa
49ffb29d-f3e4-40e5-b9b5-9ec202690a24	10000	Rank	f29d087c-a6fd-45ea-9fd1-8b25224cfb58
fb057857-81d3-4c47-aa11-f736adf0f2ef	10000	Rank	35ab5d3f-c9db-40fd-a172-e7d5eedf861f
cba56a5a-d4b4-4080-9430-b22f26ab5b6d	10000	Rank	c503dcb2-b7ee-4f15-b557-e25053de9313
0119ccd0-fce0-4cbe-9c9c-540d14d2e897	80025	Rank	fc3cd5c6-17ef-4eb6-80de-4989687a35c3
d2a76310-cc6a-4858-81ba-51d05078e6ab	10000	Rank	8cbc9163-4ab0-43e6-bc37-9d092c4f8806
38864e6e-516b-411c-b13f-25a23ae4870c	10000	Rank	7a782bd7-27b9-4f47-a28f-a751d2793a8a
b6186f8c-4260-4e5a-8b7c-1c58946ad8fd	10000	Rank	aaae4527-f282-4a98-8c35-d644005b2c71
a2f3514e-2dda-417f-930d-d329692b3bf8	10000	Rank	923c26fb-cbae-43e4-8e2a-700903702517
28fdcdd2-d4a2-4940-831b-4b66b78867ca	10000	Rank	e1848ae3-8949-448b-a578-76726c5b8a59
f1e62bad-75cf-4973-92f8-ff9075402d1f	10000	Rank	cd4b3dee-e183-4c19-b6e6-a9c607a482e8
1d67ac9f-fb5f-4e38-a04c-af47dcba800e	10000	Rank	f02a6e78-e89b-4711-9071-f534ec255774
1a0886b2-26f4-4033-81ed-e0f182042eb9	10000	Rank	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f
6ce92fcc-5b25-4ae4-9157-a809ac7240ea	10000	Rank	73297b7f-b596-4f88-9882-5741d3c5bac6
ac378212-62d7-4d62-b406-72891706e740	10000	Rank	0862236d-23aa-40ab-870f-cbd711b4cf49
18bf4c7c-3453-4119-951e-0e4f95c19dd4	10000	Rank	0956d132-2c95-491d-9168-76b49d248128
fb63d83a-bcba-4b6b-ad0b-74f9247d6f5c	10000	Rank	6436b365-d1c3-418b-91fe-89ced8f83c29
d3dbf154-ec47-4018-b84e-80bae4c3b287	10000	Rank	420937c1-6b5c-4cfc-b5f2-f326fca9aefe
1f2246b8-1ec7-4950-90ec-6caea2c3dce9	10000	Rank	3179d2c4-c5ed-47ce-801c-086d926d6696
e6fb481d-1e1a-473a-a9ff-15d8ea70ffc6	10000	Rank	d9a810df-ebbd-43b3-bed6-958e9255d059
fb4c2dcf-69d2-4ea3-9723-4ad00d6d81fa	10000	Rank	de1e208f-eef0-49dd-a47c-a7316b98868a
ce3c85aa-5456-4686-a7c6-ad60c40dfe9d	10000	Rank	c50e0244-2708-4828-b435-a538437d7ccf
0a69ddbc-aa20-485f-8730-21a0ff3fa85d	10000	Rank	b274d74f-cbb7-497a-a965-5e0b773efb43
32ff8304-4d87-4f8a-9f80-e3ec804041e1	10000	Rank	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1
6601de35-29f7-4f77-bb66-7d887b6c13a3	10000	Rank	6ec71334-96e8-40e6-88b5-722780e75cdb
b4454021-fd57-48d8-b135-42175532bd25	10000	Rank	694885f7-dea1-4c4c-b5d6-69997bb57ed4
7c7365dd-09dd-48a2-9376-44a3153eae77	10000	Rank	bdf20892-6c04-4799-85b5-0a7ec60d11a4
9474b420-851e-48ca-91cc-82c514fe583d	10000	Rank	1b41e70c-950c-443d-bf3d-d57c96af8cd4
0ca437f0-285d-4693-8129-5b2bd14898b5	10000	Rank	9889a17d-730f-4b7a-8389-8e4c7d0f45a5
a8f5ba4e-5f25-4e71-beb9-1b9bdba324bb	10000	Rank	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6
d34c5053-b45b-4c21-9eac-102383f596c5	10000	Rank	cb580957-0a49-4957-bd17-dd73c6e5fc1d
3b64952f-422b-4e63-a33a-af17feec0317	10000	Rank	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf
f70fc814-0c3f-4d7a-a62a-24f7395d0cc7	10000	Rank	068bbdd8-214c-45c5-bbd3-31400b5775ad
57865a37-52f7-477f-85ff-383c2b097c15	10000	Rank	346af1cf-7bef-45e2-8fc6-9cfcdaa05300
410b468c-cbc8-4b34-9340-67dec81d9c02	10000	Rank	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a
e6765e13-55d1-4c03-9756-6a513853fc54	10000	Rank	93492e19-b481-49c2-a2d6-c5e3644e3b2d
c5bca918-887d-4f40-a033-794b7ced25ff	10000	Rank	3ae64b94-ddef-401b-b345-1cd8696fd967
bf1f0a0d-387b-4121-87d5-b520b3fb0a2b	10000	Rank	97647052-9891-4bd9-be9b-679ca79cb1d1
49c25f13-362c-4097-a193-5c9d647a00d5	10000	Rank	6173e277-f662-4720-a5a1-f34a8bb9221a
dccecc27-8298-4079-9499-5de498abfeea	10000	Rank	b356cbf9-9aac-4203-922c-7904d844f00c
ec7a6774-3253-4596-a637-e59f0ebc9e29	10000	Rank	6dcf36ea-cec8-4420-97cf-f665b506fdb6
272a49ca-f0f8-497b-b099-c05b2207e177	10000	Rank	c1cee951-d219-41cf-a647-a61d07366fe7
b96f156e-db79-4328-a4a7-b793a6ab728b	10000	Rank	0c957416-3d9d-45bd-80a4-780cb657a77b
ac3ea2f2-21c6-46e9-bccd-4a194398a00c	10000	Rank	2162f56a-8ced-4b3d-b071-1df7dc6760c5
f0c61104-1c0c-4300-b8d7-d31b7895000a	10000	Rank	60d6a675-4f9f-463a-b239-9e2643aaa8a9
4d0a4e63-804c-4f89-a41f-af9b7f8fb6ff	10000	Rank	808c6a76-ec6c-4090-af68-b7ee4c8f3630
457741c1-7286-4a16-b1c2-4d410e3072c7	10000	Rank	51be77b3-787e-4364-8765-273088974e06
f94b6f2b-db4c-4cc2-9fcf-1772f0c76f22	10000	Rank	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f
2f2ea782-ff87-46ac-b736-0efc8967839b	10000	Rank	2db49b30-71d7-4b16-affa-c4ae49003071
f9ea3b20-c820-40bf-9e84-54a2215c5fa4	10000	Rank	5c1d9e49-c3a0-4198-8f78-654398a73090
88558440-a21d-41cc-beef-fe5a196258ed	10000	Rank	4c235c4d-1364-415e-a369-827f9aebf9a7
49a133a2-7e54-4b68-8158-a06735fb92d3	10000	Rank	efa9d746-3805-4405-8b7b-191b9137f635
ae579d09-dc6a-46a9-b033-f52cd695999f	10000	Rank	45add737-f340-4de6-8273-a3c9b62d7e77
e3231245-a0fb-46d2-a2a7-0e6356762de3	10000	Rank	dd39ed92-48b8-45c2-b336-bb8e8b05013d
952e76d3-c7f2-43f8-a503-630059b4cf3b	10000	Rank	901d66ce-8dd2-434b-92bc-052e6471a88c
4aee5eab-c9be-4f29-aa8a-359f58ca6934	10000	Rank	3c77db66-8cc1-4953-a924-d038408f309b
cbd5d580-200a-47d0-804a-551d7c56bcb9	10000	Rank	cecebe61-8db3-44cb-b651-29619044d686
f881da80-5945-45a0-a0f1-dce414406994	10000	Rank	dc58f57a-d332-4991-8059-634d9a50df68
c6136493-0dd3-4bf8-9d02-8f0a6d3e4a52	10000	Rank	f690f183-cc78-44c1-b56d-98814d650919
e018961e-ae96-43d6-ac6f-e0c1cf2c85ca	10000	Rank	a67b6419-7eac-4a49-816e-2bfdefde7c10
79b740c2-1b65-41e9-aaa0-a51a78f24cdb	10000	Rank	a8ccaea5-750e-4025-9374-ac12553f823d
edc53995-c31c-4421-bf65-706d566ef836	10000	Rank	2292c89f-3fe1-4b0d-8592-ad943a5be66c
af18c9df-123f-4a95-a813-2c8e29b8dcd3	10000	Rank	755575c5-5262-402d-97d2-7563d211eb9c
b2e8c785-84ce-4786-8f68-184fcadb26e8	10000	Rank	8982b883-6019-4b06-8215-e28dc2a5914b
1924ddb2-a5b9-4b40-9bfc-4b30a2b72ecd	10000	Rank	6ba47e11-ccbb-40e5-bf31-f0f22a10454b
e6d36fb3-3f60-4979-86ae-ab8d13137b8b	10000	Rank	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a
6071bb5e-3e42-409b-b5e1-31c5e20dca1f	10000	Rank	83be342f-6be5-4728-9ec8-0aad63fcb18f
f96fd2ce-39bd-4a36-bb81-71c033abb6e1	10000	Rank	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6
4a256e06-af02-44db-ad61-b147c170f2b8	10000	Rank	f39447bf-b1df-4970-89f7-a4df15c2a0c4
91b199a7-3ab6-44c5-a663-678a40d00f63	10000	Rank	730c98e5-5ace-47c0-826e-c3543c9686cb
52d0f25b-3df4-449f-b219-34adf7908c3b	10000	Rank	c854f638-c2f6-47c3-8da5-8c688cb1f78c
9cd9b65f-ecf5-4858-84db-998325d3b4f1	10000	Rank	05ab2789-6d48-4c89-869f-abe089fccb4a
62336c2c-e691-47b9-a07c-ac25afa67b9b	10000	Rank	5891f499-7cc8-4d19-b3de-4b15c0624ef7
3e53e1d5-758d-40f8-b7f7-6bcde9a13eb9	10000	Rank	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815
dc5d1b5e-1fc5-40bb-9a9f-e04af14641c6	10000	Rank	526b8286-c88a-40e8-87ef-b94ebea9e97d
015e0c83-26b6-41bd-9df2-b72f3453463d	10000	Rank	49fe0add-1125-46cd-a368-f8411e43c44a
80f28113-c421-4cd1-9113-dcdff1454e8f	10000	Rank	6d20670c-72c5-45d5-8525-9912c5ec1058
357eded1-4aaa-491a-8fa0-08465ee36065	10000	Rank	d33ab7e2-0a7a-4266-912b-55c5f5b18241
80dc1f4c-c239-4d06-8345-e87867a5e4d2	10000	Rank	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9
7d7dafeb-ec26-4b75-b294-471c742ee78e	10000	Rank	6c1cc459-173c-490c-9990-d222300e188b
5f5b1325-e631-428c-9f22-97e471637d43	10000	Rank	c62c44fd-85cc-4edd-a070-96a4ee09bcf1
c42b647a-0f09-42fd-bd5e-b25aeff704d1	10000	Rank	e64ccb49-7042-4678-9ab6-a8b8dadee65a
8141e058-7529-4f5a-b6cb-a768876acff8	10000	Rank	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd
f2008a69-cf2a-446c-8010-1eb9c90dca1c	10000	Rank	5db49be2-2435-460d-a6f4-f45b2f275436
50fa1304-65f3-4d12-9029-0feda348cf4a	10000	Rank	f1ba7109-837e-4fd7-944b-54d3b997fbfb
09e1fe3d-f480-4f11-b111-96ef6a0afc65	10000	Rank	5d4f5985-c330-48e3-a1e0-23760bc73f4f
8359bbbb-f8a2-46e5-8cd0-0b5c8e0338df	10000	Rank	a3c59c5b-c711-415c-b371-98ffb520891a
ee610413-9943-4c26-b9b7-be162215a3fd	10000	Rank	c49c5171-b397-41e5-a8cc-c3933347189f
207cabc0-a7f0-4d1f-8147-b1908bd1e6b4	10000	Rank	a5266896-6503-4e85-a895-a82fe27c14c7
53b399c8-a88d-489f-a4c3-5bf10a5681ca	10000	Rank	9100f2ae-e4cd-448b-b40b-251e0eb3572f
c2cee4b3-5c1d-4dec-a235-e6092ef3e65d	10000	Rank	c95385ce-966f-49ed-8b4e-7b162d2b0d66
88ec94a4-2df2-44e8-9ff7-e20e2ac6d77a	10000	Rank	aef64f27-4ed3-47d5-8620-68378fb412ef
8969d3c7-b55b-47e6-a448-560e2d7ebb16	10000	Rank	98dd5bf8-d2c3-411f-9fdf-57c51a150113
36575d45-d46d-4e3c-8c48-34a9cc9bc676	10000	Rank	c995dc27-5dc5-44f1-ad05-6f3d0350fe17
64c2d996-5d2b-442c-a566-0e03c3f2d6f9	10000	Rank	85729935-7993-4125-8562-127b29db7e60
5dc30fbe-9f7c-4c19-8819-4db8d2d52b89	10000	Rank	37d990e5-99ac-4bd1-9700-7f0efa185901
8ce24ad9-1b33-43fc-82c7-0f138f983b31	10000	Rank	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a
ee1e4388-e7c3-4b88-8491-1a31f74cb2ec	10000	Rank	a0a730cb-ef7e-4d49-a0a8-103d50af54fa
29ea7072-c01c-416f-b200-489f0005bf71	10000	Rank	5eca0755-2466-4feb-851d-1e3f407260df
824644fb-2fce-4dc4-89ec-a779dd5d76dd	10000	Rank	de0ce717-6916-4879-a04e-dbbdfadd4545
85ef0405-bf42-4194-ae38-1006db5b3261	10000	Rank	e0dbe070-d1ef-4573-8391-450a4b3eaaac
193f6745-7f79-48fa-ac38-2d175747593a	10000	Rank	63e30fe7-562e-4f11-9c47-09fa6e5188a7
07169889-8e95-4c5d-a322-369f53093c51	10000	Rank	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9
93f50362-9d9b-4bde-be02-05060cc96c2d	10000	Rank	8e934c6e-187f-42da-9467-6ebc7ccd08bd
be81fb06-ee20-46eb-a964-63347fd7f2da	10000	Rank	3eab8b06-c057-432d-8042-0b15ad87bdc7
60e2f0d7-0af5-496f-9118-246ac17a2198	10000	Rank	971f7c33-1a8f-4d58-91c7-9342a9acd69a
25389598-226d-4998-8fe2-bd9e98f0b03e	10000	Rank	b7930946-5b11-41ae-9385-a05ff8b0bb77
af814563-cfae-4650-8b23-d6f8e24ecfcb	10000	Rank	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b
0d78d17d-1a14-4889-9d75-7641f03b126d	10000	Rank	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273
2cdfb2a8-c760-40df-8c4d-f8001ed10461	10000	Rank	e84e7f8b-1821-4957-962a-063ce11ec128
47dc1b99-3a2d-4c21-a5ce-ff8a3275f4a6	10000	Rank	dc5830a1-fb20-4421-ae24-00f9be9f0f04
6674d29e-16e4-47b5-ae8e-a390e579677e	10000	Rank	d79cceb2-5cbb-4477-981f-491a969067b6
8dc4c071-4b86-40c2-99bb-2c068f735050	10000	Rank	7165d010-24ea-45e2-994d-4597b6f7dc05
50d1ea74-0204-479d-abf9-14046cd5bde8	10000	Rank	5c5f698f-3444-44bc-8055-c004d592e0f8
5fe5de1e-c61c-4d8f-a964-03eb44c8a1f6	10000	Rank	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413
59f95f23-cd06-4f4f-9c19-6da3292b7a54	10000	Rank	5e0f7570-92f8-4c39-b7d4-e89276778d25
3d1b0782-887b-44c4-817f-c00bad4f08de	10000	Rank	86d277ca-6952-4753-9e13-ccdffb252b7b
b17277e0-c445-4813-843d-d52100c79c4b	10000	Rank	dee1a302-1c56-4b6c-83f9-3bd8bf27323b
8516ac95-4465-4efb-afb8-5568e99bce09	10000	Rank	e11b9a8c-c94f-48b5-b192-1a769c1442a7
06f1e373-8678-4ae0-b8d9-517d1a53d5bb	10000	Rank	5c7b80d2-5a14-4b72-ad4e-b30749b13074
d96595db-36a2-4439-931d-407eda898ad3	10000	Rank	0582992a-1e2c-4add-863b-b5f10d6b4992
8f3b3d65-a5c3-4f40-b229-a759c69598d8	10000	Rank	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6
cafd557f-b074-42ae-b87f-764a731e961c	10000	Rank	a6759a4c-fc93-4995-9a6d-d30488ab7a12
2e945581-5f9c-4228-aacb-81c5c4d9c61b	10000	Rank	e045da04-0570-4317-a560-7cbfeae6f59f
e1ef2b40-197a-4b2e-9d56-2772fba320c0	10000	Rank	573cd423-824d-4f62-bef0-2728da79fcaf
44c91337-53f9-4568-ae3a-9bace922cff2	10000	Rank	40b38dd0-c020-4e26-bccc-14f5bfe21970
456a0f5c-a71c-43bb-9c2b-50afa1607ec3	10000	Rank	1d8467cd-0105-4e3e-957c-446e325920cb
927d0485-f3cc-4b9b-b1ea-9319ca039e8e	10000	Rank	2a74d774-a7c5-4b5f-839a-b1911e457bc2
3c9d4e31-fee6-438f-a337-a38392dc64a8	10000	Rank	ff338a1b-41d7-40fe-b370-c88ef7d387f8
54171809-2fab-4bfa-a8d8-68901f9a3d63	10000	Rank	22285a4b-a9a8-4aec-895e-5ea13125722b
cc6ce62a-7095-430e-a231-e303b4b331e4	10000	Rank	85b28ae1-f517-423e-bf6f-ef189248faac
caed1baa-54d6-4c49-851b-21fe6b8076d0	10000	Rank	542780d9-35a1-4582-86d1-d9ff5971f4ae
5cd2fab7-51ae-45e0-ad9e-00aaeb4fc1f8	10000	Rank	bd03e8cb-4881-43d1-aaaa-fd192db5b90f
dc7b4db4-5052-45b4-9ccd-814e8a894e2d	10000	Rank	ff807dea-119e-487b-9e10-1f7a83b4e172
60db4ccc-a688-442e-bcea-446ecf2f0ca3	10000	Rank	d816ad42-c674-4776-b507-f2ae86133a4c
628f1780-05ff-4b8f-8c31-346924fe3fcb	10000	Rank	77d3e7a0-1cee-4856-9308-ae8830306caf
240e0a92-d990-42d8-874d-22f57e01efd1	10000	Rank	3986bde4-e078-452d-ae3e-fd93454b4ce2
70c46716-69b7-4566-aa70-b3024d379ce2	10000	Rank	db7f8158-f71a-4ecf-a0a6-48439a05d657
5de7684d-cab3-4385-abcb-8982384fbbb3	10000	Rank	1131c61c-771b-4a75-a014-40a4731b9efd
29667b5b-39a5-4482-90ba-0e930dfc7175	10000	Rank	e1e70295-5c37-4c51-8167-9898b9c506f2
4a617023-b06d-4c66-9301-4675bb106259	10000	Rank	37e4bdbe-f7f9-433a-a726-c9990700701f
dbdd3108-094c-47d8-a114-79e37d33148d	10000	Rank	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3
1b620b20-6b1d-4ddc-be05-218e0db6c3e6	10000	Rank	a2643314-2a6f-4af7-bb1f-11494179d800
59426055-de7e-412c-875f-9d844011e134	10000	Rank	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec
e6b8f4e6-f279-4c54-aa94-58d31b05a4eb	10000	Rank	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b
8d500f08-c67a-4263-8c10-42ec3c044eca	10000	Rank	d543f357-e99d-4d70-b7be-2a98d055c997
3943ca9c-b846-46fa-b82a-87984c923124	10000	Rank	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce
43dc9a4e-0586-4b6f-b6f5-3170207ea7b7	10000	Rank	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372
c1c7c53a-bacc-4ddb-a85c-8120ce735b67	10000	Rank	d1c81fcf-526f-468c-b8f1-1de6fe5ce572
2f3a0ae0-b953-48a6-9c8b-dd85247dc5a4	10000	Rank	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965
f9126d9d-affe-4fa8-871e-e44c8998c1cb	10000	Rank	59be1293-6788-45c2-b12c-d35d03727da2
0d878144-1d60-4aa0-bb80-26f458d2f13f	10000	Rank	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8
1545d8df-4368-4546-a297-4ee0bb345724	10000	Rank	e1a109e1-01cc-476f-a100-046326507dc2
ab994ccd-e2f3-40af-ad3d-7d970475d5e8	10000	Rank	1fdcbf6b-e670-46e6-a1f8-308621c26735
4d4b789f-5917-48ad-a5ad-b1e9681fee63	10000	Rank	0c875a99-42f1-4cb4-88ed-398b1c25b9fa
226d6b32-3ed0-4388-aa75-6b60074cd000	10000	Rank	f423e5f2-d2de-4a4b-983d-7faeee04b0b2
af808329-3a09-4463-9395-1cf0b905298e	10000	Rank	bfc42f90-715d-47dd-bc34-8a3983fd76e5
4d08b76c-c7a2-43f2-9237-faaea68201de	10000	Rank	21782926-7972-49d8-b5a4-8163dda4d8bb
2e739036-fdbd-453f-ad92-0ad15cb0e2cb	10000	Rank	3ba67b11-9e37-462d-83b5-ca4defebe4ed
6d370afe-422c-4f85-8605-c8fe3f562400	10000	Rank	5cdf5b4f-0b52-4adc-a49a-6145cb01c326
96148480-25eb-4f11-841f-6db500b93681	10000	Rank	38922471-48a4-430b-acf7-80399379a847
78b37f00-a9f9-4471-9613-39f77cca44eb	10000	Rank	7d9c3111-4710-48a5-8e57-42e76f785f6d
1cd5db6f-55a9-4ae6-8ee5-3d4014cff66d	10000	Rank	619ff42b-d080-4db1-b808-d769e69bee7f
acbad3da-1b43-4bdf-b1b7-e34671b9001e	10000	Rank	c5533212-9300-4d0e-b460-5eabc1fa4a0d
6d61f6fc-cac0-45c9-a00e-a6f7ffc3424a	10000	Rank	b68c623a-ffa3-4a48-a3c9-76f2f700775b
be97ae91-c1aa-4816-a11f-3ad0a9cab5c2	10000	Rank	5cd93a3b-b144-453a-a229-2757cb28df22
b1048669-fcbf-4529-8ee0-89329975d374	10000	Rank	4dd9f659-75d6-44f8-8fae-ac963c6746ab
a66db132-a886-44fc-8254-7700740b7f31	10000	Rank	c357212b-e065-4c65-aaa5-7e8b8a14cfa0
f4928beb-32dd-4906-95ae-ec94ff6c2767	10000	Rank	f3fddd33-f77a-40e4-9897-55e61230d643
2b6a4079-1967-492c-874d-4769e71ff113	10000	Rank	5434fac2-36e9-4ff9-9955-ba531fbb1ba0
4508489f-1d93-4b31-96f9-610149b23b6b	10000	Rank	1c23cfd4-f4d7-49c5-8760-9600e414027e
9deabb8d-7e75-471f-85ca-14d75767b38c	10000	Rank	31ae5186-dc5b-42c3-b676-8590c96de53a
c9e04ac7-7d96-4aa6-945b-f9aba082c177	10000	Rank	d2615292-a50f-47ff-af73-437ec1eb0fea
194df782-6c07-42cc-bfbc-0cc0a964e416	10000	Rank	9f557edb-8adf-4832-bc25-ca5b00dfcf4a
e6395e50-251f-453e-ae96-25763c9b41d5	10000	Rank	8fbf163b-f453-434e-ad19-10228894ee8c
06da74db-00c4-410f-a57c-34023b339cf1	10000	Rank	d2834bcb-2154-433e-bb06-e8befbfd7368
445eea79-57d2-420c-8c09-1748ca7be2c8	10000	Rank	88421493-e09c-407b-91b7-a2bf5f633fa6
813d3e84-5390-4a75-8688-e14c9ea2ac23	10000	Rank	45f32ed2-3673-4022-b0ad-e4d60362361f
d0060660-d9b0-4c6d-bbd2-8d263b8813b0	10000	Rank	a6975bcc-4113-475c-9da0-5dcb952cf919
7212d1c4-85e5-4b85-a902-e1cd197501a6	10000	Rank	eb838509-93c4-4e2a-a8c3-3bffd2acc82c
7fb134a6-f912-41e9-84f0-04d7a9070c36	10000	Rank	815ba1e6-a405-4df4-9909-7fbc8e87a4ac
6504f5e2-63a2-40dd-a4f8-d948a087b440	10000	Rank	473b85ee-3707-4f2e-b370-74e791f3fe1e
a20f69f0-55b9-4080-9037-71ecfd8b41e6	10000	Rank	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2
09fb0c72-4d7c-4384-b936-604412b99f2f	10000	Rank	e88ff86f-02ae-43ba-9060-727ec1a5558c
f15b7938-edef-48bd-ab18-baca63e32f73	10000	Rank	0e562d45-0328-4a97-939d-cd11bb7f2ed2
807bac47-0a01-4100-a07f-49b44b931319	10000	Rank	6e4e0e64-47ea-44c0-a997-25766e1a85c1
ae4dc658-dcd4-4995-91bf-a93beb88ab5f	10000	Rank	6ef284cd-4c54-42c0-99a0-619cb8442030
c14b57bc-8fed-4fff-9aba-9da6d0d5344c	10000	Rank	bce15c48-3692-4a64-a01c-9ae16080077d
29ebd365-7c2a-4366-9e2a-2c9b1fa2c3f6	10000	Rank	d6bec1d0-48c5-4652-8612-b4667cb1c442
cd8e7dc0-fec3-4268-a113-df08402d18e8	10000	Rank	c8434922-ec69-4e01-beef-8cfb6ad0f92b
dee55967-6d1a-4939-84ab-eae76ab8e86d	10000	Rank	cebdc43a-6173-4d07-99df-6ffabe415516
729f93da-c54d-4eb1-99e5-f9f28a978660	10000	Rank	380bb01d-d981-4caa-b479-6089a516a075
7d032227-7a8a-4394-9cb3-d08913c8c142	10000	Rank	949c4f91-4f71-4751-8c96-4113f5c1672f
6703c386-76fa-4dba-9d43-2c9243b8ca51	10000	Rank	ffb1879e-5a8e-46a4-80ec-fe36bd67e584
eac5d075-c89e-49a9-abb6-92605824702a	10000	Rank	9f19df17-a951-4493-944a-cd158fd5ca1a
406bceae-0318-4793-a7cc-bcb6ca282886	10000	Rank	f968fe68-30ae-42d2-9e74-08bf8e223215
ef4d74e8-f961-414a-b7a0-1a855ce0904c	10000	Rank	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad
d6f477d5-f483-46b5-98f8-e1bdfd510ee3	10000	Rank	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94
31bfd5e3-06d5-4e02-a6cb-91e56bcd9550	10000	Rank	8749fd89-444e-4786-b0cc-6fed521bdc27
45933747-be53-44b7-ba2f-469d5cafe835	10000	Rank	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c
a8b747af-05a0-456d-8a6c-eb7074e7b4f8	10000	Rank	3ecb5f1f-0418-41cd-af4e-93a4f558c522
a35823a4-7528-435f-bbb6-01d04f5a9184	1	Referral	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8b654ce5-b551-493b-b7e7-9f1601df22b2	10000	Rank	7170f559-0812-46be-9851-f1142c91d14c
3066a00f-3d17-48e5-9d64-73b60a12927d	10000	Rank	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90
2a1463fc-2aa6-4c25-a0ee-04ebd54f8b64	10000	Rank	21bc0cfa-c69b-454d-9c5b-4261dea59a6d
bb5fc6cf-3e5a-4210-932b-6d85036e0214	10000	Rank	53d6dbf5-e190-4641-95a1-d734632637da
7fd04696-ccaa-4a89-a283-418f7dd2b853	10000	Rank	5566b584-2023-42f9-b25c-04d15223cd5b
0d51552a-a192-46af-bfcd-a7087bfed5b9	10000	Rank	759b3797-b95e-4abc-a83f-c37bd6aa090c
0fc8d645-9dfc-4256-b0be-bcf5ca97ef96	10000	Rank	1203d0f1-1816-4998-93f0-bdb05c314cd4
ed6c076c-1a20-405d-bee7-c48bf85f686b	10000	Rank	d04cb17e-fd2c-4727-acd1-76bad464dd01
c451bb8d-540c-413f-a778-0508c809ba27	10000	Rank	31765d40-d378-420c-a0b4-ca49e7ea59f7
ff584639-60af-4d89-b18b-59058aae4941	10000	Rank	5cb277d0-f9a3-4de9-9041-470811eeb375
de336e59-3d96-4558-99ee-aad65fde5812	10000	Rank	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6
dd8eee4a-5d10-4ddd-9866-dcad85d1dd68	10000	Rank	57734c90-01d3-4f4e-828c-1201f65e42bf
e2e9a4d5-1420-4302-8c2f-47413c344e40	10000	Rank	2f0dee24-3f81-4ccf-8244-d6488d087f1f
0ddef4bf-9380-4993-b4cf-221d1796b276	10000	Rank	d19c8610-487a-48fc-87a1-9de1b1b9cb83
1f4f28bc-f80f-469c-bea8-e1ab0a399d5e	10000	Rank	b6c3d582-e6cc-4814-a38f-7df873654608
0e3c413b-3ef6-477b-b4f9-e14d950d12f9	10000	Rank	bc505c03-f9ae-4e0f-99d5-a29a56830b15
7e64db1d-a39a-4c4f-a916-be62c7970506	10000	Rank	145ff272-c8be-4461-b4aa-1a161a921aa8
4de4bcca-73ce-4ad9-a947-15f7fbde7c8c	10000	Rank	7e5114fc-def2-4929-91d0-7ca9dc68b2ff
a180ce30-65af-41e3-96dc-a7b349ef11c4	10000	Rank	e999b8ec-ee7a-4889-bec9-9afc50e88dce
c790f932-ca3b-4d70-a1dd-2888886ad6e1	10000	Rank	1e65b0bb-703b-455e-a307-7f82464055e8
74ffdb9c-da5c-4095-a382-f050f0da0532	10000	Rank	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9
91a30cc1-0f9a-4247-bc16-40285423abf7	10000	Rank	95f8b881-4861-4f7f-a209-5e6cf25b8d78
282652ea-09fc-4470-b96a-bde3b924afab	10000	Rank	d62f5ea4-de23-4db9-afb5-db9334809de1
6edfd858-6c29-47f2-93ee-6a02fc3e16fb	10000	Rank	3bf937ce-d0c5-43bd-9119-f8590a8d574c
8834de31-0cfb-4f01-97c0-11b47cd6c12f	10000	Rank	616544be-8229-4e20-b1ec-3a286664cef5
2d869f0b-12dd-439c-93c9-d233b7062535	10000	Rank	e46a8c26-7345-4fed-b81f-2f3ebe9f3864
3765d910-e24f-411c-9c65-d2cce512accc	10000	Rank	1cb6a9e2-f9ba-412f-a284-23e6657ef879
6764e37c-dc70-4593-a554-96a8fcf0213c	10000	Rank	98431e33-b96a-4c71-a52d-07883fe7e945
1a88d5f1-d61f-400f-b76f-05fad7af6a63	10000	Rank	9eca8ffd-2cf1-4293-af11-ed381f31d2d9
bc272457-2ec3-45cb-8ff5-91ccd5169d9c	10000	Rank	77d3d92a-1bc8-4648-b22d-401a09d08ab5
e2ad8810-9a26-4757-8f1a-0de64e982fd3	10000	Rank	182027a1-551c-4601-9b84-497348f94e1c
1dad17f2-518d-4c28-a7ce-9b95fed3c83a	10000	Rank	1caaf02e-4ee5-4c2b-b520-5846341805ef
ceaeb241-f889-4009-87dd-15910648d7f1	10000	Rank	7d633720-08f4-443c-942d-8da74df41a97
0ec3decf-0dd6-4ad6-8543-3d3c80d7427b	10000	Rank	bf1a2431-a918-4a36-8334-ab6545e430f7
7e1c9eb9-b0db-4a53-acd3-fb592e98e239	10000	Rank	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8
4b123697-21ec-4eb8-a336-5755fc419ff6	10000	Rank	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c
45408b9e-3430-4b4b-80e3-567a2bd3b481	10000	Rank	237b4a46-2822-46cd-b0ac-c82739829a00
5645b117-fc54-4e35-94ec-21d3a03f21eb	10000	Rank	51f92be1-4f22-406b-816a-637ac9c1f180
1ffeae28-746e-4684-8c8f-2c28c52e84e6	10000	Rank	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f
0a6662d9-a637-4043-8950-78a7dc767206	10000	Rank	5e30ec44-bf17-4518-b5c0-2c1d552a9777
8a2b0175-39d2-4721-9ba3-14f658650697	10000	Rank	a080de1e-d906-40a2-9bb6-c3e7528d2b87
a227aa6b-08c1-4b60-b872-2fc32ef500a6	10000	Rank	20bc764d-59d8-492a-b1e0-3d9814ad034e
b5a0c2eb-e62f-47bc-a290-1ca5e50202a8	10000	Rank	188e2d5e-977a-4730-a383-0cf6431ec5fe
6e9bee39-84e8-4e69-84d2-88ca5e2d12e6	10000	Rank	a18c5901-3cba-4f12-913a-2f901f7eda55
50c3f152-ddd2-41d4-af01-955d1fc51f88	10000	Rank	6ae32738-74e8-4c49-91cb-e39f7e5df371
142f51c6-10c5-4b37-a88d-1ef3d1206066	10000	Rank	1e968ba6-7a32-4112-891d-a59c12be57c3
8b946950-b01c-47f7-bf38-6f5b0efb0d3f	10000	Rank	150bc895-b1c4-48b6-8acc-513947236dd1
865e92f8-70dc-4db8-92bb-d7a13aa25887	10000	Rank	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a
8c1fffef-19ac-4a8e-a2dc-33a0ea6ddec3	10000	Rank	eff4d266-7f89-49e1-a67c-29c28ccd7b9f
95bc65ca-4e16-4173-8bf9-50d906b1197f	10000	Rank	199da7e4-25bf-47ff-9e51-b5c412af57c9
27d2a310-8acc-41ae-9866-743b135a9af2	10000	Rank	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2
c634c2ee-e70c-47bb-a22b-5ebb5f705187	10000	Rank	2bd87bc9-bbe0-4a68-b661-67cfc55995b0
87451d01-7759-4156-86de-96a94972ca3d	10000	Rank	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd
70a761db-5504-477c-90d9-6073430ea105	10000	Rank	e1f5d089-9099-4909-805c-7ddbdd74e0a3
c3f06d5d-6728-4fac-b842-604c8e1fa9e4	10000	Rank	5f4a33a0-6d96-44ab-8d8c-24a62013003f
6aff9ca6-9eba-4d28-a83b-cc92748384f1	10000	Rank	1532bb49-0e32-4841-8531-eb9f7d831abf
5e78bb32-95a1-42af-a7b1-99b415ae6a16	10000	Rank	03c031d5-def4-4c9f-9c43-ead660b2ecd8
ccd65071-c62a-4794-8aa1-c56d24549367	10000	Rank	fd5550aa-da2e-42af-a466-67e2c59fe268
350a3dcc-9a16-4f29-8d80-d9e09750fd2d	10000	Rank	85b9217e-e690-4560-862d-523b8ddf7390
fc9d545f-4329-4171-ad2e-b4fa9b0ca3c3	10000	Rank	3c5d9bb9-923d-4745-a499-06d2421d8b06
e2b46bf1-5b7e-470e-a276-5c2fb44adcaf	10000	Rank	642a9f33-4469-4b32-b68f-cb043424e73f
42cf1994-2051-4a0b-827e-047bc7cf6167	10000	Rank	f8f489c5-baee-42a7-a22f-ceda8b8d760f
40a4c3ca-77db-4b95-b11f-b8386dd763ec	10000	Rank	ba12359e-af2d-44ae-b25e-9430f2d3fdc7
36283ae0-ee5b-4024-a05b-9ef153718bc7	10000	Rank	e6286cf3-32ef-43d2-927c-c8c62b50d95c
30ac3409-383f-4fa3-ae82-8313b24a6124	10000	Rank	3054bbb2-244c-4974-b7e7-c29dac8b1dc3
8cd9fc73-21be-435f-ae57-159ceaf636b2	10000	Rank	a4f0921c-5929-49f3-a2d1-3f0048849db6
92a0078a-4b21-4483-aae8-3becab28c0ab	10000	Rank	c9ccd729-0b35-4fbd-8f52-20014506fa20
cc7a706c-739e-46b4-9136-90d0634112c0	10000	Rank	02926a21-64dc-477e-880c-cd6b5eb3394f
8048da3c-fe44-46b0-936a-b0178e180c29	10000	Rank	4e6759e0-6ce9-4277-bff6-d6033bb6f479
eda29dd8-0122-4384-b0e4-593b4908509e	10000	Rank	bda3c9ab-385f-461e-a1cd-37a52d5335c8
b37bddce-68c3-47ef-83e4-deaefe5b0967	10000	Rank	a7f7e5ef-f3af-4ba4-b048-701b6582821f
ea667b60-b1e5-43ef-9707-f616dfe89765	10000	Rank	f868438a-b76e-46b3-abaa-f4405a63d0ff
f5747416-e1e6-421c-8432-92899e70fcb2	10000	Rank	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea
28be4e51-e8fc-4c61-8c46-8f9ec249d378	10000	Rank	04a2a76c-44ff-46d3-8155-1348edf1828b
99663d6c-4f23-4446-9a19-d597440411fb	10000	Rank	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8
549a06dd-7700-456b-83ca-1c381ee2fe44	10000	Rank	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8
074b243c-1a5d-4a54-ac02-3dab048812be	10000	Rank	b4085128-2dc7-4ed5-9332-959dce9b0cbf
04ee05dc-cbbe-44a8-8c41-1786e9d9818d	10000	Rank	6305399c-c89c-4fb4-8570-42465bd1b79f
2ef870ae-0412-4888-83b1-52e5318287fd	10000	Rank	2ae81c67-7c65-407f-862c-dc6877f856e0
2f2a4c7a-a963-42bb-be7e-d3c7b2b2d003	10000	Rank	c124d5e0-2509-43fa-8e0c-f07a9db962ed
bd640af3-92de-434b-bcbb-18dfb06f24af	10000	Rank	c0982b02-cecb-4f73-adb0-327258fe2f8a
3563ea41-b4f5-4a4b-8965-ef680e2273f6	10000	Rank	e4cc5b33-8083-410e-b92e-60b818343a90
3f1bd23c-79ba-4dbb-9a49-1beda9e58971	10000	Rank	b97773e6-a871-4572-bac1-7a6637f059cb
8ead9182-01b8-4060-992d-0c005ca3a379	10000	Rank	3c305397-9f6c-4189-aa05-f48fc6d4c02c
57e52e8c-fd03-4fc6-8283-e36fa6615d4a	10000	Rank	fc057676-e528-4fcb-a729-4f4eb9ee5e5b
fabac283-a120-4803-b6c5-5f443670064e	10000	Rank	38f81c95-5586-40dc-be11-7117fcd90f9f
63f34b87-e78f-450c-90d5-9460db2f67ca	10000	Rank	fa3b4cdc-b7a2-4595-a7e4-ef474d129883
74f8b521-ab7b-47d5-ac8a-d6d3459201f1	10000	Rank	adcd3d8a-71e5-4bea-880c-ea9f7284a724
043dbb20-3f83-4253-bedb-1ea3819ea13e	10000	Rank	9356b60b-8ca4-459e-8347-04943b40dae5
67b7dad1-c849-42db-82df-48100e3e6c8d	10000	Rank	98b12365-5eed-4f3b-b615-ab87f317c2fd
b94db350-a73c-4725-9578-b4c2ad362f34	10000	Rank	feaeaa90-81a5-4098-b44e-d39b0d059cf9
e7796fb7-f181-44d4-8e76-39ab2bb0d907	10000	Rank	c7437b7a-8e9d-4fd9-a56d-05973ac990df
9b4e6c97-3a53-4705-9313-d9fb767051c5	200	Rank	c3d9b51f-dfea-40f0-a0d2-7f87737824c3
7b0e5694-3111-4cbd-9f1f-e910be5f7567	25000	Rank	96f14723-7249-4338-a06a-3b6bbb2ca242
22bc76d4-02e2-45d7-8767-37ba96e69d8d	75000	Rank	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b
\.


--
-- Data for Name: player_rank_profit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_rank_profit (id, profit, is_collected, rank_id, player_id) FROM stdin;
725766e9-0660-4111-ba69-4585927dee71	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7b85a40d-2149-44be-a888-438cc50012f7
a6a18719-52fc-4e25-869d-97ae0e40c3fe	50000	t	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	7b85a40d-2149-44be-a888-438cc50012f7
afe918c4-7616-4b06-91c1-4d4b0395a1cd	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	fc3cd5c6-17ef-4eb6-80de-4989687a35c3
f1148261-3409-49f4-b336-962838715c3a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e3db2078-4a85-44a4-bf97-e165be03f56d
2aff2d5d-c787-4056-af2a-34dc4c778e2b	50000	t	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	fc3cd5c6-17ef-4eb6-80de-4989687a35c3
61f5cc37-309d-4cdb-a8c3-578f7bd81734	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7c7c9b13-f79a-4442-99d5-9bc341727fa0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa
753da460-48b9-4941-a82b-bb4ec296a906	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c442f7d2-81bd-48b2-91dc-4c64d172c548
bfeb5fcd-916e-4871-af8f-434daadb3b57	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	32b069c3-007e-49c7-84fd-1231b4a2db4a
19160e04-ed85-4af9-bf56-fea8ffa7bdb2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	44023214-fb54-41f8-b586-783d108dbaca
73092e53-6ada-4d19-82f4-2189472bf041	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f29d087c-a6fd-45ea-9fd1-8b25224cfb58
f269d7f8-8cc2-41f5-b91a-e16aa8abc0d2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	35ab5d3f-c9db-40fd-a172-e7d5eedf861f
81b75be6-25e3-439e-b9c8-64e3b81c6098	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c503dcb2-b7ee-4f15-b557-e25053de9313
cb29b078-e7b7-4289-bcca-e69c24e820e8	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8cbc9163-4ab0-43e6-bc37-9d092c4f8806
96708b04-ea94-4807-9e9e-8c8fc6dd44a7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7a782bd7-27b9-4f47-a28f-a751d2793a8a
f38651b1-8d74-4ad7-83a5-7767c03c60af	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	aaae4527-f282-4a98-8c35-d644005b2c71
deaa75cb-bc14-4739-bf61-87a409f931d5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	923c26fb-cbae-43e4-8e2a-700903702517
de411503-8287-482d-84b1-e2f740f978cb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e1848ae3-8949-448b-a578-76726c5b8a59
823c026b-4ffd-4730-a131-590aeebfd1ed	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	cd4b3dee-e183-4c19-b6e6-a9c607a482e8
aca85c49-fa41-49d5-9415-d4ccced340db	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f02a6e78-e89b-4711-9071-f534ec255774
5fc0299b-6a54-4650-a1e8-f403b752634c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	73297b7f-b596-4f88-9882-5741d3c5bac6
f37c2d2a-07a7-4e6f-956b-fb6276faf716	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	fa3bb8cd-9908-4339-96a8-d61927544541
d3449705-25ec-43b5-a60a-2228a9756e10	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8
d039867f-b91b-41e7-b35a-4014b32603fa	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e
dc556eb8-bb1b-4386-8e02-1e7d76491b28	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4c84519b-ac34-4171-91c3-0c664a03e2cb
2e3ee164-585d-4276-b082-b28c49cb890b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	be3f0321-d6fb-4442-8146-1eeee301be02
ce9b9928-2835-4bf1-9b8e-165a6670b2e4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	27aa7650-6bf0-496c-971b-013fe6af4bbb
404c1f40-630c-4139-a3e3-40356bcefaa5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	acd9b172-5bab-4a2a-987d-5b09bcfd94cd
99ef49ee-6158-4868-868e-e7d8a0b7f088	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1
1450cd95-17bc-4b12-881b-65bd02c5bd90	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4fac8997-e95e-4fc7-af66-ad553fd9666f
cb4d8c26-e4ef-48e2-a1b7-c4bf31f954de	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	77d18071-abfc-4f46-828b-27543aa92f25
e8deaff1-beb3-4d55-9162-f890e126eb7f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d22a81a3-c6d1-43ea-a70d-14a4723d3a73
5bc8256a-f6c8-4aff-8586-a8e14f5cc642	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f
98888a43-31f4-47b7-95fd-dd6480cb0b05	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0862236d-23aa-40ab-870f-cbd711b4cf49
227e9154-7ae3-4263-a2b7-b05fe3b1eedc	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0956d132-2c95-491d-9168-76b49d248128
4f9db379-6a40-4427-9fb8-579ed92b8d50	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6436b365-d1c3-418b-91fe-89ced8f83c29
db792961-7c4b-4fdd-bfd8-5e472bb84054	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	420937c1-6b5c-4cfc-b5f2-f326fca9aefe
584b3e35-ae8b-487c-a547-28068f37ea81	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3179d2c4-c5ed-47ce-801c-086d926d6696
cb418e65-e565-4a6c-aeec-249a4b606f5d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d9a810df-ebbd-43b3-bed6-958e9255d059
85895dc3-5158-46e9-b0d6-1b81c3d5fa7b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	de1e208f-eef0-49dd-a47c-a7316b98868a
9db4c0bd-04b5-48a5-9e8d-b82d86cb4da9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c50e0244-2708-4828-b435-a538437d7ccf
a45e24ab-1472-46fb-a87d-68a1e37d3b18	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b274d74f-cbb7-497a-a965-5e0b773efb43
c4c579a0-24fa-4254-bde7-39b265364008	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1
a181ac49-3ebc-43bf-a98f-8e5f0b1baf57	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6ec71334-96e8-40e6-88b5-722780e75cdb
32493b2e-0d6a-4251-aa3f-8101f4591103	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	694885f7-dea1-4c4c-b5d6-69997bb57ed4
efdb3826-241e-4719-b008-3248e316de69	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bdf20892-6c04-4799-85b5-0a7ec60d11a4
de71c67d-8bb0-4179-87c5-9f1869b8d942	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1b41e70c-950c-443d-bf3d-d57c96af8cd4
ae8a28b4-3420-40d6-b9a0-4b0fc414183a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9889a17d-730f-4b7a-8389-8e4c7d0f45a5
179b4e58-ab87-48b7-aeb1-5b4dd4493b18	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6
a52546bf-3ccf-4d28-9873-7678520bbd65	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	cb580957-0a49-4957-bd17-dd73c6e5fc1d
d1df591c-23ac-4955-abd1-1b7b34504d44	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf
c6639965-c662-4984-a364-309bcbfe9f9c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	068bbdd8-214c-45c5-bbd3-31400b5775ad
e698268d-d8cb-4a88-8785-abdb62d706ad	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	346af1cf-7bef-45e2-8fc6-9cfcdaa05300
f7c93057-9b33-4a51-aa8e-0e58cac1f0ba	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a
37090fe2-19fb-4de8-9000-7828f5aa16b2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	93492e19-b481-49c2-a2d6-c5e3644e3b2d
9716f854-d093-4bfc-aad1-fcae2da9ccaf	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3ae64b94-ddef-401b-b345-1cd8696fd967
367cf301-a9ff-45b1-8fcb-836f8b21ac74	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	97647052-9891-4bd9-be9b-679ca79cb1d1
b00c14bd-a66c-44da-abc5-bde24f05d6b3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6173e277-f662-4720-a5a1-f34a8bb9221a
7adac203-12fb-4091-aae3-d541f2b37c17	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b356cbf9-9aac-4203-922c-7904d844f00c
8b64b214-45c0-48d0-9fba-bffe4eb1700b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6dcf36ea-cec8-4420-97cf-f665b506fdb6
ed654566-5d5f-48bf-948b-36671b27c8af	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c1cee951-d219-41cf-a647-a61d07366fe7
09cd0292-d59a-48b7-847e-f4963c5562cf	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0c957416-3d9d-45bd-80a4-780cb657a77b
6b8deff6-6a88-4281-a8d7-f77e659dff56	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2162f56a-8ced-4b3d-b071-1df7dc6760c5
93cbbb89-99c2-4846-9b1d-570fc483e624	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	60d6a675-4f9f-463a-b239-9e2643aaa8a9
65725fa9-da2f-4372-9100-3472f273db8d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	808c6a76-ec6c-4090-af68-b7ee4c8f3630
d9ae954b-9b87-4f4b-9b7e-4989c16dbf6c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	51be77b3-787e-4364-8765-273088974e06
04d20d64-bdf2-4080-8ee5-daca438f90d4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f
23cf3067-e29d-4cf9-8e49-4cde14d713ae	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2db49b30-71d7-4b16-affa-c4ae49003071
30e0b59b-4f9a-4618-b0ba-da06daf5a43f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5c1d9e49-c3a0-4198-8f78-654398a73090
2ae7ef98-2abd-4d63-8c92-c1b21fcfaf93	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4c235c4d-1364-415e-a369-827f9aebf9a7
8a70710f-a657-465f-90a7-61d782a2a6b1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	efa9d746-3805-4405-8b7b-191b9137f635
98079f68-ea8c-4374-9723-ca940f6fdc3b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	45add737-f340-4de6-8273-a3c9b62d7e77
d426aac8-7751-4a5b-82ad-c5c67bc20535	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	dd39ed92-48b8-45c2-b336-bb8e8b05013d
9ab7c846-16cc-452f-b2ed-3fdbfd66dee9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	901d66ce-8dd2-434b-92bc-052e6471a88c
960b4e9a-023a-46c5-ac3e-d53aa0b79a91	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3c77db66-8cc1-4953-a924-d038408f309b
7c07a819-e314-4862-8d07-89dc50015c33	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	cecebe61-8db3-44cb-b651-29619044d686
674fd21a-6a69-40e4-9466-85f524454a35	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	dc58f57a-d332-4991-8059-634d9a50df68
9b9d58fd-b2c7-48a3-b22b-a621d68803f7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f690f183-cc78-44c1-b56d-98814d650919
810360c3-fbfc-4541-9765-e843f3dc73ed	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a67b6419-7eac-4a49-816e-2bfdefde7c10
d6f7ce8a-449c-4522-baef-bad1bc0e304e	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a8ccaea5-750e-4025-9374-ac12553f823d
c331f372-8a79-4cdd-87dd-c37f48b98c54	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2292c89f-3fe1-4b0d-8592-ad943a5be66c
6df24c24-a502-49c9-b674-c610fc973b52	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	755575c5-5262-402d-97d2-7563d211eb9c
d23414d5-91cd-446f-bbbb-a98430670757	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8982b883-6019-4b06-8215-e28dc2a5914b
c7afbaed-bceb-4c36-b55e-7fceefaa2ddb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6ba47e11-ccbb-40e5-bf31-f0f22a10454b
f2857856-10a5-4d3d-9f11-393dbdc5b490	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a
d317071f-f5dd-4a1f-b5f8-b3e45941d1cd	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	83be342f-6be5-4728-9ec8-0aad63fcb18f
9972ef89-13ef-4abb-81ed-f54dc5cac4ca	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6
552f06c6-dd08-41bc-98d4-fa2adf5127b6	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f39447bf-b1df-4970-89f7-a4df15c2a0c4
53fd6172-7378-4052-89b6-bef89d4edbd9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	730c98e5-5ace-47c0-826e-c3543c9686cb
37d7bd0c-44ca-42dc-a259-5743b2c16de8	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c854f638-c2f6-47c3-8da5-8c688cb1f78c
165ed465-e232-4fa8-8507-9b49c138d2b8	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	05ab2789-6d48-4c89-869f-abe089fccb4a
0dc17ec2-409d-4f14-a6a1-7315f1f258e9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5891f499-7cc8-4d19-b3de-4b15c0624ef7
c0b1aff8-c76b-4c22-b0ef-1cea8dcec75a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815
e854b545-b221-4e96-be70-fbd17cdf1fa0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	526b8286-c88a-40e8-87ef-b94ebea9e97d
9450dee0-8e70-4838-84a2-bc03171627ca	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	49fe0add-1125-46cd-a368-f8411e43c44a
7119a0bf-7a9b-4df2-93f3-25da95dc7b36	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6d20670c-72c5-45d5-8525-9912c5ec1058
66bdbe68-8ea0-41f6-854f-4e0c5204b4f4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d33ab7e2-0a7a-4266-912b-55c5f5b18241
5b1d0986-1997-4f2e-bbbe-80ad335c86a7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9
072d77e5-3f4a-4007-bf1a-8ff887499254	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6c1cc459-173c-490c-9990-d222300e188b
fe112622-eff3-400d-8c2d-650ed9c58366	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c62c44fd-85cc-4edd-a070-96a4ee09bcf1
a7ba734e-cb6c-4027-b0e5-7a3afb4155cc	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e64ccb49-7042-4678-9ab6-a8b8dadee65a
fa3b6dc2-eed7-4bf4-add3-426c1adafb67	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd
0012cf80-26de-41d1-8f3b-6820c43e65bd	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5db49be2-2435-460d-a6f4-f45b2f275436
f357a100-b576-4a8a-a41d-e742e9d28a03	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f1ba7109-837e-4fd7-944b-54d3b997fbfb
83915d87-946c-4c7a-8464-9a2ae4985c08	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5d4f5985-c330-48e3-a1e0-23760bc73f4f
802975d3-f181-43d7-9a49-75889361cd3f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a3c59c5b-c711-415c-b371-98ffb520891a
4a8d5ca6-48a7-4aec-966d-caab6900f8db	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c49c5171-b397-41e5-a8cc-c3933347189f
a5178c7d-e421-4a47-bf58-1cf38f536b3c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a5266896-6503-4e85-a895-a82fe27c14c7
14719a88-3d93-49cb-a862-da245385b087	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9100f2ae-e4cd-448b-b40b-251e0eb3572f
a1f62f4e-701c-45d8-9c5e-9df544210037	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c95385ce-966f-49ed-8b4e-7b162d2b0d66
34a1c2d9-bb6e-4739-88cc-58f603d64123	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	98dd5bf8-d2c3-411f-9fdf-57c51a150113
81412300-e22e-48a4-a5b0-e109cf97b1f2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c995dc27-5dc5-44f1-ad05-6f3d0350fe17
7c0e7b3f-8524-48bc-8fb2-f6376ead3f41	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	aef64f27-4ed3-47d5-8620-68378fb412ef
78419934-0458-48cc-a51f-ab34f0ae2c07	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	85729935-7993-4125-8562-127b29db7e60
a16c0c6f-8c4f-477c-af51-0dac4bda7565	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a
10e609bb-4fa8-45ad-924c-45464ce20294	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	37d990e5-99ac-4bd1-9700-7f0efa185901
903f0e95-3e24-4e51-9fcd-55fcccfe347c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5eca0755-2466-4feb-851d-1e3f407260df
afd9089d-7995-4b3a-b4c4-0387cee01606	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a0a730cb-ef7e-4d49-a0a8-103d50af54fa
7151270c-fd6f-4cef-8a61-b0ebae8ce4d5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	de0ce717-6916-4879-a04e-dbbdfadd4545
5ac5e03f-6ba3-4eb6-86f3-80b220010233	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e0dbe070-d1ef-4573-8391-450a4b3eaaac
a84fae42-752b-4008-b031-86b216839ee3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	63e30fe7-562e-4f11-9c47-09fa6e5188a7
fac982c9-2120-4817-894d-3daf0a265ba4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9
553429ff-7ffe-4e04-879d-3b511876fb88	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8e934c6e-187f-42da-9467-6ebc7ccd08bd
91d18845-e641-489b-8b7e-0909bfbf40fa	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3eab8b06-c057-432d-8042-0b15ad87bdc7
d25144f2-d6a6-44a5-9197-9df418ef07ca	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	971f7c33-1a8f-4d58-91c7-9342a9acd69a
4b6294fc-bf9e-498b-8d9c-5b587481ef6c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b7930946-5b11-41ae-9385-a05ff8b0bb77
47efbfd5-6c0e-4d57-ab7a-1872fb172d78	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b
9461396c-cdba-4c1c-a1c2-df3e593ab7e5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273
6da58e6f-1390-46bc-9657-af121adeece0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e84e7f8b-1821-4957-962a-063ce11ec128
0a6fe732-4bea-4e20-95c4-0dbbb0712a0e	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	dc5830a1-fb20-4421-ae24-00f9be9f0f04
f95fc7ec-06db-404a-ac0e-ef5eaa682be0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7165d010-24ea-45e2-994d-4597b6f7dc05
2b29e9ac-3ba4-4636-b528-f9ef1933c974	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413
62411e09-e86c-4872-b6b3-a386c10f0ff4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5e0f7570-92f8-4c39-b7d4-e89276778d25
786de220-43de-41a6-ae06-223f4abc07e0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	dee1a302-1c56-4b6c-83f9-3bd8bf27323b
95386d41-a90f-443c-9418-fe8dbf2fa219	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5c7b80d2-5a14-4b72-ad4e-b30749b13074
5159b54b-3cd0-4ee9-b60c-34dd7a13a51a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0582992a-1e2c-4add-863b-b5f10d6b4992
fb0151f2-5154-494d-98e7-ed02796fdd20	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a6759a4c-fc93-4995-9a6d-d30488ab7a12
2215d47a-7f9b-4f3f-9cda-ee235812d6ae	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e045da04-0570-4317-a560-7cbfeae6f59f
51dd6e5c-6c41-4e8e-ba82-535c3807ebfa	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	573cd423-824d-4f62-bef0-2728da79fcaf
8ea00b95-4062-4cf5-b76d-b3e9dc2a6860	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1d8467cd-0105-4e3e-957c-446e325920cb
aa43e3de-1a08-41ed-aa82-d4be170552c0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ff338a1b-41d7-40fe-b370-c88ef7d387f8
e9166422-893c-4c87-9267-bf3f111216bb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	22285a4b-a9a8-4aec-895e-5ea13125722b
7fc2da17-fb7a-46dc-8a55-22ce4c95fe60	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	542780d9-35a1-4582-86d1-d9ff5971f4ae
e5980e1a-eb76-40f4-9a9a-3ee3fdfc3943	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ff807dea-119e-487b-9e10-1f7a83b4e172
3ca0f80b-5e07-463a-a2fd-85f7dc291570	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d816ad42-c674-4776-b507-f2ae86133a4c
4dbb0e91-b07f-47ac-87df-5dd7135dd7c3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	77d3e7a0-1cee-4856-9308-ae8830306caf
fe24f960-e28a-486e-b868-1e1690033b4a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d79cceb2-5cbb-4477-981f-491a969067b6
af837c01-74ef-4dc5-8ceb-2ae097b0f9e0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	86d277ca-6952-4753-9e13-ccdffb252b7b
51cf98c8-c375-4690-86e3-6a1bcecbc135	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6
5e1450a6-44a7-4a3a-b1a2-3de05ffdc31d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	40b38dd0-c020-4e26-bccc-14f5bfe21970
bcedc83d-90a2-4fbd-9e51-c29805866e74	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	85b28ae1-f517-423e-bf6f-ef189248faac
15a67a96-9faa-4171-9e63-ae0eec91cbe4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3986bde4-e078-452d-ae3e-fd93454b4ce2
651b6383-d94e-42ac-9fe3-2ee8bccd26bf	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	db7f8158-f71a-4ecf-a0a6-48439a05d657
b8790537-190b-4c8f-a57f-107aeb3c7a76	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e1e70295-5c37-4c51-8167-9898b9c506f2
90f75fb4-cd76-43df-a970-8f68ff645352	100000	t	6e6c1c2a-b108-429f-b7db-8a5a7e43d495	5c88a435-14b9-4c7d-ae97-08c38822e5ad
42266636-b24b-42af-9e69-9bc19c740178	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	37e4bdbe-f7f9-433a-a726-c9990700701f
9e69e8cc-29bf-4a61-833a-7888d7b8fa6d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3
5d9833bc-2169-4b69-846c-c166a8aa969d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec
f3bcaf69-34ec-433e-a4d8-b5262f20510c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d543f357-e99d-4d70-b7be-2a98d055c997
69c75cfb-e000-4fa2-aa5f-fe5605ea80d8	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5c5f698f-3444-44bc-8055-c004d592e0f8
cc404190-9df7-4c3f-beb1-035d771c73a2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2a74d774-a7c5-4b5f-839a-b1911e457bc2
c2ad9364-3f06-4094-bfae-524f7a287b9b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1131c61c-771b-4a75-a014-40a4731b9efd
92db4d54-5a7b-4cc3-bab7-b100093e5feb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a2643314-2a6f-4af7-bb1f-11494179d800
adc737c5-495e-4967-9600-ef64da1c4bf3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce
a5d8e85c-a4aa-4c2e-b0a7-87bb1371a34e	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372
802b179a-fd07-499f-ae78-12c127045cb4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965
4495d89f-b013-4280-ae0f-fd0c3d5551e9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	59be1293-6788-45c2-b12c-d35d03727da2
b8f7f71a-0d06-4a4d-bc5b-bfda87470038	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e11b9a8c-c94f-48b5-b192-1a769c1442a7
218527fe-e04e-4ab3-9071-483caf2ee832	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b
7437ba1d-1def-41e7-9bd4-0dc86f5bb1d2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d1c81fcf-526f-468c-b8f1-1de6fe5ce572
2a1b349a-0dfc-4d1b-9c09-0506ab172353	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e1a109e1-01cc-476f-a100-046326507dc2
8d133e22-ce77-4cf0-a119-a508d70a1e66	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1fdcbf6b-e670-46e6-a1f8-308621c26735
927a354f-f75c-49aa-8718-612da1985f33	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bd03e8cb-4881-43d1-aaaa-fd192db5b90f
5088e4d4-5970-4fdd-8f29-79be2bfe76ac	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8
3165c520-1cc4-4ca0-b0bc-4b25965229d0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f423e5f2-d2de-4a4b-983d-7faeee04b0b2
af33a943-2e56-4ee7-b4e9-e6868181c630	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	21782926-7972-49d8-b5a4-8163dda4d8bb
0c5b0c17-170c-4d6e-9452-255dab5005d7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0c875a99-42f1-4cb4-88ed-398b1c25b9fa
0e89eb54-ac4f-47c1-8c9f-df2a03e34c9c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3ba67b11-9e37-462d-83b5-ca4defebe4ed
89c343e3-4879-4191-a0af-bb2e1baa4429	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bfc42f90-715d-47dd-bc34-8a3983fd76e5
f106da9e-b6bc-414c-b8d9-0f3dbef5e110	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	38922471-48a4-430b-acf7-80399379a847
ed9939c4-8dea-4441-8784-01e841f17395	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7d9c3111-4710-48a5-8e57-42e76f785f6d
db705b69-f01a-4a12-b1db-be1162bf5f5c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5cdf5b4f-0b52-4adc-a49a-6145cb01c326
2c0bcbd5-3c13-4944-a0cd-f5da273c03d2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	619ff42b-d080-4db1-b808-d769e69bee7f
c39c6a23-5aed-43f7-8706-dd9ff27b990d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c5533212-9300-4d0e-b460-5eabc1fa4a0d
f4b059bb-96d7-40ea-8fc0-3e280cb29cf5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b68c623a-ffa3-4a48-a3c9-76f2f700775b
522ef8d5-f5f3-4b4d-bb5d-76d4bdbd822b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5cd93a3b-b144-453a-a229-2757cb28df22
f7ffaf9a-495c-4c5f-8e59-216d7aff2e95	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4dd9f659-75d6-44f8-8fae-ac963c6746ab
0a54337a-638f-4ad3-a9c4-3854dba12292	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c357212b-e065-4c65-aaa5-7e8b8a14cfa0
f8129b67-e0ea-42be-bf8a-104bae875cb3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f3fddd33-f77a-40e4-9897-55e61230d643
baa3609f-4248-4229-9673-7c6d1ab135c6	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5434fac2-36e9-4ff9-9955-ba531fbb1ba0
3a28123f-6703-4e0e-88ec-7139b52c9071	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1c23cfd4-f4d7-49c5-8760-9600e414027e
2c4b14dd-885b-47ae-a6d8-52dd7ba0d92d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	31ae5186-dc5b-42c3-b676-8590c96de53a
8b239843-1687-47ac-b230-de9676c63d11	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d2615292-a50f-47ff-af73-437ec1eb0fea
8a3b3271-4a54-48ff-ab66-3d18e1b5afbb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9f557edb-8adf-4832-bc25-ca5b00dfcf4a
ad83e3a4-2eef-4f45-beae-dc6ce4c215eb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8fbf163b-f453-434e-ad19-10228894ee8c
dfdce9c6-799c-4b7a-b284-985d830fd5b7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d2834bcb-2154-433e-bb06-e8befbfd7368
5d0fbc65-97a5-41f8-8ec6-229b91ec4235	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	88421493-e09c-407b-91b7-a2bf5f633fa6
5f25067a-1554-4163-96b8-927a7a6ad7a5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	45f32ed2-3673-4022-b0ad-e4d60362361f
f144a286-50d6-4881-a5ab-e26506d24a50	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a6975bcc-4113-475c-9da0-5dcb952cf919
3b36118b-b629-4e62-860f-40d4ff4df8d1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	eb838509-93c4-4e2a-a8c3-3bffd2acc82c
870e6b02-8326-4e57-aa4c-a1f8ab66caff	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	815ba1e6-a405-4df4-9909-7fbc8e87a4ac
bdee79c6-8d08-48de-9b70-482a4f0b5d36	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	473b85ee-3707-4f2e-b370-74e791f3fe1e
3fcc9fa3-19c0-4831-9a97-5cd7a9824dc2	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2
170d60b7-9c30-4eb0-ac8e-f38610a57cad	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e88ff86f-02ae-43ba-9060-727ec1a5558c
bb21d907-1e62-4d3e-8ef0-4dd660d599c9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0e562d45-0328-4a97-939d-cd11bb7f2ed2
9b53d940-79db-4a30-a42d-83f4ba9e3bb7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6e4e0e64-47ea-44c0-a997-25766e1a85c1
99430418-e739-4fba-8736-3224f4813116	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6ef284cd-4c54-42c0-99a0-619cb8442030
973c519f-e03a-4d5a-9179-1eb289663fa7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bce15c48-3692-4a64-a01c-9ae16080077d
295c320d-8767-4398-a101-29aa3ac0fc8a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d6bec1d0-48c5-4652-8612-b4667cb1c442
575231b5-e753-4d61-bcff-2fe85ae1dfd1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c8434922-ec69-4e01-beef-8cfb6ad0f92b
1d392ef7-2bff-4be1-8fac-6cb4f33b01d9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	cebdc43a-6173-4d07-99df-6ffabe415516
5cf04ee5-fe85-47c7-8316-4076ecc57d7f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	949c4f91-4f71-4751-8c96-4113f5c1672f
485211da-ba91-4380-bc72-fafce9c77095	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9f19df17-a951-4493-944a-cd158fd5ca1a
48b61181-3ee3-4920-ac08-3fc0c28f42a5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f968fe68-30ae-42d2-9e74-08bf8e223215
686ae75a-9d36-422a-bb4a-ca7928bb7816	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	380bb01d-d981-4caa-b479-6089a516a075
f2c74b69-26f6-4a49-a66c-fec3341e92c3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94
267f91e3-7f26-4432-b21b-765c70b963c5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	8749fd89-444e-4786-b0cc-6fed521bdc27
afbf7a81-81a3-4cbb-a36a-1bfd0c1b8f49	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3ecb5f1f-0418-41cd-af4e-93a4f558c522
cb8a3af3-ad1a-40a7-8d5a-bb5aef9a0ebb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7170f559-0812-46be-9851-f1142c91d14c
495aabc8-c724-422a-a89e-6d7a33b47f2f	50000	f	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	7c191628-7c7a-4b36-85ca-4c6eb8333aaa
61404bbe-0c90-42bb-b7a0-6bcb9a3dc9df	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90
7a7b813b-164e-447c-b9fc-9a06b2e910f6	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	21bc0cfa-c69b-454d-9c5b-4261dea59a6d
65ed15e8-f1bb-44d9-8649-a55b9edaf197	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5566b584-2023-42f9-b25c-04d15223cd5b
2c35dee9-229d-4dba-a5a3-418625eea4e0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	759b3797-b95e-4abc-a83f-c37bd6aa090c
7ed9a366-e50a-4f98-9eef-e64cc7eb46d9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1203d0f1-1816-4998-93f0-bdb05c314cd4
7b75ca1b-5ed3-4c05-b035-8284422cf0b1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ffb1879e-5a8e-46a4-80ec-fe36bd67e584
64a6de3b-8d91-4f67-988e-49b928c9f1d3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c
bb11d808-33de-4d4c-96f2-7a328f69729b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d04cb17e-fd2c-4727-acd1-76bad464dd01
ad83e876-5013-495f-9b44-9e9950b0054c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5cb277d0-f9a3-4de9-9041-470811eeb375
2435a764-9797-4488-872c-40166df795ff	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6
c0a006b3-264e-4803-a868-0a70a6fea99c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	57734c90-01d3-4f4e-828c-1201f65e42bf
043293db-4b24-4791-a443-a37dc0a1d1c7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad
e74bf29a-5d6f-4705-b6cc-caf633fc15db	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	31765d40-d378-420c-a0b4-ca49e7ea59f7
ba5f456c-db06-4f72-94d4-18658178b3ed	100000	t	6e6c1c2a-b108-429f-b7db-8a5a7e43d495	7b85a40d-2149-44be-a888-438cc50012f7
01c0351e-f132-4089-8f93-af9c91356269	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2f0dee24-3f81-4ccf-8244-d6488d087f1f
db503d61-29db-47ee-8166-6c7960ae8a41	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b6c3d582-e6cc-4814-a38f-7df873654608
6fa24e0f-468f-4ae6-9e98-a0af9590f8cc	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	53d6dbf5-e190-4641-95a1-d734632637da
9b743ffc-8dc0-4abb-add9-679964777188	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d19c8610-487a-48fc-87a1-9de1b1b9cb83
8e68e8d4-c0ee-4a4a-8eea-776d3623bf1c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	145ff272-c8be-4461-b4aa-1a161a921aa8
19b4b9c7-43c8-4fb8-b446-5d167fcae0c3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bc505c03-f9ae-4e0f-99d5-a29a56830b15
44658025-c08e-4008-a5df-a1c1f1b256a1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7e5114fc-def2-4929-91d0-7ca9dc68b2ff
44697e92-6413-42dc-80d7-dcd0b8f9f83c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1e65b0bb-703b-455e-a307-7f82464055e8
66229209-ff1a-4d64-8764-b4789c9aaaf6	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e999b8ec-ee7a-4889-bec9-9afc50e88dce
56a6d1f1-a88c-4b47-b456-9dfa7753470c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9
9c7e35cd-d56c-4746-8910-0d2e06538818	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	95f8b881-4861-4f7f-a209-5e6cf25b8d78
fe801439-8742-4319-bffd-c3a15651ffb9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	d62f5ea4-de23-4db9-afb5-db9334809de1
f1746285-451d-4476-a3f7-6857af2ee36a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3bf937ce-d0c5-43bd-9119-f8590a8d574c
f93ff8e3-745d-4f6d-9c10-b3b626a52f73	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	616544be-8229-4e20-b1ec-3a286664cef5
93cb6d7f-8c24-400a-b02d-d6776ae6412a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e46a8c26-7345-4fed-b81f-2f3ebe9f3864
0cf7b61c-52a8-4e8f-a916-6b7400330de9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1cb6a9e2-f9ba-412f-a284-23e6657ef879
41332c67-05ad-4ec0-bfb5-86a52df53c6b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	98431e33-b96a-4c71-a52d-07883fe7e945
5fbe48cb-8b51-4663-90f8-fefdc82086ad	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9eca8ffd-2cf1-4293-af11-ed381f31d2d9
50880f98-c14a-43b1-9d54-75eb73de6102	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	77d3d92a-1bc8-4648-b22d-401a09d08ab5
c364d7b3-cf2b-421e-b679-070e3bdde349	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	182027a1-551c-4601-9b84-497348f94e1c
d35549c5-eb85-4be2-a600-47beba86c493	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1caaf02e-4ee5-4c2b-b520-5846341805ef
03949441-71aa-49be-ab69-8984886ade60	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7d633720-08f4-443c-942d-8da74df41a97
30fca6ae-85f0-4ace-83a9-4558a9c94b40	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bf1a2431-a918-4a36-8334-ab6545e430f7
b5678109-10bf-4fb5-a4c8-866e19819b67	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8
3121faae-4864-426e-85a1-ec149a316fd5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c
91094885-fc8b-4478-9c03-4a840e3016d9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	237b4a46-2822-46cd-b0ac-c82739829a00
5ee5a37e-6fb8-43d5-82ee-816556df575f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	51f92be1-4f22-406b-816a-637ac9c1f180
2ef913c3-e334-4bd6-84b6-1f0ce36c2f12	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f
e0f1e3b2-6bae-4ac1-9088-343463270cb5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5e30ec44-bf17-4518-b5c0-2c1d552a9777
4475dd3e-d715-43c4-9895-48d25cea52fd	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a080de1e-d906-40a2-9bb6-c3e7528d2b87
c790505d-dae5-48c4-96b6-08a9569b12f6	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	20bc764d-59d8-492a-b1e0-3d9814ad034e
6adb4be2-a1ee-46ed-8283-208294467839	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	188e2d5e-977a-4730-a383-0cf6431ec5fe
545d66de-7c12-4c53-a3a1-47f41096fbb3	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6ae32738-74e8-4c49-91cb-e39f7e5df371
d55b965d-b95d-479f-b217-7f8661fdcb14	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1e968ba6-7a32-4112-891d-a59c12be57c3
7745660e-e958-4bb9-8808-6e118d8eecc1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	150bc895-b1c4-48b6-8acc-513947236dd1
c96be9cc-6e74-4a2d-9ded-f2138f84d12c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	eff4d266-7f89-49e1-a67c-29c28ccd7b9f
697c3435-ea74-471c-8ebe-ffcc9f83bd4c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2
f0f2607c-7de8-4d6d-92e6-35af3ac5a42f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2bd87bc9-bbe0-4a68-b661-67cfc55995b0
a7488031-683b-415f-84c0-61ef1063299c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e1f5d089-9099-4909-805c-7ddbdd74e0a3
5fc5ade6-4bf3-4c5d-aa59-fee1f2fd4807	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	1532bb49-0e32-4841-8531-eb9f7d831abf
699c6cb8-b3c5-4b51-a6a5-bb88df9d2c0d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a18c5901-3cba-4f12-913a-2f901f7eda55
6256ba27-1897-4c18-b15a-064a74128e29	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a
0b4299e7-ca17-4632-9cdc-e5e77cc586fa	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd
f9ac0652-aa38-4b7a-bac5-91e085363f08	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	03c031d5-def4-4c9f-9c43-ead660b2ecd8
1e277b16-da1c-4dc7-a41a-c0eff9168706	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	85b9217e-e690-4560-862d-523b8ddf7390
52a8ff82-3e3d-4660-9796-6be8c5b15c51	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3c5d9bb9-923d-4745-a499-06d2421d8b06
d32bf4a6-6955-4298-a82e-dbc71de17420	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	642a9f33-4469-4b32-b68f-cb043424e73f
fbead6c7-e096-4591-a735-4f2d941b9d33	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	ba12359e-af2d-44ae-b25e-9430f2d3fdc7
9cbb36f2-223b-49ad-8ba2-0f73bde56e7b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e6286cf3-32ef-43d2-927c-c8c62b50d95c
19958ab1-5207-4075-bffc-684a10593858	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3054bbb2-244c-4974-b7e7-c29dac8b1dc3
9eb84fc5-e78f-471f-9081-7cbf5ffabc2d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c9ccd729-0b35-4fbd-8f52-20014506fa20
a054b607-905a-4e5b-a3e8-e96c1f38e67c	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	199da7e4-25bf-47ff-9e51-b5c412af57c9
992fe53d-f2df-4724-a826-32617f3c7e7d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	fd5550aa-da2e-42af-a466-67e2c59fe268
b25e1e1c-b096-47bf-a5de-cdd134d8fc99	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f8f489c5-baee-42a7-a22f-ceda8b8d760f
6b262170-d672-40fc-8dcd-71b8fe39b6a9	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a4f0921c-5929-49f3-a2d1-3f0048849db6
75168a20-64b0-4b47-8d4f-b5ab0543a92b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	4e6759e0-6ce9-4277-bff6-d6033bb6f479
c8293812-1dda-432a-a608-abd99baf5e99	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	bda3c9ab-385f-461e-a1cd-37a52d5335c8
adbec391-90c2-4c4c-aa3e-db26a767e9e4	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	f868438a-b76e-46b3-abaa-f4405a63d0ff
30107683-1a59-401b-bf6b-f791990c2a31	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	5f4a33a0-6d96-44ab-8d8c-24a62013003f
9b424f99-f5e8-4608-9431-fb29ed1fe7c5	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	02926a21-64dc-477e-880c-cd6b5eb3394f
368f5840-64b2-4aad-b5c4-85d2b42f3739	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	a7f7e5ef-f3af-4ba4-b048-701b6582821f
4bf13efe-cd60-4861-8877-e00cf6995d21	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	04a2a76c-44ff-46d3-8155-1348edf1828b
058b8b93-1e4f-4d44-86a9-ba6630a2ba06	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8
7720e114-cb45-4201-b143-d30036d4eb2a	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea
20d4b9e9-8d1f-443b-a91d-61ec29a1b459	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b4085128-2dc7-4ed5-9332-959dce9b0cbf
0086b88e-be35-4458-b909-87c12479f1e7	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	6305399c-c89c-4fb4-8570-42465bd1b79f
c1c55e7f-5368-45c1-a859-0e9a1c8db6d1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8
ed552156-0f05-476d-8e4d-96661a6982d1	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c124d5e0-2509-43fa-8e0c-f07a9db962ed
433fc8bf-6cff-4f79-b2f2-e7a8fa7f73c0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c0982b02-cecb-4f73-adb0-327258fe2f8a
eaf76296-9f81-43de-bfac-63164004231e	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2ae81c67-7c65-407f-862c-dc6877f856e0
154866f5-bb25-48ff-bef3-d6f5ee8313eb	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	e4cc5b33-8083-410e-b92e-60b818343a90
8add7b00-dfb4-4873-a882-3fe6ea844bc0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	b97773e6-a871-4572-bac1-7a6637f059cb
bb1e28f7-e34f-40af-b952-a3b7db74666f	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	3c305397-9f6c-4189-aa05-f48fc6d4c02c
c52b63bd-33a4-4e86-90c5-ee61c56a5f0b	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	fc057676-e528-4fcb-a729-4f4eb9ee5e5b
eedce9a5-282e-43d4-afd3-f8c15c6d5c60	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	38f81c95-5586-40dc-be11-7117fcd90f9f
653311e8-2e2a-46c9-933e-bbb4634c9827	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	fa3b4cdc-b7a2-4595-a7e4-ef474d129883
1185d8f3-c1a3-4e7f-ae7b-0e9d56f548bf	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	adcd3d8a-71e5-4bea-880c-ea9f7284a724
e3c4b076-a904-4bb0-a814-64bf58fc52dc	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	9356b60b-8ca4-459e-8347-04943b40dae5
b3dbbb86-d54f-4f0e-b7d2-71158c365a7d	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	98b12365-5eed-4f3b-b615-ab87f317c2fd
124f6600-d7b4-4b99-98b7-612a36281131	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	feaeaa90-81a5-4098-b44e-d39b0d059cf9
7a4160be-b8f4-450b-bcd5-15ae4feb63e0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c7437b7a-8e9d-4fd9-a56d-05973ac990df
f2139a0c-b074-45d7-a54b-27e9f7aecbef	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	c3d9b51f-dfea-40f0-a0d2-7f87737824c3
78737080-e889-4af1-b759-7048ac7f16e0	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	96f14723-7249-4338-a06a-3b6bbb2ca242
d721729f-33e8-4175-aec1-8d2d9520adfc	50000	f	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	96f14723-7249-4338-a06a-3b6bbb2ca242
4fd6cb44-4dcf-408e-b872-298693713876	0	t	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b
ea8a9961-ec91-444a-9dd8-02b3b744a00b	50000	t	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b
173863b7-5d6d-4d6b-b4c5-ecec3734d5ea	50000	t	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cb02b681-7513-4b76-8617-6535bc691cf2	150000	t	7c16d8d3-2740-4330-958b-113b1e63b1db	5c88a435-14b9-4c7d-ae97-08c38822e5ad
baabc0f9-345a-4cfc-b24c-2f638741c1dc	150000	t	7c16d8d3-2740-4330-958b-113b1e63b1db	7b85a40d-2149-44be-a888-438cc50012f7
\.


--
-- Data for Name: player_ranks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_ranks (id, player_id, rank_id, achieved_at) FROM stdin;
bb2484d1-d437-485f-aad2-1e51eec2d175	5c88a435-14b9-4c7d-ae97-08c38822e5ad	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-21 13:28:58.983
ca1b6c2c-b176-49bc-b834-52d5ed728484	e3db2078-4a85-44a4-bf97-e165be03f56d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-22 11:30:23.484
529108a4-8430-414a-8202-a501cee2e39e	7b85a40d-2149-44be-a888-438cc50012f7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-22 12:59:12.724
d429ceb5-6189-4fb5-9c02-a5534bbf8ac1	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-22 13:08:24.749
93ec7c71-ab6e-44e6-9c80-8b376b34d255	7b85a40d-2149-44be-a888-438cc50012f7	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-24 11:27:58.061
5dda4f4f-fa6f-4f2b-beac-301d44086370	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-24 11:31:50.048
0931b42a-d71e-43fc-ab32-bcd232d90d3a	e4418041-7cfb-492e-a3dc-0f348e86268d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-24 16:24:34.62
6d146f62-8fab-49a5-8c44-113e80fd730c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-26 07:59:20.465
4f4edab7-51a1-4536-b73c-785deaf3ccc8	c442f7d2-81bd-48b2-91dc-4c64d172c548	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-27 18:49:33.845
9801d378-3609-426a-ab55-65cf8bb8c12e	32b069c3-007e-49c7-84fd-1231b4a2db4a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:12.592
77007b57-b21c-4ebb-a42e-f71e5427c0a0	44023214-fb54-41f8-b586-783d108dbaca	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:12.967
b37c32fb-790e-484e-8e85-fa86d07fd8ac	f29d087c-a6fd-45ea-9fd1-8b25224cfb58	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.098
eba0e19c-72a2-4527-86a2-746ff063635c	35ab5d3f-c9db-40fd-a172-e7d5eedf861f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.209
07357f0b-f6b0-4faa-9c5e-75bed964ea5e	c503dcb2-b7ee-4f15-b557-e25053de9313	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.367
2364e35a-6ba5-4fe4-b991-adc1670c1a85	8cbc9163-4ab0-43e6-bc37-9d092c4f8806	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.491
03e3beb2-e8af-492f-92e2-36470fc394e3	7a782bd7-27b9-4f47-a28f-a751d2793a8a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.637
21761600-0954-4856-8cb7-0d018cf12da7	aaae4527-f282-4a98-8c35-d644005b2c71	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.762
5b08ed9b-6465-4866-b3d0-a1d6c066a139	923c26fb-cbae-43e4-8e2a-700903702517	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.864
793c8f7a-5d0a-49b5-95bc-a436a92a5d5b	e1848ae3-8949-448b-a578-76726c5b8a59	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:13.966
0ca500b7-08d9-422e-95c9-40a14c94b77b	cd4b3dee-e183-4c19-b6e6-a9c607a482e8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.063
adf19b63-96f7-4d2e-b079-c0ef3e12da23	f02a6e78-e89b-4711-9071-f534ec255774	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.186
459f538e-3825-431a-bdfa-2ac7c843aaf5	73297b7f-b596-4f88-9882-5741d3c5bac6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.356
36ebe8f2-4864-40f6-b6d4-9bd78167faf3	fa3bb8cd-9908-4339-96a8-d61927544541	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.449
9702ccbc-7ebf-4684-9bb8-d0255ecfb8a5	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.609
239c64d7-3d34-4d28-86fc-beb1fa3c32ee	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.735
38e7cdbd-e3c3-45cf-914c-76e2bed25c87	4c84519b-ac34-4171-91c3-0c664a03e2cb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.828
6066f53e-402a-45ac-ad51-60783494af7c	be3f0321-d6fb-4442-8146-1eeee301be02	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:14.938
0846a79d-34e0-43a0-a4cf-3a9cf7a89eff	27aa7650-6bf0-496c-971b-013fe6af4bbb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.106
872191ec-b96a-4644-b7ca-e0997d38108a	acd9b172-5bab-4a2a-987d-5b09bcfd94cd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.191
c2e76447-3cd4-481f-8501-02fe2204b021	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.292
8498dadf-e933-4899-80ec-ee01c5abe973	4fac8997-e95e-4fc7-af66-ad553fd9666f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.393
bc035414-f461-416f-bb6e-be2f67cbc52d	77d18071-abfc-4f46-828b-27543aa92f25	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.489
323f5ea7-afb8-410d-ba66-018f2b31348e	d22a81a3-c6d1-43ea-a70d-14a4723d3a73	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.666
fa12e6e1-8600-47a2-8857-5c4f95061ec5	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.809
688a9b89-51b2-428c-a614-9cc2a7952eb0	0862236d-23aa-40ab-870f-cbd711b4cf49	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:15.976
6e96fe38-20c9-4cd4-a7c2-6f0f1fa92ed0	0956d132-2c95-491d-9168-76b49d248128	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.08
b8108b11-e4a2-4994-9508-d12dccb62e24	6436b365-d1c3-418b-91fe-89ced8f83c29	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.175
56c8fd7a-1b48-45e5-a632-973b43c4094c	420937c1-6b5c-4cfc-b5f2-f326fca9aefe	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.268
b49f8db2-1e6e-43d0-a52d-b0b11700f1ed	3179d2c4-c5ed-47ce-801c-086d926d6696	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.392
a14d7af4-d158-43e4-afc3-6e8545e2ccec	d9a810df-ebbd-43b3-bed6-958e9255d059	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.51
08034a5b-40b1-44f6-97eb-628a3c5b24ea	de1e208f-eef0-49dd-a47c-a7316b98868a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.628
ab835176-4f34-42d0-993f-617bc75678cd	c50e0244-2708-4828-b435-a538437d7ccf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.782
d43f36a5-3e91-44b2-a0f3-290752d7b0ec	b274d74f-cbb7-497a-a965-5e0b773efb43	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:16.903
7cc23598-b373-4fe2-84c9-0cead4fae976	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.024
81bb3c1f-5116-428a-84e8-d1303b9ac3e0	6ec71334-96e8-40e6-88b5-722780e75cdb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.147
0c989f97-4fd0-464c-a0f9-4f8efd78c6c5	694885f7-dea1-4c4c-b5d6-69997bb57ed4	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.261
bb201dc6-0ff3-4813-a1cb-42dd83cdf3ed	bdf20892-6c04-4799-85b5-0a7ec60d11a4	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.428
25baac8e-4c88-4dd2-a17a-62ac27e200be	1b41e70c-950c-443d-bf3d-d57c96af8cd4	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.551
cad2e9d4-747e-40c1-93dd-e42772e92ddc	9889a17d-730f-4b7a-8389-8e4c7d0f45a5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.666
8222325c-8ebe-4ade-b0c7-8a6bae7c480c	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.775
4a909f41-df74-4837-a9e2-6aa682722cc1	cb580957-0a49-4957-bd17-dd73c6e5fc1d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:17.911
788ea60d-37f8-4138-99e5-f4c9cd80790f	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.012
c71385bb-68a1-413a-ba22-0e641e17cdf3	068bbdd8-214c-45c5-bbd3-31400b5775ad	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.116
06b718f2-1c37-440f-b42c-dc30350572f5	346af1cf-7bef-45e2-8fc6-9cfcdaa05300	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.202
3613f722-5a33-433a-99a0-5f7ca5e63e24	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.303
205e9337-db0e-4901-95a1-b783fcb9f399	93492e19-b481-49c2-a2d6-c5e3644e3b2d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.39
790c4da7-2b60-434c-8ed4-51b14351b575	3ae64b94-ddef-401b-b345-1cd8696fd967	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.494
b7d19375-373f-4126-b27d-b272abb501d4	97647052-9891-4bd9-be9b-679ca79cb1d1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.597
c17e94ca-a349-4a52-aa14-1fd413971fcb	6173e277-f662-4720-a5a1-f34a8bb9221a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.687
82b076e1-a1ce-40a2-aad8-6007e2213dfc	b356cbf9-9aac-4203-922c-7904d844f00c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.787
f347d0c4-1b2f-4f1e-b2ee-521c22157d5e	6dcf36ea-cec8-4420-97cf-f665b506fdb6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:18.916
2f917877-37c7-45d5-a54e-fb184352c5fe	c1cee951-d219-41cf-a647-a61d07366fe7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.008
32dcbd00-eb21-47e3-b3ac-83cf73ef0776	0c957416-3d9d-45bd-80a4-780cb657a77b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.147
8bf793f6-eb45-4565-ab09-afc78666b58a	2162f56a-8ced-4b3d-b071-1df7dc6760c5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.278
ffc15195-6b91-40ad-be0a-305d97d8e7f3	60d6a675-4f9f-463a-b239-9e2643aaa8a9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.402
8ee83b4c-ec48-42a4-a42b-913092fa15c3	808c6a76-ec6c-4090-af68-b7ee4c8f3630	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.546
6a94a4b0-7e47-418f-871c-4fd8d97301e3	51be77b3-787e-4364-8765-273088974e06	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.67
8c849c59-9be3-47b1-9a4e-0a8e6fd3204f	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.774
b53b3cc1-4500-40d0-bcc2-4dec876f2cae	2db49b30-71d7-4b16-affa-c4ae49003071	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.874
7f3595b6-aa55-4be7-9091-170fa0a7e801	5c1d9e49-c3a0-4198-8f78-654398a73090	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:19.976
9f35b153-9f78-48c8-81c4-b32c82f21044	4c235c4d-1364-415e-a369-827f9aebf9a7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.112
b4247e3e-964f-489a-bf19-a183aee60d01	efa9d746-3805-4405-8b7b-191b9137f635	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.213
016f0a90-b034-492b-8783-506840b799a7	45add737-f340-4de6-8273-a3c9b62d7e77	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.299
26045fd3-2c5f-4e1c-9a09-398d86d89806	dd39ed92-48b8-45c2-b336-bb8e8b05013d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.38
4352eb09-1290-4f92-8997-66ff9bc58357	901d66ce-8dd2-434b-92bc-052e6471a88c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.496
26c75d12-cbf2-4d41-92b8-034653b44ae2	3c77db66-8cc1-4953-a924-d038408f309b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.587
f076cbf0-77aa-4b41-a64c-55a174ad820a	cecebe61-8db3-44cb-b651-29619044d686	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.689
c60256f4-f54a-42ab-b1d1-40ec95c205dd	dc58f57a-d332-4991-8059-634d9a50df68	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.798
6dff955f-ba04-4c2e-a680-7647a2bd1d99	f690f183-cc78-44c1-b56d-98814d650919	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:20.895
b65dac7f-164e-4d65-b2a3-dc7c44c2d3f4	a67b6419-7eac-4a49-816e-2bfdefde7c10	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.002
2f79f692-60f4-46f9-bb98-cebb6677438a	a8ccaea5-750e-4025-9374-ac12553f823d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.152
e29d5ee4-d178-4b8e-abd7-3e4c83d714bd	2292c89f-3fe1-4b0d-8592-ad943a5be66c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.288
7827c8b1-fb70-4cf8-bf01-d8b8e47ce8b6	755575c5-5262-402d-97d2-7563d211eb9c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.381
59f8b27e-a90f-4198-99ea-3011f612a4a6	8982b883-6019-4b06-8215-e28dc2a5914b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.534
b171e742-f2bc-4f5a-a800-6df489b68768	6ba47e11-ccbb-40e5-bf31-f0f22a10454b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.656
fcd70924-99b5-41d0-a861-ff468c18bf4b	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.75
519f13a8-e7cb-4c82-bdb2-eb70a65cc66c	83be342f-6be5-4728-9ec8-0aad63fcb18f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:21.923
46053cea-7e1b-437a-b8f6-ddbffd903332	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.029
4405f674-189c-4c45-bcbf-2508715a0759	f39447bf-b1df-4970-89f7-a4df15c2a0c4	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.206
0d1836d0-4aad-4174-8694-a63f3c0659cc	730c98e5-5ace-47c0-826e-c3543c9686cb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.291
c4322df8-6e7d-416c-b6f2-f4ca10bb4485	c854f638-c2f6-47c3-8da5-8c688cb1f78c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.356
c73bdb30-d22b-40d8-b168-e0ed911f0319	05ab2789-6d48-4c89-869f-abe089fccb4a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.44
65ec76c4-0d79-4fca-9d2c-c743eb7741cc	5891f499-7cc8-4d19-b3de-4b15c0624ef7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.547
e4645c7d-4340-4685-b5d2-a8c179b1578e	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.669
8c5cfd49-de04-4c27-aa7a-bd5cc99aa9a2	526b8286-c88a-40e8-87ef-b94ebea9e97d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.799
b658d9d3-bdce-4fce-9839-0c22eeb74b1a	49fe0add-1125-46cd-a368-f8411e43c44a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.896
1084eeb1-0b12-4c33-92f6-c7d0e43dd308	6d20670c-72c5-45d5-8525-9912c5ec1058	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:22.988
23409978-357d-4300-b813-4071915a5933	d33ab7e2-0a7a-4266-912b-55c5f5b18241	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.188
188f4773-5770-4a57-adf8-77ae79d6875c	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.287
25da2e6f-5b1b-40c5-be3c-c74dd9ee7c36	6c1cc459-173c-490c-9990-d222300e188b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.408
63d8fee0-fe99-4482-a4e1-ff8c8d8944bb	c62c44fd-85cc-4edd-a070-96a4ee09bcf1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.503
5d2da77c-c2fe-4e08-9e97-c2f48aa29478	e64ccb49-7042-4678-9ab6-a8b8dadee65a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.595
8301f361-c716-4c59-a306-96f295dafa31	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.731
d476d80f-e94b-441e-b032-e10007634c23	5db49be2-2435-460d-a6f4-f45b2f275436	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.836
d2549e1a-e609-4c5a-ab8a-be5826fac3a8	f1ba7109-837e-4fd7-944b-54d3b997fbfb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:23.953
a9179cd8-4ed1-47b6-9707-3eac950b5cb9	5d4f5985-c330-48e3-a1e0-23760bc73f4f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:24.048
8481d1d9-e350-4cfd-9e7f-b0c822ba9be7	a3c59c5b-c711-415c-b371-98ffb520891a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:24.13
fbd32080-ad84-48c1-91c3-fce4992debae	c49c5171-b397-41e5-a8cc-c3933347189f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:24.238
37462014-8b94-4149-9910-6fedab761c91	a5266896-6503-4e85-a895-a82fe27c14c7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:48:24.318
565d9556-99a0-47ae-8a44-bc98596b59c0	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-28 05:53:58.29
bf926cd8-d7c5-4b4a-8bce-b78df9ba40aa	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6e6c1c2a-b108-429f-b7db-8a5a7e43d495	2024-08-28 05:53:58.298
bc83f5f6-e957-4764-bc74-0149ef2d59b9	9100f2ae-e4cd-448b-b40b-251e0eb3572f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.185
d9c06fe7-869f-4538-b5f8-46d4c11390a5	c95385ce-966f-49ed-8b4e-7b162d2b0d66	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.471
40548b39-632c-4b8e-947d-79fcf71e864a	98dd5bf8-d2c3-411f-9fdf-57c51a150113	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.632
d601aa2f-c495-486a-807a-63c363776b38	c995dc27-5dc5-44f1-ad05-6f3d0350fe17	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.75
17d595a0-52e8-40e1-8f48-0faa84a8ad63	aef64f27-4ed3-47d5-8620-68378fb412ef	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.84
80233c71-898b-4fcc-8f79-c6e88efae0b2	85729935-7993-4125-8562-127b29db7e60	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:03.97
cec6b50c-57d7-4313-834f-a496117336f4	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:04.11
fb5d5d44-692f-42d5-9a20-217de95e62ad	37d990e5-99ac-4bd1-9700-7f0efa185901	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:04.291
21c81077-bdbc-40c4-a187-eb755c0980e2	5eca0755-2466-4feb-851d-1e3f407260df	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:04.454
befeff18-78e4-4f50-b429-13ffd5f8d77a	a0a730cb-ef7e-4d49-a0a8-103d50af54fa	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:04.688
61ef2374-faf6-4423-8f1e-a6fc9d45cd37	de0ce717-6916-4879-a04e-dbbdfadd4545	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:04.809
bccc663d-5177-482c-a409-825e2aadf837	e0dbe070-d1ef-4573-8391-450a4b3eaaac	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.03
d2b2b5c5-7c7d-4222-91a7-9a7eb4e5d00b	63e30fe7-562e-4f11-9c47-09fa6e5188a7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.347
b6f709bb-d9ae-4aa6-a7e6-7d7fd973b27b	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.512
1b21a3e3-3079-4942-b9ab-69901d0227ee	8e934c6e-187f-42da-9467-6ebc7ccd08bd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.597
5737bdc9-298d-4d15-bcb7-f90eace096e1	3eab8b06-c057-432d-8042-0b15ad87bdc7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.717
4ac819b9-7b4e-41e8-9629-c1edd65cb9d7	971f7c33-1a8f-4d58-91c7-9342a9acd69a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.806
bc41e043-1439-49fe-8ebb-cc4c60d32395	b7930946-5b11-41ae-9385-a05ff8b0bb77	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:05.931
05f1ab77-3a29-4736-a91b-f9582c3487d5	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:06.101
def0c39e-5363-4ba4-a960-7ac2f61474bd	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:06.356
7119620d-6109-4277-b287-04736f855f5e	e84e7f8b-1821-4957-962a-063ce11ec128	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:06.589
ca1cd57a-3f93-4036-9903-f0e827912690	dc5830a1-fb20-4421-ae24-00f9be9f0f04	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:06.717
47d38f94-20a1-4bfe-b78d-71e24729ff43	7165d010-24ea-45e2-994d-4597b6f7dc05	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:06.941
ba8e97db-5ae5-42cd-8b17-31512b8d8845	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.293
79462cba-985d-4282-9297-7b41807b35c7	5e0f7570-92f8-4c39-b7d4-e89276778d25	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.383
f2c70c02-e605-483e-8521-d12013cb1c18	dee1a302-1c56-4b6c-83f9-3bd8bf27323b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.507
a3e31c26-d2e8-480e-8a29-e97bb1fdb612	5c7b80d2-5a14-4b72-ad4e-b30749b13074	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.704
ff4cf55c-97cc-408a-922d-ff1663cf347e	0582992a-1e2c-4add-863b-b5f10d6b4992	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.821
4f5ad0f3-f6ee-4a7d-8ce0-37ec921b19f3	a6759a4c-fc93-4995-9a6d-d30488ab7a12	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:07.987
63b7124f-6002-4452-9d9a-134433e6e9af	e045da04-0570-4317-a560-7cbfeae6f59f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.128
62991494-5217-45fd-b4a3-f903cd39f7a8	573cd423-824d-4f62-bef0-2728da79fcaf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.247
5b816b55-874b-45c9-9418-0a173236e022	1d8467cd-0105-4e3e-957c-446e325920cb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.385
42f70397-4dfe-4437-a157-d0756b9664df	ff338a1b-41d7-40fe-b370-c88ef7d387f8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.537
a530344f-a475-4767-854d-f381ff2c26d8	22285a4b-a9a8-4aec-895e-5ea13125722b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.648
aad76b97-a57e-4c6b-9b24-84955d913f54	542780d9-35a1-4582-86d1-d9ff5971f4ae	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.74
0ece0d2e-95b9-40b0-a01b-1c9a98879d70	ff807dea-119e-487b-9e10-1f7a83b4e172	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.842
c3ca56b9-83e7-4d85-a13f-38694ffd6f90	d816ad42-c674-4776-b507-f2ae86133a4c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:08.944
aea73838-1f0f-4b9a-8333-dca46ca22945	77d3e7a0-1cee-4856-9308-ae8830306caf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.116
5cfe399d-0c1b-477e-ad8b-fdf3e50f4ebb	d79cceb2-5cbb-4477-981f-491a969067b6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.221
d74ba18b-6835-4bab-8b4e-779f1a060acd	86d277ca-6952-4753-9e13-ccdffb252b7b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.366
47c64f6a-296b-4065-a7ff-07fc5065e6b7	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.455
080d84bf-73c1-403d-86ee-aa64215b801f	40b38dd0-c020-4e26-bccc-14f5bfe21970	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.552
4083a97e-adc5-458a-a26e-2596bfbdd898	85b28ae1-f517-423e-bf6f-ef189248faac	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:09.721
182b9dc2-a97f-46ec-8cbc-f174d8a130ac	3986bde4-e078-452d-ae3e-fd93454b4ce2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.005
86426276-9bcd-46d2-b49a-fbf553aa111c	db7f8158-f71a-4ecf-a0a6-48439a05d657	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.126
1e8b166a-5ae1-4bfa-b5ab-d6e023b8e82d	e1e70295-5c37-4c51-8167-9898b9c506f2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.231
35152765-9844-4e22-ad50-595f56b71695	37e4bdbe-f7f9-433a-a726-c9990700701f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.39
382cc3bb-0dd9-4b7e-b934-bef0d22abd28	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.483
aac0d544-192f-44a4-a65d-9760711f1b48	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.601
59b1521b-08f6-46cb-aa28-6691945e4db5	d543f357-e99d-4d70-b7be-2a98d055c997	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.716
f1a6cb8e-52dd-4fde-9b11-838bedce25cb	5c5f698f-3444-44bc-8055-c004d592e0f8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.87
52391483-1712-43e6-ab8a-cfa9be19bd18	2a74d774-a7c5-4b5f-839a-b1911e457bc2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:10.98
b3b28b20-3b3c-483b-bc61-134b41610ad8	1131c61c-771b-4a75-a014-40a4731b9efd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.152
56b9ae8c-c928-4e16-a352-105989db9b50	a2643314-2a6f-4af7-bb1f-11494179d800	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.236
f582c7b4-9fdb-493d-a478-c59baa5b2270	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.369
42a50e95-79a2-4482-8ca2-92b3ef1fcca3	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.462
a5425f42-12a6-4d6b-93b1-b258a9d535fa	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.547
778b5228-16d6-41e8-b4ef-5d131bafcaae	59be1293-6788-45c2-b12c-d35d03727da2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.675
b867ba7f-928d-41ba-b5aa-0d6d72e40a0b	e11b9a8c-c94f-48b5-b192-1a769c1442a7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:11.869
6783925f-c470-43a2-a93e-911070c21cbf	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.019
a9a4e56c-2341-4daa-8bba-86450dbda2e2	d1c81fcf-526f-468c-b8f1-1de6fe5ce572	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.142
2944286c-f1a7-40a1-9f4c-8305babbc0ce	e1a109e1-01cc-476f-a100-046326507dc2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.241
a2077953-a7d7-457a-9a30-222ec40f5dac	1fdcbf6b-e670-46e6-a1f8-308621c26735	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.365
ae683dec-a87d-46b2-be33-9a90d1275af8	bd03e8cb-4881-43d1-aaaa-fd192db5b90f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.487
0ec53e96-736b-44d3-9443-354c6795a161	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.647
9e13de7e-1e7f-4425-af03-6a2cc4493c7d	f423e5f2-d2de-4a4b-983d-7faeee04b0b2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:12.762
849eeb8a-55e3-45cc-a7db-aa59924d07fd	21782926-7972-49d8-b5a4-8163dda4d8bb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.002
d3ee3c97-a4cc-4692-858f-a7f11657cb4f	0c875a99-42f1-4cb4-88ed-398b1c25b9fa	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.225
1ffee957-d997-4045-b9e6-ff625bdb060f	3ba67b11-9e37-462d-83b5-ca4defebe4ed	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.361
cb57b648-f1b4-496b-81a3-9fb79b8a5599	bfc42f90-715d-47dd-bc34-8a3983fd76e5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.456
7e0f2968-40d8-43a9-a416-d7bce6cd8da7	38922471-48a4-430b-acf7-80399379a847	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.577
1be6c1be-c4ba-42ac-aa11-2ce84e30f4f4	7d9c3111-4710-48a5-8e57-42e76f785f6d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.668
f2953d4a-9d22-40fb-9dfb-afa8250317cd	5cdf5b4f-0b52-4adc-a49a-6145cb01c326	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.772
5622fe77-d7c9-4200-bc9e-07fe79b3ac3d	619ff42b-d080-4db1-b808-d769e69bee7f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.88
43c6b4bc-4ad3-4687-a32b-30a0432e0b5c	c5533212-9300-4d0e-b460-5eabc1fa4a0d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:13.988
9a25be52-21cf-4e48-80c7-19efae9e6177	b68c623a-ffa3-4a48-a3c9-76f2f700775b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.126
1b48f050-217f-496e-a2b6-8eacf652f36a	5cd93a3b-b144-453a-a229-2757cb28df22	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.266
cfa2ecfd-c68f-4bda-8b6f-fe4dfb370836	4dd9f659-75d6-44f8-8fae-ac963c6746ab	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.374
f969f22c-2e8d-4b15-911b-19d8c0f41d86	c357212b-e065-4c65-aaa5-7e8b8a14cfa0	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.482
441177a5-d129-49d6-86e4-b267be7f7963	f3fddd33-f77a-40e4-9897-55e61230d643	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.706
8d3d45b0-91bd-454d-9203-934e51a0678e	5434fac2-36e9-4ff9-9955-ba531fbb1ba0	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.788
ad037c9c-1b64-45f8-8757-15d974b03bbd	1c23cfd4-f4d7-49c5-8760-9600e414027e	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:14.953
165b1416-3791-4438-aec8-1f76d78860d5	31ae5186-dc5b-42c3-b676-8590c96de53a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.07
32c2eef0-be22-4841-b2d6-b4ba3bb8f320	d2615292-a50f-47ff-af73-437ec1eb0fea	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.177
7aeec4c6-bdee-4b22-98d2-61eab0b25549	9f557edb-8adf-4832-bc25-ca5b00dfcf4a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.291
9c25f386-57cd-416e-a71e-989e04a51e6f	8fbf163b-f453-434e-ad19-10228894ee8c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.376
53cddfa7-2e08-441f-9735-f47e4e66d9e4	d2834bcb-2154-433e-bb06-e8befbfd7368	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.512
b37a76b7-b951-4e4f-ae76-6e04dd0c43a2	88421493-e09c-407b-91b7-a2bf5f633fa6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.622
0a40a7e9-24e1-44a7-9919-06ed1a8ad40d	45f32ed2-3673-4022-b0ad-e4d60362361f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.712
64324ca7-119a-4512-99db-0403e551f1de	a6975bcc-4113-475c-9da0-5dcb952cf919	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.822
1db672b5-4ce0-4339-89b2-0cfdf626d28f	eb838509-93c4-4e2a-a8c3-3bffd2acc82c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:15.922
03d5069c-4f2c-4eeb-83c2-cdbeadda06c6	815ba1e6-a405-4df4-9909-7fbc8e87a4ac	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.068
3bc64286-bc3e-45ca-957c-a25f7cff325d	473b85ee-3707-4f2e-b370-74e791f3fe1e	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.242
31337884-ed4e-454f-808b-784732cc532c	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.43
32da3eb9-7c93-481e-9e1e-a72dc6430ed0	e88ff86f-02ae-43ba-9060-727ec1a5558c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.593
eae94efc-a5a1-4149-9bbf-477857be70af	0e562d45-0328-4a97-939d-cd11bb7f2ed2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.733
166a8295-281e-48fe-b7fb-6467e5d72ca4	6e4e0e64-47ea-44c0-a997-25766e1a85c1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.868
bdcd0442-7a90-450c-8cbe-152ebd02d90f	6ef284cd-4c54-42c0-99a0-619cb8442030	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:16.968
17877d19-8dc7-46a5-9259-16317200e69d	bce15c48-3692-4a64-a01c-9ae16080077d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:17.072
84322c40-3d47-4cbe-b7b8-d2752eb89386	d6bec1d0-48c5-4652-8612-b4667cb1c442	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:55:17.162
ef57dd6f-c0ff-4d09-a0c8-769be5bc2f36	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7c16d8d3-2740-4330-958b-113b1e63b1db	2024-08-28 05:56:24.3
bcc1f942-066d-457b-8cd3-1dca5b7cde23	c8434922-ec69-4e01-beef-8cfb6ad0f92b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:10.938
a10dae98-757f-4363-81f9-8498254dd71e	cebdc43a-6173-4d07-99df-6ffabe415516	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.226
af0f1de6-8188-4f1b-87c5-006f228c687e	949c4f91-4f71-4751-8c96-4113f5c1672f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.349
51666f68-fbdc-40ea-b281-888808898fc7	9f19df17-a951-4493-944a-cd158fd5ca1a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.506
5056cb0a-bcb8-4ac4-a7a0-0147368f94a7	f968fe68-30ae-42d2-9e74-08bf8e223215	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.698
9cf15af9-d55c-4b19-bd44-7036e8723a4c	380bb01d-d981-4caa-b479-6089a516a075	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.825
52372ec8-1f4a-49a4-bce1-848c495fa3ae	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:11.986
b75d58a1-7b39-4a02-8dca-f5a9d2a1a54f	8749fd89-444e-4786-b0cc-6fed521bdc27	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:12.108
997dfe04-2292-4443-ac35-d90d43a2fdf9	3ecb5f1f-0418-41cd-af4e-93a4f558c522	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:12.223
4bf7072e-31fd-4889-9250-e88a9ac6c95f	7170f559-0812-46be-9851-f1142c91d14c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 05:59:12.35
5a7d022e-ee3e-4706-aa15-7916efe5969e	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-28 07:11:18.457
7b9f5af7-191e-40ff-b73e-9097e8026731	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:33:56.419
5dfe7fcc-5b12-4663-a231-4657cf18a94a	21bc0cfa-c69b-454d-9c5b-4261dea59a6d	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:36:39.744
1a2eb3a6-8555-4cc5-8f20-fae72f6c4af3	5566b584-2023-42f9-b25c-04d15223cd5b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:37:10.085
83d347cb-f1e8-4645-bbdf-75dce2ce05dd	759b3797-b95e-4abc-a83f-c37bd6aa090c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:40:20.809
f1f5ee5c-60a1-453f-9b3c-4df811e3ff6f	1203d0f1-1816-4998-93f0-bdb05c314cd4	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:40:21.224
6c449352-1645-4133-a16a-65d5f54a20f5	ffb1879e-5a8e-46a4-80ec-fe36bd67e584	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:42:07.249
0338486b-ca66-44a9-b7eb-fa4b63dafce6	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:42:07.468
c4d494d9-e63a-4897-b319-98f69bc2c2fb	d04cb17e-fd2c-4727-acd1-76bad464dd01	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:42:16.838
7b7ca972-2d73-4589-b34d-8503cb40a1e7	5cb277d0-f9a3-4de9-9041-470811eeb375	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:42:17.027
0b869dec-7870-4fba-b198-d08a2cd0440e	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:43:12.192
99cf2512-77e7-4f84-814d-d9c273156a71	57734c90-01d3-4f4e-828c-1201f65e42bf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:43:12.449
ce629372-5aa3-44f7-aced-89ff18df7d05	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:43:23.302
b9cf6046-5a4b-4d3a-9e8c-6abb93c8c783	31765d40-d378-420c-a0b4-ca49e7ea59f7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:43:23.589
63bf3eef-830c-42c4-b28a-3ccda246e86d	96f14723-7249-4338-a06a-3b6bbb2ca242	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:48:02.885
2b795f4e-6431-4dda-8ce4-d001f99e9d49	7b85a40d-2149-44be-a888-438cc50012f7	6e6c1c2a-b108-429f-b7db-8a5a7e43d495	2024-08-28 11:50:02.127
3049673a-4c0c-49aa-990f-e3d9b1fac960	2f0dee24-3f81-4ccf-8244-d6488d087f1f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:07.961
eefd1333-ce55-409a-88e7-46c8d47b85f9	b6c3d582-e6cc-4814-a38f-7df873654608	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:08.281
c54387f1-a913-4050-a6cf-b2c1b2f0456d	53d6dbf5-e190-4641-95a1-d734632637da	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:08.443
70cbc653-c99f-48bc-92c5-40b5bf114ffc	d19c8610-487a-48fc-87a1-9de1b1b9cb83	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:08.584
b74ead15-acf8-45e2-8839-5a4fb272db26	145ff272-c8be-4461-b4aa-1a161a921aa8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:08.768
d471c2d2-d264-411d-be4d-ae4ee8fc8f02	bc505c03-f9ae-4e0f-99d5-a29a56830b15	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 11:58:08.947
37253a6c-3f89-455f-9d68-33d90a084210	7e5114fc-def2-4929-91d0-7ca9dc68b2ff	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.11
acc3efb3-2276-41b8-aa10-bc2121872a8c	1e65b0bb-703b-455e-a307-7f82464055e8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.295
0ae12197-9737-4b1d-a459-77e3e9cb4ae2	e999b8ec-ee7a-4889-bec9-9afc50e88dce	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.462
b7fd2e79-9862-42bd-bb5a-68f49a58c6ba	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.553
1244556c-0d16-48c9-835b-2008614c31c2	95f8b881-4861-4f7f-a209-5e6cf25b8d78	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.674
3a86ed20-0608-4c97-84cb-3125327a1f5c	d62f5ea4-de23-4db9-afb5-db9334809de1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.782
ba9b78c7-5d2a-4348-97b9-abfee5f55696	3bf937ce-d0c5-43bd-9119-f8590a8d574c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:32.869
afb1841d-1d90-4c90-8f28-b79d8302db83	616544be-8229-4e20-b1ec-3a286664cef5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.1
33f979ea-f47a-4e69-9710-6ebb4856dde4	e46a8c26-7345-4fed-b81f-2f3ebe9f3864	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.23
a300f446-9b6b-4007-a045-b9a20bbed02f	1cb6a9e2-f9ba-412f-a284-23e6657ef879	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.35
2f44eff8-72db-4803-b85f-fa9c6d08d5c4	98431e33-b96a-4c71-a52d-07883fe7e945	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.48
6ddd68b7-ef9b-4fee-9acf-33e0fb9c759e	9eca8ffd-2cf1-4293-af11-ed381f31d2d9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.56
8d1c333e-9b22-4c28-9708-ba09c4852a45	77d3d92a-1bc8-4648-b22d-401a09d08ab5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.664
6b01118e-2b57-4123-867b-eb42127af488	182027a1-551c-4601-9b84-497348f94e1c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.81
ad25c65c-54bb-43c5-8677-661bd58451ef	1caaf02e-4ee5-4c2b-b520-5846341805ef	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:33.941
f927b6e2-d38e-4af6-910b-8a32cc840312	7d633720-08f4-443c-942d-8da74df41a97	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.198
d896c80f-1eb6-4ce7-8527-42dda7d89d81	bf1a2431-a918-4a36-8334-ab6545e430f7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.305
b0e7277a-ec44-452b-a96a-b3e7f07a6ae7	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.441
f9847c9e-755f-4935-b372-5d416f6e387f	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.543
1fc4140a-12e9-4e4e-bf40-c3b5333d6db6	237b4a46-2822-46cd-b0ac-c82739829a00	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.689
c39f1bb0-e321-403f-ada7-d9c692c34810	51f92be1-4f22-406b-816a-637ac9c1f180	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.786
7f3ac5bf-95f2-4149-a8f6-ca96a222fe42	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:34.871
6cb10ae1-e6eb-4632-9e43-448bd7cee514	5e30ec44-bf17-4518-b5c0-2c1d552a9777	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:35.022
4e64c0d0-dfa0-4d01-9d5b-c33a13c9536b	a080de1e-d906-40a2-9bb6-c3e7528d2b87	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:13:35.134
02baed86-0c4e-4e27-a8b9-2d4770c06cef	20bc764d-59d8-492a-b1e0-3d9814ad034e	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:45.184
2101040a-d6cd-4965-a8e9-4f5ed61ad405	188e2d5e-977a-4730-a383-0cf6431ec5fe	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:45.515
68c268cd-9771-4545-8cb6-76de1e46e35a	6ae32738-74e8-4c49-91cb-e39f7e5df371	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:45.695
b7501e46-50b7-49eb-8f47-7c4f50e66cf0	1e968ba6-7a32-4112-891d-a59c12be57c3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:45.815
9d0904fe-dbdc-44a9-82c7-4e6aae6579b5	150bc895-b1c4-48b6-8acc-513947236dd1	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:45.969
32503754-5ad4-4b4d-8f49-24c1539bba27	eff4d266-7f89-49e1-a67c-29c28ccd7b9f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:46.216
72e8325d-a0e6-4682-8fe0-79a576f33b49	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:46.337
d234ddc9-75bb-414c-b74b-db436af9bdc1	2bd87bc9-bbe0-4a68-b661-67cfc55995b0	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:46.476
d0b03679-7764-490d-9d60-bf109cecdeef	e1f5d089-9099-4909-805c-7ddbdd74e0a3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:46.832
971c7df1-a348-4a0c-a4f8-8940ed1f8619	1532bb49-0e32-4841-8531-eb9f7d831abf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:46.962
445fa882-1ad5-4be9-a223-09fb6f72dda9	a18c5901-3cba-4f12-913a-2f901f7eda55	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.12
00462ee1-8ece-47cd-9e7e-b681dc9555df	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.264
d4f14b59-fe16-4e61-b7f9-1d3e827d88bb	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.356
8cf11f44-5500-401a-b0e4-c46131b45362	03c031d5-def4-4c9f-9c43-ead660b2ecd8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.493
2cfe29ed-a487-4bd2-89fd-78e980b558de	85b9217e-e690-4560-862d-523b8ddf7390	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.675
4e66dd0b-4f4d-4943-bdb8-e46a0ea13502	3c5d9bb9-923d-4745-a499-06d2421d8b06	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.797
e07c151c-3131-4bc6-b0f4-1852224336cc	642a9f33-4469-4b32-b68f-cb043424e73f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:47.953
81b25e5e-5e7a-4cfe-a9fd-38296da72e75	ba12359e-af2d-44ae-b25e-9430f2d3fdc7	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.118
1b1b7cda-15f9-4ad5-bce6-5e74749aef2f	e6286cf3-32ef-43d2-927c-c8c62b50d95c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.266
9831e40c-e1d4-49c7-9a3c-c78cfee65c97	3054bbb2-244c-4974-b7e7-c29dac8b1dc3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.443
300237bf-e980-4cd8-a749-c9c8f2737edb	c9ccd729-0b35-4fbd-8f52-20014506fa20	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.565
ec236a7f-008b-402e-9873-360755782ee3	199da7e4-25bf-47ff-9e51-b5c412af57c9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.714
a9c3abfa-a230-4425-9d2a-3761fe960be4	fd5550aa-da2e-42af-a466-67e2c59fe268	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:48.829
8db7d879-9c36-42c3-981d-1dbca869c436	f8f489c5-baee-42a7-a22f-ceda8b8d760f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:24:49.114
392dba75-3329-42eb-aa65-561e183c3462	a4f0921c-5929-49f3-a2d1-3f0048849db6	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:18.727
b9362a59-399d-46ec-b136-1dddc599d4cc	4e6759e0-6ce9-4277-bff6-d6033bb6f479	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.052
9b377953-55c2-42f0-897b-890b7402c4a9	bda3c9ab-385f-461e-a1cd-37a52d5335c8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.257
2061eea9-b60e-4c34-94e0-3d23559e0fe0	f868438a-b76e-46b3-abaa-f4405a63d0ff	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.37
abd2bdaf-b0a4-4cb9-b883-19cb9f2339cb	5f4a33a0-6d96-44ab-8d8c-24a62013003f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.56
417097ce-9ab4-4f69-aa10-192fb79b46bb	02926a21-64dc-477e-880c-cd6b5eb3394f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.712
f680a671-d37a-42be-86c7-4ba807048e4a	a7f7e5ef-f3af-4ba4-b048-701b6582821f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.816
0796cee6-7e79-4938-a1c1-a209c0b731da	04a2a76c-44ff-46d3-8155-1348edf1828b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:19.965
fabd21a9-bbc5-4741-8e4b-883c2bb647cf	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.084
44696cb8-ee26-4323-b449-2b47e5fb6bf2	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.215
764a36d7-c293-4d84-bebf-1f4063df1745	b4085128-2dc7-4ed5-9332-959dce9b0cbf	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.343
e01e1f37-2ba6-46bb-a195-7ae0b760cbb5	6305399c-c89c-4fb4-8570-42465bd1b79f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.484
1abbccb2-269d-44eb-b7ff-32b50297e39a	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.6
eb60a18e-bceb-4e70-a782-e974e4b9720e	c124d5e0-2509-43fa-8e0c-f07a9db962ed	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.771
4ba2172e-6c26-451d-9134-4214b4b278de	c0982b02-cecb-4f73-adb0-327258fe2f8a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:20.933
543a692f-953f-4067-a140-f80d41799f4d	2ae81c67-7c65-407f-862c-dc6877f856e0	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.033
eccdd3c3-78de-43b9-828c-0bbfd57f94a0	e4cc5b33-8083-410e-b92e-60b818343a90	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.165
0924a41e-f69f-4962-a5b2-b385e0a9a3d0	b97773e6-a871-4572-bac1-7a6637f059cb	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.331
172f39eb-814b-442c-8bc2-93c097911f3f	3c305397-9f6c-4189-aa05-f48fc6d4c02c	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.458
6beac22e-bc41-49f0-a789-22263a2a2248	fc057676-e528-4fcb-a729-4f4eb9ee5e5b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.645
f20b7cc9-8e9e-4871-b64a-5872b690fca5	38f81c95-5586-40dc-be11-7117fcd90f9f	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.773
fce3f865-c80e-4a67-bf6b-8683f2093861	fa3b4cdc-b7a2-4595-a7e4-ef474d129883	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:21.91
67c9770d-c96c-4eac-a9e5-6369b6934446	adcd3d8a-71e5-4bea-880c-ea9f7284a724	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:22.038
712d7bcd-4be0-4e91-afd2-1c0cea61f0e6	9356b60b-8ca4-459e-8347-04943b40dae5	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:22.287
bea6fc4d-8aa1-46d0-aaf1-edd55839a6a2	98b12365-5eed-4f3b-b615-ab87f317c2fd	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:22.467
fe30a8c7-2c5c-45a1-8683-2c768145719b	feaeaa90-81a5-4098-b44e-d39b0d059cf9	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:26:22.669
95dbf912-46c7-40c4-860c-69b02ab04b41	c7437b7a-8e9d-4fd9-a56d-05973ac990df	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 12:28:09.946
2cd0604b-ff1a-46aa-9198-8541c75a4612	c3d9b51f-dfea-40f0-a0d2-7f87737824c3	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 19:38:20.494
114c9600-df56-48d0-af55-49762b65d7d4	a9ad51d1-99d6-4e58-b712-cfbaf6ea5a5b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-28 20:19:47.157
6a07c529-b3ac-4d74-9343-71f0b9018f76	96f14723-7249-4338-a06a-3b6bbb2ca242	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-29 10:40:06.107
82e2762a-9849-445c-8625-63428ddfe8a1	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-29 11:58:57.931
890f54a3-3bce-4158-b661-ac566eb60a46	dd015ecf-9c62-421e-9e5e-91205ad2126a	38cd4fd8-aa67-4919-aeb9-69aa873ec20c	2024-08-29 12:05:26.697
667ae48a-c9a5-4970-89f7-8306fde86e33	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	f66de41e-b6bd-4df7-8d2d-400b8dac5cff	2024-08-29 12:24:48.059
6f906f82-0e93-484b-ac89-4ad527f6d01d	7b85a40d-2149-44be-a888-438cc50012f7	7c16d8d3-2740-4330-958b-113b1e63b1db	2024-08-29 13:54:12.095
\.


--
-- Data for Name: player_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_tokens (id, refresh_token, player_id, created_at, updated_at) FROM stdin;
d39a9ca9-54c6-4410-bae0-4da2d3ce2333	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU0NDE4MDQxLTdjZmItNDkyZS1hM2RjLTBmMzQ4ZTg2MjY4ZCIsInVzZXJOYW1lIjoibG9sZXhwcmVzczIiLCJ0Z0lkIjoiNTM5MjA1NTIyMCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQzMjQzLCJleHAiOjE3Mjc0MzUyNDN9.okpxytHL0DS1576uDq9Kg7z2FDpxMyEwhl3KU0KBvew	e4418041-7cfb-492e-a3dc-0f348e86268d	2024-08-24 16:24:34.617	2024-08-28 11:07:23.361
ab8c2e04-1e0b-47ee-97c3-5d4cd5e373b8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUzZGIyMDc4LTRhODUtNDRhNC1iZjk3LWUxNjViZTAzZjU2ZCIsInVzZXJOYW1lIjoibF9BeWFfSSIsInRnSWQiOiIxMDU4NDQ2Mzg3IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ1MTQ3NjgsImV4cCI6MTcyNzEwNjc2OH0.Df6UOVTFEIaOHhC56VfrXMG2pObFL_HalgJyY9az5DY	e3db2078-4a85-44a4-bf97-e165be03f56d	2024-08-22 11:30:23.478	2024-08-24 15:52:48.173
0fb81164-01f3-4c25-ba17-7e62a7484f8c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ0MDIzMjE0LWZiNTQtNDFmOC1iNTg2LTc4M2QxMDhkYmFjYSIsInVzZXJOYW1lIjoiVml0YSIsInRnSWQiOiIxMzg3NTQwMDg5MTQzMjk2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTIsImV4cCI6MTcyNzQxNjA5Mn0.QVcPB1-JoZrXxjxxAUobRmz4i4uDfsEiJveISjw4LtE	44023214-fb54-41f8-b586-783d108dbaca	2024-08-28 05:48:12.965	2024-08-28 05:48:13.049
df0bbec0-1d0f-4083-b580-d34def3a7fa0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM0NDJmN2QyLTgxYmQtNDhiMi05MWRjLTRjNjRkMTcyYzU0OCIsInVzZXJOYW1lIjoid2Vic2hhcmszIiwidGdJZCI6IjE3ODY4OTE2MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg3NjA3NiwiZXhwIjoxNzI3NDY4MDc2fQ.miZw_aPN0E1VSZkrCH9rI_zsNqd-SWBX9648Sn4tKSM	c442f7d2-81bd-48b2-91dc-4c64d172c548	2024-08-27 18:49:33.841	2024-08-28 20:14:36.893
c03519c5-7072-484d-8ebc-2f4f86bf10e8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdiODVhNDBkLTIxNDktNDRiZS1hODg4LTQzOGNjNTAwMTJmNyIsInVzZXJOYW1lIjoiZGVudGVydWtvcm4iLCJ0Z0lkIjoiNzI5NjE1Mzg0OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0OTQwNjA4LCJleHAiOjE3Mjc1MzI2MDh9.zDkLdjrbjP-SUoFw07Rw9SOacIOPb2TrvD181GhCgP8	7b85a40d-2149-44be-a888-438cc50012f7	2024-08-22 12:59:12.721	2024-08-29 14:10:08.78
5fb9ca4d-e962-480b-ae74-b6b39c3e2399	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdjMTkxNjI4LTdjN2EtNGIzNi04NWNhLTRjNmViODMzM2FhYSIsInVzZXJOYW1lIjoiTGFtYmVydHNvbkFydCIsInRnSWQiOiIxMTA0MjI1NTEyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ5MTU4ODMsImV4cCI6MTcyNzUwNzg4M30.apejTZwpletwzdh_akgDqE16r1UnFi_r1Ts-pJmy6jk	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	2024-08-26 07:59:20.461	2024-08-29 07:18:03.684
c25cb3f0-4ab4-4e6e-b837-26a7598d10a7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYyOWQwODdjLWE2ZmQtNDVlYS05ZmQxLThiMjUyMjRjZmI1OCIsInVzZXJOYW1lIjoiSG9sbGllIiwidGdJZCI6IjMwMDM1NzIwNTg4NDkyODAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MywiZXhwIjoxNzI3NDE2MDkzfQ.d3LDk0-ObXPXYf5vj91P84tqz5sigde5TryRQ38hvIU	f29d087c-a6fd-45ea-9fd1-8b25224cfb58	2024-08-28 05:48:13.096	2024-08-28 05:48:13.156
15cae543-c4f7-4cff-8d4e-f94afc64fa2d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM1YWI1ZDNmLWM5ZGItNDBmZC1hMTcyLWU3ZDVlZWRmODYxZiIsInVzZXJOYW1lIjoiQW50b25pYSIsInRnSWQiOiI1MDU5ODk0ODQ3NzMzNzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MywiZXhwIjoxNzI3NDE2MDkzfQ.2R3KIMLT3k6-P2LyCigVvk0pXJQ1ppWPRm_00DcD4oo	35ab5d3f-c9db-40fd-a172-e7d5eedf861f	2024-08-28 05:48:13.205	2024-08-28 05:48:13.302
fa745e7e-032c-4a49-ac3f-81121b9a2f13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjODhhNDM1LTE0YjktNGM3ZC1hZTk3LTA4YzM4ODIyZTVhZCIsInVzZXJOYW1lIjoiS3Jha2VuQml0MzM3IiwidGdJZCI6IjY1OTI1Mzg5NTAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDk0MDE2OCwiZXhwIjoxNzI3NTMyMTY4fQ.52RixtSgXKpz6jLyi7MdMwHi-VJNRyfcI_KH9mkECjg	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2024-08-21 13:27:23.783	2024-08-29 14:02:48.945
b2805017-023f-467c-baa6-9b6748ea299b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZjM2NkNWM2LTE3ZWYtNGViNi04MGRlLTQ5ODk2ODdhMzVjMyIsInVzZXJOYW1lIjoiZ2FuZ19kcyIsInRnSWQiOiI1NzEwNDMxMDkiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDkzMDg2NywiZXhwIjoxNzI3NTIyODY3fQ.zPDedDj87HQGQ__EeXzsqLx0DTDwEX6DT5mvVdkEETw	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	2024-08-22 13:08:24.746	2024-08-29 11:27:47.581
2995a50f-d9d5-433a-9bd9-6200f758b750	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMyYjA2OWMzLTAwN2UtNDljNy04NGZkLTEyMzFiNGEyZGI0YSIsInVzZXJOYW1lIjoiS2FlbHluIiwidGdJZCI6IjIwNDgwMTU1ODgxMzA4MTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MiwiZXhwIjoxNzI3NDE2MDkyfQ.N9YmIB_Zgg3uuqXuo-x-h7WTS4NJJHVXZ60_CMwfmmU	32b069c3-007e-49c7-84fd-1231b4a2db4a	2024-08-28 05:48:12.586	2024-08-28 05:48:12.749
0328bb24-fa00-4276-9706-effc53b31daa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM1MDNkY2IyLWI3ZWUtNGYxNS1iNTU3LWUyNTA1M2RlOTMxMyIsInVzZXJOYW1lIjoiSW1tYW51ZWwiLCJ0Z0lkIjoiMjE5MDQ4MzY2MzA5Mzc2MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDkzLCJleHAiOjE3Mjc0MTYwOTN9.WUByNNTW1DHqwVsR2j7ZUAZdvna-INmFwuDwUvK85wM	c503dcb2-b7ee-4f15-b557-e25053de9313	2024-08-28 05:48:13.363	2024-08-28 05:48:13.426
a963829b-b480-404f-817b-4f9618ea88f1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYmM5MTYzLTRhYjAtNDNlNi1iYzM3LTlkMDkyYzRmODgwNiIsInVzZXJOYW1lIjoiSmFjcXVlbHluIiwidGdJZCI6IjM4NjA4NjU2NTg5MTI3NjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MywiZXhwIjoxNzI3NDE2MDkzfQ.zB7YuFwhh6GUKimskdliyMMo560WZLvOJw9F_9mtXts	8cbc9163-4ab0-43e6-bc37-9d092c4f8806	2024-08-28 05:48:13.488	2024-08-28 05:48:13.571
9c5b8867-505d-4235-bc43-a4c062837539	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNzgyYmQ3LTI3YjktNGY0Ny1hMjhmLWE3NTFkMjc5M2E4YSIsInVzZXJOYW1lIjoiSmFxdWFuIiwidGdJZCI6IjQ0ODIzMjA3NjU1NTA1OTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MywiZXhwIjoxNzI3NDE2MDkzfQ.behBcoehH3CjTpeIwTRO8TxyyBpaO7fqEAuDc9OZICc	7a782bd7-27b9-4f47-a28f-a751d2793a8a	2024-08-28 05:48:13.635	2024-08-28 05:48:13.704
8e45cb4a-e83f-479c-886a-b59ade317006	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFhYWU0NTI3LWYyODItNGE5OC04YzM1LWQ2NDQwMDViMmM3MSIsInVzZXJOYW1lIjoiTGVzc2llIiwidGdJZCI6IjMwODA1MDc5MDAyOTcyMTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5MywiZXhwIjoxNzI3NDE2MDkzfQ.W82SV2ql0gYK7nQZ8CEQXC-08vXB8gBwFaE3jJZz0FM	aaae4527-f282-4a98-8c35-d644005b2c71	2024-08-28 05:48:13.743	2024-08-28 05:48:13.82
912673b2-29ee-48e3-954f-c1d52ef9eead	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkyM2MyNmZiLWNiYWUtNDNlNC04ZTJhLTcwMDkwMzcwMjUxNyIsInVzZXJOYW1lIjoiTWFkZGlzb24iLCJ0Z0lkIjoiMzk0Nzc3MjQ5OTcyMjI0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTMsImV4cCI6MTcyNzQxNjA5M30.XpwyxXzTB17p6sUH6YaDr0GPQJKc-v-AcBlrtRZwX38	923c26fb-cbae-43e4-8e2a-700903702517	2024-08-28 05:48:13.861	2024-08-28 05:48:13.925
3f5e4f5a-efbf-4ec1-bfff-5367a5803c21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUxODQ4YWUzLTg5NDktNDQ4Yi1hNTc4LTc2NzI2YzViOGE1OSIsInVzZXJOYW1lIjoiSmFycmV0IiwidGdJZCI6IjExMzY3MjczMDk2ODA2NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDkzLCJleHAiOjE3Mjc0MTYwOTN9.qIM8jlSluZqugpV-x0powNuRE4yFMT7I-9lI2rvYM0U	e1848ae3-8949-448b-a578-76726c5b8a59	2024-08-28 05:48:13.964	2024-08-28 05:48:14.023
9fd7e7af-3eb6-4c2a-90ce-dc199f0bbfbf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNkNGIzZGVlLWUxODMtNGMxOS1iNmU2LWE5YzYwN2E0ODJlOCIsInVzZXJOYW1lIjoiRGFycmVsIiwidGdJZCI6IjMyMDI0MjgzNDIxMDgxNjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NCwiZXhwIjoxNzI3NDE2MDk0fQ.d0lhUsL8WGBQfoqJ399BYXSxSU5ksPerPn-kiHWT2P0	cd4b3dee-e183-4c19-b6e6-a9c607a482e8	2024-08-28 05:48:14.061	2024-08-28 05:48:14.126
686ef661-b95a-476e-be42-c00540b1cf5b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYwMmE2ZTc4LWU4OWItNDcxMS05MDcxLWY1MzRlYzI1NTc3NCIsInVzZXJOYW1lIjoiQXVyb3JlIiwidGdJZCI6IjI1NjIxNDc0OTQxMzM3NjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NCwiZXhwIjoxNzI3NDE2MDk0fQ.FXj2n6BojH2AbKsYn8vOP1vYBfXQqHLOGFNoawV23dw	f02a6e78-e89b-4711-9071-f534ec255774	2024-08-28 05:48:14.182	2024-08-28 05:48:14.276
79788b07-5eea-4cff-9511-82a2b89a81e2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczMjk3YjdmLWI1OTYtNGY4OC05ODgyLTU3NDFkM2M1YmFjNiIsInVzZXJOYW1lIjoiR2xhZHlzIiwidGdJZCI6IjMxMTU2ODgwMzE5NDQ3MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NCwiZXhwIjoxNzI3NDE2MDk0fQ.FD8aGrEwmWziBlDoyZB9WkZJznyvnu5fLeHixOyIGS0	73297b7f-b596-4f88-9882-5741d3c5bac6	2024-08-28 05:48:14.343	2024-08-28 05:48:14.409
266c6999-6051-479b-8ad5-99767f0e3311	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZhM2JiOGNkLTk5MDgtNDMzOS05NmE4LWQ2MTkyNzU0NDU0MSIsInVzZXJOYW1lIjoiSmF5ZGUiLCJ0Z0lkIjoiNTcwOTUyMjQ2MzA5NjgzMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk0LCJleHAiOjE3Mjc0MTYwOTR9.NWlvH_BWnT7uI0Nnb1iCd_Sg0gLgKGfSU1udAe6-_ig	fa3bb8cd-9908-4339-96a8-d61927544541	2024-08-28 05:48:14.446	2024-08-28 05:48:14.563
dfa165cc-e384-4ff6-9a96-a9350acd2841	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFlYWU4OGJjLThlNmMtNGY2Mi05MzNmLTBmYTNlNWU5ZjVmOCIsInVzZXJOYW1lIjoiU2lsYXMiLCJ0Z0lkIjoiMjY4MjczMjA0ODAyMzU1MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk0LCJleHAiOjE3Mjc0MTYwOTR9.w2kUg7RtCoFBMBG7cUAUhylyEcOj5foixmMeOyOAGvc	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8	2024-08-28 05:48:14.604	2024-08-28 05:48:14.696
646ed836-fe4a-4c9d-a318-4fcc54cb2e6a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxZjdhNmZmLWViYzItNGZiMi05N2FiLTk5YjBiYTc4YWYyZSIsInVzZXJOYW1lIjoiTGlsbHkiLCJ0Z0lkIjoiNjEzNDgzNzAyMjgxODMwNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk0LCJleHAiOjE3Mjc0MTYwOTR9.ghGCdueAhmRV1cVl5f3HVQi_IFMqSYTEqfhKk3AWv1I	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e	2024-08-28 05:48:14.733	2024-08-28 05:48:14.792
6c668d58-083b-4e15-8e82-c85b031a55ea	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRjODQ1MTliLWFjMzQtNDE3MS05MWMzLTBjNjY0YTAzZTJjYiIsInVzZXJOYW1lIjoiQW5nZWxpY2EiLCJ0Z0lkIjoiNjc5MzEzNzg0NjQ4NDk5MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk0LCJleHAiOjE3Mjc0MTYwOTR9.4Nj9g9eLtFXR3s1VZI-ThTT23W6Z7jIyebXZLv8v59I	4c84519b-ac34-4171-91c3-0c664a03e2cb	2024-08-28 05:48:14.826	2024-08-28 05:48:14.895
ad627cd2-1356-4c77-91e0-cdd321bc7aeb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJlM2YwMzIxLWQ2ZmItNDQ0Mi04MTQ2LTFlZWVlMzAxYmUwMiIsInVzZXJOYW1lIjoiQXJkaXRoIiwidGdJZCI6IjM3OTMxODAwMjk4NzgyNzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NCwiZXhwIjoxNzI3NDE2MDk0fQ.JrVthnCgZlF3x2qnTkAgEA8cUj_ppEbEPj8GDmWhSnk	be3f0321-d6fb-4442-8146-1eeee301be02	2024-08-28 05:48:14.935	2024-08-28 05:48:15.068
3ad17bd6-46d5-422e-96dd-967e0a92e506	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI3YWE3NjUwLTZiZjAtNDk2Yy05NzFiLTAxM2ZlNmFmNGJiYiIsInVzZXJOYW1lIjoiVWxpY2VzIiwidGdJZCI6IjYzNjIxNzk3MzExOTM4NTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NSwiZXhwIjoxNzI3NDE2MDk1fQ.wGoaU7FIlEXMmqpqwYWT45DI9oiXFf49DZNKyCnYi0g	27aa7650-6bf0-496c-971b-013fe6af4bbb	2024-08-28 05:48:15.104	2024-08-28 05:48:15.151
08a509d8-8f16-491d-96e9-ac90dbe229fd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFjZDliMTcyLTViYWItNGEyYS05ODdkLTViMDliY2ZkOTRjZCIsInVzZXJOYW1lIjoiUmlja2llIiwidGdJZCI6IjM3ODczMjkwOTExNDE2MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NSwiZXhwIjoxNzI3NDE2MDk1fQ.Ly1blqbAMko-qchahXJDxakDwcwyGmMbZwOyhl6uZaI	acd9b172-5bab-4a2a-987d-5b09bcfd94cd	2024-08-28 05:48:15.189	2024-08-28 05:48:15.243
15476a7f-fda0-41de-b92a-c4c9c4decd65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZmMjZiMmY5LTQxZTQtNGExZi05YTEwLWQwZmNhNzU5ZjNhMSIsInVzZXJOYW1lIjoiUm9zZW5kbyIsInRnSWQiOiIyOTEzNjgxNDg4NzQwMzUyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTUsImV4cCI6MTcyNzQxNjA5NX0.DTmftE3AvjwcZbmxgag2l8HBBrgekwrCJ7aKfY-K5f8	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1	2024-08-28 05:48:15.289	2024-08-28 05:48:15.345
4798b0b7-aae5-4566-b0b9-49daaaca5c9b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRmYWM4OTk3LWU5NWUtNGZjNy1hZjY2LWFkNTUzZmQ5NjY2ZiIsInVzZXJOYW1lIjoiRG9yY2FzIiwidGdJZCI6IjY2Njc5MTQ0NzgzNTQ0MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NSwiZXhwIjoxNzI3NDE2MDk1fQ.za7HEjakI0WwNVtw0Z54s5fsa-XAXMBAyDNwRuLWFwQ	4fac8997-e95e-4fc7-af66-ad553fd9666f	2024-08-28 05:48:15.39	2024-08-28 05:48:15.446
226be1c4-b4c8-4923-b039-9a635eb998f3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ZDE4MDcxLWFiZmMtNGY0Ni04MjhiLTI3NTQzYWE5MmYyNSIsInVzZXJOYW1lIjoiRGlubyIsInRnSWQiOiI0ODE2ODg0NDA5MDQwODk2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTUsImV4cCI6MTcyNzQxNjA5NX0.68vFbLF-5FLknmvdnkTTQq3nj6JMc5Lsyus8mUbxFmk	77d18071-abfc-4f46-828b-27543aa92f25	2024-08-28 05:48:15.487	2024-08-28 05:48:15.567
6bf4de7e-f792-4586-978e-2af10adc6fa0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQyMmE4MWEzLWM2ZDEtNDNlYS1hNzBkLTE0YTQ3MjNkM2E3MyIsInVzZXJOYW1lIjoiTWFyaWJlbCIsInRnSWQiOiI1Mjc5OTI5NDMyMjc2OTkyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTUsImV4cCI6MTcyNzQxNjA5NX0.YHnUC-EId_N1Jxpv0hBUthXzKePLFEJWhrKVj8QQMWQ	d22a81a3-c6d1-43ea-a70d-14a4723d3a73	2024-08-28 05:48:15.665	2024-08-28 05:48:15.753
ccd54e97-d0bc-4356-9619-1a5700f3d147	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhmZTIxZWU3LWNlZDYtNGE5ZS04NmFjLTlkYmJkYmFhMDAzZiIsInVzZXJOYW1lIjoiR3JhbnQiLCJ0Z0lkIjoiNjUxNjM0MzI5NzgwMjI0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTUsImV4cCI6MTcyNzQxNjA5NX0.1UUs4A82K-e_mmv7M9ZWoN0436i2qI-F0bTHeLnLDuc	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f	2024-08-28 05:48:15.807	2024-08-28 05:48:15.879
23aed54c-a980-4da3-a1c6-b28b0c860aae	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA4NjIyMzZkLTIzYWEtNDBhYi04NzBmLWNiZDcxMWI0Y2Y0OSIsInVzZXJOYW1lIjoiRGVzbW9uZCIsInRnSWQiOiI1NTg3OTQwMTMyNTE5OTM2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTUsImV4cCI6MTcyNzQxNjA5NX0.-69YGCxfeJPEiY0FU4IQS_bwT6OjoL2z_1_A2SUXBJs	0862236d-23aa-40ab-870f-cbd711b4cf49	2024-08-28 05:48:15.973	2024-08-28 05:48:16.02
0ed75c43-3cff-4893-95ba-2fbfae0cfb44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA5NTZkMTMyLTJjOTUtNDkxZC05MTY4LTc2YjQ5ZDI0ODEyOCIsInVzZXJOYW1lIjoiTWFnbnVzIiwidGdJZCI6IjQ0OTI2NDIyNTM1MzcyODAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NiwiZXhwIjoxNzI3NDE2MDk2fQ.L1y-YBqPT8bhsgjaZ58aoVIRCpbjVB3kFdoveqETx4A	0956d132-2c95-491d-9168-76b49d248128	2024-08-28 05:48:16.079	2024-08-28 05:48:16.126
b1d5e827-197c-4fe0-86bc-5e268fcb46d2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MzZiMzY1LWQxYzMtNDE4Yi05MWZlLTg5Y2VkOGY4M2MyOSIsInVzZXJOYW1lIjoiQnJvb2tlIiwidGdJZCI6IjIyMjE4NDI0NzU1MTU5MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NiwiZXhwIjoxNzI3NDE2MDk2fQ.i2qWpJBqIPlC72ZDtBCICS4sYz8mN9lOQny_pqC8VI8	6436b365-d1c3-418b-91fe-89ced8f83c29	2024-08-28 05:48:16.166	2024-08-28 05:48:16.228
72b72c2a-9d41-4df6-b585-296c2664ca7b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyMDkzN2MxLTZiNWMtNGNmYy1iNWYyLWYzMjZmY2E5YWVmZSIsInVzZXJOYW1lIjoiUm9kIiwidGdJZCI6IjMxOTg1ODE2MjAwODA2NDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NiwiZXhwIjoxNzI3NDE2MDk2fQ.hZ9svvv8FoP9Yeqw0h9_efTV2tpiq68ACcwcqsURaW8	420937c1-6b5c-4cfc-b5f2-f326fca9aefe	2024-08-28 05:48:16.266	2024-08-28 05:48:16.348
6b368cb1-bacb-4b16-baa3-b4dec10b1f47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxNzlkMmM0LWM1ZWQtNDdjZS04MDFjLTA4NmQ5MjZkNjY5NiIsInVzZXJOYW1lIjoiQXJ2aWQiLCJ0Z0lkIjoiOTkwODY0NDc0MTEyMDAwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTYsImV4cCI6MTcyNzQxNjA5Nn0.KVhB0UO5NuwTuG30NvCF4UpcYa6tJEz3ouVnfeizpQA	3179d2c4-c5ed-47ce-801c-086d926d6696	2024-08-28 05:48:16.39	2024-08-28 05:48:16.454
15a28f79-0812-42e8-acb2-862b89b68883	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ5YTgxMGRmLWViYmQtNDNiMy1iZWQ2LTk1OGU5MjU1ZDA1OSIsInVzZXJOYW1lIjoiRW1pbGUiLCJ0Z0lkIjoiODU1MjY0NDcxMjg1NzYwMCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk2LCJleHAiOjE3Mjc0MTYwOTZ9.DxmL9N7ieqNAkSM_1SqXyt2jMh3ZCRTvmpYnURjggVQ	d9a810df-ebbd-43b3-bed6-958e9255d059	2024-08-28 05:48:16.508	2024-08-28 05:48:16.56
fecc983a-7a42-47db-a4f7-334eb479061e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRlMWUyMDhmLWVlZjAtNDlkZC1hNDdjLWE3MzE2Yjk4ODY4YSIsInVzZXJOYW1lIjoiRW1lcnNvbiIsInRnSWQiOiIxNDkxNDAzNzA0MTA3MDA4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTYsImV4cCI6MTcyNzQxNjA5Nn0.1t2HV0KUid7AnUmnwNC_ADqFJt59xRiPQRCc_h8_vJY	de1e208f-eef0-49dd-a47c-a7316b98868a	2024-08-28 05:48:16.625	2024-08-28 05:48:16.708
adfe91ee-c3ae-4c97-80f7-c2b8acfc2ef1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM1MGUwMjQ0LTI3MDgtNDgyOC1iNDM1LWE1Mzg0MzdkN2NjZiIsInVzZXJOYW1lIjoiTGVhIiwidGdJZCI6IjU4ODkyOTM2MzEzNTY5MjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NiwiZXhwIjoxNzI3NDE2MDk2fQ.1v2OmFMpu3yOiCyKJPbZDDdoWEgj3F5n1zSVXPuwzlg	c50e0244-2708-4828-b435-a538437d7ccf	2024-08-28 05:48:16.78	2024-08-28 05:48:16.84
c3026e6a-04ed-47ee-bf81-93f57d5c9266	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIyNzRkNzRmLWNiYjctNDk3YS1hOTY1LTVlMGI3NzNlZmI0MyIsInVzZXJOYW1lIjoiU3VtbWVyIiwidGdJZCI6IjU0NTYyNzg1MTYxMzc5ODQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NiwiZXhwIjoxNzI3NDE2MDk2fQ.NfwVm-U4q5pL3xhoExiPSf6aT0mZSjreyu2ACioNze4	b274d74f-cbb7-497a-a965-5e0b773efb43	2024-08-28 05:48:16.9	2024-08-28 05:48:16.958
c89a0a09-688b-46ec-b98e-db8ec3804578	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY5MzdkYjE2LTdjM2EtNGNmYi05ZmQ0LTU2MWFhNmEwY2VhMSIsInVzZXJOYW1lIjoiUnVieSIsInRnSWQiOiIyMzQ0NTg4NzAwMjg2OTc2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTcsImV4cCI6MTcyNzQxNjA5N30.nFVymkndz_9CS3WFtDeK09bcxhbI0yMsJzbcA-lDDlY	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1	2024-08-28 05:48:17.022	2024-08-28 05:48:17.086
4577bfe0-cfc6-4611-9750-5203747ba905	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZlYzcxMzM0LTk2ZTgtNDBlNi04OGI1LTcyMjc4MGU3NWNkYiIsInVzZXJOYW1lIjoiU2hha2lyYSIsInRnSWQiOiIzMjkwMTI3OTAyMTc5MzI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTcsImV4cCI6MTcyNzQxNjA5N30.L0z6Y1DiWMLIsJkfFkNA8kcVBasgNlqPUrm_aIjX2R8	6ec71334-96e8-40e6-88b5-722780e75cdb	2024-08-28 05:48:17.144	2024-08-28 05:48:17.225
b562bfb9-742a-4586-bfe8-15fb955f43bb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDg4NWY3LWRlYTEtNGM0Yy1iNWQ2LTY5OTk3YmI1N2VkNCIsInVzZXJOYW1lIjoiSG9sbHkiLCJ0Z0lkIjoiMTcxMDQ1NTg0MDA0NzEwNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk3LCJleHAiOjE3Mjc0MTYwOTd9.tv0H30YFdlin8Z9_hz2oQn55edCG1tHPJOPI4POa93M	694885f7-dea1-4c4c-b5d6-69997bb57ed4	2024-08-28 05:48:17.258	2024-08-28 05:48:17.361
7ed07b8b-c21d-402c-be64-b05e03e137a7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJkZjIwODkyLTZjMDQtNDc5OS04NWI1LTBhN2VjNjBkMTFhNCIsInVzZXJOYW1lIjoiUm9kZXJpY2siLCJ0Z0lkIjoiNDAyMDg5ODQ5OTY1NzcyOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk3LCJleHAiOjE3Mjc0MTYwOTd9.29zg1_dHQO2NCFlebVRqIzwqfNMPUhaEpJHV2_m4tgg	bdf20892-6c04-4799-85b5-0a7ec60d11a4	2024-08-28 05:48:17.425	2024-08-28 05:48:17.482
2e9b8935-da5c-484a-b5d5-48da59adc22e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFiNDFlNzBjLTk1MGMtNDQzZC1iZjNkLWQ1N2M5NmFmOGNkNCIsInVzZXJOYW1lIjoiSGF6ZWwiLCJ0Z0lkIjoiNzQyNTg1MTMxODU5OTY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTcsImV4cCI6MTcyNzQxNjA5N30.J8Q5F4QiJrblqduycW240lCaqzXpHVeCVu3Fu95wCrg	1b41e70c-950c-443d-bf3d-d57c96af8cd4	2024-08-28 05:48:17.549	2024-08-28 05:48:17.606
784287f9-0404-4c66-ac0a-6a6c15372b00	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk4ODlhMTdkLTczMGYtNGI3YS04Mzg5LThlNGM3ZDBmNDVhNSIsInVzZXJOYW1lIjoiUmhlYSIsInRnSWQiOiI0ODM5NDMxNDA4MTg5NDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NywiZXhwIjoxNzI3NDE2MDk3fQ.3fHYhnBEcnHLiPJLx6YG93HILCv4DZYoBeVDED9jBM8	9889a17d-730f-4b7a-8389-8e4c7d0f45a5	2024-08-28 05:48:17.664	2024-08-28 05:48:17.723
e659e8c6-ec36-4f58-8133-df4657eb3dfa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJjMTg5YTNkLTZhZjUtNGIxZC04MWJmLWE0ZDllMzYwMWRkNiIsInVzZXJOYW1lIjoiSGVucmlldHRlIiwidGdJZCI6IjMzNDU5MDMxNzc5NTczNzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NywiZXhwIjoxNzI3NDE2MDk3fQ.Q20mHthZWtf3zgwGos4Mh2zhs8nn4Bx1RgTHHVGwfZs	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6	2024-08-28 05:48:17.772	2024-08-28 05:48:17.868
9f9c406c-016e-499a-92ee-6c486435666b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNiNTgwOTU3LTBhNDktNDk1Ny1iZDE3LWRkNzNjNmU1ZmMxZCIsInVzZXJOYW1lIjoiVmVybGllIiwidGdJZCI6Ijc1MTY1MDQxMDkwODg3NjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5NywiZXhwIjoxNzI3NDE2MDk3fQ.1993BwqkU92Cni9arTkQCM_dcH0zs9SUpzszgrdM6Is	cb580957-0a49-4957-bd17-dd73c6e5fc1d	2024-08-28 05:48:17.909	2024-08-28 05:48:17.956
a2db71d2-46d8-4e5f-bff6-09ba00f81b89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGFlOTc2LTgyZjItNDVmOC1iZmMwLTZiYzJmOWFhNTFiZiIsInVzZXJOYW1lIjoiV2Fpbm8iLCJ0Z0lkIjoiNzA4MDQyMjU5OTAzMjgzMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk3LCJleHAiOjE3Mjc0MTYwOTd9.IrpORAWMxajiatqNXO9pdtWoAKllSc7KuDWriXMP_eU	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf	2024-08-28 05:48:18.001	2024-08-28 05:48:18.076
931971e1-6037-43ee-a5c2-cda0b90f02e9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA2OGJiZGQ4LTIxNGMtNDVjNS1iYmQzLTMxNDAwYjU3NzVhZCIsInVzZXJOYW1lIjoiSHVnaCIsInRnSWQiOiIyNTE5OTkwMzk5OTI2MjcyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.c8BPDMZTQo4WAiyp3_kQcQCpy2PuulPoVZQqvgUB4m0	068bbdd8-214c-45c5-bbd3-31400b5775ad	2024-08-28 05:48:18.113	2024-08-28 05:48:18.167
3b0b1dd5-d396-45b6-b2fe-7f4a4acf6c49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM0NmFmMWNmLTdiZWYtNDVlMi04ZmM2LTljZmNkYWEwNTMwMCIsInVzZXJOYW1lIjoiQ29sZW1hbiIsInRnSWQiOiI3NDIyNTAxMDExMzI0OTI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.IhjxTNJ2RBEvpS7kJrzTyZZULpRYJy93FIUt76GR1I0	346af1cf-7bef-45e2-8fc6-9cfcdaa05300	2024-08-28 05:48:18.2	2024-08-28 05:48:18.262
10e9b69f-d5f6-4219-9363-8e0a81ec0fe1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEzZGQyYjg5LWQxMWEtNDI4OS1hZjBlLTkzY2Q3YmYzZmIxYSIsInVzZXJOYW1lIjoiRXVuYSIsInRnSWQiOiI2NjI0NjU4OTQ0MTYzODQwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.23pUKV-2zAveZ99yOsvrvogybiYKz2L6Vca-ubopFrI	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a	2024-08-28 05:48:18.3	2024-08-28 05:48:18.347
7a942531-7d86-4224-bd19-64acfbee1f8e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkzNDkyZTE5LWI0ODEtNDljMi1hMmQ2LWM1ZTM2NDRlM2IyZCIsInVzZXJOYW1lIjoiQ2FyeSIsInRnSWQiOiI1NzI3OTk3MzA0NzY2NDY0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.ebA20DwYHMmEzMmaK5CnFBCVHz3meKCqSccZReR7WzM	93492e19-b481-49c2-a2d6-c5e3644e3b2d	2024-08-28 05:48:18.388	2024-08-28 05:48:18.452
b797559f-e4ff-4319-b3fa-2ad66ab5870d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNhZTY0Yjk0LWRkZWYtNDAxYi1iMzQ1LTFjZDg2OTZmZDk2NyIsInVzZXJOYW1lIjoiV2VsbGluZ3RvbiIsInRnSWQiOiI0Mzg4ODA0NDg1OTcxOTY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.ZoOTK3WD2xMfEaLkEVJ1Z7pEs0DqNu5PaAijSMKSfdM	3ae64b94-ddef-401b-b345-1cd8696fd967	2024-08-28 05:48:18.492	2024-08-28 05:48:18.553
dbbe22df-7565-48f6-9b48-fa9e955a6f89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk3NjQ3MDUyLTk4OTEtNGJkOS1iZTliLTY3OWNhNzljYjFkMSIsInVzZXJOYW1lIjoiQ29ubmVyIiwidGdJZCI6IjY1MTI1NTk2MTYxNjM4NDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5OCwiZXhwIjoxNzI3NDE2MDk4fQ.Fhsq1wsFYOzPra0H7vghlhMQxkQZBwcKP04Q8riu7Og	97647052-9891-4bd9-be9b-679ca79cb1d1	2024-08-28 05:48:18.594	2024-08-28 05:48:18.649
6adf474b-da1f-4703-906e-9673d8740091	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNzNlMjc3LWY2NjItNDcyMC1hNWExLWYzNGE4YmI5MjIxYSIsInVzZXJOYW1lIjoiRXBocmFpbSIsInRnSWQiOiIyODc5NzM5NTMyNDEwODgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTgsImV4cCI6MTcyNzQxNjA5OH0.5ty6ZqWdDfsp6xE9dT_kXKnrS7HOexom2E6i-wbt7_0	6173e277-f662-4720-a5a1-f34a8bb9221a	2024-08-28 05:48:18.684	2024-08-28 05:48:18.734
7990fe92-3ed9-4762-b64a-ace2d7a8ac2f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIzNTZjYmY5LTlhYWMtNDIwMy05MjJjLTc5MDRkODQ0ZjAwYyIsInVzZXJOYW1lIjoiRGVsbGEiLCJ0Z0lkIjoiNTExNDI0NTE3NzkzMzgyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk4LCJleHAiOjE3Mjc0MTYwOTh9.j6gL4G7k0T0WC-A_6lbfQfRkoHF-Ex5W0-Fx2kGPZ3Q	b356cbf9-9aac-4203-922c-7904d844f00c	2024-08-28 05:48:18.785	2024-08-28 05:48:18.862
2f29b152-0d53-4826-a5cd-6d523395cf88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZkY2YzNmVhLWNlYzgtNDQyMC05N2NmLWY2NjViNTA2ZmRiNiIsInVzZXJOYW1lIjoiU2lzdGVyIiwidGdJZCI6IjM3MDk3OTYxOTg5MDc5MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5OCwiZXhwIjoxNzI3NDE2MDk4fQ.0_FxKkLFDFNqE4NfYIoDqSJko0INWYSlknaCIBYQI2k	6dcf36ea-cec8-4420-97cf-f665b506fdb6	2024-08-28 05:48:18.913	2024-08-28 05:48:18.966
e1732b8b-4c73-4991-8202-a7b4bcb36358	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMxY2VlOTUxLWQyMTktNDFjZi1hNjQ3LWE2MWQwNzM2NmZlNyIsInVzZXJOYW1lIjoiU3RlcGhhbnkiLCJ0Z0lkIjoiNTA0NjkxMjE1MTQ1MzY5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk5LCJleHAiOjE3Mjc0MTYwOTl9.ZYCcnc658VKPB5gS8j5hSbK6FiDEw3CFpj_ips6l0qM	c1cee951-d219-41cf-a647-a61d07366fe7	2024-08-28 05:48:19.006	2024-08-28 05:48:19.08
9e805fd0-f3cc-4796-9beb-d8a375ecd976	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBjOTU3NDE2LTNkOWQtNDViZC04MGE0LTc4MGNiNjU3YTc3YiIsInVzZXJOYW1lIjoiTHVpZ2kiLCJ0Z0lkIjoiMjE0MjI2MTcyOTAzNDI0MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk5LCJleHAiOjE3Mjc0MTYwOTl9.qI5Ma9ioWoGU1K2UGl5fMT3L4LuCcy2cJ201tGy90x0	0c957416-3d9d-45bd-80a4-780cb657a77b	2024-08-28 05:48:19.124	2024-08-28 05:48:19.222
5ba0b6c2-aa11-4a11-85d6-8c57be884ca5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxNjJmNTZhLThjZWQtNGIzZC1iMDcxLTFkZjdkYzY3NjBjNSIsInVzZXJOYW1lIjoiRGVzdGFueSIsInRnSWQiOiI1ODIzNjYwODgzNDQzNzEyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTksImV4cCI6MTcyNzQxNjA5OX0.WUHhmO0MTbGlQrHU13ZYA85G7AxkUXBo-InJNvfks0c	2162f56a-8ced-4b3d-b071-1df7dc6760c5	2024-08-28 05:48:19.274	2024-08-28 05:48:19.343
4879aaf7-3b98-4526-ac00-b980c18cb68e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwZDZhNjc1LTRmOWYtNDYzYS1iMjM5LTllMjY0M2FhYThhOSIsInVzZXJOYW1lIjoiTW9uaWNhIiwidGdJZCI6IjY5MjM5MjU5MTA5Nzg1NjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5OSwiZXhwIjoxNzI3NDE2MDk5fQ.TCODkwZHOt8eWLx-UP5DheZUab60Yz_i2H1NvKs8KAI	60d6a675-4f9f-463a-b239-9e2643aaa8a9	2024-08-28 05:48:19.399	2024-08-28 05:48:19.453
0d4bec5e-dff9-4faa-a325-b1376cdb7b75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgwOGM2YTc2LWVjNmMtNDA5MC1hZjY4LWI3ZWU0YzhmMzYzMCIsInVzZXJOYW1lIjoiQXVzdGVuIiwidGdJZCI6IjM3NzkwMDYyNDM1MzY4OTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDA5OSwiZXhwIjoxNzI3NDE2MDk5fQ.q7PGkMVkAuPMjI4PD25mxIg14gqJXxK9mV8J4GyttCo	808c6a76-ec6c-4090-af68-b7ee4c8f3630	2024-08-28 05:48:19.524	2024-08-28 05:48:19.622
a78bd804-5ec8-48a5-9d75-ec5ab0700b84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUxYmU3N2IzLTc4N2UtNDM2NC04NzY1LTI3MzA4ODk3NGUwNiIsInVzZXJOYW1lIjoiSHltYW4iLCJ0Z0lkIjoiODM5ODUzNjQxMjQ5NTg3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MDk5LCJleHAiOjE3Mjc0MTYwOTl9.khS9XKWlT45nGOWAAjESsX4fjxhc1cp6BO-E1lxzy48	51be77b3-787e-4364-8765-273088974e06	2024-08-28 05:48:19.658	2024-08-28 05:48:19.733
4b768bbd-9462-441f-9cfb-03949205309d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVhMDFmYmMwLTdhN2QtNDM4MC1hNmEyLTYyOGZiMTNjOWU3ZiIsInVzZXJOYW1lIjoiTGluY29sbiIsInRnSWQiOiIxNzgzNjkyMTg3OTI2NTI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTksImV4cCI6MTcyNzQxNjA5OX0.Gtczs8PA3B8bG-vN0-eS2pOLP6Tg3R1BD7uCur8154Y	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f	2024-08-28 05:48:19.771	2024-08-28 05:48:19.832
c06543d9-e3ff-45c5-956c-01347924e7ef	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJkYjQ5YjMwLTcxZDctNGIxNi1hZmZhLWM0YWU0OTAwMzA3MSIsInVzZXJOYW1lIjoiTWFyaXNvbCIsInRnSWQiOiI3MDc0MDk3MjE5NTAyMDgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTksImV4cCI6MTcyNzQxNjA5OX0.JWW-QrwjIrDPuO79H081DiCEhwhm809ysNDMaCMGt4g	2db49b30-71d7-4b16-affa-c4ae49003071	2024-08-28 05:48:19.871	2024-08-28 05:48:19.933
f4053e65-dfad-416c-8075-8d492da1ad56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjMWQ5ZTQ5LWMzYTAtNDE5OC04Zjc4LTY1NDM5OGE3MzA5MCIsInVzZXJOYW1lIjoiTW9uYSIsInRnSWQiOiI1OTI4Mjg4MzM1NjkxNzc2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQwOTksImV4cCI6MTcyNzQxNjA5OX0.iGN_H63M2Y_YcoATmQrZ_bWxqEeezhPWux8MBbn4aZY	5c1d9e49-c3a0-4198-8f78-654398a73090	2024-08-28 05:48:19.974	2024-08-28 05:48:20.049
3c672749-8f57-4c5e-b9d2-376e81249107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRjMjM1YzRkLTEzNjQtNDE1ZS1hMzY5LTgyN2Y5YWViZjlhNyIsInVzZXJOYW1lIjoiR29sZGVuIiwidGdJZCI6Ijc5MDU1NzUxNzQxNDQwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDAsImV4cCI6MTcyNzQxNjEwMH0.Redc97Lt4-FOgV2BIBvyBiyRe_Gv7E3jaVxQnXMNW6k	4c235c4d-1364-415e-a369-827f9aebf9a7	2024-08-28 05:48:20.109	2024-08-28 05:48:20.162
8e2f97bc-d1e7-41bc-9de2-9e067655985c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVmYTlkNzQ2LTM4MDUtNDQwNS04YjdiLTE5MWI5MTM3ZjYzNSIsInVzZXJOYW1lIjoiSGVsb2lzZSIsInRnSWQiOiIzNTA3NzM5MTc1MTU3NzYwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDAsImV4cCI6MTcyNzQxNjEwMH0.3xN-7UgEclfAHZeAQaj178ork4nYeTAXrAJMiRzEsWM	efa9d746-3805-4405-8b7b-191b9137f635	2024-08-28 05:48:20.211	2024-08-28 05:48:20.262
724db44e-af3d-4e96-9474-c0e4fe3581dd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ1YWRkNzM3LWYzNDAtNGRlNi04MjczLWEzYzliNjJkN2U3NyIsInVzZXJOYW1lIjoiSmFtaXIiLCJ0Z0lkIjoiODAyNzc3MDk4MjQ5ODMwNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAwLCJleHAiOjE3Mjc0MTYxMDB9.PHC9ba1NfiZPHjBKgBeti-C1KOx3FXlROBFokY5QeOE	45add737-f340-4de6-8273-a3c9b62d7e77	2024-08-28 05:48:20.297	2024-08-28 05:48:20.344
a95f08ff-26a9-4dee-9331-f71affe29d71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRkMzllZDkyLTQ4YjgtNDVjMi1iMzM2LWJiOGU4YjA1MDEzZCIsInVzZXJOYW1lIjoiQ2FybGllIiwidGdJZCI6IjcwMDYyMTM3OTEyODUyNDgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMCwiZXhwIjoxNzI3NDE2MTAwfQ.paioe3E73tZ3Zu2gZ0O7IR40uBqhcT_NwL21ZAM-vX4	dd39ed92-48b8-45c2-b336-bb8e8b05013d	2024-08-28 05:48:20.379	2024-08-28 05:48:20.437
8d476d60-8085-4298-82f6-75797505f480	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkwMWQ2NmNlLThkZDItNDM0Yi05MmJjLTA1MmU2NDcxYTg4YyIsInVzZXJOYW1lIjoiUm9kZXJpY2siLCJ0Z0lkIjoiNzIzMDkxNjgxMjM0MTI0OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAwLCJleHAiOjE3Mjc0MTYxMDB9._R_TrWA4oUWt7ZBkNYgl7mA6YskZTZamizbFx30MJ_c	901d66ce-8dd2-434b-92bc-052e6471a88c	2024-08-28 05:48:20.494	2024-08-28 05:48:20.542
22bc8a45-57b8-44c9-b7e9-ef1b2bb2e215	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNjNzdkYjY2LThjYzEtNDk1My1hOTI0LWQwMzg0MDhmMzA5YiIsInVzZXJOYW1lIjoiUmVhZ2FuIiwidGdJZCI6IjY5MjE0NzQ3MTE0ODY0NjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMCwiZXhwIjoxNzI3NDE2MTAwfQ.RrmluKAwPcMbZIerm0aHUZVs9795vMv4Psfq767Tvsg	3c77db66-8cc1-4953-a924-d038408f309b	2024-08-28 05:48:20.585	2024-08-28 05:48:20.646
bca499ef-248e-4d61-bbf7-7c0b518da046	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNlY2ViZTYxLThkYjMtNDRjYi1iNjUxLTI5NjE5MDQ0ZDY4NiIsInVzZXJOYW1lIjoiVWJhbGRvIiwidGdJZCI6IjE1MDM1MTQwNjkwNDExNTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMCwiZXhwIjoxNzI3NDE2MTAwfQ.e6e82cJ0ib3fY4YAJu6CVbabqiYufZkQ-9aRZgnwzI4	cecebe61-8db3-44cb-b651-29619044d686	2024-08-28 05:48:20.684	2024-08-28 05:48:20.765
3af97592-49ad-413f-b97b-a773b72ac2aa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRjNThmNTdhLWQzMzItNDk5MS04MDU5LTYzNGQ5YTUwZGY2OCIsInVzZXJOYW1lIjoiU2FsbGllIiwidGdJZCI6Ijc2MDU3MTIxNzU3NTkzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAwLCJleHAiOjE3Mjc0MTYxMDB9.Mp_eC0FwISnv80VUJA0-xRoPDQicIEWaN5A8X5km6Lg	dc58f57a-d332-4991-8059-634d9a50df68	2024-08-28 05:48:20.796	2024-08-28 05:48:20.852
e477dcea-9021-4b55-9644-a9daa4e6639b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY2OTBmMTgzLWNjNzgtNDRjMS1iNTZkLTk4ODE0ZDY1MDkxOSIsInVzZXJOYW1lIjoiUmljYXJkbyIsInRnSWQiOiI3MTg2NTYyMzg5Mzc3MDI0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDAsImV4cCI6MTcyNzQxNjEwMH0.o7GY_sFnxAWm2YIYgK0Kg72-0fwHhJciO6Aubi8OKLQ	f690f183-cc78-44c1-b56d-98814d650919	2024-08-28 05:48:20.894	2024-08-28 05:48:20.941
a671e574-3c53-480d-ad9c-128c81d62f4c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE2N2I2NDE5LTdlYWMtNGE0OS04MTZlLTJiZmRlZmRlN2MxMCIsInVzZXJOYW1lIjoiT2xnYSIsInRnSWQiOiIxODk2NTA2MTcyODk5MzI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDAsImV4cCI6MTcyNzQxNjEwMH0.DCRzuXFM2StWpE6qrrXeW3W8ooQvZBPH0HtLwJg_Pg8	a67b6419-7eac-4a49-816e-2bfdefde7c10	2024-08-28 05:48:20.998	2024-08-28 05:48:21.077
b87287c5-77b8-4838-819f-47f0ee926557	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE4Y2NhZWE1LTc1MGUtNDAyNS05Mzc0LWFjMTI1NTNmODIzZCIsInVzZXJOYW1lIjoiQ2F0aGVyaW5lIiwidGdJZCI6Ijc2MjUyMTI2Njk0NjA0ODAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMSwiZXhwIjoxNzI3NDE2MTAxfQ.HpoTYZOs9izzdoKhdax-I4gGWwMzqtiAasBtqtM1xtU	a8ccaea5-750e-4025-9374-ac12553f823d	2024-08-28 05:48:21.15	2024-08-28 05:48:21.227
7d5677a0-c0c9-4ecb-8793-721312c21ea2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyOTJjODlmLTNmZTEtNGIwZC04NTkyLWFkOTQzYTViZTY2YyIsInVzZXJOYW1lIjoiVml0YSIsInRnSWQiOiIxMjQwNTkyNjIxMjQwMzIwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDEsImV4cCI6MTcyNzQxNjEwMX0.XXhsCRQdbsB8fWWZ4JRGXpeXaUOv_XH3CuGpM_GqHOE	2292c89f-3fe1-4b0d-8592-ad943a5be66c	2024-08-28 05:48:21.272	2024-08-28 05:48:21.345
1abf03f8-4982-4914-b3d2-513277154b7f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc1NTU3NWM1LTUyNjItNDAyZC05N2QyLTc1NjNkMjExZWI5YyIsInVzZXJOYW1lIjoiQmVydGhhIiwidGdJZCI6IjY4MzEwOTY4MzI0NTg3NTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMSwiZXhwIjoxNzI3NDE2MTAxfQ.Xm9iak3RBeEkukpN8Nlngwgq2FTOg2ULYET_iKgOLtk	755575c5-5262-402d-97d2-7563d211eb9c	2024-08-28 05:48:21.379	2024-08-28 05:48:21.484
a579ca80-210e-4487-ab48-b1f75e284563	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5ODJiODgzLTYwMTktNGIwNi04MjE1LWUyOGRjMmE1OTE0YiIsInVzZXJOYW1lIjoiTWVsdmluIiwidGdJZCI6Ijc4NDAxMTAxMTY2MDE4NTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMSwiZXhwIjoxNzI3NDE2MTAxfQ.KEJlsBcWhWrkxwS5KtL2z7MIS5_RtEZeVPYNEQ7eyTQ	8982b883-6019-4b06-8215-e28dc2a5914b	2024-08-28 05:48:21.531	2024-08-28 05:48:21.622
bc93961a-973b-4bef-abfe-490a116b8f17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZiYTQ3ZTExLWNjYmItNDBlNS1iZjMxLWYwZjIyYTEwNDU0YiIsInVzZXJOYW1lIjoiTGFyb24iLCJ0Z0lkIjoiODU5Mzk2NDI2NTM3MzY5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAxLCJleHAiOjE3Mjc0MTYxMDF9.XttuYtLZ5wlXH_foQghgyr-gXiEg-nhioRYMEvZ7xb8	6ba47e11-ccbb-40e5-bf31-f0f22a10454b	2024-08-28 05:48:21.655	2024-08-28 05:48:21.703
8d6163d2-a695-4da2-a17a-0dad55ca72fe	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyYzE5YjNjLWY1MGMtNDA2MS1iNmVkLWU0YzRjN2EyMDkzYSIsInVzZXJOYW1lIjoiRGVhbmdlbG8iLCJ0Z0lkIjoiMjIxNzEyMTY3NTIxNDg0OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAxLCJleHAiOjE3Mjc0MTYxMDF9.FEOJy85m2QOIDX2CUXHzDxx_z8KqmOuzIqRt9gfmstM	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a	2024-08-28 05:48:21.748	2024-08-28 05:48:21.829
79ff42b4-7b01-454b-8a1f-d064f4d60161	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgzYmUzNDJmLTZiZTUtNDcyOC05ZWM4LTBhYWQ2M2ZjYjE4ZiIsInVzZXJOYW1lIjoiUm9tYWluZSIsInRnSWQiOiI2OTk1NzQ0MDM4ODQ2NDY0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDEsImV4cCI6MTcyNzQxNjEwMX0.6_4WvOjXEidyoth2-n1uhn8nfbhil3XEgTMyCGzmUZA	83be342f-6be5-4728-9ec8-0aad63fcb18f	2024-08-28 05:48:21.921	2024-08-28 05:48:21.98
74f7f480-fed4-4d00-a7ab-d8b8d3f8b202	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRlZjcwYzRhLTc0ZTAtNGNjMy05NTYyLWFkMmZiYjE1MTVmNiIsInVzZXJOYW1lIjoiQWduZXMiLCJ0Z0lkIjoiNzUxNTE5OTQyMjU5NTA3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAyLCJleHAiOjE3Mjc0MTYxMDJ9.l6uSvTtJwftbmUonM9oUD5OqH5bQbNTlBfY2DISeeAI	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6	2024-08-28 05:48:22.026	2024-08-28 05:48:22.12
513dc1b0-59c7-4bad-99bd-aa425d1c1e39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYzOTQ0N2JmLWIxZGYtNDk3MC04OWY3LWE0ZGYxNWMyYTBjNCIsInVzZXJOYW1lIjoiQWhtYWQiLCJ0Z0lkIjoiODAyNDU5MDIyNzg2NTYwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDIsImV4cCI6MTcyNzQxNjEwMn0.YGA6Ap45JBPrSbF6QH1Y8lgXs1WbwC8HLfSsSJZnnqY	f39447bf-b1df-4970-89f7-a4df15c2a0c4	2024-08-28 05:48:22.204	2024-08-28 05:48:22.262
511d45d5-906e-4802-8241-325de874760d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczMGM5OGU1LTVhY2UtNDdjMC04MjZlLWMzNTQzYzk2ODZjYiIsInVzZXJOYW1lIjoiRWxpbm9yZSIsInRnSWQiOiIyNTM5NzYyNTk4NTQzMzYwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDIsImV4cCI6MTcyNzQxNjEwMn0.5FMFzDl6AA0h_3su8tBAS_eIP-YPxX5YHF7vhdiPr_M	730c98e5-5ace-47c0-826e-c3543c9686cb	2024-08-28 05:48:22.29	2024-08-28 05:48:22.326
3cbffe3f-3312-40ac-83f6-e3db2d2c02c6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM4NTRmNjM4LWMyZjYtNDdjMy04ZGE1LThjNjg4Y2IxZjc4YyIsInVzZXJOYW1lIjoiU2F2aW9uIiwidGdJZCI6Ijc2OTM0NTM1MDI3MDk3NjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMiwiZXhwIjoxNzI3NDE2MTAyfQ.qIzorLtiBZg36dXUQzBFDMxjvw7xyuV7XLBFvEamCdA	c854f638-c2f6-47c3-8da5-8c688cb1f78c	2024-08-28 05:48:22.355	2024-08-28 05:48:22.403
c5d0f8b9-f381-40b2-b5c0-203e33687861	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA1YWIyNzg5LTZkNDgtNGM4OS04NjlmLWFiZTA4OWZjY2I0YSIsInVzZXJOYW1lIjoiSWRhIiwidGdJZCI6Ijc5NzczNDU0NTk2ODMzMjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMiwiZXhwIjoxNzI3NDE2MTAyfQ.woQaqcTpF816cXr6tg-sPMkOhikmMHJMJx4tz3GBEAc	05ab2789-6d48-4c89-869f-abe089fccb4a	2024-08-28 05:48:22.439	2024-08-28 05:48:22.499
c332abe9-b0bb-4f7f-8f56-aea1f8f8da8e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU4OTFmNDk5LTdjYzgtNGQxOS1iM2RlLTRiMTVjMDYyNGVmNyIsInVzZXJOYW1lIjoiTWFuZHkiLCJ0Z0lkIjoiODE2NTUxMTQ3OTE2NDkyOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAyLCJleHAiOjE3Mjc0MTYxMDJ9.YY5eWXYjvDBpQqjwQQoz_cuFdqdym3Iz5z1n6hCxgS0	5891f499-7cc8-4d19-b3de-4b15c0624ef7	2024-08-28 05:48:22.545	2024-08-28 05:48:22.621
af92856a-3016-4060-ae0a-26914c7a202c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI5MmQ1ZmE1LWYwYjYtNGY2MS04ZWQ2LTBmNWIzNmRhNjgxNSIsInVzZXJOYW1lIjoiS3lsZXIiLCJ0Z0lkIjoiNjI1NjE0MTA5OTA3MzUzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAyLCJleHAiOjE3Mjc0MTYxMDJ9.0Lc2SJ0DFmrUv7YvOUaHXZGViZl8epDsWRiMkfhiWm4	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815	2024-08-28 05:48:22.667	2024-08-28 05:48:22.764
7cd4e579-6b3e-4416-a1aa-55993774ad81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUyNmI4Mjg2LWM4OGEtNDBlOC04N2VmLWI5NGViZWE5ZTk3ZCIsInVzZXJOYW1lIjoiTWFrYXlsYSIsInRnSWQiOiI4MTM0MDY0NTM4MTI0Mjg4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDIsImV4cCI6MTcyNzQxNjEwMn0.OkfPPhbXV6RTa8MCSxr_J0Wl59XEYGd8CF_LlZWswzc	526b8286-c88a-40e8-87ef-b94ebea9e97d	2024-08-28 05:48:22.797	2024-08-28 05:48:22.843
7cff1793-5514-436c-8c87-484d6d4ca09a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ5ZmUwYWRkLTExMjUtNDZjZC1hMzY4LWY4NDExZTQzYzQ0YSIsInVzZXJOYW1lIjoiQnJpY2UiLCJ0Z0lkIjoiNTYzNzg1NTc0NzUwNjE3NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAyLCJleHAiOjE3Mjc0MTYxMDJ9.eqi9gzkDQInX89zalm6WAo2nYhwtDekdKZtTC4N_QUQ	49fe0add-1125-46cd-a368-f8411e43c44a	2024-08-28 05:48:22.893	2024-08-28 05:48:22.95
1dfac5e9-28aa-4720-8b06-8216cea2f254	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZkMjA2NzBjLTcyYzUtNDVkNS04NTI1LTk5MTJjNWVjMTA1OCIsInVzZXJOYW1lIjoiUm9iaW4iLCJ0Z0lkIjoiMjY5MTI2OTUzNDk0MTE4NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAyLCJleHAiOjE3Mjc0MTYxMDJ9.w_8qrv6uIDSQEtAXDnKA5yMPjSKxxf6svB4J_85FdKg	6d20670c-72c5-45d5-8525-9912c5ec1058	2024-08-28 05:48:22.985	2024-08-28 05:48:23.149
71e92011-4a95-4d7a-b9a4-45b43020f0dd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQzM2FiN2UyLTBhN2EtNDI2Ni05MTJiLTU1YzVmNWIxODI0MSIsInVzZXJOYW1lIjoiRWR5dGhlIiwidGdJZCI6IjUwODA1NjI1MTk3NjkwODgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMywiZXhwIjoxNzI3NDE2MTAzfQ.7ZTwulAuj2wqT9E3L8MYpII4cDKU-tAQ_UhLIx9qo5M	d33ab7e2-0a7a-4266-912b-55c5f5b18241	2024-08-28 05:48:23.183	2024-08-28 05:48:23.237
a8c67520-c4c1-4858-a28f-651a45499c8f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyM2E5Y2I5LTU3ZmEtNDhmNy1hMWRjLWZjZDY3ZmQwNzZmOSIsInVzZXJOYW1lIjoiT3Jpb24iLCJ0Z0lkIjoiNDkzOTU2ODEyNjA5OTQ1NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAzLCJleHAiOjE3Mjc0MTYxMDN9.incQUfHW9fe2VoLDAXspnjokCcz1HXz4m8FPRvjZY8Y	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9	2024-08-28 05:48:23.284	2024-08-28 05:48:23.366
1d149171-037a-4f0b-884d-3f76e385a984	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZjMWNjNDU5LTE3M2MtNDkwYy05OTkwLWQyMjIzMDBlMTg4YiIsInVzZXJOYW1lIjoiRHVuY2FuIiwidGdJZCI6IjIwMTI4MzczMjUwNDU3NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAzLCJleHAiOjE3Mjc0MTYxMDN9.iVtOpON3qyAgbtVg63FQEgQjnibxXGAGxMnapv1Wb88	6c1cc459-173c-490c-9990-d222300e188b	2024-08-28 05:48:23.405	2024-08-28 05:48:23.453
29fa26ec-6494-4591-9e14-15c8b2252d44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM2MmM0NGZkLTg1Y2MtNGVkZC1hMDcwLTk2YTRlZTA5YmNmMSIsInVzZXJOYW1lIjoiU3RldmUiLCJ0Z0lkIjoiNTE4MjA3MDE0Mzg0NDM1MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0MTAzLCJleHAiOjE3Mjc0MTYxMDN9.__clKyBMBx6RT1xwX8kDJojbSpz0lsA4O2zO5dN4XkQ	c62c44fd-85cc-4edd-a070-96a4ee09bcf1	2024-08-28 05:48:23.501	2024-08-28 05:48:23.542
2eea3689-2ea6-4b4c-afb7-595f8de49d1b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2NGNjYjQ5LTcwNDItNDY3OC05YWI2LWE4YjhkYWRlZTY1YSIsInVzZXJOYW1lIjoiRWRpc29uIiwidGdJZCI6IjEyODExNjg4NTA4MTI5MjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMywiZXhwIjoxNzI3NDE2MTAzfQ.0YiEXy3bNo0Fia_q5yOx4VO0Oap45H3rl9OuFogXZQQ	e64ccb49-7042-4678-9ab6-a8b8dadee65a	2024-08-28 05:48:23.594	2024-08-28 05:48:23.687
5ca26d1c-5e4b-42fc-9cab-19feb50e2668	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVhMjdhMzJlLWY5NmItNDQ2MS1iNTRiLWM1ZThkZDRjODhjZCIsInVzZXJOYW1lIjoiVmFsZW50aW5hIiwidGdJZCI6Ijg4MDgwMzMxNDY2MzQyNDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMywiZXhwIjoxNzI3NDE2MTAzfQ.hVfFD6mbZ-W_Z9dI2b_szBRh7QMfKHIWcb6p8_Uo5OU	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd	2024-08-28 05:48:23.729	2024-08-28 05:48:23.801
0178455b-51cc-4a79-bb83-6aae19b2ef10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVkYjQ5YmUyLTI0MzUtNDYwZC1hNmY0LWY0NWIyZjI3NTQzNiIsInVzZXJOYW1lIjoiTWlrZSIsInRnSWQiOiI3MTgzNzM2Mjg2MjE2MTkyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDMsImV4cCI6MTcyNzQxNjEwM30.pQHBq4HixdDb0UjQZ8PsCdI6xxI6NrdGIoz_9N1y0ws	5db49be2-2435-460d-a6f4-f45b2f275436	2024-08-28 05:48:23.834	2024-08-28 05:48:23.902
8b690ee3-1e45-485a-9675-5d1309e8cb77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYxYmE3MTA5LTgzN2UtNGZkNy05NDRiLTU0ZDNiOTk3ZmJmYiIsInVzZXJOYW1lIjoiTGVubmllIiwidGdJZCI6IjMwNTgwNzQzNjk2NTQ3ODQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDEwMywiZXhwIjoxNzI3NDE2MTAzfQ.LG72XywPPBE0e21qwYqk9CekFH3ypO7AjF87a3lG-Zo	f1ba7109-837e-4fd7-944b-54d3b997fbfb	2024-08-28 05:48:23.951	2024-08-28 05:48:24.014
c423ad14-1726-4db9-8e49-2bbb295637b9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVkNGY1OTg1LWMzMzAtNDhlMy1hMWUwLTIzNzYwYmM3M2Y0ZiIsInVzZXJOYW1lIjoiSnVzdGljZSIsInRnSWQiOiIyNzQyMTQxMzUwNTc2MTI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDQsImV4cCI6MTcyNzQxNjEwNH0.RFg2my6jaWwXpiOp24WvJTWJtVgv9kqVqOzkP37wq-4	5d4f5985-c330-48e3-a1e0-23760bc73f4f	2024-08-28 05:48:24.045	2024-08-28 05:48:24.092
34e6ce20-36b7-445e-a617-0cea8498fdf4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEzYzU5YzViLWM3MTEtNDE1Yy1iMzcxLTk4ZmZiNTIwODkxYSIsInVzZXJOYW1lIjoiRWxzZSIsInRnSWQiOiIyNzk3NDY4MDQzNDQ0MjI0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDQsImV4cCI6MTcyNzQxNjEwNH0.l-3aniIo2zXzOhtHcGYwkLQmwIKQBeGhJUVBAmy34w0	a3c59c5b-c711-415c-b371-98ffb520891a	2024-08-28 05:48:24.128	2024-08-28 05:48:24.198
265457c3-8178-4ed7-a1fe-575a62b0fe67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM0OWM1MTcxLWIzOTctNDFlNS1hOGNjLWMzOTMzMzQ3MTg5ZiIsInVzZXJOYW1lIjoiRGVzbW9uZCIsInRnSWQiOiIyNjAzMjY5NjEwMjc0ODE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDQsImV4cCI6MTcyNzQxNjEwNH0.db_PwMNe1RJBGwk_2KsX3hAPmMunAnL5p6Lyk-84M5k	c49c5171-b397-41e5-a8cc-c3933347189f	2024-08-28 05:48:24.237	2024-08-28 05:48:24.287
864e7ec2-ee5e-4bc7-b25b-a6a76abc2238	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1MjY2ODk2LTY1MDMtNGU4NS1hODk1LWE4MmZlMjdjMTRjNyIsInVzZXJOYW1lIjoiQ2Fzc2lkeSIsInRnSWQiOiI4MjYwNjk5OTA0MDE2Mzg0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQxMDQsImV4cCI6MTcyNzQxNjEwNH0.OJqsqv5GCGqWEikwJ33cOq1DHr9stFf5NjCswIjTMjc	a5266896-6503-4e85-a895-a82fe27c14c7	2024-08-28 05:48:24.316	2024-08-28 05:48:24.361
23de0c0b-292c-4c54-856b-c0fa3ffaff46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxMDBmMmFlLWU0Y2QtNDQ4Yi1iNDBiLTI1MWUwZWIzNTcyZiIsInVzZXJOYW1lIjoiS2lyc3RlbiIsInRnSWQiOiIzNDMwNTcwNjA4NTU4MDgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwMywiZXhwIjoxNzI3NDE2NTAzfQ.Xcy5mD-K558lWszzhUOJQPVAzf-xpbiPOHF68KqH4Lw	9100f2ae-e4cd-448b-b40b-251e0eb3572f	2024-08-28 05:55:03.181	2024-08-28 05:55:03.326
0795dd26-6ac9-45cb-b123-012d4611e01d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5NTM4NWNlLTk2NmYtNDllZC04YjRlLTdiMTYyZDJiMGQ2NiIsInVzZXJOYW1lIjoiRG91ZyIsInRnSWQiOiI4NDAxMDYyNDQwNDY4NDgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDMsImV4cCI6MTcyNzQxNjUwM30.yQn6g7G_i8HqKSz3u3JOb-hB-dHqjdk3ETKMQgUZcqg	c95385ce-966f-49ed-8b4e-7b162d2b0d66	2024-08-28 05:55:03.469	2024-08-28 05:55:03.542
f35b286f-2f09-4b01-af37-3d6a9a364a48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk4ZGQ1YmY4LWQyYzMtNDExZi05ZmRmLTU3YzUxYTE1MDExMyIsInVzZXJOYW1lIjoiQnJhbmR5biIsInRnSWQiOiIyMzg2ODEzOTE4MzgwMDMyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDMsImV4cCI6MTcyNzQxNjUwM30.p0qIhm-stUdBFGqyyPtnmmDQ17DP1onNqo3gQFXrv_g	98dd5bf8-d2c3-411f-9fdf-57c51a150113	2024-08-28 05:55:03.628	2024-08-28 05:55:03.704
190f0d54-f834-43ca-bd1d-7df0ae0460e3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5OTVkYzI3LTVkYzUtNDRmMS1hZDA1LTZmM2QwMzUwZmUxNyIsInVzZXJOYW1lIjoiTm9ibGUiLCJ0Z0lkIjoiNjk3NDMwMzIzNDk0OTEyMCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTAzLCJleHAiOjE3Mjc0MTY1MDN9.p4IlwvB6gf6kUDnOlVBJaPbU4WdY7NSZuEdsf57XbTY	c995dc27-5dc5-44f1-ad05-6f3d0350fe17	2024-08-28 05:55:03.747	2024-08-28 05:55:03.801
57c08aa3-f4e9-4e40-aad9-477f27fb71c3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFlZjY0ZjI3LTRlZDMtNDdkNS04NjIwLTY4Mzc4ZmI0MTJlZiIsInVzZXJOYW1lIjoiQW50b25ldHRhIiwidGdJZCI6Ijg0NjY2NzY5MTU4OTYzMjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwMywiZXhwIjoxNzI3NDE2NTAzfQ.eHtMubkXFaiTgRqzcutmzFkOBE6aZ_OmAtS9KnnbVHE	aef64f27-4ed3-47d5-8620-68378fb412ef	2024-08-28 05:55:03.838	2024-08-28 05:55:03.915
7dde2c94-2141-488f-9a4e-23ec4df2f2d2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg1NzI5OTM1LTc5OTMtNDEyNS04NTYyLTEyN2IyOWRiN2U2MCIsInVzZXJOYW1lIjoiSmF1bml0YSIsInRnSWQiOiI0OTMyMTc1MDgyMjkxMjAwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDMsImV4cCI6MTcyNzQxNjUwM30.7jU2P331lOO8mnvUqti64-nH7_nIU4RzakOPRArcAN8	85729935-7993-4125-8562-127b29db7e60	2024-08-28 05:55:03.955	2024-08-28 05:55:04.051
a880e800-5b21-4a04-8960-88784910972e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFkN2IyNWQzLWQ3M2QtNDAzMC1iMWQ4LTU2NjNiMWIwYTQyYSIsInVzZXJOYW1lIjoiQ2xveWQiLCJ0Z0lkIjoiMjU3MjM4ODA2MzUxMDUyOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA0LCJleHAiOjE3Mjc0MTY1MDR9.OZSJdtgiBDh16-pWASP4V7qwwpaWt6OuMCbWCd3dR4c	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a	2024-08-28 05:55:04.104	2024-08-28 05:55:04.208
efeef4f4-88fc-4b85-9493-e17e5b32e72b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM3ZDk5MGU1LTk5YWMtNGJkMS05NzAwLTdmMGVmYTE4NTkwMSIsInVzZXJOYW1lIjoiSmFjbHluIiwidGdJZCI6IjQ5NjM4NTE5NTUwNzcxMjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNCwiZXhwIjoxNzI3NDE2NTA0fQ.bnyGXmriIu3_3W7kPSK6_d5jVa2WVC57wv6w8WR0680	37d990e5-99ac-4bd1-9700-7f0efa185901	2024-08-28 05:55:04.277	2024-08-28 05:55:04.39
f8864a5e-c4e9-4dcd-a082-f88300ed4064	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlY2EwNzU1LTI0NjYtNGZlYi04NTFkLTFlM2Y0MDcyNjBkZiIsInVzZXJOYW1lIjoiU2hhbmlhIiwidGdJZCI6IjI3ODg3OTE2OTc4MDEyMTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNCwiZXhwIjoxNzI3NDE2NTA0fQ.Acz_9h7I__kWZz9t9v2uu20sxtkhnFXsQnnOv-Lt958	5eca0755-2466-4feb-851d-1e3f407260df	2024-08-28 05:55:04.437	2024-08-28 05:55:04.627
f9ff9383-69b1-4afa-bf0a-9f5fbba1a71f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEwYTczMGNiLWVmN2UtNGQ0OS1hMGE4LTEwM2Q1MGFmNTRmYSIsInVzZXJOYW1lIjoiTm9lbWkiLCJ0Z0lkIjoiMjY0ODUzNjI1NDUxMzE1MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA0LCJleHAiOjE3Mjc0MTY1MDR9.-tg_PmDHoDNYPYpACSw6f0s6Srwxs5zJLwvtsVnoFIA	a0a730cb-ef7e-4d49-a0a8-103d50af54fa	2024-08-28 05:55:04.685	2024-08-28 05:55:04.741
c12be01a-b80b-4ddd-a4b1-4447cb524d5e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRlMGNlNzE3LTY5MTYtNDg3OS1hMDRlLWRiYmRmYWRkNDU0NSIsInVzZXJOYW1lIjoiTmljb2xhcyIsInRnSWQiOiIzNTQ1ODkwMDYxMDI1MjgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDQsImV4cCI6MTcyNzQxNjUwNH0.CJnoy6fw-D4U_ZqdVHZ9uwxojrRDKBU4C3o69ISklAk	de0ce717-6916-4879-a04e-dbbdfadd4545	2024-08-28 05:55:04.801	2024-08-28 05:55:04.969
788f4070-c096-485f-b91f-e83294d57649	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUwZGJlMDcwLWQxZWYtNDU3My04MzkxLTQ1MGE0YjNlYWFhYyIsInVzZXJOYW1lIjoiQXJhY2VseSIsInRnSWQiOiI0Mjc4Mjg0Njg2NzIxMDI0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDUsImV4cCI6MTcyNzQxNjUwNX0.98gaOJsr4CxvzdSu5w7goJUrcMUy_urLI6uYnBEALsQ	e0dbe070-d1ef-4573-8391-450a4b3eaaac	2024-08-28 05:55:05.017	2024-08-28 05:55:05.203
ef73c1c4-14ac-4c27-b31f-cbfb0a91c1c2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZTMwZmU3LTU2MmUtNGYxMS05YzQ3LTA5ZmE2ZTUxODhhNyIsInVzZXJOYW1lIjoiTmV2YSIsInRnSWQiOiIyOTIxMDg2NDM4MDgwNTEyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDUsImV4cCI6MTcyNzQxNjUwNX0.-1ZcE3I6Qlu8o1g_aJh9IlB87kfrYXoDw82bqq56ESo	63e30fe7-562e-4f11-9c47-09fa6e5188a7	2024-08-28 05:55:05.32	2024-08-28 05:55:05.453
0722ec23-0898-435a-8bd8-71e74c28457e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhmZDRlYTgwLTlmOGItNDFmNS1hY2Q3LWZiOGQ5ZDFhNDFiOSIsInVzZXJOYW1lIjoiVGlhbm5hIiwidGdJZCI6IjYwMTUxMzEzOTU4MTc0NzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNSwiZXhwIjoxNzI3NDE2NTA1fQ.hWsFSbHimSmq9XYynWTZLVRRbb7NNE2qVk3SbGEpaVc	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9	2024-08-28 05:55:05.51	2024-08-28 05:55:05.558
642ad403-6fbd-48f3-b435-bdcf7adcc465	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhlOTM0YzZlLTE4N2YtNDJkYS05NDY3LTZlYmM3Y2NkMDhiZCIsInVzZXJOYW1lIjoiVHJhdmlzIiwidGdJZCI6IjU4MzExODY4NTMxMzQzMzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNSwiZXhwIjoxNzI3NDE2NTA1fQ.W1uxwFOq3CIfmK0T1C_zG61gmF2Ky1skRCIpC5xP2kE	8e934c6e-187f-42da-9467-6ebc7ccd08bd	2024-08-28 05:55:05.594	2024-08-28 05:55:05.664
5b415b86-0d2b-485c-ac12-0a1070982ac0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNlYWI4YjA2LWMwNTctNDMyZC04MDQyLTBiMTVhZDg3YmRjNyIsInVzZXJOYW1lIjoiQWxldGhhIiwidGdJZCI6IjcwMzI4NDQ4ODQ5MDE4ODgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNSwiZXhwIjoxNzI3NDE2NTA1fQ.AytJqqn4_5wbbVZ1GBMJN_MpIoV1so_ZMbYuycsfxdg	3eab8b06-c057-432d-8042-0b15ad87bdc7	2024-08-28 05:55:05.711	2024-08-28 05:55:05.769
6e3a33ce-1a12-416e-99ce-814d7d1473ab	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk3MWY3YzMzLTFhOGYtNGQ1OC05MWM3LTkzNDJhOWFjZDY5YSIsInVzZXJOYW1lIjoiTWFpYSIsInRnSWQiOiI4NjUyMTY1MjI0NTk1NDU2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDUsImV4cCI6MTcyNzQxNjUwNX0.94o1ws0q9Rx1B9N4ltHDAmYcO-1YuAWihqSevu0LEVQ	971f7c33-1a8f-4d58-91c7-9342a9acd69a	2024-08-28 05:55:05.804	2024-08-28 05:55:05.87
4614c239-7cfb-4b8c-8992-e6a418ecb749	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3OTMwOTQ2LTViMTEtNDFhZS05Mzg1LWEwNWZmOGIwYmI3NyIsInVzZXJOYW1lIjoiRGFyaW9uIiwidGdJZCI6IjkzNTgzNzk2MzM4Njg4MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA1LCJleHAiOjE3Mjc0MTY1MDV9.8LHcBauMXhqcmDjsOUdL5_YgHl9m4rQtmq6bqIFnTTs	b7930946-5b11-41ae-9385-a05ff8b0bb77	2024-08-28 05:55:05.929	2024-08-28 05:55:06.063
61ebf66a-5f5a-4991-94c5-dc126c90e657	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhiOTlkNTM5LTdjM2UtNGYyMy1iOWU0LTEwMTJlN2YyYTMyYiIsInVzZXJOYW1lIjoiUXVpbm4iLCJ0Z0lkIjoiMzQ4ODc4NTQwODk4MzA0MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA2LCJleHAiOjE3Mjc0MTY1MDZ9.kWbSVTps-0saqo1SR8WJ-HnfT-sxS6Zk_c7vH57f4X4	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b	2024-08-28 05:55:06.099	2024-08-28 05:55:06.231
f7e3c17e-6c78-4b53-b1ea-858b9057447d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ZWEwY2QyLTVmN2EtNGE4Mi1iY2I4LWJiZjk5NGM4MDI3MyIsInVzZXJOYW1lIjoiQW5hIiwidGdJZCI6IjEzNzg4MTI4ODc1NjQyODgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNiwiZXhwIjoxNzI3NDE2NTA2fQ.x1cPqZvz9oA_i_k8z80NA8XqMpqUzGurQFZX6JhkPzs	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273	2024-08-28 05:55:06.315	2024-08-28 05:55:06.553
0049561a-4a89-4dd6-b516-22ab903b8a70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU4NGU3ZjhiLTE4MjEtNDk1Ny05NjJhLTA2M2NlMTFlYzEyOCIsInVzZXJOYW1lIjoiSnVsaW8iLCJ0Z0lkIjoiNzc0MTY5NTA3NjU5Nzc2MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA2LCJleHAiOjE3Mjc0MTY1MDZ9.tgnbnhVGLoka_bL4vRBjQubLvbsxGQCEfvSvvtWRycI	e84e7f8b-1821-4957-962a-063ce11ec128	2024-08-28 05:55:06.586	2024-08-28 05:55:06.662
2531cd90-e6e4-4f61-9ede-bf48fcdae5e0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRjNTgzMGExLWZiMjAtNDQyMS1hZTI0LTAwZjliZTlmMGYwNCIsInVzZXJOYW1lIjoiRnJlZGR5IiwidGdJZCI6IjYwNjcxNDY0NTcwODgwMDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNiwiZXhwIjoxNzI3NDE2NTA2fQ.ZZnC6maaCIwaJUtJl6bGyfJ3I7k2lQ4tM-4xfRdPxAw	dc5830a1-fb20-4421-ae24-00f9be9f0f04	2024-08-28 05:55:06.715	2024-08-28 05:55:06.817
d246740c-9ee8-423f-acf3-0ebbd1da6fa9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjcxNjVkMDEwLTI0ZWEtNDVlMi05OTRkLTQ1OTdiNmY3ZGMwNSIsInVzZXJOYW1lIjoiR2VuZSIsInRnSWQiOiIyODg2OTYwNTgyNDkyMTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNiwiZXhwIjoxNzI3NDE2NTA2fQ.WuMFn9lI3tVhFNEdftCGZIZCr2QuAeQfAoJWxzra2_U	7165d010-24ea-45e2-994d-4597b6f7dc05	2024-08-28 05:55:06.936	2024-08-28 05:55:07.192
fe285e90-de8e-4e29-8e4e-177dc2813d41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk4YjAzZTJlLWU1YTctNGYzYS1iZDA0LWE3YWQ1NmNkNzQxMyIsInVzZXJOYW1lIjoiQ2xvdmlzIiwidGdJZCI6IjExOTkxNDE5Mjk2MTUzNjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNywiZXhwIjoxNzI3NDE2NTA3fQ.HGqIW8nMzk3E2v7TCq4B3P_DSujbrp5fWhIT90YF4tQ	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413	2024-08-28 05:55:07.265	2024-08-28 05:55:07.343
7715f94a-ac11-4b84-8ffb-d63ae2778a21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlMGY3NTcwLTkyZjgtNGMzOS1iN2Q0LWU4OTI3Njc3OGQyNSIsInVzZXJOYW1lIjoiSmFkZSIsInRnSWQiOiI2NTAwMDg2MTE0NjgwODMyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDcsImV4cCI6MTcyNzQxNjUwN30.xWOCpqEb40T8w3SZ6DrGFCkmL_vADLv6PE-_1LisDKo	5e0f7570-92f8-4c39-b7d4-e89276778d25	2024-08-28 05:55:07.381	2024-08-28 05:55:07.454
4a173198-359d-4709-aa58-90ce87afbb3b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRlZTFhMzAyLTFjNTYtNGI2Yy04M2Y5LTNiZDhiZjI3MzIzYiIsInVzZXJOYW1lIjoiQ2hhbmVsIiwidGdJZCI6IjYxMzE4MTkxNTM5ODE0NDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNywiZXhwIjoxNzI3NDE2NTA3fQ.YRCHbn7i0_8TU4oSzlxRokw23rAQo1H5_DgHxQEbSjI	dee1a302-1c56-4b6c-83f9-3bd8bf27323b	2024-08-28 05:55:07.498	2024-08-28 05:55:07.668
c7781fb4-cbe0-4682-a89f-6203feab86f6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjN2I4MGQyLTVhMTQtNGI3Mi1hZDRlLWIzMDc0OWIxMzA3NCIsInVzZXJOYW1lIjoiRGFycmVsIiwidGdJZCI6Ijg5NTk2ODA1MTY3MTg1OTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNywiZXhwIjoxNzI3NDE2NTA3fQ.4MN0LKvG6QjRrU0Z5XQvDqDFBZvI9lxJy5cvguK_Igk	5c7b80d2-5a14-4b72-ad4e-b30749b13074	2024-08-28 05:55:07.701	2024-08-28 05:55:07.78
d7d899e6-5852-40c2-8ea8-2b348d9cf8c3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA1ODI5OTJhLTFlMmMtNGFkZC04NjNiLWI1ZjEwZDZiNDk5MiIsInVzZXJOYW1lIjoiSmF5bGluIiwidGdJZCI6IjQ1NjY2NDk4OTE5NzkyNjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwNywiZXhwIjoxNzI3NDE2NTA3fQ.KZptGEu8Tx0jhMGIfxDKVldEUZ31Lo8rP0TmJIBxVxc	0582992a-1e2c-4add-863b-b5f10d6b4992	2024-08-28 05:55:07.813	2024-08-28 05:55:07.947
33cf11aa-2d9f-4caf-81c8-34b9d6071138	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE2NzU5YTRjLWZjOTMtNDk5NS05YTZkLWQzMDQ4OGFiN2ExMiIsInVzZXJOYW1lIjoiSGFsaWUiLCJ0Z0lkIjoiNTI5MTY3NjkxMjMyMDUxMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA3LCJleHAiOjE3Mjc0MTY1MDd9.EUGKmOxrfn6eZh6NDBR9EEMJ1rnBeN1FBg_keylGt_8	a6759a4c-fc93-4995-9a6d-d30488ab7a12	2024-08-28 05:55:07.985	2024-08-28 05:55:08.084
0a610bd2-e1b2-4d05-81ad-24ae10a78993	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUwNDVkYTA0LTA1NzAtNDMxNy1hNTYwLTdjYmZlYWU2ZjU5ZiIsInVzZXJOYW1lIjoiRGVtYXJjbyIsInRnSWQiOiIzNDAwODI0NTM3NDgxMjE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDgsImV4cCI6MTcyNzQxNjUwOH0.M87gvdEXvFwgsdS32Beu8x45Ni59BHFDuMQIcVSP5yo	e045da04-0570-4317-a560-7cbfeae6f59f	2024-08-28 05:55:08.126	2024-08-28 05:55:08.205
4893b4cd-679f-4dae-b777-21fac149ba31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU3M2NkNDIzLTgyNGQtNGY2Mi1iZWYwLTI3MjhkYTc5ZmNhZiIsInVzZXJOYW1lIjoiQW5pYmFsIiwidGdJZCI6Ijg0MTM4OTU4NDI1OTQ4MTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOCwiZXhwIjoxNzI3NDE2NTA4fQ.ezlSX3eExinIvmuQ28EMjdngeIkF7Q5tt8VMFyFrv94	573cd423-824d-4f62-bef0-2728da79fcaf	2024-08-28 05:55:08.244	2024-08-28 05:55:08.336
92d3db82-5264-4c39-8c00-8e0519b4d38e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFkODQ2N2NkLTAxMDUtNGUzZS05NTdjLTQ0NmUzMjU5MjBjYiIsInVzZXJOYW1lIjoiRGVyZWsiLCJ0Z0lkIjoiNjkzNDI5MTg5MjE0MjA4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDgsImV4cCI6MTcyNzQxNjUwOH0.FSKJ9BuyqdBhk21GqcTmX80_h6nGoGzCHmAS5XmLnQc	1d8467cd-0105-4e3e-957c-446e325920cb	2024-08-28 05:55:08.382	2024-08-28 05:55:08.477
e04680c4-1338-4b9e-a9ee-63942d04c0c6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZmMzM4YTFiLTQxZDctNDBmZS1iMzcwLWM4OGVmN2QzODdmOCIsInVzZXJOYW1lIjoiSnVzdHluIiwidGdJZCI6Ijg2NDMzOTQ3NTAzODIwODAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOCwiZXhwIjoxNzI3NDE2NTA4fQ.DdgUkqrPcY08jnu8a2wgauI19QySkM-uBGTa0JPqkOE	ff338a1b-41d7-40fe-b370-c88ef7d387f8	2024-08-28 05:55:08.535	2024-08-28 05:55:08.603
8a057df4-b87f-4bb1-8ea1-4e11b38a8672	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyMjg1YTRiLWE5YTgtNGFlYy04OTVlLTVlYTEzMTI1NzIyYiIsInVzZXJOYW1lIjoiR3VpZG8iLCJ0Z0lkIjoiNjc3MTM0MzU3ODEwMzgwOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA4LCJleHAiOjE3Mjc0MTY1MDh9.hyp1Rhu9mA--QLlZtEcAlMxgkTRIOzB1QKpQ_AbW0c0	22285a4b-a9a8-4aec-895e-5ea13125722b	2024-08-28 05:55:08.646	2024-08-28 05:55:08.701
d013e8a1-45dd-42a9-afda-3be1f529623a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0Mjc4MGQ5LTM1YTEtNDU4Mi04NmQxLWQ5ZmY1OTcxZjRhZSIsInVzZXJOYW1lIjoiV2lsbGFyZCIsInRnSWQiOiIyNjI0MjQ3NTk3ODkxNTg0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDgsImV4cCI6MTcyNzQxNjUwOH0.hp0wfBs8NG6OWvbsDS1wvTQJiWMOdeo-NcX7jQnEf5M	542780d9-35a1-4582-86d1-d9ff5971f4ae	2024-08-28 05:55:08.738	2024-08-28 05:55:08.799
c6ce3a51-d429-4923-9eb1-a82e7dab8d61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZmODA3ZGVhLTExOWUtNDg3Yi05ZTEwLTFmN2E4M2I0ZTE3MiIsInVzZXJOYW1lIjoiU2FtYXJhIiwidGdJZCI6Ijg3MDc1OTk4ODUxMzk5NjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOCwiZXhwIjoxNzI3NDE2NTA4fQ.6YT354_bmqekVEGIYHa163JDlLA7K6YCw2OwVABu3Oo	ff807dea-119e-487b-9e10-1f7a83b4e172	2024-08-28 05:55:08.84	2024-08-28 05:55:08.895
13f64b8f-705f-4bf2-8e83-515cfa5c1043	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ4MTZhZDQyLWM2NzQtNDc3Ni1iNTA3LWYyYWU4NjEzM2E0YyIsInVzZXJOYW1lIjoiQWx2ZXJhIiwidGdJZCI6IjMwNDk3NTQ4OTYzNjc2MTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOCwiZXhwIjoxNzI3NDE2NTA4fQ.RYtrRlTmFwtdvLPLKGytr4XRMY-1E2lb8J6Htw0_Ues	d816ad42-c674-4776-b507-f2ae86133a4c	2024-08-28 05:55:08.941	2024-08-28 05:55:09.048
6f00b656-b935-4818-a928-afccc806cf70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ZDNlN2EwLTFjZWUtNDg1Ni05MzA4LWFlODgzMDMwNmNhZiIsInVzZXJOYW1lIjoiS2l0dHkiLCJ0Z0lkIjoiMzMyODU1MTA5Mjc0ODI4OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA5LCJleHAiOjE3Mjc0MTY1MDl9.QEje416hfm_ONtH4UZVlo7aJeOrJ8F2SrqIxXIuzAck	77d3e7a0-1cee-4856-9308-ae8830306caf	2024-08-28 05:55:09.089	2024-08-28 05:55:09.171
9f5dbc80-2825-4be0-9a06-d9295af95c16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ3OWNjZWIyLTVjYmItNDQ3Ny05ODFmLTQ5MWE5NjkwNjdiNiIsInVzZXJOYW1lIjoiSm9zaWFoIiwidGdJZCI6IjMzMTQ5NjI1MTAzODEwNTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOSwiZXhwIjoxNzI3NDE2NTA5fQ.LUkg6MGLsHsIsgO5MkuSCkwYlvz14G5vW8vJM6O5mUM	d79cceb2-5cbb-4477-981f-491a969067b6	2024-08-28 05:55:09.218	2024-08-28 05:55:09.32
550da3c1-a53a-47c2-9e7f-3c2d8929f011	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg2ZDI3N2NhLTY5NTItNDc1My05ZTEzLWNjZGZmYjI1MmI3YiIsInVzZXJOYW1lIjoiRW1lcnNvbiIsInRnSWQiOiIyMzgxMjA2NTQwNzc5NTIwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MDksImV4cCI6MTcyNzQxNjUwOX0.WSIvvqsZynd1EwLj-d5VA2XobVDWWDSAcEqICyWnw78	86d277ca-6952-4753-9e13-ccdffb252b7b	2024-08-28 05:55:09.364	2024-08-28 05:55:09.418
a4c5147d-6dd4-4e6d-a228-e79f89188388	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJhOGNiN2MzLTZjMWItNGQ5OS04ZWY1LWVhYzYwMmY2MjNiNiIsInVzZXJOYW1lIjoiS3J5c3RpbmEiLCJ0Z0lkIjoiNDI2ODI4ODE2MjkyMjQ5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTA5LCJleHAiOjE3Mjc0MTY1MDl9.sFYp8j7N0lESpajk8UToEPttkI8CWkbygmWm_rWe6tA	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6	2024-08-28 05:55:09.453	2024-08-28 05:55:09.517
e66b3247-9f36-403a-86b8-78966e9bb230	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQwYjM4ZGQwLWMwMjAtNGUyNi1iY2NjLTE0ZjViZmUyMTk3MCIsInVzZXJOYW1lIjoiVmFkYSIsInRnSWQiOiIzMzAxOTg2MDQwNTQ1MjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOSwiZXhwIjoxNzI3NDE2NTA5fQ.F90N3W1zr-2quISKSTx_ty_n0cpEJcCGXi4udxRyYXM	40b38dd0-c020-4e26-bccc-14f5bfe21970	2024-08-28 05:55:09.55	2024-08-28 05:55:09.62
a8482b2c-7645-4eb3-9571-922fd71b8429	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg1YjI4YWUxLWY1MTctNDIzZS1iZjZmLWVmMTg5MjQ4ZmFhYyIsInVzZXJOYW1lIjoiSmF5c29uIiwidGdJZCI6IjIyNDg0MjgwMTg5OTExMDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOSwiZXhwIjoxNzI3NDE2NTA5fQ.DS3mlY2ZwTBfpUHNPW9EunPYyj4Bfq3BjU0dNi4cz3Q	85b28ae1-f517-423e-bf6f-ef189248faac	2024-08-28 05:55:09.656	2024-08-28 05:55:09.884
f0306717-b0d3-42e7-b41a-67ad8230c2e2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM5ODZiZGU0LWUwNzgtNDUyZC1hZTNlLWZkOTM0NTRiNGNlMiIsInVzZXJOYW1lIjoiU2VsaW5hIiwidGdJZCI6IjcxMjExODAyMzg1NDQ4OTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUwOSwiZXhwIjoxNzI3NDE2NTA5fQ.L77kLgrYjelVd9uhyLWR340oh0gm8tFuMJTKvcY5uiE	3986bde4-e078-452d-ae3e-fd93454b4ce2	2024-08-28 05:55:09.999	2024-08-28 05:55:10.089
d88a3f5b-ec8e-4212-85e3-142169917189	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRiN2Y4MTU4LWY3MWEtNGVjZi1hMGE2LTQ4NDM5YTA1ZDY1NyIsInVzZXJOYW1lIjoiRmVybmUiLCJ0Z0lkIjoiNjA5NDQ1MjE5NDAxNzI4MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEwLCJleHAiOjE3Mjc0MTY1MTB9.cgKo2tEgTE-h2hrYzaWwwdUxsp06NjTPI98d9wLGiqg	db7f8158-f71a-4ecf-a0a6-48439a05d657	2024-08-28 05:55:10.124	2024-08-28 05:55:10.185
277b23e6-2c49-4751-96b9-7db13525f3af	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUxZTcwMjk1LTVjMzctNGM1MS04MTY3LTk4OThiOWM1MDZmMiIsInVzZXJOYW1lIjoiVHJveSIsInRnSWQiOiI3MDIyNDcxNjY4NTYzOTY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTAsImV4cCI6MTcyNzQxNjUxMH0.X_0yxRCgnCTVHivEFJWzcH2mYA4zfdo5RqS5eK5VSh4	e1e70295-5c37-4c51-8167-9898b9c506f2	2024-08-28 05:55:10.226	2024-08-28 05:55:10.306
08c2d04d-794b-483c-b09d-57c965c8a05f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM3ZTRiZGJlLWY3ZjktNDMzYS1hNzI2LWM5OTkwNzAwNzAxZiIsInVzZXJOYW1lIjoiRW1pbGllIiwidGdJZCI6IjYzNDgzNDM4NDYzNzEzMjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMCwiZXhwIjoxNzI3NDE2NTEwfQ.yZllaWc1s1wruJ-jg-c7BUUPMlM-yQVEnIzoqrGsLDs	37e4bdbe-f7f9-433a-a726-c9990700701f	2024-08-28 05:55:10.387	2024-08-28 05:55:10.446
d494bb60-6779-4daa-a524-32edbde64724	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjljZmJmY2UyLWJiMGYtNGFjMi1hNWM5LWUxNDQ3OTAwNjVhMyIsInVzZXJOYW1lIjoiV2lsc29uIiwidGdJZCI6IjMyMzM5NTA5NDIxMDE1MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMCwiZXhwIjoxNzI3NDE2NTEwfQ.Lr7R6IC0hhtsx6-2fxM8vhx2mG0OSC6C7pUtRSZJf1M	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3	2024-08-28 05:55:10.481	2024-08-28 05:55:10.561
154a0493-f0a1-4f78-8b1b-c8b16d902e10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxYTcyYWU3LTJhNWUtNGZkMi1iYmNkLTkzYzEzMmI4YTJlYyIsInVzZXJOYW1lIjoiSW1tYW51ZWwiLCJ0Z0lkIjoiNDgwMTM5MTE1OTY3MjgzMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEwLCJleHAiOjE3Mjc0MTY1MTB9.puhj0TSP8KGRQv657l7GKauhSBaz3h4kU6Hl-hJ3ygE	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec	2024-08-28 05:55:10.599	2024-08-28 05:55:10.666
31ebb741-248b-48b1-ac16-7206c62a177d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ1NDNmMzU3LWU5OWQtNGQ3MC1iN2JlLTJhOThkMDU1Yzk5NyIsInVzZXJOYW1lIjoiTGF1cmVsIiwidGdJZCI6IjE2NDE2OTg3NDA0MDQyMjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMCwiZXhwIjoxNzI3NDE2NTEwfQ._hPkUcKO2T9HvEm76siD_owVYGOpHKNY_uV3FrJkHgU	d543f357-e99d-4d70-b7be-2a98d055c997	2024-08-28 05:55:10.713	2024-08-28 05:55:10.814
4ad6974c-e731-486d-b81c-af57b89e0897	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjNWY2OThmLTM0NDQtNDRiYy04MDU1LWMwMDRkNTkyZTBmOCIsInVzZXJOYW1lIjoiSmVybWFpbiIsInRnSWQiOiI1NzIxNjYyMTcxMzgxNzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMCwiZXhwIjoxNzI3NDE2NTEwfQ.DCjASRzmzfek4vX8gTeOEnBsJJoteZxJiETWJPLhYeg	5c5f698f-3444-44bc-8055-c004d592e0f8	2024-08-28 05:55:10.867	2024-08-28 05:55:10.925
6e271101-e024-44e2-9251-f3d823900afa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJhNzRkNzc0LWE3YzUtNGI1Zi04MzlhLWIxOTExZTQ1N2JjMiIsInVzZXJOYW1lIjoiSmVyb215IiwidGdJZCI6IjEyOTYyNDY2Mzc1OTI1NzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMCwiZXhwIjoxNzI3NDE2NTEwfQ.CEzNOIU8dMtxdj2cj4hbi6KQu_mMkxhRoiYSj1-7OoI	2a74d774-a7c5-4b5f-839a-b1911e457bc2	2024-08-28 05:55:10.966	2024-08-28 05:55:11.116
3a7dd3d4-1e82-4563-a301-e1a01a88b4ed	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjExMzFjNjFjLTc3MWItNGE3NS1hMDE0LTQwYTQ3MzFiOWVmZCIsInVzZXJOYW1lIjoiQmVybmFyZCIsInRnSWQiOiIzMDg1Mjk4MjUwNTQ3MjAwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTEsImV4cCI6MTcyNzQxNjUxMX0.mkDHy4nhMdvLS7oM5i8Kus2yCg28DG3Kuu-B-6cOboM	1131c61c-771b-4a75-a014-40a4731b9efd	2024-08-28 05:55:11.151	2024-08-28 05:55:11.204
b13101a1-4e7b-4a1e-b3e2-4077496c8f35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEyNjQzMzE0LTJhNmYtNGFmNy1iYjFmLTExNDk0MTc5ZDgwMCIsInVzZXJOYW1lIjoiS2FkaW4iLCJ0Z0lkIjoiODAwMzQ5Mjk4NTcwMDM1MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTExLCJleHAiOjE3Mjc0MTY1MTF9.wyvAFgK_2ckqe2eRoK1uVn15M3bfKqupEsDYXcyWgD8	a2643314-2a6f-4af7-bb1f-11494179d800	2024-08-28 05:55:11.234	2024-08-28 05:55:11.314
68399eeb-ee7a-46be-9728-c8c09fd5b813	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjlhYTI3ZTIzLWMzZWQtNGQwOS1iMmMxLTFiMzRmYjM0NTBjZSIsInVzZXJOYW1lIjoiQXVyZWxpYSIsInRnSWQiOiI4ODgzODg0NzU0MjA2NzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMSwiZXhwIjoxNzI3NDE2NTExfQ.PEA0ZQAGrVbbUnHVPeM6spkUHHUaqxG4om2UsGxblDM	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce	2024-08-28 05:55:11.365	2024-08-28 05:55:11.434
c9e659cc-f2d8-4e82-b1dd-3d8538c44dca	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQxZDcwZGM4LWViNjEtNGQ0Zi1hZDMyLWUxZmNkZmNiNDM3MiIsInVzZXJOYW1lIjoiQW5pa2EiLCJ0Z0lkIjoiNjE3OTczNTU0NzY3NDYyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTExLCJleHAiOjE3Mjc0MTY1MTF9.YerS3q_P0SwofUajxjBpd1ZyFly2lh4S6wRKgBIbDOg	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372	2024-08-28 05:55:11.461	2024-08-28 05:55:11.512
6d56f6c8-d9f0-43ff-94c7-5a4b5361c206	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhN2VkMmVmLThiNzgtNDRlYy1hM2NiLWI3NGE1MzgwZjk2NSIsInVzZXJOYW1lIjoiR2FybmV0IiwidGdJZCI6IjM4MDMxNDU1MDMyNDQyODgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMSwiZXhwIjoxNzI3NDE2NTExfQ.xI7BnhsuBeuLLo7e0MGgU4w6FV30UJLj7l2embuqvJE	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965	2024-08-28 05:55:11.544	2024-08-28 05:55:11.617
bbc616df-fb92-4eb3-8307-51dec0a4204e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU5YmUxMjkzLTY3ODgtNDVjMi1iMTJjLWQzNWQwMzcyN2RhMiIsInVzZXJOYW1lIjoiUmVuZSIsInRnSWQiOiI1NjE0OTgzODgwNjM4NDY0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTEsImV4cCI6MTcyNzQxNjUxMX0.XI0bCtqWlgX0UYiKpCPwuvvxOgr-3P1V1DhVbINgd9w	59be1293-6788-45c2-b12c-d35d03727da2	2024-08-28 05:55:11.674	2024-08-28 05:55:11.806
2724ad25-d694-4868-8c1f-0ce6a38392f9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUxMWI5YThjLWM5NGYtNDhiNS1iMTkyLTFhNzY5YzE0NDJhNyIsInVzZXJOYW1lIjoiR2lhIiwidGdJZCI6IjU2NTQ3OTE2MDA0NzIwNjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMSwiZXhwIjoxNzI3NDE2NTExfQ.pm3Oe0YtfgR_Pd2RRvWwbE5sl0bCG6y12g1RNkzILWI	e11b9a8c-c94f-48b5-b192-1a769c1442a7	2024-08-28 05:55:11.861	2024-08-28 05:55:11.922
79f563c9-7053-480b-95eb-96bf72d97967	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBjMWYxZTdjLTM0MTItNGEzMC1iZGQ4LTAzYzJjMmE3NzMwYiIsInVzZXJOYW1lIjoiSnVkZSIsInRnSWQiOiIxMTk5NTExOTUxMTE0MjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMSwiZXhwIjoxNzI3NDE2NTExfQ._3NbXRedZrl6LVKKVWnVHMuuNJ3mS6ZiYd5zMdUI-7w	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b	2024-08-28 05:55:11.999	2024-08-28 05:55:12.096
5d8f7123-ac03-4cee-8dc0-2f2e3549b2d9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQxYzgxZmNmLTUyNmYtNDY4Yy1iOGYxLTFkZTZmZTVjZTU3MiIsInVzZXJOYW1lIjoiVHJ1ZGllIiwidGdJZCI6IjI3NzM5MzgwODYwODQ2MDgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMiwiZXhwIjoxNzI3NDE2NTEyfQ.xDlquO97cJ4Kjy2fqCVxigB1Pv-bRHRvPajDBpn2xls	d1c81fcf-526f-468c-b8f1-1de6fe5ce572	2024-08-28 05:55:12.14	2024-08-28 05:55:12.184
7ae976ab-83d2-4ba2-9108-22a9e9a18d9b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUxYTEwOWUxLTAxY2MtNDc2Zi1hMTAwLTA0NjMyNjUwN2RjMiIsInVzZXJOYW1lIjoiUmVlZCIsInRnSWQiOiI1MzI5NjEzNTY5OTE2OTI4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTIsImV4cCI6MTcyNzQxNjUxMn0.FoqhsBtdqaRHRamdCPRN4reKBnA4BjyYi5TIRLCPGO0	e1a109e1-01cc-476f-a100-046326507dc2	2024-08-28 05:55:12.215	2024-08-28 05:55:12.317
f57e224a-154a-4f23-952e-443b7f651d10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFmZGNiZjZiLWU2NzAtNDZlNi1hMWY4LTMwODYyMWMyNjczNSIsInVzZXJOYW1lIjoiV2luc3RvbiIsInRnSWQiOiIxOTMyODk2Nzg0ODc1NTIwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTIsImV4cCI6MTcyNzQxNjUxMn0.8kz7ZSqhEekj5NEhoJuuVtMa3riZP8vhio4GoaXm7b8	1fdcbf6b-e670-46e6-a1f8-308621c26735	2024-08-28 05:55:12.363	2024-08-28 05:55:12.453
ee19ed91-a9ed-4fb2-b422-601da7e71245	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJkMDNlOGNiLTQ4ODEtNDNkMS1hYWFhLWZkMTkyZGI1YjkwZiIsInVzZXJOYW1lIjoiSGFsbGllIiwidGdJZCI6IjU5Mzc1MTI1MTQwNjAyODgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMiwiZXhwIjoxNzI3NDE2NTEyfQ.8c-7FIb_vZlngmvzovqmLM0sxrqC_KUW_651NSqcgTY	bd03e8cb-4881-43d1-aaaa-fd192db5b90f	2024-08-28 05:55:12.485	2024-08-28 05:55:12.542
1f6f3830-cda3-43ce-87db-1b12f5816518	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZmMjUzYTlkLWVmZDQtNDZhYy04NjkzLTlhYWY0ZWE1ZDNmOCIsInVzZXJOYW1lIjoiVHJhdm9uIiwidGdJZCI6IjQwMDMwMzc0MTI1ODk1NjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMiwiZXhwIjoxNzI3NDE2NTEyfQ.Kh2lJCGPcGBCoQDbLG2CWEZswt8Ua7jIJKI81ssMLuM	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8	2024-08-28 05:55:12.614	2024-08-28 05:55:12.712
2a896a45-f623-43ab-8459-e026cf828bdd	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY0MjNlNWYyLWQyZGUtNGE0Yi05ODNkLTdmYWVlZTA0YjBiMiIsInVzZXJOYW1lIjoiSmFyb2QiLCJ0Z0lkIjoiODI4Mzg2OTAzNzk4NTc5MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEyLCJleHAiOjE3Mjc0MTY1MTJ9.Sti24YcBgYVYpEfWOsTs_F7YNXqPycthjEp6pynXDhk	f423e5f2-d2de-4a4b-983d-7faeee04b0b2	2024-08-28 05:55:12.757	2024-08-28 05:55:12.911
59507427-9def-43b3-86c8-bf8c6c62023f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxNzgyOTI2LTc5NzItNDlkOC1iNWE0LTgxNjNkZGE0ZDhiYiIsInVzZXJOYW1lIjoiS3JhaWciLCJ0Z0lkIjoiNzYwNTIxOTExMDE1ODMzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEyLCJleHAiOjE3Mjc0MTY1MTJ9.ZKgHBR3tzHjn7n6WN1em5xIH0RzALYAQVWJ0bfX3EKA	21782926-7972-49d8-b5a4-8163dda4d8bb	2024-08-28 05:55:12.998	2024-08-28 05:55:13.142
739262de-4d34-4ca4-a509-e2649bf3819c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBjODc1YTk5LTQyZjEtNGNiNC04OGVkLTM5OGIxYzI1YjlmYSIsInVzZXJOYW1lIjoiVmlkYWwiLCJ0Z0lkIjoiODE3OTEzMDExMTYyMzE2OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.t-tYZci2x-ozCeQAFaRE2HyNd7LhKaw9KtzUStWSWCE	0c875a99-42f1-4cb4-88ed-398b1c25b9fa	2024-08-28 05:55:13.212	2024-08-28 05:55:13.313
a1f69f8d-4a73-44fa-a8cf-cb6d559a81d4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNiYTY3YjExLTllMzctNDYyZC04M2I1LWNhNGRlZmViZTRlZCIsInVzZXJOYW1lIjoiSWRhIiwidGdJZCI6Ijg1NDkzMzkyMjU5MTUzOTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMywiZXhwIjoxNzI3NDE2NTEzfQ.8pNq_kKQlkagJj-RkpFuMMTu0gzgwFmdS54Vbef9I20	3ba67b11-9e37-462d-83b5-ca4defebe4ed	2024-08-28 05:55:13.355	2024-08-28 05:55:13.405
63c476ac-05fd-4102-8d35-67ed81069821	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJmYzQyZjkwLTcxNWQtNDdkZC1iYzM0LThhMzk4M2ZkNzZlNSIsInVzZXJOYW1lIjoiQW5nZWxpbmUiLCJ0Z0lkIjoiMzE1Mzk2OTgyODMzMTUyMCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.QXU2R-vF7jzp6vUHCAiMwcurXsBlrEnkTviRy5Ge9Uc	bfc42f90-715d-47dd-bc34-8a3983fd76e5	2024-08-28 05:55:13.434	2024-08-28 05:55:13.518
16037d5f-6650-49b6-aade-eb1f6354cbed	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM4OTIyNDcxLTQ4YTQtNDMwYi1hY2Y3LTgwMzk5Mzc5YTg0NyIsInVzZXJOYW1lIjoiTGlsbHkiLCJ0Z0lkIjoiNzc1MzgwMTQyNTQ4NTgyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.1z5V7OrLLAmf2qT9HPFnbjNlWNUuk1vl5rXrAXrix7w	38922471-48a4-430b-acf7-80399379a847	2024-08-28 05:55:13.575	2024-08-28 05:55:13.63
096ff31b-3f19-4c19-9bf2-a68c66dac5aa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdkOWMzMTExLTQ3MTAtNDhhNS04ZTU3LTQyZTc2Zjc4NWY2ZCIsInVzZXJOYW1lIjoiQWxhbmEiLCJ0Z0lkIjoiMzg2MjQ0MDMwNzU4OTEyMCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.S2-M2zwSgma_0th3CuYGbiKWaAeHSTIe5g1SarHVy9Q	7d9c3111-4710-48a5-8e57-42e76f785f6d	2024-08-28 05:55:13.666	2024-08-28 05:55:13.717
ec5db31e-ece7-4a8e-9935-1ff7713db9fe	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjZGY1YjRmLTBiNTItNGFkYy1hNDlhLTYxNDVjYjAxYzMyNiIsInVzZXJOYW1lIjoiS2VsdG9uIiwidGdJZCI6Ijg4MTA0OTk2ODA1MDE3NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.Que4UuUMKH3H8lYl0IdOsHtX9z3sWB1CeySaVkwunZA	5cdf5b4f-0b52-4adc-a49a-6145cb01c326	2024-08-28 05:55:13.771	2024-08-28 05:55:13.831
b0b766a6-7aad-48fb-9b05-d345f1e5d874	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxOWZmNDJiLWQwODAtNGRiMS1iODA4LWQ3NjllNjliZWU3ZiIsInVzZXJOYW1lIjoiVmVybmVyIiwidGdJZCI6IjcxMTkxMzk1MjkyOTM4MjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxMywiZXhwIjoxNzI3NDE2NTEzfQ.0EvI2-6AGwh__LKI2Gl7idp3BQe3rGttbRjdmOfKwWc	619ff42b-d080-4db1-b808-d769e69bee7f	2024-08-28 05:55:13.875	2024-08-28 05:55:13.938
790d9ef4-fede-4855-9650-2ad7d7861641	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM1NTMzMjEyLTkzMDAtNGQwZS1iNDYwLTVlYWJjMWZhNGEwZCIsInVzZXJOYW1lIjoiRWx2aXMiLCJ0Z0lkIjoiNzM0NDc2NjQ2NzQ0MDY0MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTEzLCJleHAiOjE3Mjc0MTY1MTN9.7yJ1WGagoNAXVgL6IIySCdrh93JZDgKWzKyK9nsDu9k	c5533212-9300-4d0e-b460-5eabc1fa4a0d	2024-08-28 05:55:13.987	2024-08-28 05:55:14.073
6cfe093f-8d67-4555-8575-82e8f9d248b3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI2OGM2MjNhLWZmYTMtNGE0OC1hM2M5LTc2ZjJmNzAwNzc1YiIsInVzZXJOYW1lIjoiRGFyZW4iLCJ0Z0lkIjoiNTU5NTMxMDg1NDI0MjMwNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE0LCJleHAiOjE3Mjc0MTY1MTR9.LrqKVFnPizqqvsLHiRwHO47W2MJD-oRKGHpQR0sMWQ8	b68c623a-ffa3-4a48-a3c9-76f2f700775b	2024-08-28 05:55:14.124	2024-08-28 05:55:14.224
7c411d9f-a587-4644-9f45-8984c30e346f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjZDkzYTNiLWIxNDQtNDUzYS1hMjI5LTI3NTdjYjI4ZGYyMiIsInVzZXJOYW1lIjoiQ29saW4iLCJ0Z0lkIjoiNzY4MjkzMzc1ODM2MTYwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTQsImV4cCI6MTcyNzQxNjUxNH0.unxVjungMbc0J9dRsI01aiSDwvY0unW0MZ_COlS8PIE	5cd93a3b-b144-453a-a229-2757cb28df22	2024-08-28 05:55:14.264	2024-08-28 05:55:14.334
7a6fccd7-b2cf-4688-9806-db36bb47e641	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRkZDlmNjU5LTc1ZDYtNDRmOC04ZmFlLWFjOTYzYzY3NDZhYiIsInVzZXJOYW1lIjoiTWVhZ2FuIiwidGdJZCI6IjUyMzkwNjI3NDI5NTgwOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE0LCJleHAiOjE3Mjc0MTY1MTR9.jWICHgQvK9ZVCil6wJ_-rkaUOXJJ0U_P7UERKvaGV3A	4dd9f659-75d6-44f8-8fae-ac963c6746ab	2024-08-28 05:55:14.372	2024-08-28 05:55:14.413
be7554dd-e193-4665-8729-06e24c86db9f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMzNTcyMTJiLWUwNjUtNGM2NS1hYWE1LTdlOGI4YTE0Y2ZhMCIsInVzZXJOYW1lIjoiUm9iZXJ0IiwidGdJZCI6Ijg0MTE0OTIzMTM0NjQ4MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNCwiZXhwIjoxNzI3NDE2NTE0fQ.2GDcCt53Yu2_V6JbgZSziIBvfoZ9QYUSJocROf-LHJA	c357212b-e065-4c65-aaa5-7e8b8a14cfa0	2024-08-28 05:55:14.48	2024-08-28 05:55:14.669
d759b3eb-351e-4e3a-8868-8f2bd3f011a5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYzZmRkZDMzLWY3N2EtNDBlNC05ODk3LTU1ZTYxMjMwZDY0MyIsInVzZXJOYW1lIjoiQW1icm9zZSIsInRnSWQiOiI0ODA4ODM2OTkwODk0MDgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTQsImV4cCI6MTcyNzQxNjUxNH0.S3pS--_Fcx6GjmZnL0_dhIMgf_RcCFkbmTl2BZgSeCs	f3fddd33-f77a-40e4-9897-55e61230d643	2024-08-28 05:55:14.704	2024-08-28 05:55:14.754
d71fe53c-f873-496e-a8e2-4146714f47c0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0MzRmYWMyLTM2ZTktNGZmOS05OTU1LWJhNTMxZmJiMWJhMCIsInVzZXJOYW1lIjoiTmlnZWwiLCJ0Z0lkIjoiNTgzNTE4NDQwMjMzMzY5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE0LCJleHAiOjE3Mjc0MTY1MTR9.bL28g57jHGmt80MT1_GBQhgoafW0DCrsSCME2CLYMC0	5434fac2-36e9-4ff9-9955-ba531fbb1ba0	2024-08-28 05:55:14.785	2024-08-28 05:55:14.916
dec81a77-8470-46f2-b3a7-16f4cfd94121	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFjMjNjZmQ0LWY0ZDctNDljNS04NzYwLTk2MDBlNDE0MDI3ZSIsInVzZXJOYW1lIjoiUGVycnkiLCJ0Z0lkIjoiNjg3MzE2MTMwNTk0ODE2MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE0LCJleHAiOjE3Mjc0MTY1MTR9.xioSvxQ0Jzs-NDHnf6sFO4awe8W0FAxzy_YhX4hrjdw	1c23cfd4-f4d7-49c5-8760-9600e414027e	2024-08-28 05:55:14.951	2024-08-28 05:55:15.033
8bd2bbd9-81a4-4130-8d36-9c1c36f8949f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxYWU1MTg2LWRjNWItNDJjMy1iNjc2LTg1OTBjOTZkZTUzYSIsInVzZXJOYW1lIjoiSmFja3NvbiIsInRnSWQiOiI3MDk2MTg5NTc3MDY4NTQ0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTUsImV4cCI6MTcyNzQxNjUxNX0.fWlBvru8jC2r_qyxYS-WIljftYpOIxW24mZAS2eW140	31ae5186-dc5b-42c3-b676-8590c96de53a	2024-08-28 05:55:15.069	2024-08-28 05:55:15.132
07b3a987-59e9-4fdd-8221-ada69e21d5ac	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQyNjE1MjkyLWE1MGYtNDdmZi1hZjczLTQzN2VjMWViMGZlYSIsInVzZXJOYW1lIjoiRnJhbmNlc2NhIiwidGdJZCI6IjM3NjQ2MTA1NDkxNTM3OTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNSwiZXhwIjoxNzI3NDE2NTE1fQ.6ByqkbptnNt4rTI9LtFnlrH8HiVQrPBE13C6VuTqVPg	d2615292-a50f-47ff-af73-437ec1eb0fea	2024-08-28 05:55:15.175	2024-08-28 05:55:15.233
ae391259-fcf4-4ff3-8015-88099d646197	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjlmNTU3ZWRiLThhZGYtNDgzMi1iYzI1LWNhNWIwMGRmY2Y0YSIsInVzZXJOYW1lIjoiQXlkZW4iLCJ0Z0lkIjoiNzQ5NjEyNjEyOTI0MjExMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE1LCJleHAiOjE3Mjc0MTY1MTV9.LTYvYlEzv1uIYqJsNjUnOp6FXzWe1t4IXPSyosxG8uA	9f557edb-8adf-4832-bc25-ca5b00dfcf4a	2024-08-28 05:55:15.289	2024-08-28 05:55:15.345
063a02f7-fd62-4a63-8103-add464fd910d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhmYmYxNjNiLWY0NTMtNDM0ZS1hZDE5LTEwMjI4ODk0ZWU4YyIsInVzZXJOYW1lIjoiTmFvbWkiLCJ0Z0lkIjoiODE2MDYwMDU1NTI1Nzg1NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE1LCJleHAiOjE3Mjc0MTY1MTV9.hvHSKzyZK3uhGj-QG5D2c8ddXd4a8e_QVHP_0-mlPaU	8fbf163b-f453-434e-ad19-10228894ee8c	2024-08-28 05:55:15.375	2024-08-28 05:55:15.449
5060cf73-e14e-48f4-98c1-20b5c0848074	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQyODM0YmNiLTIxNTQtNDMzZS1iYjA2LWU4YmVmYmZkNzM2OCIsInVzZXJOYW1lIjoiQW50b25ldHRlIiwidGdJZCI6IjY4MDUxNzMzNzI0NTI4NjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNSwiZXhwIjoxNzI3NDE2NTE1fQ.v7LRPrxMDt2W8fycp8o9HgmsDILoK4z3gGUwjYFoD-I	d2834bcb-2154-433e-bb06-e8befbfd7368	2024-08-28 05:55:15.508	2024-08-28 05:55:15.581
7f2ce0fc-7734-44e2-a380-35104dcbe6e4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg4NDIxNDkzLWUwOWMtNDA3Yi05MWI3LWEyYmY1ZjYzM2ZhNiIsInVzZXJOYW1lIjoiUnVieWUiLCJ0Z0lkIjoiNzYyNDAzNjE0MjAyMjY1NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE1LCJleHAiOjE3Mjc0MTY1MTV9.8U1lslXjwTYrqf03VZP2CEdBx1zuX1iGpUX3MnlTvrM	88421493-e09c-407b-91b7-a2bf5f633fa6	2024-08-28 05:55:15.621	2024-08-28 05:55:15.674
8c8990df-0314-4b97-b33d-c5d1f9567deb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ1ZjMyZWQyLTM2NzMtNDAyMi1iMGFkLWU0ZDYwMzYyMzYxZiIsInVzZXJOYW1lIjoiV2VsZG9uIiwidGdJZCI6IjMyMTA3ODkwMTgxNDA2NzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNSwiZXhwIjoxNzI3NDE2NTE1fQ.JWb6nhs686hGPhNRPXp0HmvyyHHAymwunhSTxC5CuqM	45f32ed2-3673-4022-b0ad-e4d60362361f	2024-08-28 05:55:15.71	2024-08-28 05:55:15.785
5f569231-b271-4117-a28e-1e00fd78c6a7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE2OTc1YmNjLTQxMTMtNDc1Yy05ZGEwLTVkY2I5NTJjZjkxOSIsInVzZXJOYW1lIjoiUm9kIiwidGdJZCI6IjE4ODUzMzM3MTkzNTEyOTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNSwiZXhwIjoxNzI3NDE2NTE1fQ.DfwL7uL0ZcKRMNY5j2SFtFmWSi9J3k73Hce0xLV5YFE	a6975bcc-4113-475c-9da0-5dcb952cf919	2024-08-28 05:55:15.82	2024-08-28 05:55:15.876
e9941622-b4ae-435c-a64a-5bc361773bac	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImViODM4NTA5LTkzYzQtNGUyYS1hOGMzLTNiZmZkMmFjYzgyYyIsInVzZXJOYW1lIjoiVmlkYWwiLCJ0Z0lkIjoiNzU3Mzk4MTEzNzczMTU4NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE1LCJleHAiOjE3Mjc0MTY1MTV9.A2vD6litgxPTLIlk-vFLA4xtu1Wi21fvE0zSzDV2yRc	eb838509-93c4-4e2a-a8c3-3bffd2acc82c	2024-08-28 05:55:15.92	2024-08-28 05:55:16.025
d990f74d-1350-41d5-878d-66df1f254b68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgxNWJhMWU2LWE0MDUtNGRmNC05OTA5LTdmYmM4ZTg3YTRhYyIsInVzZXJOYW1lIjoiTHVjaW5kYSIsInRnSWQiOiIxNjQ4OTM2MDg3NDUzNjk2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTYsImV4cCI6MTcyNzQxNjUxNn0.ozGqD3ZHKtWARYMNdD3j6goROB8L3TtA5LO639RVc1I	815ba1e6-a405-4df4-9909-7fbc8e87a4ac	2024-08-28 05:55:16.066	2024-08-28 05:55:16.171
9d7a53bb-efa3-4cd9-b0fd-18f891cbaa07	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ3M2I4NWVlLTM3MDctNGYyZS1iMzcwLTc0ZTc5MWYzZmUxZSIsInVzZXJOYW1lIjoiRCdhbmdlbG8iLCJ0Z0lkIjoiMTA1ODUxNDgyMjc1ODQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNiwiZXhwIjoxNzI3NDE2NTE2fQ.u_V0KGJIBger5PHw7Vvkzu7PSs95VFuz3bPwoZJS9UE	473b85ee-3707-4f2e-b370-74e791f3fe1e	2024-08-28 05:55:16.24	2024-08-28 05:55:16.35
6af21abd-9cb5-402b-8c5a-042cc319b53b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0MzhhZDZiLTVhNzQtNGQzMS04MTIyLTMyYjNkN2EyYzhhMiIsInVzZXJOYW1lIjoiTm9yZW5lIiwidGdJZCI6IjIwNTA3ODc4NDA2MjI1OTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDUxNiwiZXhwIjoxNzI3NDE2NTE2fQ.uWxqwJkLPIxYBsDF6LWOGqdvXqjAiyyFqI8oV_Ic11U	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2	2024-08-28 05:55:16.426	2024-08-28 05:55:16.551
2b8df5a5-2159-4da0-96dc-9bfdee8a9010	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU4OGZmODZmLTAyYWUtNDNiYS05MDYwLTcyN2VjMWE1NTU4YyIsInVzZXJOYW1lIjoiTWF4aW1pbGxpYSIsInRnSWQiOiI2MDk3NjkxMjcyNTQ0MjU2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTYsImV4cCI6MTcyNzQxNjUxNn0.EH4QHB-LHpbRDznQOrfJ8HlLijrdxj97tg7Td2rs5Lg	e88ff86f-02ae-43ba-9060-727ec1a5558c	2024-08-28 05:55:16.588	2024-08-28 05:55:16.687
a29361cc-b8eb-4439-8aff-730d6087340d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBlNTYyZDQ1LTAzMjgtNGE5Ny05MzlkLWNkMTFiYjdmMmVkMiIsInVzZXJOYW1lIjoiVG9ieSIsInRnSWQiOiI1ODAwMTA1OTE1NDQ5MzQ0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTYsImV4cCI6MTcyNzQxNjUxNn0.XUbPAhBtTdhEbE_J3C8CHgXz_kKUijIuXbp9QGKsiD0	0e562d45-0328-4a97-939d-cd11bb7f2ed2	2024-08-28 05:55:16.731	2024-08-28 05:55:16.812
69ce10f7-091b-45ae-ab08-febde0573961	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZlNGUwZTY0LTQ3ZWEtNDRjMC1hOTk3LTI1NzY2ZTFhODVjMSIsInVzZXJOYW1lIjoiQnVkZHkiLCJ0Z0lkIjoiNTkyOTE2MzExNDQxNDA4MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE2LCJleHAiOjE3Mjc0MTY1MTZ9.B93aXU-6-oZL9Kh85KT6wLt-aOX3rVTm7gt_KzltCrg	6e4e0e64-47ea-44c0-a997-25766e1a85c1	2024-08-28 05:55:16.866	2024-08-28 05:55:16.935
4c8d57be-5112-44d0-967c-cbf8df89653c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZlZjI4NGNkLTRjNTQtNDJjMC05OWEwLTYxOWNiODQ0MjAzMCIsInVzZXJOYW1lIjoiTGVvbmFyZCIsInRnSWQiOiI2MTgyNDMyNDc2NzU4MDE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTYsImV4cCI6MTcyNzQxNjUxNn0.ZCjWSyEgScpnPaXvCARyA9XzfdC08VIAcVQ6VuBg5Xk	6ef284cd-4c54-42c0-99a0-619cb8442030	2024-08-28 05:55:16.966	2024-08-28 05:55:17.039
1d875089-011f-4177-92ca-744cff1a9be4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJjZTE1YzQ4LTM2OTItNGE2NC1hMDFjLTlhZTE2MDgwMDc3ZCIsInVzZXJOYW1lIjoiQW1lbHkiLCJ0Z0lkIjoiMzIyMzcyMDQyNjQ3MTQyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NTE3LCJleHAiOjE3Mjc0MTY1MTd9.ZKI7KNIzFdZgm-EnMiiC13xffkhgDJwpsmWL7ojoqxk	bce15c48-3692-4a64-a01c-9ae16080077d	2024-08-28 05:55:17.07	2024-08-28 05:55:17.112
3c3a0e80-6efc-4785-a053-1b0ef47b9853	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ2YmVjMWQwLTQ4YzUtNDY1Mi04NjEyLWI0NjY3Y2IxYzQ0MiIsInVzZXJOYW1lIjoiTmVpbCIsInRnSWQiOiI4NDIzMjA5MDE1NzA1NjAwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ1MTcsImV4cCI6MTcyNzQxNjUxN30.DDoC15c7UFXt5MGFlZtUFJsP9QyvJw7SlvJd71LJvA0	d6bec1d0-48c5-4652-8612-b4667cb1c442	2024-08-28 05:55:17.16	2024-08-28 05:55:17.201
dca888c5-7c55-45f5-b4a2-de426b8a32ba	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM4NDM0OTIyLWVjNjktNGUwMS1iZWVmLThjZmI2YWQwZjkyYiIsInVzZXJOYW1lIjoiTnlhc2lhIiwidGdJZCI6IjgwOTkwMjk4OTYzOTY4MDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDc1MCwiZXhwIjoxNzI3NDE2NzUwfQ.TReOSeO78Qq2-Ac8yjTa8MPv5gmi1ixZscrOT4OVjQ8	c8434922-ec69-4e01-beef-8cfb6ad0f92b	2024-08-28 05:59:10.933	2024-08-28 05:59:11.062
d5dcb12d-291e-42ea-b86c-4892c7d374d3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNlYmRjNDNhLTYxNzMtNGQwNy05OWRmLTZmZmFiZTQxNTUxNiIsInVzZXJOYW1lIjoiTG9uaWUiLCJ0Z0lkIjoiMzYzNTYwNjk0OTE5OTg3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NzUxLCJleHAiOjE3Mjc0MTY3NTF9.Xunu6AVWNclpXMBnpIl2od63SRG1SLbZLkyrkBMAnb4	cebdc43a-6173-4d07-99df-6ffabe415516	2024-08-28 05:59:11.224	2024-08-28 05:59:11.287
604e3c4b-aa6f-4a42-b914-3d33b83f95d3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk0OWM0ZjkxLTRmNzEtNDc1MS04Yzk2LTQxMTNmNWMxNjcyZiIsInVzZXJOYW1lIjoiVmVyZGllIiwidGdJZCI6IjI2MTgyMjYwMjg1NzY3NjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDc1MSwiZXhwIjoxNzI3NDE2NzUxfQ.LSt8dDsUPhoqoKgmwkNUwpPORazM65Oy_qsts6RuKmI	949c4f91-4f71-4751-8c96-4113f5c1672f	2024-08-28 05:59:11.338	2024-08-28 05:59:11.433
f3088809-e232-45e6-ad22-a2095f3f71dc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjlmMTlkZjE3LWE5NTEtNDQ5My05NDRhLWNkMTU4ZmQ1Y2ExYSIsInVzZXJOYW1lIjoiQ2hyaXN0aWFuYSIsInRnSWQiOiI1MDMyMTUzMzcwODUzMzc2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ3NTEsImV4cCI6MTcyNzQxNjc1MX0.CfSHdPkFurCy0-uXlPwMOIKvCqqiMhxBgCWKdn9Tnu4	9f19df17-a951-4493-944a-cd158fd5ca1a	2024-08-28 05:59:11.5	2024-08-28 05:59:11.592
cffb2a4e-24d3-4914-9049-767a2dfe1304	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY5NjhmZTY4LTMwYWUtNDJkMi05ZTc0LTA4YmY4ZTIyMzIxNSIsInVzZXJOYW1lIjoiS2VsdmluIiwidGdJZCI6IjIyNDQwODcwMjU1MDAxNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODI0NzUxLCJleHAiOjE3Mjc0MTY3NTF9.Vi1R4gNmik3EEoNifv5dALAnZCTGe6-PUgS_K2A6V_E	f968fe68-30ae-42d2-9e74-08bf8e223215	2024-08-28 05:59:11.695	2024-08-28 05:59:11.762
7a633e93-e699-4299-b4fd-fcd805495fef	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM4MGJiMDFkLWQ5ODEtNGNhYS1iNDc5LTYwODlhNTE2YTA3NSIsInVzZXJOYW1lIjoiTGVtdWVsIiwidGdJZCI6Ijc2NDI3NTU3MzYwMTA3NTIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDc1MSwiZXhwIjoxNzI3NDE2NzUxfQ.28GYr02o5oqDL-Z2xplM165vgY9vmrC71W8tszV1IzI	380bb01d-d981-4caa-b479-6089a516a075	2024-08-28 05:59:11.823	2024-08-28 05:59:11.911
2c00603c-7d1e-4c50-8952-c62943a14717	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjcwZWNiN2Q0LWMwZmItNGUyNi04NDcxLWQwNmU3YTVhZmQ5NCIsInVzZXJOYW1lIjoiQ2hyaXN0aW5lIiwidGdJZCI6IjgxOTM4NTIxODk5NjYzMzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDc1MSwiZXhwIjoxNzI3NDE2NzUxfQ.kJjzlfTdpvBQxUfKDUQ86zOFOilfXynWFvh0_b8drEs	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94	2024-08-28 05:59:11.984	2024-08-28 05:59:12.065
e26b2f23-818c-4c95-8632-d6a5bce44d68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg3NDlmZDg5LTQ0NGUtNDc4Ni1iMGNjLTZmZWQ1MjFiZGMyNyIsInVzZXJOYW1lIjoiU2hheW5hIiwidGdJZCI6IjQ4MTUwOTgyMzExMjgwNjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDgyNDc1MiwiZXhwIjoxNzI3NDE2NzUyfQ.TaoMxcsmnvMasyDtRZqsEiN6U3bMOTaPN1SwyZE0rEc	8749fd89-444e-4786-b0cc-6fed521bdc27	2024-08-28 05:59:12.105	2024-08-28 05:59:12.174
ab2e1f45-2be7-412e-93f3-c39c4206b749	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNlY2I1ZjFmLTA0MTgtNDFjZC1hZjRlLTkzYTRmNTU4YzUyMiIsInVzZXJOYW1lIjoiSmFjayIsInRnSWQiOiI3OTgwNjMwNDk1MTk5MjMyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ3NTIsImV4cCI6MTcyNzQxNjc1Mn0.IIaNp6RGTV4zqUXxCg473Xx_myEhIgVAASJ7oZhuSSw	3ecb5f1f-0418-41cd-af4e-93a4f558c522	2024-08-28 05:59:12.22	2024-08-28 05:59:12.296
0a380f2b-8d3b-4667-96ec-f083acb3fbc9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjcxNzBmNTU5LTA4MTItNDZiZS05ODUxLWYxMTQyYzkxZDE0YyIsInVzZXJOYW1lIjoiQmVhdSIsInRnSWQiOiI4NzAxMzUwMjMzNzY3OTM2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4MjQ3NTIsImV4cCI6MTcyNzQxNjc1Mn0.4ntEQNzgTNEXnsPdeWbqp9xjFdpOPcN4Vw6xwC7lc_Q	7170f559-0812-46be-9851-f1142c91d14c	2024-08-28 05:59:12.348	2024-08-28 05:59:12.406
bbb104f0-16ab-4999-ae9f-9d04b4157979	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMyYjVkMDlmLWZmODEtNGM1MC1iMWM5LWE2YzQ2ZjEyZGY5MCIsInVzZXJOYW1lIjoiRGV4dGVyIiwidGdJZCI6IjIyMzA0NTQzNzk4NzIyNTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NDgzNiwiZXhwIjoxNzI3NDM2ODM2fQ.kmLHu4p_9LnpjFm66CoF7tdCAm6W4cX9Mdp71pay_OM	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90	2024-08-28 11:33:56.407	2024-08-28 11:33:56.622
cb2bf5ef-aa44-4984-a07e-9a0b400d5d84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxYmMwY2ZhLWM2OWItNDU0ZC05YzViLTQyNjFkZWE1OWE2ZCIsInVzZXJOYW1lIjoiS2FpdGxpbiIsInRnSWQiOiI5MDY2NDA2NjQ1NTk2MTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NDk5OSwiZXhwIjoxNzI3NDM2OTk5fQ.VzHwhFcyMRBPPxE0DZ53p56D886WXHyp2grfekEhvdQ	21bc0cfa-c69b-454d-9c5b-4261dea59a6d	2024-08-28 11:36:39.732	2024-08-28 11:36:39.909
5ffa101f-3bef-4d67-98a1-b0da4f1de84f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU1NjZiNTg0LTIwMjMtNDJmOS1iMjVjLTA0ZDE1MjIzY2Q1YiIsInVzZXJOYW1lIjoiR2FldGFubyIsInRnSWQiOiIyODk2NzEyMjMyMzM3NDA4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDUwMzAsImV4cCI6MTcyNzQzNzAzMH0.xfRnJPpWe52apv0gigz9wDRN5TQUBMmJYLAEiydrTxo	5566b584-2023-42f9-b25c-04d15223cd5b	2024-08-28 11:37:10.079	2024-08-28 11:37:10.188
c1025c55-4b48-41cf-9f80-78a0a099f955	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc1OWIzNzk3LWI5NWUtNGFiYy1hODNmLWMzN2JkNmFhMDkwYyIsInVzZXJOYW1lIjoiSG9ydGVuc2UiLCJ0Z0lkIjoiODMzOTE3Mzk0OTgzMzIxNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ1MjIwLCJleHAiOjE3Mjc0MzcyMjB9.MBUOpAG6AaekHlL1zvRF9IXGhxX9YdOHX9berf8mojE	759b3797-b95e-4abc-a83f-c37bd6aa090c	2024-08-28 11:40:20.783	2024-08-28 11:40:20.947
c48bbb96-39f4-4fee-9e2d-0cd16d7484b2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEyMDNkMGYxLTE4MTYtNDk5OC05M2YwLWJkYjA1YzMxNGNkNCIsInVzZXJOYW1lIjoiSGVydGEiLCJ0Z0lkIjoiNjQ1Njc1NTc4NTU2NDE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDUyMjEsImV4cCI6MTcyNzQzNzIyMX0.4V3XknfbOVC2n9jld40CLz7kZbsrd9K9V9GfOn5evYw	1203d0f1-1816-4998-93f0-bdb05c314cd4	2024-08-28 11:40:21.203	2024-08-28 11:40:21.393
8fed9c5b-a06e-4f7f-a87b-d91515fd5ea2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZmYjE4NzllLTVhOGUtNDZhNC04MGVjLWZlMzZiZDY3ZTU4NCIsInVzZXJOYW1lIjoiUGF0dGllIiwidGdJZCI6IjEwOTU0NDkyMzQ2MzY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDUzMjcsImV4cCI6MTcyNzQzNzMyN30.TlJfYOaFBhME2efCz3g3p80FDCsvG-OgkbzWO9PSdwU	ffb1879e-5a8e-46a4-80ec-fe36bd67e584	2024-08-28 11:42:07.241	2024-08-28 11:42:07.343
dc81a370-3fb0-4d64-b9f9-6669b6c97246	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmZGJiMmU0LWM2YjUtNGJjZC04YjlkLWIwYjE0NWMzNWY5YyIsInVzZXJOYW1lIjoiR3JlZ29yaW8iLCJ0Z0lkIjoiNDM5NzcyMTA4MzQ0NTI0OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ1MzI3LCJleHAiOjE3Mjc0MzczMjd9.5KDXzx7_W5LYksvGe_PxwL_Gdja0BRK_C6gI-ZzkGMY	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c	2024-08-28 11:42:07.466	2024-08-28 11:42:07.525
88b1007c-e989-4651-9f1f-3d72fe60009c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQwNGNiMTdlLWZkMmMtNDcyNy1hY2QxLTc2YmFkNDY0ZGQwMSIsInVzZXJOYW1lIjoiSXNhaWFoIiwidGdJZCI6IjMxODI4OTI3ODQwMjU2MCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ1MzM2LCJleHAiOjE3Mjc0MzczMzZ9.0dYxCbzVeImysBjS5V7P4mf-gi2Tb0TeilhIlMWWZTQ	d04cb17e-fd2c-4727-acd1-76bad464dd01	2024-08-28 11:42:16.834	2024-08-28 11:42:16.914
dcfc8061-6184-4337-b837-196333a2cd5c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjYjI3N2QwLWY5YTMtNGRlOS05MDQxLTQ3MDgxMWVlYjM3NSIsInVzZXJOYW1lIjoiR3VubmVyIiwidGdJZCI6IjI1ODc5Mjc5MzY3NjE4NTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NTMzNywiZXhwIjoxNzI3NDM3MzM3fQ.7bJQfZLhjb43BezCywbu00tvxvpR-Tu8p1ihB6Onz7Y	5cb277d0-f9a3-4de9-9041-470811eeb375	2024-08-28 11:42:17.026	2024-08-28 11:42:17.113
5f51fdd7-b1c0-4a55-be9f-a371224817ea	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk1MWZmN2NkLTc4MzAtNGU1YS05ZTIxLWViN2IwZWNhNjNhNiIsInVzZXJOYW1lIjoiTWFyY2VsaW5vIiwidGdJZCI6Ijc5OTI4Njk1MjQ2MDI4OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ1MzkyLCJleHAiOjE3Mjc0MzczOTJ9.Ylt6InUJirta_kn9XIds1tRwGbY3X395kFR75AskhZ4	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6	2024-08-28 11:43:12.153	2024-08-28 11:43:12.334
07334179-437c-404c-add2-62f3ab3feeea	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU3NzM0YzkwLTAxZDMtNGY0ZS04MjhjLTEyMDFmNjVlNDJiZiIsInVzZXJOYW1lIjoiRGVqdWFuIiwidGdJZCI6IjM0MjYwMzA4Njc5NzIwOTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NTM5MiwiZXhwIjoxNzI3NDM3MzkyfQ.xDqN9PagxWczQEiY_Spc300tnLsc-lu8kJjCEnfsZv0	57734c90-01d3-4f4e-828c-1201f65e42bf	2024-08-28 11:43:12.433	2024-08-28 11:43:12.53
0c41ad5a-12cf-42de-a15e-f449af2364a5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRiOGQ1YmE5LTZjYmUtNDViZi04MmNlLWM3YTc0NzE0NzhhZCIsInVzZXJOYW1lIjoiTGVhIiwidGdJZCI6IjU3NDgxMzk4NDE1NTIzODQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NTQwMywiZXhwIjoxNzI3NDM3NDAzfQ.nChJhUTUwPUJwUS8CBSe4b4qP2INIawkPv3Ax70nrTo	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad	2024-08-28 11:43:23.268	2024-08-28 11:43:23.387
5c7798e2-6e1a-4e59-b1c1-b65e68a5e498	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxNzY1ZDQwLWQzNzgtNDIwYy1hMGI0LWNhNDllN2VhNTlmNyIsInVzZXJOYW1lIjoiTWF0ZW8iLCJ0Z0lkIjoiMTg3MjU2MDIyNjU2NjE0NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ1NDAzLCJleHAiOjE3Mjc0Mzc0MDN9.mUN7p1iOqVk_gRSVyhbhAa9lDUdumkkbDUPd1HmjIZA	31765d40-d378-420c-a0b4-ca49e7ea59f7	2024-08-28 11:43:23.555	2024-08-28 11:43:23.784
5e5ad60d-2940-4cd3-95a7-fff961cee91d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU5OTliOGVjLWVlN2EtNDg4OS1iZWM5LTlhZmM1MGU4OGRjZSIsInVzZXJOYW1lIjoiTWFyaWFoIiwidGdJZCI6IjY5NjUxNjE2MTMwNjYyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEyLCJleHAiOjE3Mjc0MzkyMTJ9._KnltpW0Z6bvS5UmvQE7fnSZ7x2QIbeQgWgXu3a77bk	e999b8ec-ee7a-4889-bec9-9afc50e88dce	2024-08-28 12:13:32.457	2024-08-28 12:13:32.51
55c5ca47-fb2c-483a-9b82-f06a32d0b719	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJmMGRlZTI0LTNmODEtNGNjZi04MjQ0LWQ2NDg4ZDA4N2YxZiIsInVzZXJOYW1lIjoiVGlhcmEiLCJ0Z0lkIjoiODMyMjg4MjgzNjg4OTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NjI4NywiZXhwIjoxNzI3NDM4Mjg3fQ.Dsr-u3Xg-zuRcdLokEpxF1kEFl2w79iYdm9-6fcer58	2f0dee24-3f81-4ccf-8244-d6488d087f1f	2024-08-28 11:58:07.938	2024-08-28 11:58:08.14
395b2ac4-0ffd-497a-845f-f90a70d210b6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI2YzNkNTgyLWU2Y2MtNDgxNC1hMzhmLTdkZjg3MzY1NDYwOCIsInVzZXJOYW1lIjoiQWJhZ2FpbCIsInRnSWQiOiI1MDQ1Nzc3ODA0MDM0MDQ4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDYyODgsImV4cCI6MTcyNzQzODI4OH0.oimIXTtes91U1Q-R6Hr1pLfFvXShjwn_MPuUY6a45IM	b6c3d582-e6cc-4814-a38f-7df873654608	2024-08-28 11:58:08.277	2024-08-28 11:58:08.387
6f8ca610-d5a9-4329-a492-7ec07dcdc518	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUzZDZkYmY1LWUxOTAtNDY0MS05NWExLWQ3MzQ2MzI2MzdkYSIsInVzZXJOYW1lIjoiWGF2aWVyIiwidGdJZCI6IjUxNzE0MzcwNzE0OTkyNjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NjI4OCwiZXhwIjoxNzI3NDM4Mjg4fQ.0h39IXc6mJmn42eQiGilYVMq8We3aHZAVJvVPua6X7I	53d6dbf5-e190-4641-95a1-d734632637da	2024-08-28 11:58:08.441	2024-08-28 11:58:08.521
c7354bc7-a987-477b-8700-a5bfe28369e5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFmZGIxMmZjLTA2MjUtNGZiZC1hOTJkLWExZDgzMDBkNWZiOSIsInVzZXJOYW1lIjoiQ29uc3VlbG8iLCJ0Z0lkIjoiMTAxMjY3Nzg3MjcxMzcyOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEyLCJleHAiOjE3Mjc0MzkyMTJ9.gOCRcRlquev1erPxVQJ9KUWEtBTabaqhyLEV1BUx0fk	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9	2024-08-28 12:13:32.55	2024-08-28 12:13:32.616
5bfbd11e-6fde-44b3-834d-ba686a6c7ed2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQxOWM4NjEwLTQ4N2EtNDhmYy04N2ExLTlkZTFiMWI5Y2I4MyIsInVzZXJOYW1lIjoiTWFja2VuemllIiwidGdJZCI6IjM2ODIzNDcxODI0NTY4MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NjI4OCwiZXhwIjoxNzI3NDM4Mjg4fQ.80gHgKl0-HyzZFe6yuIrd5A_nmbd_rAwU0YqP5dnNlY	d19c8610-487a-48fc-87a1-9de1b1b9cb83	2024-08-28 11:58:08.582	2024-08-28 11:58:08.671
9c431761-0d4d-4255-94fe-c3a415c03826	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE0NWZmMjcyLWM4YmUtNDQ2MS1iNGFhLTFhMTYxYTkyMWFhOCIsInVzZXJOYW1lIjoiU2FsdmF0b3JlIiwidGdJZCI6IjIxNTE4MDAxMzYyNjk4MjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NjI4OCwiZXhwIjoxNzI3NDM4Mjg4fQ.-h2eC-mAcHcdx_eAog-wAbP_Lu18MrHiVmurJJoA0AQ	145ff272-c8be-4461-b4aa-1a161a921aa8	2024-08-28 11:58:08.743	2024-08-28 11:58:08.888
7f83045a-6447-4430-8ea7-5843186c6d63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJjNTA1YzAzLWY5YWUtNGUwZi05OWQ1LWEyOWE1NjgzMGIxNSIsInVzZXJOYW1lIjoiTW9sbHkiLCJ0Z0lkIjoiMzgxMjY1Mzk0NjM3MjA5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ2Mjg4LCJleHAiOjE3Mjc0MzgyODh9.Bb7hppueRmbKSHsFhvjQTRV7Drgd05_jsyCXbsP02YE	bc505c03-f9ae-4e0f-99d5-a29a56830b15	2024-08-28 11:58:08.944	2024-08-28 11:58:09.107
4ba58ee2-6376-4472-bc4c-dd594fd9d1f7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk2ZjE0NzIzLTcyNDktNDMzOC1hMDZhLTNiNmJiYjJjYTI0MiIsInVzZXJOYW1lIjoiZ2dfcGF2ZWxfZ2ciLCJ0Z0lkIjoiNzQ0MDYwNjUwMyIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0OTMyNzM3LCJleHAiOjE3Mjc1MjQ3Mzd9.vI5pmtfI98ROzsU3UIXKo7R0nQkL4iO5lKzHYjcJXEE	96f14723-7249-4338-a06a-3b6bbb2ca242	2024-08-28 11:48:02.882	2024-08-29 11:58:57.974
f05a1066-f7db-469f-a423-552ad8c573e0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdlNTExNGZjLWRlZjItNDkyOS05MWQwLTdjYTlkYzY4YjJmZiIsInVzZXJOYW1lIjoiVGhlbG1hIiwidGdJZCI6Ijg5ODI0MTgzOTIzNTA3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEyLCJleHAiOjE3Mjc0MzkyMTJ9.PATQGFUU-ZWhHMDblvG9IzpLiW90jqfw1K5n38ur69A	7e5114fc-def2-4929-91d0-7ca9dc68b2ff	2024-08-28 12:13:32.107	2024-08-28 12:13:32.183
0b049273-e080-40c2-b754-8a8943dfea92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFlNjViMGJiLTcwM2ItNDU1ZS1hMzA3LTdmODI0NjQwNTVlOCIsInVzZXJOYW1lIjoiQ2hyaXN0eSIsInRnSWQiOiI2OTkxNDk4MzUyNTI1MzEyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTIsImV4cCI6MTcyNzQzOTIxMn0.uhfL15rYLgLlhaHIeOWSTBfj6NA9fh3LymhK6KcoWxI	1e65b0bb-703b-455e-a307-7f82464055e8	2024-08-28 12:13:32.29	2024-08-28 12:13:32.413
1ab7d0be-d986-4524-8778-02f6d30ad234	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk1ZjhiODgxLTQ4NjEtNGY3Zi1hMjA5LTVlNmNmMjViOGQ3OCIsInVzZXJOYW1lIjoiRGFyeWwiLCJ0Z0lkIjoiMTA2MzkxNDk4NzA2MTI0OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEyLCJleHAiOjE3Mjc0MzkyMTJ9.tL9DZe7rEMyzcxd-46Rb0tdPD2PpjLTEAKQqXFiJo-g	95f8b881-4861-4f7f-a209-5e6cf25b8d78	2024-08-28 12:13:32.67	2024-08-28 12:13:32.737
d6fa833e-a36b-4e98-97a9-d1e699c2627b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ2MmY1ZWE0LWRlMjMtNGRiOS1hZmI1LWRiOTMzNDgwOWRlMSIsInVzZXJOYW1lIjoiRmFubnkiLCJ0Z0lkIjoiNTA3NjY0MzA0MzM0NDM4NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEyLCJleHAiOjE3Mjc0MzkyMTJ9.TIszqO1GSIia516ghl4fgmhluem1jgOBPuX5BuTahaI	d62f5ea4-de23-4db9-afb5-db9334809de1	2024-08-28 12:13:32.781	2024-08-28 12:13:32.825
4612a910-6c31-4869-8ea2-4ccdab18a02b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNiZjkzN2NlLWQwYzUtNDNiZC05MTE5LWY4NTkwYThkNTc0YyIsInVzZXJOYW1lIjoiUGFtZWxhIiwidGdJZCI6IjQ1MTYwMTQ0MDg1OTc1MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxMiwiZXhwIjoxNzI3NDM5MjEyfQ.LQfyvlSBJSZJGXJTpd98R-_JBg31QAi4h-QwbsC7RZM	3bf937ce-d0c5-43bd-9119-f8590a8d574c	2024-08-28 12:13:32.867	2024-08-28 12:13:33.024
3c18763f-c67e-450a-9073-8500e1ee37ae	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNjU0NGJlLTgyMjktNGUyMC1iMWVjLTNhMjg2NjY0Y2VmNSIsInVzZXJOYW1lIjoiR2xvcmlhIiwidGdJZCI6IjUzODI1MDYyNTk5MzkzMjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxMywiZXhwIjoxNzI3NDM5MjEzfQ.58VorpDCeAMHKKECe5d0XRWzZkMHrYx97acOQ_bAUE4	616544be-8229-4e20-b1ec-3a286664cef5	2024-08-28 12:13:33.06	2024-08-28 12:13:33.144
88b873ba-9655-42e0-9c09-58df93eb3baa	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU0NmE4YzI2LTczNDUtNGZlZC1iODFmLTJmM2ViZTlmMzg2NCIsInVzZXJOYW1lIjoiTWlzc291cmkiLCJ0Z0lkIjoiMzU0NjUwNDYyNTEyNzQyNCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEzLCJleHAiOjE3Mjc0MzkyMTN9.dAY7Rn-QbChfJg-TDTaJrH4mZQqLcwK6cds4cPjkDDE	e46a8c26-7345-4fed-b81f-2f3ebe9f3864	2024-08-28 12:13:33.215	2024-08-28 12:13:33.318
95c46de4-4015-4da7-9fe1-87aa78f577d2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFjYjZhOWUyLWY5YmEtNDEyZi1hMjg0LTIzZTY2NTdlZjg3OSIsInVzZXJOYW1lIjoiQ29vcGVyIiwidGdJZCI6IjgxOTQ5NTczMTc3NjcxNjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxMywiZXhwIjoxNzI3NDM5MjEzfQ.vKF0JSaCYjaXrkq26cDeR3WbNPBgYoDt-3k0YOVc7O0	1cb6a9e2-f9ba-412f-a284-23e6657ef879	2024-08-28 12:13:33.349	2024-08-28 12:13:33.403
6e2cd48f-b99c-4a9b-9b9b-2a497e954ab9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk4NDMxZTMzLWI5NmEtNGM3MS1hNTJkLTA3ODgzZmU3ZTk0NSIsInVzZXJOYW1lIjoiTGl6emllIiwidGdJZCI6IjU5Nzg1MTY2NDY1MjY5NzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxMywiZXhwIjoxNzI3NDM5MjEzfQ.tnlXrwJwNEbOlcOQsHPG6YCri3_PPKXy3AWG-BzMuro	98431e33-b96a-4c71-a52d-07883fe7e945	2024-08-28 12:13:33.476	2024-08-28 12:13:33.532
02f0aada-ccbf-4bb5-8b60-c544a2a29a60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjllY2E4ZmZkLTJjZjEtNDI5My1hZjExLWVkMzgxZjMxZDJkOSIsInVzZXJOYW1lIjoiVG9ueSIsInRnSWQiOiIyMDAzNDE4NzQ2OTc4MzA0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTMsImV4cCI6MTcyNzQzOTIxM30.9prJ9abmI5OruQiEyNdS3UYum55TBxyXKoBDFndRFik	9eca8ffd-2cf1-4293-af11-ed381f31d2d9	2024-08-28 12:13:33.559	2024-08-28 12:13:33.631
c5923392-d0d9-4ee5-bdbb-741450501a0b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ZDNkOTJhLTFiYzgtNDY0OC1iMjJkLTQwMWEwOWQwOGFiNSIsInVzZXJOYW1lIjoiRXZlcmV0dGUiLCJ0Z0lkIjoiODIxMTM0NDU5NTYxNTc0NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjEzLCJleHAiOjE3Mjc0MzkyMTN9.1eFTokUkAo9oy07ZjrlUWsRFHHEax8R8QSdsxEN00nE	77d3d92a-1bc8-4648-b22d-401a09d08ab5	2024-08-28 12:13:33.662	2024-08-28 12:13:33.747
48c3735e-bcfb-44ad-8502-3c63a0182a1f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE4MjAyN2ExLTU1MWMtNDYwMS05Yjg0LTQ5NzM0OGY5NGUxYyIsInVzZXJOYW1lIjoiRm9yZCIsInRnSWQiOiIxODM5NTI5MDc1OTMzMTg0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTMsImV4cCI6MTcyNzQzOTIxM30.BY4yjBO6fvILKvyEm7R8pFmb1CIHMn8g6wRRRLf-MKY	182027a1-551c-4601-9b84-497348f94e1c	2024-08-28 12:13:33.808	2024-08-28 12:13:33.899
53fae159-c7be-4964-816e-208c6a18529c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFjYWFmMDJlLTRlZTUtNGMyYi1iNTIwLTU4NDYzNDE4MDVlZiIsInVzZXJOYW1lIjoiQ2VjaWxpYSIsInRnSWQiOiIxMDMxMzYwNTY1MjE1MjMyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTMsImV4cCI6MTcyNzQzOTIxM30.5kHS8MS65gQrkmUPLgkTfvk4yHK8nDm_TITfHW44kRY	1caaf02e-4ee5-4c2b-b520-5846341805ef	2024-08-28 12:13:33.939	2024-08-28 12:13:34.117
66c1921c-46fe-42fb-9b1c-aa8102c05d58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdkNjMzNzIwLTA4ZjQtNDQzYy05NDJkLThkYTc0ZGY0MWE5NyIsInVzZXJOYW1lIjoiTWFyam9sYWluZSIsInRnSWQiOiI3Njg1MTQ3OTAyMDgzMDcyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTQsImV4cCI6MTcyNzQzOTIxNH0.asTCWA-YygwD26sklC5CmmlX3xL2MNwrhbUhFQTbFEo	7d633720-08f4-443c-942d-8da74df41a97	2024-08-28 12:13:34.196	2024-08-28 12:13:34.268
f6287083-d882-48e8-b4c3-373bdbfb3f1d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJmMWEyNDMxLWE5MTgtNGEzNi04MzM0LWFiNjU0NWU0MzBmNyIsInVzZXJOYW1lIjoiSXNhYmVsIiwidGdJZCI6Ijg3NjQzNTE5MjIwNDQ5MjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxNCwiZXhwIjoxNzI3NDM5MjE0fQ.7Mtt7JtnxzWNJRkfa9MMFTcC6ubgdA4vQLLzy7nmLHs	bf1a2431-a918-4a36-8334-ab6545e430f7	2024-08-28 12:13:34.304	2024-08-28 12:13:34.386
afa9b40f-afa3-4dba-82d9-310a16c9602d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjliZjRhYWU5LTc3ZjctNDg1Yy04Y2MxLWViNTRkOTRkZjNjOCIsInVzZXJOYW1lIjoiRnJhbmsiLCJ0Z0lkIjoiNDI3NDYzMzY0MTU1ODAxNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjE0LCJleHAiOjE3Mjc0MzkyMTR9.3c7r47g7oHflIY994VdmhIFxaL7KkrYUMa3MAnbpwtQ	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8	2024-08-28 12:13:34.438	2024-08-28 12:13:34.493
9fb51a3a-6b9d-4e45-a4d9-84cdcb2b16db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5YjExODBhLWNkZWUtNGE4Zi05OTA5LWU1Y2Q2MGY0ZWExYyIsInVzZXJOYW1lIjoiQ2hhcmxlbmUiLCJ0Z0lkIjoiNjMwMDI4MTE1OTU0ODkyOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjE0LCJleHAiOjE3Mjc0MzkyMTR9.7b9jgWWjZLZSqJPbAowdZxTkTIDK8c4aVD3tkQsUdf8	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c	2024-08-28 12:13:34.541	2024-08-28 12:13:34.624
cba77cb5-a4b7-461f-8d84-908e65b35054	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIzN2I0YTQ2LTI4MjItNDZjZC1iMGFjLWM4MjczOTgyOWEwMCIsInVzZXJOYW1lIjoiTG9ubnkiLCJ0Z0lkIjoiNDc2NDA0ODIzNzI2NDg5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjE0LCJleHAiOjE3Mjc0MzkyMTR9.hvw82lKK_j9vOx8fINRyWIriHhURMwzKHALrKWOQROA	237b4a46-2822-46cd-b0ac-c82739829a00	2024-08-28 12:13:34.665	2024-08-28 12:13:34.748
ba21c2f7-c409-48e8-9173-81a69c69edb0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUxZjkyYmUxLTRmMjItNDA2Yi04MTZhLTYzN2FjOWMxZjE4MCIsInVzZXJOYW1lIjoiTWF4IiwidGdJZCI6Ijc0MzQ0MTE5NDk2ODY3ODQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0NzIxNCwiZXhwIjoxNzI3NDM5MjE0fQ.Nw9bLpurpfgUIQogNps7e1ZCejULNAEUj-pnnu8cUmw	51f92be1-4f22-406b-816a-637ac9c1f180	2024-08-28 12:13:34.784	2024-08-28 12:13:34.831
37e05999-d4bb-4cf1-9214-ad4c55042bae	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVhN2VjYzlkLWM4YzItNGRjNi04MmE4LTM1YWQxM2I3MWY4ZiIsInVzZXJOYW1lIjoiTXVybCIsInRnSWQiOiI1NjI1MjA1NTA2NDQxMjE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTQsImV4cCI6MTcyNzQzOTIxNH0.5YTLwk87tBh5j5g9IQikQpMVpsEFaSum5KYWm34dkLI	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f	2024-08-28 12:13:34.869	2024-08-28 12:13:34.983
7dd27e80-ea8c-4ede-a137-1a81c1a36aac	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlMzBlYzQ0LWJmMTctNDUxOC1iNWMwLTJjMWQ1NTJhOTc3NyIsInVzZXJOYW1lIjoiSGVhdGhlciIsInRnSWQiOiI3MjMxNDExNjQ1ODQxNDA4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDcyMTUsImV4cCI6MTcyNzQzOTIxNX0.8GwZhsN5AJoKvOL567Mfw4yFRBH57O9OISmkgLiTXdM	5e30ec44-bf17-4518-b5c0-2c1d552a9777	2024-08-28 12:13:35.02	2024-08-28 12:13:35.084
9e93fecd-298d-4c40-ab2a-06c666a4d0b7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEwODBkZTFlLWQ5MDYtNDBhMi05YmI2LWMzZTc1MjhkMmI4NyIsInVzZXJOYW1lIjoiQmVybmhhcmQiLCJ0Z0lkIjoiMTk0MTk5ODkwODk5NzYzMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3MjE1LCJleHAiOjE3Mjc0MzkyMTV9.3kL6awQB8OXGJirLTacxl2Epyhygt6bL2QdAQ_SB-iU	a080de1e-d906-40a2-9bb6-c3e7528d2b87	2024-08-28 12:13:35.131	2024-08-28 12:13:35.184
b5a563f7-8400-4e58-9416-1ef1e9560760	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIwYmM3NjRkLTU5ZDgtNDkyYS1iMWUwLTNkOTgxNGFkMDM0ZSIsInVzZXJOYW1lIjoiRGVlIiwidGdJZCI6IjI1NTE3NjkxMDIwMjQ3MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NSwiZXhwIjoxNzI3NDM5ODg1fQ.5OT_6CH-8wQ-JsWOTkXtTVki45hobBF0IrIM6lHkPpg	20bc764d-59d8-492a-b1e0-3d9814ad034e	2024-08-28 12:24:45.181	2024-08-28 12:24:45.338
7553b1a3-3759-4d73-af35-39523b5ea73c	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE4OGUyZDVlLTk3N2EtNDczMC1hMzgzLTBjZjY0MzFlYzVmZSIsInVzZXJOYW1lIjoiRW1lbGllIiwidGdJZCI6IjgzMzI4MzkxNTE5OTI4MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NSwiZXhwIjoxNzI3NDM5ODg1fQ.6DT0nO52RMXKbctnmYt3fVL7VbHI9qnfOfaP-1gg4Jc	188e2d5e-977a-4730-a383-0cf6431ec5fe	2024-08-28 12:24:45.496	2024-08-28 12:24:45.649
93a31270-d1de-46cf-8846-e4e9355bfb34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhZTMyNzM4LTc0ZTgtNGM0OS05MWNiLWUzOWY3ZTVkZjM3MSIsInVzZXJOYW1lIjoiQWxlamFuZHJpbiIsInRnSWQiOiI2MTkyNDMwNDE4MjMxMjk2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODUsImV4cCI6MTcyNzQzOTg4NX0.KN_IeFPTvuLjbjHu2o1JEPdn4aKjx8b15ve2nzsIUZw	6ae32738-74e8-4c49-91cb-e39f7e5df371	2024-08-28 12:24:45.693	2024-08-28 12:24:45.754
5bb1ba66-8a57-4bc7-8d60-a15a1ee16d16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFlOTY4YmE2LTdhMzItNDExMi04OTFkLWE1OWMxMmJlNTdjMyIsInVzZXJOYW1lIjoiQW1peWEiLCJ0Z0lkIjoiMTkwNjk5NjcyNjk4ODgwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODUsImV4cCI6MTcyNzQzOTg4NX0.kpC10ViqOVcoi8bsyAxgrRR1vBBSdj-TD35VL1sMOes	1e968ba6-7a32-4112-891d-a59c12be57c3	2024-08-28 12:24:45.812	2024-08-28 12:24:45.917
81d7bac4-f4ff-4465-998b-550517fea02e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE1MGJjODk1LWIxYzQtNDhiNi04YWNjLTUxMzk0NzIzNmRkMSIsInVzZXJOYW1lIjoiSGlsbGFyZCIsInRnSWQiOiIxMDQxNjE2NTY3NTMzNTY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODUsImV4cCI6MTcyNzQzOTg4NX0.Jeye3WTeso20TMwyeoDhaG3nbfSMrxQvDQL3STtDo84	150bc895-b1c4-48b6-8acc-513947236dd1	2024-08-28 12:24:45.967	2024-08-28 12:24:46.139
ed93e03a-d803-4a70-b84a-3b7841f9ef91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVmZjRkMjY2LTdmODktNDllMS1hNjdjLTI5YzI4Y2NkN2I5ZiIsInVzZXJOYW1lIjoiSmFrb2IiLCJ0Z0lkIjoiNTg0MDU1MjI0NzQyNzA3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg2LCJleHAiOjE3Mjc0Mzk4ODZ9.83H2KrnT6dq6dTF3sdUCk45ctR53-SNhnYXSHwFBrHo	eff4d266-7f89-49e1-a67c-29c28ccd7b9f	2024-08-28 12:24:46.214	2024-08-28 12:24:46.295
562c45e1-b670-4706-bbf4-6013b5675654	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImEyZDM2Yjc0LTkzYjgtNGIxZi1iMWMyLWMxYTk4MzI3MDhiMiIsInVzZXJOYW1lIjoiVmVyZGEiLCJ0Z0lkIjoiNjE0NDc3MTc4NzU4NzU4NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg2LCJleHAiOjE3Mjc0Mzk4ODZ9.iJ1RhUJtKoQp_ovyGiiMdReDH9gTYiMkgjcJ_KD0NlU	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2	2024-08-28 12:24:46.336	2024-08-28 12:24:46.412
6b6ae61f-583b-4e18-88ee-9cf874e6e6ec	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJiZDg3YmM5LWJiZTAtNGE2OC1iNjYxLTY3Y2ZjNTU5OTViMCIsInVzZXJOYW1lIjoiQ2hyaXN0b3AiLCJ0Z0lkIjoiODkxNDM4NTg2NTAxNTI5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg2LCJleHAiOjE3Mjc0Mzk4ODZ9.KmfOSi4JtupRe37wGeCq06zntQw0klgwz8mz7Wr8PX0	2bd87bc9-bbe0-4a68-b661-67cfc55995b0	2024-08-28 12:24:46.447	2024-08-28 12:24:46.771
f0ef219c-5695-4b56-9594-93d9b38dd166	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImUxZjVkMDg5LTkwOTktNDkwOS04MDVjLTdkZGJkZDc0ZTBhMyIsInVzZXJOYW1lIjoiSmFuZSIsInRnSWQiOiIzODMzNjM0ODM2NDQ3MjMyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODYsImV4cCI6MTcyNzQzOTg4Nn0.__63J_ibO9Sym0PLzuTMDeZidi4SQshfvFFuJpBJckA	e1f5d089-9099-4909-805c-7ddbdd74e0a3	2024-08-28 12:24:46.83	2024-08-28 12:24:46.914
a55dd42d-7f60-4c23-b357-dfd7bda847ff	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE1MzJiYjQ5LTBlMzItNDg0MS04NTMxLWViOWY3ZDgzMWFiZiIsInVzZXJOYW1lIjoiVmVsbWEiLCJ0Z0lkIjoiNDQ5NTQ0MTIwMDY3Njg2NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg2LCJleHAiOjE3Mjc0Mzk4ODZ9.uR6qmVgS3wFUKFMhGxM5E45UEx4BNz8F2Ybdu7Gl5qI	1532bb49-0e32-4841-8531-eb9f7d831abf	2024-08-28 12:24:46.96	2024-08-28 12:24:47.025
feada3a7-8cc9-45bb-af6e-7af85735f616	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImExOGM1OTAxLTNjYmEtNGYxMi05MTNhLTJmOTAxZjdlZGE1NSIsInVzZXJOYW1lIjoiRWFybGluZSIsInRnSWQiOiI0NTY2MDk2NzcyMzMzNTY4IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODcsImV4cCI6MTcyNzQzOTg4N30.EXYPbvCvR6WGml8Ug73mutJsYcK1Wk547mtqgMsmtEU	a18c5901-3cba-4f12-913a-2f901f7eda55	2024-08-28 12:24:47.118	2024-08-28 12:24:47.211
c4740b3f-12ab-45fa-9be6-7f943f289e2b	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU4MDM4YTQwLTVhMGMtNGExZC1hZjA2LWYwZDRjNGE3MGI5YSIsInVzZXJOYW1lIjoiSmVybWV5IiwidGdJZCI6IjUxMDg0Mzc4Mjg1MDE1MDQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NywiZXhwIjoxNzI3NDM5ODg3fQ.PBmkDwrZTZl6i-Nh0kDzioXKdg1Dwy2oHXEft7zo6Xc	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a	2024-08-28 12:24:47.262	2024-08-28 12:24:47.314
e04579c8-6f6d-419e-b710-104e31683a98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdmMWVjNGZjLWQ5NWEtNGE5OC04ZmYyLTdkNjM5YTY1NWRmZCIsInVzZXJOYW1lIjoiR2FybmV0dCIsInRnSWQiOiI0MzE1NjA5NDA3OTQ2NzUyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODcsImV4cCI6MTcyNzQzOTg4N30.08GbkBhZKHNU485JOjjyEU5Reif2ftPZgq95xxZ3TLs	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd	2024-08-28 12:24:47.354	2024-08-28 12:24:47.439
6963f432-ca89-44dc-984f-0da2e2f8d745	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAzYzAzMWQ1LWRlZjQtNGM5Zi05YzQzLWVhZDY2MGIyZWNkOCIsInVzZXJOYW1lIjoiTGF2ZXJuIiwidGdJZCI6IjQ4MTU3MTkwOTUwNzQ4MTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NywiZXhwIjoxNzI3NDM5ODg3fQ.NH4EiuhkZDlbd26x6dpnFZTy3Lj4zKVjECWcnJMnZsk	03c031d5-def4-4c9f-9c43-ead660b2ecd8	2024-08-28 12:24:47.491	2024-08-28 12:24:47.633
d6d35dc9-1e96-4cc6-90b0-71886e116201	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg1YjkyMTdlLWU2OTAtNDU2MC04NjJkLTUyM2I4ZGRmNzM5MCIsInVzZXJOYW1lIjoiTXlhIiwidGdJZCI6IjE3NjEwMDQyNTM4NzIxMjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NywiZXhwIjoxNzI3NDM5ODg3fQ.CEX51hy1Pmvwzc3q6W7vIiJUfUgVWXQWnYSx05h0tvo	85b9217e-e690-4560-862d-523b8ddf7390	2024-08-28 12:24:47.673	2024-08-28 12:24:47.747
2e17270d-41ee-48ab-8848-96df58865ca5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNjNWQ5YmI5LTkyM2QtNDc0NS1hNDk5LTA2ZDI0MjFkOGIwNiIsInVzZXJOYW1lIjoiR3VubmFyIiwidGdJZCI6IjM5MTkyMDE1MDI3NTY4NjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4NywiZXhwIjoxNzI3NDM5ODg3fQ.C87Pgt1UEixszdT_E_5JXuJDGJ0ed3sTOFplVlBwDw4	3c5d9bb9-923d-4745-a499-06d2421d8b06	2024-08-28 12:24:47.794	2024-08-28 12:24:47.871
f90c69b5-7eea-4d2c-a1fd-bbf7dcd429f9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MmE5ZjMzLTQ0NjktNGIzMi1iNjhmLWNiMDQzNDI0ZTczZiIsInVzZXJOYW1lIjoiU29uaWEiLCJ0Z0lkIjoiNTY1NjM0MjE1Mjg3MTkzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg3LCJleHAiOjE3Mjc0Mzk4ODd9.uZTJ8oAWeF4AT0QnsF1t0k3ZYDE6tgAQ7bZJSV8hWW4	642a9f33-4469-4b32-b68f-cb043424e73f	2024-08-28 12:24:47.95	2024-08-28 12:24:48.018
1f6117fd-70a7-4bf5-be03-c289333ca66f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJhMTIzNTllLWFmMmQtNDRhZS1iMjVlLTk0MzBmMmQzZmRjNyIsInVzZXJOYW1lIjoiSmFtZXkiLCJ0Z0lkIjoiMzYzODUwMjAyNTU5MjgzMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg4LCJleHAiOjE3Mjc0Mzk4ODh9.tKHawq96QnZHzEizDZbuvJ0p2WduoBF7qam4yXcpyMk	ba12359e-af2d-44ae-b25e-9430f2d3fdc7	2024-08-28 12:24:48.097	2024-08-28 12:24:48.212
fec7fabe-e61b-4867-b80d-887d2eea47a8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2Mjg2Y2YzLTMyZWYtNDNkMi05MjdjLWM4YzYyYjUwZDk1YyIsInVzZXJOYW1lIjoiRGFtaW9uIiwidGdJZCI6IjIwNDc2MzkxODA4MDQwOTYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4OCwiZXhwIjoxNzI3NDM5ODg4fQ.ok5ZDclRsCmtNf0030A9Pqk2VuJJMRJiCrBXBIvnf5s	e6286cf3-32ef-43d2-927c-c8c62b50d95c	2024-08-28 12:24:48.256	2024-08-28 12:24:48.398
2a5d5d95-0659-4568-9604-ce281dd9dc7a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMwNTRiYmIyLTI0NGMtNDk3NC1iN2U3LWMyOWRhYzhiMWRjMyIsInVzZXJOYW1lIjoiUHJpbmNlIiwidGdJZCI6IjE1OTAwMjU0MzczMTUwNzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzg4OCwiZXhwIjoxNzI3NDM5ODg4fQ.ho-P2t6DbtO6UDW8Of01tPd3XVV5ehGvBhgPsSlnZeM	3054bbb2-244c-4974-b7e7-c29dac8b1dc3	2024-08-28 12:24:48.44	2024-08-28 12:24:48.53
275d6dc0-159e-42c1-8a9e-f0bffd2e6491	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5Y2NkNzI5LTBiMzUtNGZiZC04ZjUyLTIwMDE0NTA2ZmEyMCIsInVzZXJOYW1lIjoiS2VsbHkiLCJ0Z0lkIjoiNzE1MzY4NDM5MTY1NzQ3MiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg4LCJleHAiOjE3Mjc0Mzk4ODh9.tY2dbEHyMZZA1lNvU6ZeFhgUNMWfjuB6_og6yJDOah8	c9ccd729-0b35-4fbd-8f52-20014506fa20	2024-08-28 12:24:48.564	2024-08-28 12:24:48.654
9720d7c3-e692-4670-9ddf-4501af5f95a0	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE5OWRhN2U0LTI1YmYtNDdmZi05ZTUxLWI1YzQxMmFmNTdjOSIsInVzZXJOYW1lIjoiSmVhbmV0dGUiLCJ0Z0lkIjoiNDExNTkwNzUxNzM0OTg4OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg4LCJleHAiOjE3Mjc0Mzk4ODh9.g1Y43OkeBCNSlbDqML-Rjx4U2rf8InkpzaL3KeFbejc	199da7e4-25bf-47ff-9e51-b5c412af57c9	2024-08-28 12:24:48.712	2024-08-28 12:24:48.783
ccef1ada-960d-4fb6-afb6-ae3629807400	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZkNTU1MGFhLWRhMmUtNDJhZi1hNDY2LTY3ZTJjNTlmZTI2OCIsInVzZXJOYW1lIjoiT2tleSIsInRnSWQiOiIzMTYxMzAzMTc2NzA4MDk2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc4ODgsImV4cCI6MTcyNzQzOTg4OH0.7vZnVrWgf01o8A1VZyZ9iNxoQB0eJ8zGFFpREOTuDjc	fd5550aa-da2e-42af-a466-67e2c59fe268	2024-08-28 12:24:48.821	2024-08-28 12:24:49.019
d9f98ffb-fcc2-4dac-b3b5-1831bacfa5d9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY4ZjQ4OWM1LWJhZWUtNDJhNy1hMjJmLWNlZGE4YjhkNzYwZiIsInVzZXJOYW1lIjoiTW9oYW1tZWQiLCJ0Z0lkIjoiNDYzMjA3NjU0ODU3MTEzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3ODg5LCJleHAiOjE3Mjc0Mzk4ODl9.aqc3xEKUs-4PQOWKBdquhnOL3rB5KKFYDzwJoxxBbug	f8f489c5-baee-42a7-a22f-ceda8b8d760f	2024-08-28 12:24:49.108	2024-08-28 12:24:49.228
fba1d8f8-6fd9-46dd-bd67-b479733eb60a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE0ZjA5MjFjLTU5MjktNDlmMy1hMmQxLTNmMDA0ODg0OWRiNiIsInVzZXJOYW1lIjoiRWxmcmllZGEiLCJ0Z0lkIjoiODY0NDY3ODg1MTIzMTc0NCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTc4LCJleHAiOjE3Mjc0Mzk5Nzh9.xNVtvY67jDaG-X8I6WS4xK1IK6iSrVNY6tO-3iPR1uM	a4f0921c-5929-49f3-a2d1-3f0048849db6	2024-08-28 12:26:18.699	2024-08-28 12:26:18.855
cdc21720-ee29-4c99-ab7d-48a8b3f62b90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRlNjc1OWUwLTZjZTktNDI3Ny1iZmY2LWQ2MDMzYmI2ZjQ3OSIsInVzZXJOYW1lIjoiRXZhbHluIiwidGdJZCI6Ijg0MDUxNDAxNDA3MjAxMjgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk3OSwiZXhwIjoxNzI3NDM5OTc5fQ.gECEovxjFH5cEiPFjYcQYQRI_5PTexTjlUxGNmJ9QlQ	4e6759e0-6ce9-4277-bff6-d6033bb6f479	2024-08-28 12:26:19.032	2024-08-28 12:26:19.205
4df8c091-ecb6-4ba3-b272-35b20cfdf1f1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJkYTNjOWFiLTM4NWYtNDYxZS1hMWNkLTM3YTUyZDUzMzVjOCIsInVzZXJOYW1lIjoiTGF2ZXJuIiwidGdJZCI6IjM2MzY4MzAyNDczMjE2MDAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk3OSwiZXhwIjoxNzI3NDM5OTc5fQ.4-CmFmq5_qbjOnBWPCtB4FOfNWC9ds1gfaHtoHZzuVc	bda3c9ab-385f-461e-a1cd-37a52d5335c8	2024-08-28 12:26:19.252	2024-08-28 12:26:19.317
36e5b0bc-5d0f-44f4-9fa7-a737373af1ee	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY4Njg0MzhhLWI3NmUtNDZiMy1hYmFhLWY0NDA1YTYzZDBmZiIsInVzZXJOYW1lIjoiVGFkIiwidGdJZCI6IjI3MTU0OTk3MjkyNTY0NDgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk3OSwiZXhwIjoxNzI3NDM5OTc5fQ.3i5VgbkaD2xE5B4WguCXOUFOSDlc0LhgWlKUwfri6tk	f868438a-b76e-46b3-abaa-f4405a63d0ff	2024-08-28 12:26:19.365	2024-08-28 12:26:19.489
2be97972-bf34-44cd-a550-f992d327536d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmNGEzM2EwLTZkOTYtNDRhYi04ZDhjLTI0YTYyMDEzMDAzZiIsInVzZXJOYW1lIjoiQW1iZXIiLCJ0Z0lkIjoiOTI3NTAwODA5MDExMjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk3OSwiZXhwIjoxNzI3NDM5OTc5fQ.e2_QmCgSqEI5UoAT4b4gMndfwtCO-zZsKpK-5r0IvBM	5f4a33a0-6d96-44ab-8d8c-24a62013003f	2024-08-28 12:26:19.548	2024-08-28 12:26:19.619
966c1ed3-c183-4a15-8571-0dc49efc969e	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAyOTI2YTIxLTY0ZGMtNDc3ZS04ODBjLWNkNmI1ZWIzMzk0ZiIsInVzZXJOYW1lIjoiQXhlbCIsInRnSWQiOiIyNDMwMjI5Mjg3MDEwMzA0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5NzksImV4cCI6MTcyNzQzOTk3OX0.OyE0hbP2gP65qXKChTE4Q79mfK_mNZsGdlioJw7_XC8	02926a21-64dc-477e-880c-cd6b5eb3394f	2024-08-28 12:26:19.706	2024-08-28 12:26:19.771
88562ea5-5e1d-4775-a01e-8ae53ef16013	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE3ZjdlNWVmLWYzYWYtNGJhNC1iMDQ4LTcwMWI2NTgyODIxZiIsInVzZXJOYW1lIjoiT25pZSIsInRnSWQiOiI0ODE5NTUyNjc4NDQ1MDU2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5NzksImV4cCI6MTcyNzQzOTk3OX0.DU1fnFDAZ4gFYloAHxPH7LNGq1iXRb6zr7Uny0gXJZY	a7f7e5ef-f3af-4ba4-b048-701b6582821f	2024-08-28 12:26:19.814	2024-08-28 12:26:19.913
eee26fdd-399e-4172-8531-188237740bac	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA0YTJhNzZjLTQ0ZmYtNDZkMy04MTU1LTEzNDhlZGYxODI4YiIsInVzZXJOYW1lIjoiU2NhcmxldHQiLCJ0Z0lkIjoiMzM4MzE0Mjk5ODA4MTUzNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTc5LCJleHAiOjE3Mjc0Mzk5Nzl9.4CyWXY5-2kkxQxbEk-Pgk57W4ADNO9s4NndyOpe-JHA	04a2a76c-44ff-46d3-8155-1348edf1828b	2024-08-28 12:26:19.958	2024-08-28 12:26:20.042
2fcabc36-d157-4835-9a0a-d7328acc26e2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4MzRlMzViLTFlMjktNGU5ZC04OGYxLWRkY2RhM2MzZjFhOCIsInVzZXJOYW1lIjoiQ2F0ZXJpbmEiLCJ0Z0lkIjoiODk3NTgzMzU4NDYzMTgwOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgwLCJleHAiOjE3Mjc0Mzk5ODB9.dDqsLkT44w7jznvQUVIgZJ_jVTTZ-lCJCRgz7Q6oPfg	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8	2024-08-28 12:26:20.082	2024-08-28 12:26:20.157
7e9afc13-1c11-4fa3-80c0-cf2bae2ae2fe	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImViN2M1M2ZjLTEwZTEtNDdmNS1hNmU3LWZhZTJiZTg4OTZlYSIsInVzZXJOYW1lIjoiRmF1c3Rpbm8iLCJ0Z0lkIjoiMjE1NzgxNTg2MjkxOTE2OCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgwLCJleHAiOjE3Mjc0Mzk5ODB9.s31UlNKipZSSK93PliNdiurlX4zquHMxbMk-LN4yXgc	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea	2024-08-28 12:26:20.21	2024-08-28 12:26:20.291
c3b00891-26cf-40aa-b4b6-e16c9b10e6bb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI0MDg1MTI4LTJkYzctNGVkNS05MzMyLTk1OWRjZTliMGNiZiIsInVzZXJOYW1lIjoiWmFjaGFyeSIsInRnSWQiOiIxMDA1NzAyNjg2NDQxNDcyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5ODAsImV4cCI6MTcyNzQzOTk4MH0.y9wyoRa6ddayAXeqvjTgns30IC9ddC3yqi0xdSobwKk	b4085128-2dc7-4ed5-9332-959dce9b0cbf	2024-08-28 12:26:20.341	2024-08-28 12:26:20.402
22485ee1-166f-405f-9e5b-3109bb80c49d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMDUzOTljLWM4OWMtNGZiNC04NTcwLTQyNDY1YmQxYjc5ZiIsInVzZXJOYW1lIjoiVGVycmlsbCIsInRnSWQiOiIxNjgzNTk2MTAwMjM5MzYiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk4MCwiZXhwIjoxNzI3NDM5OTgwfQ.gHVTTT9fjOEddbIq2dbAJIG1tdpNmC2-QZRQ_mc3pq8	6305399c-c89c-4fb4-8570-42465bd1b79f	2024-08-28 12:26:20.439	2024-08-28 12:26:20.535
a6acecb2-36ca-494e-bdd8-38fae26dc432	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ1ZjNmMmJmLTNhNGItNGYwYi1iZmYxLTNmNDc3YmM2MjliOCIsInVzZXJOYW1lIjoiQ2x5ZGUiLCJ0Z0lkIjoiNzg3NzMxNTE3MDE0MDE2IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5ODAsImV4cCI6MTcyNzQzOTk4MH0.D2BT-4oJ4cpPnOCfKv1sCLVZZ-YjH404DIND9x1W9V4	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8	2024-08-28 12:26:20.58	2024-08-28 12:26:20.716
fd47e26e-1f15-4160-aaa1-a5b4aa3ae2d2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMxMjRkNWUwLTI1MDktNDNmYS04ZTBjLWYwN2E5ZGI5NjJlZCIsInVzZXJOYW1lIjoiT3RoYSIsInRnSWQiOiI3ODA1NTU4MDg0MDc1NTIwIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5ODAsImV4cCI6MTcyNzQzOTk4MH0.lz4nimz5QoE_DAPNvQOyelgw2Qa03zG8dTfDLtZ___g	c124d5e0-2509-43fa-8e0c-f07a9db962ed	2024-08-28 12:26:20.769	2024-08-28 12:26:20.875
ce2fb9ec-f872-4894-8a02-65d0db7fed96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMwOTgyYjAyLWNlY2ItNGY3My1hZGIwLTMyNzI1OGZlMmY4YSIsInVzZXJOYW1lIjoiU2h5YW5uIiwidGdJZCI6IjIzNjExMjQyNzYxNDIwOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgwLCJleHAiOjE3Mjc0Mzk5ODB9.SolW9VdzmwHh0_Ci5W9aMZvwlpbRcqvcpnKd3YpbBpM	c0982b02-cecb-4f73-adb0-327258fe2f8a	2024-08-28 12:26:20.93	2024-08-28 12:26:20.992
8df0426b-d170-4a91-9679-410538b83473	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJhZTgxYzY3LTdjNjUtNDA3Zi04NjJjLWRjNjg3N2Y4NTZlMCIsInVzZXJOYW1lIjoiQ2hhc2l0eSIsInRnSWQiOiIzOTAyNzQ4NTE0ODQ0NjcyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5ODEsImV4cCI6MTcyNzQzOTk4MX0.XYAkZUGP_BW35pNe6zYmJkOgFcyhxWmchRzMoTrMI8o	2ae81c67-7c65-407f-862c-dc6877f856e0	2024-08-28 12:26:21.031	2024-08-28 12:26:21.101
ace150ae-0050-47e7-a6b2-a84c3405c325	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU0Y2M1YjMzLTgwODMtNDEwZS1iOTJlLTYwYjgxODM0M2E5MCIsInVzZXJOYW1lIjoiVmlvbGEiLCJ0Z0lkIjoiMjY2MjE4NzE0NzQ2MDYwOCIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgxLCJleHAiOjE3Mjc0Mzk5ODF9.BkBaX-3GGrJnWFuaBZdkXM8lhUrlEYR8VklD0MAjMt4	e4cc5b33-8083-410e-b92e-60b818343a90	2024-08-28 12:26:21.163	2024-08-28 12:26:21.247
93f61c07-ac08-43d2-8a91-4139c83618cb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI5Nzc3M2U2LWE4NzEtNDU3Mi1iYWMxLTdhNjYzN2YwNTljYiIsInVzZXJOYW1lIjoiTHVkaWUiLCJ0Z0lkIjoiNjc1NjIzNjMzMjYzMDAxNiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgxLCJleHAiOjE3Mjc0Mzk5ODF9.wvEPLk5jTpcbkCDe4ozDRkbcdkjroCKULcNfP9EpAHE	b97773e6-a871-4572-bac1-7a6637f059cb	2024-08-28 12:26:21.328	2024-08-28 12:26:21.412
7cbdf833-5558-4294-a9cd-76d41da0fbed	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNjMzA1Mzk3LTlmNmMtNDE4OS1hYTA1LWY0OGZjNmQ0YzAyYyIsInVzZXJOYW1lIjoiQ29yaW5lIiwidGdJZCI6Ijc0MzIwMzQwNjY2Mjg2MDgiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk4MSwiZXhwIjoxNzI3NDM5OTgxfQ.wH1vK19NyMkLbS3rub7gX_SP26n9tHTpcNfZV3fMNJ0	3c305397-9f6c-4189-aa05-f48fc6d4c02c	2024-08-28 12:26:21.455	2024-08-28 12:26:21.592
d6727420-6960-40eb-906d-e26feb241db9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZjMDU3Njc2LWU1MjgtNGZjYi1hNzI5LTRmNGViOWVlNWU1YiIsInVzZXJOYW1lIjoiVGlhbmEiLCJ0Z0lkIjoiNTU2ODA5MDUxMTI0NTMxMiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgxLCJleHAiOjE3Mjc0Mzk5ODF9.btJLpB_vXHBe7rYjJY-2NQmEQxQzDo-IHFT6Z5yjsKQ	fc057676-e528-4fcb-a729-4f4eb9ee5e5b	2024-08-28 12:26:21.643	2024-08-28 12:26:21.706
2ee9149e-2c57-428b-a501-8f119508eed8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM4ZjgxYzk1LTU1ODYtNDBkYy1iZTExLTcxMTdmY2Q5MGY5ZiIsInVzZXJOYW1lIjoiTWFkZWx5biIsInRnSWQiOiIzMzA0NjAyNzUzNTY0NjcyIiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDc5ODEsImV4cCI6MTcyNzQzOTk4MX0.ZfDzVfuB_ixrMV1ODMCRlQ5zs4jqpq_0Pkvo1-vMyo0	38f81c95-5586-40dc-be11-7117fcd90f9f	2024-08-28 12:26:21.751	2024-08-28 12:26:21.863
9059f5f1-23a0-494e-b3ee-d10fb7c9c02a	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZhM2I0Y2RjLWI3YTItNDU5NS1hN2U0LWVmNDc0ZDEyOTg4MyIsInVzZXJOYW1lIjoiQW5hYmVsIiwidGdJZCI6IjUyMDA2NzA5NDY3NTQ1NjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk4MSwiZXhwIjoxNzI3NDM5OTgxfQ.mhn22osrKwHLGD_F5QuNdbEGj2GV3bTjaJRm6cWjndA	fa3b4cdc-b7a2-4595-a7e4-ef474d129883	2024-08-28 12:26:21.908	2024-08-28 12:26:21.974
254e3391-d4e3-4db9-858e-cd361c9d6d19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFkY2QzZDhhLTcxZTUtNGJlYS04ODBjLWVhOWY3Mjg0YTcyNCIsInVzZXJOYW1lIjoiTmVsZGEiLCJ0Z0lkIjoiODE1Njk1MDA5NTIwMDI1NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgyLCJleHAiOjE3Mjc0Mzk5ODJ9.PScwBe6JYFy_xAwldqqycB84j_9LcDOn9c7xIHqihT4	adcd3d8a-71e5-4bea-880c-ea9f7284a724	2024-08-28 12:26:22.024	2024-08-28 12:26:22.225
3de64f93-42d1-45f9-b9da-5647c6d4e0f6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkzNTZiNjBiLThjYTQtNDU5ZS04MzQ3LTA0OTQzYjQwZGFlNSIsInVzZXJOYW1lIjoiQ2xhdWQiLCJ0Z0lkIjoiODI4MTk1MzAxMDcxMjU3NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgyLCJleHAiOjE3Mjc0Mzk5ODJ9.F-uqxS2iVtlH5x1SpOUkkbIYppfkH2YAepMRMhMTVH8	9356b60b-8ca4-459e-8347-04943b40dae5	2024-08-28 12:26:22.284	2024-08-28 12:26:22.411
2478fdd0-26f7-43ad-88d7-7f885babafa5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk4YjEyMzY1LTVlZWQtNGYzYi1iNjE1LWFiODdmMzE3YzJmZCIsInVzZXJOYW1lIjoiU2llbm5hIiwidGdJZCI6IjExMzQ2Nzc0MjExOTUyNjQiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg0Nzk4MiwiZXhwIjoxNzI3NDM5OTgyfQ.-1iD-TGAiIJp3X19xpL0RXIqRbEVleARFulwltXms7k	98b12365-5eed-4f3b-b615-ab87f317c2fd	2024-08-28 12:26:22.465	2024-08-28 12:26:22.573
f2947c85-2abc-4b99-9ac5-48323ae89901	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZlYWVhYTkwLTgxYTUtNDA5OC1iNDRlLWQzOWIwZDA1OWNmOSIsInVzZXJOYW1lIjoiUHJlY2lvdXMiLCJ0Z0lkIjoiNzQ2MjgyODY4NjQ0MjQ5NiIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0ODQ3OTgyLCJleHAiOjE3Mjc0Mzk5ODJ9.gYpZVY5YHoMCOki5jR8yl8vus_3nNh1vYrub6cP7db4	feaeaa90-81a5-4098-b44e-d39b0d059cf9	2024-08-28 12:26:22.648	2024-08-28 12:26:22.769
ce6bd8a6-a1b9-4f2b-9692-24e5d0e61d45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM3NDM3YjdhLThlOWQtNGZkOS1hNTZkLTA1OTczYWM5OTBkZiIsInVzZXJOYW1lIjoiV2lsZm9yZCIsInRnSWQiOiIxNjQxMTM5MzU2NTY1NTA0IiwicmVmZXJyZWRCeUlkIjpudWxsLCJpYXQiOjE3MjQ4NDgwODksImV4cCI6MTcyNzQ0MDA4OX0.RWNbvjqvnPsJP0XfWm8wc8I47EvIxm1pFPlfLEdSql0	c7437b7a-8e9d-4fd9-a56d-05973ac990df	2024-08-28 12:28:09.939	2024-08-28 12:28:10.14
1723268c-9f91-4495-8d88-87cb0b01fe47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRkMDE1ZWNmLTljNjItNDIxZS05ZTVlLTkxMjA1YWQyMTI2YSIsInVzZXJOYW1lIjoicm9ndWUiLCJ0Z0lkIjoiOTkyODE5MzIiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDkzNjc1NiwiZXhwIjoxNzI3NTI4NzU2fQ.8n8VYnSzGROJMlNIvEkuvr_1Vtid16Z9az5jP5WLsCE	dd015ecf-9c62-421e-9e5e-91205ad2126a	2024-08-29 12:05:26.692	2024-08-29 13:05:56.999
1b6fedc8-4934-49e6-9789-eebae7a64957	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMzZDliNTFmLWRmZWEtNDBmMC1hMGQyLTdmODc3Mzc4MjRjMyIsInVzZXJOYW1lIjoiIiwidGdJZCI6Ijc0NTQxMDQ3NjAiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg3NDAxMCwiZXhwIjoxNzI3NDY2MDEwfQ.BV_G8-g4Lhqz6G6H4f621FSTYBkVHMIS7GlQnGgh6m4	c3d9b51f-dfea-40f0-a0d2-7f87737824c3	2024-08-28 19:38:20.49	2024-08-28 19:40:10.24
5c6532ad-69ae-4ecb-b1f4-12dfdc637a03	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE5YWQ1MWQxLTk5ZDYtNGU1OC1iNzEyLWNmYmFmNmVhNWE1YiIsInVzZXJOYW1lIjoia3Jld19zdHVkIiwidGdJZCI6IjU0NDQ1NDQ4NDEiLCJyZWZlcnJlZEJ5SWQiOm51bGwsImlhdCI6MTcyNDg3NjQ1MiwiZXhwIjoxNzI3NDY4NDUyfQ.jl9pnWipSrckN-A1bug1p9oSc1a5EH6X2mK4fODKUiE	a9ad51d1-99d6-4e58-b712-cfbaf6ea5a5b	2024-08-28 20:19:47.153	2024-08-28 20:20:52.803
b4b43aae-0bf9-45f9-b6d4-2ce86facc1ce	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRkNzc1ZWFkLWY3YjgtNGM1MC1hN2IxLWNmMWQ5MGFlMTE5YiIsInVzZXJOYW1lIjoibkxFcnQiLCJ0Z0lkIjoiNzI3MDI5NzU5NSIsInJlZmVycmVkQnlJZCI6bnVsbCwiaWF0IjoxNzI0OTM1NzQ3LCJleHAiOjE3Mjc1Mjc3NDd9.b0ZTzDAvL_QVXeNLnbEGCzL6IZU23YDkeauqnyV1IJk	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	2024-08-29 11:58:57.928	2024-08-29 12:49:07.538
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, honey_latest, honey_max, balance, total_referral_profit, last_login, last_logout, level_id, referred_by_id, tg_id, is_premium, user_name, nick_name, created_at, farming_date, farming_end_date) FROM stdin;
7b85a40d-2149-44be-a888-438cc50012f7	1400	100000	1896425	130650	2024-08-29 14:10:08.782	\N	\N	\N	7296153848	t	denterukorn	Denter Ukorn	2024-08-22 12:59:12.712	2024-08-24 11:28:47.529	2024-08-24 15:28:47.529
e4418041-7cfb-492e-a3dc-0f348e86268d	0	100000	0	0	2024-08-28 11:07:23.362	\N	\N	\N	5392055220	t	lolexpress2	Druj Berlok	2024-08-24 16:24:34.61	\N	\N
aaae4527-f282-4a98-8c35-d644005b2c71	0	100000	758143.4902561596	0	2024-08-28 05:48:13.736	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3080507900297216	t	Lessie	Wendell Collier	2024-08-28 05:48:13.737	\N	\N
32b069c3-007e-49c7-84fd-1231b4a2db4a	0	100000	930591.9261832954	0	2024-08-28 05:48:12.56	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2048015588130816	t	Kaelyn	Joe Trantow	2024-08-28 05:48:12.569	\N	\N
44023214-fb54-41f8-b586-783d108dbaca	0	100000	670066.6779213585	0	2024-08-28 05:48:12.956	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1387540089143296	t	Vita	Homer Lakin	2024-08-28 05:48:12.956	\N	\N
d22a81a3-c6d1-43ea-a70d-14a4723d3a73	0	100000	86262.2428647941	0	2024-08-28 05:48:15.657	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5279929432276992	t	Maribel	Percy Lockman	2024-08-28 05:48:15.658	\N	\N
923c26fb-cbae-43e4-8e2a-700903702517	0	100000	424866.9417176163	0	2024-08-28 05:48:13.854	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	394777249972224	t	Maddison	Kelley Cremin	2024-08-28 05:48:13.854	\N	\N
5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	100000	2762300	1005000	2024-08-29 14:02:48.947	\N	\N	\N	6592538950	t	KrakenBit337	KrakenBit ADT	2024-08-21 13:27:23.767	\N	\N
f29d087c-a6fd-45ea-9fd1-8b25224cfb58	0	100000	490336.7133726599	0	2024-08-28 05:48:13.086	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3003572058849280	t	Hollie	Ella Turner	2024-08-28 05:48:13.087	\N	\N
fa3bb8cd-9908-4339-96a8-d61927544541	0	100000	529515.8596629277	0	2024-08-28 05:48:14.439	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5709522463096832	t	Jayde	Marlon Cruickshank	2024-08-28 05:48:14.44	\N	\N
35ab5d3f-c9db-40fd-a172-e7d5eedf861f	0	100000	707762.2437081765	0	2024-08-28 05:48:13.192	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	505989484773376	t	Antonia	Marianne Schmitt	2024-08-28 05:48:13.197	\N	\N
e1848ae3-8949-448b-a578-76726c5b8a59	0	100000	810492.5263526617	0	2024-08-28 05:48:13.958	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	113672730968064	t	Jarret	Richard Wolf	2024-08-28 05:48:13.958	\N	\N
c503dcb2-b7ee-4f15-b557-e25053de9313	0	100000	1008538.1739475532	0	2024-08-28 05:48:13.353	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2190483663093760	t	Immanuel	Stephanie Homenick	2024-08-28 05:48:13.354	\N	\N
e3db2078-4a85-44a4-bf97-e165be03f56d	400	100000	400	0	2024-08-24 15:52:48.183	\N	\N	\N	1058446387	f	l_Aya_I		2024-08-22 11:30:23.435	\N	\N
c442f7d2-81bd-48b2-91dc-4c64d172c548	0	100000	20000	0	2024-08-28 20:14:36.895	\N	\N	\N	1786891632	t	webshark3	Grangur	2024-08-27 18:49:33.826	\N	\N
be3f0321-d6fb-4442-8146-1eeee301be02	0	100000	690283.4570274455	0	2024-08-28 05:48:14.925	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3793180029878272	t	Ardith	Gustavo Funk	2024-08-28 05:48:14.93	\N	\N
8cbc9163-4ab0-43e6-bc37-9d092c4f8806	0	100000	451307.552060415	0	2024-08-28 05:48:13.478	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3860865658912768	t	Jacquelyn	Miriam Mante	2024-08-28 05:48:13.479	\N	\N
cd4b3dee-e183-4c19-b6e6-a9c607a482e8	0	100000	756293.8066753559	0	2024-08-28 05:48:14.055	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3202428342108160	t	Darrel	Carlton Labadie	2024-08-28 05:48:14.055	\N	\N
7c191628-7c7a-4b36-85ca-4c6eb8333aaa	400	100000	251133	0	2024-08-29 07:18:03.691	\N	\N	\N	1104225512	f	LambertsonArt	lambertson	2024-08-26 07:59:20.451	2024-08-26 09:01:20.31	2024-08-26 13:01:20.31
7a782bd7-27b9-4f47-a28f-a751d2793a8a	0	100000	776674.8544222675	0	2024-08-28 05:48:13.627	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4482320765550592	t	Jaquan	Mark Bernhard	2024-08-28 05:48:13.628	\N	\N
fc3cd5c6-17ef-4eb6-80de-4989687a35c3	2800	100000	180025	0	2024-08-29 11:27:47.583	\N	\N	\N	571043109	t	gang_ds	Gang	2024-08-22 13:08:24.738	2024-08-24 11:32:02.912	2024-08-24 15:32:02.912
aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8	0	100000	531736.0729202395	0	2024-08-28 05:48:14.598	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2682732048023552	t	Silas	Trevor Metz	2024-08-28 05:48:14.598	\N	\N
f02a6e78-e89b-4711-9071-f534ec255774	0	100000	256603.4772116691	0	2024-08-28 05:48:14.173	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2562147494133760	t	Aurore	Freda Haag	2024-08-28 05:48:14.174	\N	\N
6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1	0	100000	613010.3684870293	0	2024-08-28 05:48:15.282	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2913681488740352	t	Rosendo	Deborah Barrows	2024-08-28 05:48:15.283	\N	\N
31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e	0	100000	985349.8558921507	0	2024-08-28 05:48:14.728	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6134837022818304	t	Lilly	Blake Kub	2024-08-28 05:48:14.728	\N	\N
73297b7f-b596-4f88-9882-5741d3c5bac6	0	100000	707976.6662715003	0	2024-08-28 05:48:14.328	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3115688031944704	t	Gladys	Delbert Mayert	2024-08-28 05:48:14.329	\N	\N
27aa7650-6bf0-496c-971b-013fe6af4bbb	0	100000	676225.2118151868	0	2024-08-28 05:48:15.097	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6362179731193856	t	Ulices	Opal Leannon	2024-08-28 05:48:15.098	\N	\N
4c84519b-ac34-4171-91c3-0c664a03e2cb	0	100000	817936.2232270418	0	2024-08-28 05:48:14.821	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6793137846484992	t	Angelica	Patty Blick	2024-08-28 05:48:14.821	\N	\N
77d18071-abfc-4f46-828b-27543aa92f25	0	100000	886706.0024348786	0	2024-08-28 05:48:15.481	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4816884409040896	t	Dino	Miss Bessie Schiller-Moen	2024-08-28 05:48:15.481	\N	\N
acd9b172-5bab-4a2a-987d-5b09bcfd94cd	0	100000	745033.8994187769	0	2024-08-28 05:48:15.183	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3787329091141632	t	Rickie	Roberta Swaniawski	2024-08-28 05:48:15.184	\N	\N
4fac8997-e95e-4fc7-af66-ad553fd9666f	0	100000	565830.1325850887	0	2024-08-28 05:48:15.385	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6667914478354432	t	Dorcas	Jackie Gottlieb	2024-08-28 05:48:15.385	\N	\N
0956d132-2c95-491d-9168-76b49d248128	0	100000	374473.4704551287	0	2024-08-28 05:48:16.072	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4492642253537280	t	Magnus	Vanessa VonRueden	2024-08-28 05:48:16.073	\N	\N
8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f	0	100000	163814.5617175382	0	2024-08-28 05:48:15.796	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	651634329780224	t	Grant	Jennie Padberg	2024-08-28 05:48:15.797	\N	\N
0862236d-23aa-40ab-870f-cbd711b4cf49	0	100000	565945.3945780871	0	2024-08-28 05:48:15.94	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5587940132519936	t	Desmond	Diana Bailey	2024-08-28 05:48:15.941	\N	\N
6436b365-d1c3-418b-91fe-89ced8f83c29	0	100000	296581.6216227831	0	2024-08-28 05:48:16.158	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2221842475515904	t	Brooke	Melanie Okuneva	2024-08-28 05:48:16.159	\N	\N
420937c1-6b5c-4cfc-b5f2-f326fca9aefe	0	100000	425674.5464937761	0	2024-08-28 05:48:16.259	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3198581620080640	t	Rod	Claudia Wolff	2024-08-28 05:48:16.26	\N	\N
3179d2c4-c5ed-47ce-801c-086d926d6696	0	100000	592013.6367646512	0	2024-08-28 05:48:16.383	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	990864474112000	t	Arvid	Micheal Wolff	2024-08-28 05:48:16.384	\N	\N
d9a810df-ebbd-43b3-bed6-958e9255d059	0	100000	343665.6687403563	0	2024-08-28 05:48:16.482	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8552644712857600	t	Emile	Mr. Aaron Herzog	2024-08-28 05:48:16.483	\N	\N
93492e19-b481-49c2-a2d6-c5e3644e3b2d	0	100000	185854.6936591389	0	2024-08-28 05:48:18.381	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5727997304766464	t	Cary	Delores Franey	2024-08-28 05:48:18.382	\N	\N
de1e208f-eef0-49dd-a47c-a7316b98868a	0	100000	296732.7101076953	0	2024-08-28 05:48:16.614	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1491403704107008	t	Emerson	Omar Hartmann	2024-08-28 05:48:16.614	\N	\N
2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6	0	100000	277844.5425870595	0	2024-08-28 05:48:17.754	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3345903177957376	t	Henriette	Bennie Hudson II	2024-08-28 05:48:17.755	\N	\N
c50e0244-2708-4828-b435-a538437d7ccf	0	100000	854011.7640740937	0	2024-08-28 05:48:16.773	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5889293631356928	t	Lea	Stella Howe	2024-08-28 05:48:16.774	\N	\N
6dcf36ea-cec8-4420-97cf-f665b506fdb6	0	100000	401973.4218027443	0	2024-08-28 05:48:18.903	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3709796198907904	t	Sister	Danielle Wuckert-Mante	2024-08-28 05:48:18.904	\N	\N
b274d74f-cbb7-497a-a965-5e0b773efb43	0	100000	700312.8588843625	0	2024-08-28 05:48:16.889	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5456278516137984	t	Summer	Ms. Irma Larson Sr.	2024-08-28 05:48:16.891	\N	\N
cb580957-0a49-4957-bd17-dd73c6e5fc1d	0	100000	701056.581553584	0	2024-08-28 05:48:17.903	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7516504109088768	t	Verlie	Vickie Orn	2024-08-28 05:48:17.904	\N	\N
f937db16-7c3a-4cfb-9fd4-561aa6a0cea1	0	100000	130250.7399066351	0	2024-08-28 05:48:16.994	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2344588700286976	t	Ruby	Bonnie Kreiger	2024-08-28 05:48:16.995	\N	\N
3ae64b94-ddef-401b-b345-1cd8696fd967	0	100000	299179.3178140419	0	2024-08-28 05:48:18.478	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4388804485971968	t	Wellington	Phyllis Watsica Jr.	2024-08-28 05:48:18.48	\N	\N
6ec71334-96e8-40e6-88b5-722780e75cdb	0	100000	199721.1626440752	0	2024-08-28 05:48:17.136	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3290127902179328	t	Shakira	Garrett Sauer	2024-08-28 05:48:17.137	\N	\N
69dae976-82f2-45f8-bfc0-6bc2f9aa51bf	0	100000	974352.0417652791	0	2024-08-28 05:48:17.992	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7080422599032832	t	Waino	Doug Langosh	2024-08-28 05:48:17.993	\N	\N
694885f7-dea1-4c4c-b5d6-69997bb57ed4	0	100000	420337.2584905941	0	2024-08-28 05:48:17.249	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1710455840047104	t	Holly	Marcos Casper	2024-08-28 05:48:17.25	\N	\N
bdf20892-6c04-4799-85b5-0a7ec60d11a4	0	100000	451904.3013476301	0	2024-08-28 05:48:17.417	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4020898499657728	t	Roderick	Melba Quigley	2024-08-28 05:48:17.418	\N	\N
60d6a675-4f9f-463a-b239-9e2643aaa8a9	0	100000	504490.9522767179	0	2024-08-28 05:48:19.385	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6923925910978560	t	Monica	Faith Ritchie	2024-08-28 05:48:19.386	\N	\N
068bbdd8-214c-45c5-bbd3-31400b5775ad	0	100000	619131.9346672622	0	2024-08-28 05:48:18.104	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2519990399926272	t	Hugh	Billie Feest	2024-08-28 05:48:18.105	\N	\N
1b41e70c-950c-443d-bf3d-d57c96af8cd4	0	100000	489762.2684274334	0	2024-08-28 05:48:17.514	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	742585131859968	t	Hazel	Wendy Koch-Wiegand	2024-08-28 05:48:17.515	\N	\N
97647052-9891-4bd9-be9b-679ca79cb1d1	0	100000	945603.5936651751	0	2024-08-28 05:48:18.586	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6512559616163840	t	Conner	Mark Jenkins	2024-08-28 05:48:18.587	\N	\N
9889a17d-730f-4b7a-8389-8e4c7d0f45a5	0	100000	490281.8979483796	0	2024-08-28 05:48:17.653	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	483943140818944	t	Rhea	Dr. Aaron Reinger	2024-08-28 05:48:17.654	\N	\N
346af1cf-7bef-45e2-8fc6-9cfcdaa05300	0	100000	786551.7909715418	0	2024-08-28 05:48:18.193	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7422501011324928	t	Coleman	Dr. Randolph Jacobs Jr.	2024-08-28 05:48:18.194	\N	\N
c1cee951-d219-41cf-a647-a61d07366fe7	0	100000	966593.5546510853	0	2024-08-28 05:48:18.996	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5046912151453696	t	Stephany	Dr. Andy McClure Sr.	2024-08-28 05:48:18.996	\N	\N
13dd2b89-d11a-4289-af0e-93cd7bf3fb1a	0	100000	320043.1565763894	0	2024-08-28 05:48:18.291	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6624658944163840	t	Euna	Helen Lowe	2024-08-28 05:48:18.292	\N	\N
6173e277-f662-4720-a5a1-f34a8bb9221a	0	100000	978448.1433999026	0	2024-08-28 05:48:18.678	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2879739532410880	t	Ephraim	Peggy Howe	2024-08-28 05:48:18.679	\N	\N
0c957416-3d9d-45bd-80a4-780cb657a77b	0	100000	308700.43345585	0	2024-08-28 05:48:19.115	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2142261729034240	t	Luigi	Olga Konopelski	2024-08-28 05:48:19.115	\N	\N
b356cbf9-9aac-4203-922c-7904d844f00c	0	100000	338490.6786636915	0	2024-08-28 05:48:18.775	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5114245177933824	t	Della	Norman O'Hara	2024-08-28 05:48:18.775	\N	\N
45add737-f340-4de6-8273-a3c9b62d7e77	0	100000	294857.0300929714	0	2024-08-28 05:48:20.289	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8027770982498304	t	Jamir	Raul Hegmann	2024-08-28 05:48:20.29	\N	\N
808c6a76-ec6c-4090-af68-b7ee4c8f3630	0	100000	790695.3967152862	0	2024-08-28 05:48:19.49	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3779006243536896	t	Austen	Pearl Moen	2024-08-28 05:48:19.491	\N	\N
2162f56a-8ced-4b3d-b071-1df7dc6760c5	0	100000	569300.547675998	0	2024-08-28 05:48:19.26	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5823660883443712	t	Destany	Lindsey Goodwin	2024-08-28 05:48:19.261	\N	\N
ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f	0	100000	744668.9166104421	0	2024-08-28 05:48:19.763	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1783692187926528	t	Lincoln	Archie Lockman	2024-08-28 05:48:19.764	\N	\N
4c235c4d-1364-415e-a369-827f9aebf9a7	0	100000	309613.5155644501	0	2024-08-28 05:48:20.099	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	79055751741440	t	Golden	Jeremiah Mertz	2024-08-28 05:48:20.099	\N	\N
51be77b3-787e-4364-8765-273088974e06	0	100000	480811.4870512858	0	2024-08-28 05:48:19.652	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8398536412495872	t	Hyman	Angelo Abernathy	2024-08-28 05:48:19.653	\N	\N
5c1d9e49-c3a0-4198-8f78-654398a73090	0	100000	879017.563097761	0	2024-08-28 05:48:19.966	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5928288335691776	t	Mona	Mr. Jody Parker	2024-08-28 05:48:19.967	\N	\N
2db49b30-71d7-4b16-affa-c4ae49003071	0	100000	68110.68109236658	0	2024-08-28 05:48:19.865	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7074097219502080	t	Marisol	Garry Russel	2024-08-28 05:48:19.866	\N	\N
efa9d746-3805-4405-8b7b-191b9137f635	0	100000	307500.6379079306	0	2024-08-28 05:48:20.203	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3507739175157760	t	Heloise	Gayle Kovacek	2024-08-28 05:48:20.204	\N	\N
dd39ed92-48b8-45c2-b336-bb8e8b05013d	0	100000	1007322.1684887307	0	2024-08-28 05:48:20.372	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7006213791285248	t	Carlie	Mr. Harold Pfeffer	2024-08-28 05:48:20.372	\N	\N
901d66ce-8dd2-434b-92bc-052e6471a88c	0	100000	740990.2490496868	0	2024-08-28 05:48:20.472	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7230916812341248	t	Roderick	Emanuel D'Amore	2024-08-28 05:48:20.477	\N	\N
3c77db66-8cc1-4953-a924-d038408f309b	0	100000	105589.68085849192	0	2024-08-28 05:48:20.579	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6921474711486464	t	Reagan	Tanya Lehner	2024-08-28 05:48:20.58	\N	\N
cecebe61-8db3-44cb-b651-29619044d686	0	100000	849135.0910212146	0	2024-08-28 05:48:20.677	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1503514069041152	t	Ubaldo	Alvin Schinner	2024-08-28 05:48:20.678	\N	\N
83be342f-6be5-4728-9ec8-0aad63fcb18f	0	100000	827783.2749938592	0	2024-08-28 05:48:21.901	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6995744038846464	t	Romaine	Norma Sporer	2024-08-28 05:48:21.902	\N	\N
dc58f57a-d332-4991-8059-634d9a50df68	0	100000	175250.7423264906	0	2024-08-28 05:48:20.791	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	760571217575936	t	Sallie	Lorene Abernathy	2024-08-28 05:48:20.792	\N	\N
f690f183-cc78-44c1-b56d-98814d650919	0	100000	143638.4556869976	0	2024-08-28 05:48:20.888	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7186562389377024	t	Ricardo	Clarence Wisoky	2024-08-28 05:48:20.889	\N	\N
b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815	0	100000	21067.10613758769	0	2024-08-28 05:48:22.657	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6256141099073536	t	Kyler	Dwayne Bahringer	2024-08-28 05:48:22.658	\N	\N
4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6	0	100000	186182.971360581	0	2024-08-28 05:48:22.02	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7515199422595072	t	Agnes	Lori Brakus	2024-08-28 05:48:22.021	\N	\N
a67b6419-7eac-4a49-816e-2bfdefde7c10	0	100000	1007769.7739309166	0	2024-08-28 05:48:20.983	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1896506172899328	t	Olga	Herman McLaughlin	2024-08-28 05:48:20.984	\N	\N
a8ccaea5-750e-4025-9374-ac12553f823d	0	100000	117714.8143426282	0	2024-08-28 05:48:21.118	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7625212669460480	t	Catherine	Juana Jones	2024-08-28 05:48:21.119	\N	\N
623a9cb9-57fa-48f7-a1dc-fcd67fd076f9	0	100000	763411.4412431372	0	2024-08-28 05:48:23.277	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4939568126099456	t	Orion	Sheldon Hessel	2024-08-28 05:48:23.278	\N	\N
f39447bf-b1df-4970-89f7-a4df15c2a0c4	0	100000	371640.5072935158	0	2024-08-28 05:48:22.192	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	802459022786560	t	Ahmad	Marcos Mertz DVM	2024-08-28 05:48:22.193	\N	\N
2292c89f-3fe1-4b0d-8592-ad943a5be66c	0	100000	265457.9971675528	0	2024-08-28 05:48:21.265	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1240592621240320	t	Vita	Joel Corwin	2024-08-28 05:48:21.265	\N	\N
755575c5-5262-402d-97d2-7563d211eb9c	0	100000	449850.539067341	0	2024-08-28 05:48:21.371	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6831096832458752	t	Bertha	Terrence Rowe I	2024-08-28 05:48:21.372	\N	\N
526b8286-c88a-40e8-87ef-b94ebea9e97d	0	100000	843146.053457493	0	2024-08-28 05:48:22.792	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8134064538124288	t	Makayla	Elijah Schmitt-Jakubowski II	2024-08-28 05:48:22.793	\N	\N
730c98e5-5ace-47c0-826e-c3543c9686cb	0	100000	940845.857236674	0	2024-08-28 05:48:22.284	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2539762598543360	t	Elinore	Stewart Klocko-Zemlak MD	2024-08-28 05:48:22.285	\N	\N
8982b883-6019-4b06-8215-e28dc2a5914b	0	100000	218685.7740912121	0	2024-08-28 05:48:21.52	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7840110116601856	t	Melvin	Elsa Kautzer Sr.	2024-08-28 05:48:21.521	\N	\N
6ba47e11-ccbb-40e5-bf31-f0f22a10454b	0	100000	993555.196713563	0	2024-08-28 05:48:21.645	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8593964265373696	t	Laron	Doreen Tremblay	2024-08-28 05:48:21.646	\N	\N
c854f638-c2f6-47c3-8da5-8c688cb1f78c	0	100000	309707.4582234025	0	2024-08-28 05:48:22.349	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7693453502709760	t	Savion	Alexis Collier	2024-08-28 05:48:22.35	\N	\N
22c19b3c-f50c-4061-b6ed-e4c4c7a2093a	0	100000	244239.9608634645	0	2024-08-28 05:48:21.728	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2217121675214848	t	Deangelo	Frederick Abernathy	2024-08-28 05:48:21.729	\N	\N
49fe0add-1125-46cd-a368-f8411e43c44a	0	100000	667227.4480512133	0	2024-08-28 05:48:22.879	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5637855747506176	t	Brice	Randolph Dicki	2024-08-28 05:48:22.88	\N	\N
05ab2789-6d48-4c89-869f-abe089fccb4a	0	100000	253270.4796918435	0	2024-08-28 05:48:22.433	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7977345459683328	t	Ida	Alma Dooley-Kulas	2024-08-28 05:48:22.434	\N	\N
6c1cc459-173c-490c-9990-d222300e188b	0	100000	401885.0914308336	0	2024-08-28 05:48:23.396	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	201283732504576	t	Duncan	Dr. Jaime Roberts	2024-08-28 05:48:23.397	\N	\N
5891f499-7cc8-4d19-b3de-4b15c0624ef7	0	100000	347646.2320396444	0	2024-08-28 05:48:22.539	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8165511479164928	t	Mandy	Adrienne Thompson	2024-08-28 05:48:22.54	\N	\N
5a27a32e-f96b-4461-b54b-c5e8dd4c88cd	0	100000	237097.4966922542	0	2024-08-28 05:48:23.722	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8808033146634240	t	Valentina	Marian Brown	2024-08-28 05:48:23.723	\N	\N
6d20670c-72c5-45d5-8525-9912c5ec1058	0	100000	894816.0454256926	0	2024-08-28 05:48:22.976	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2691269534941184	t	Robin	Dr. Hugh Wolf	2024-08-28 05:48:22.977	\N	\N
c62c44fd-85cc-4edd-a070-96a4ee09bcf1	0	100000	11309.7601685673	0	2024-08-28 05:48:23.495	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5182070143844352	t	Steve	Mabel Ankunding MD	2024-08-28 05:48:23.496	\N	\N
d33ab7e2-0a7a-4266-912b-55c5f5b18241	0	100000	576752.4330836721	0	2024-08-28 05:48:23.177	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5080562519769088	t	Edythe	Leo Treutel	2024-08-28 05:48:23.178	\N	\N
c95385ce-966f-49ed-8b4e-7b162d2b0d66	0	100000	565292.9559077602	0	2024-08-28 05:55:03.461	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8401062440468480	t	Doug	Flora Stanton	2024-08-28 05:55:03.462	\N	\N
5d4f5985-c330-48e3-a1e0-23760bc73f4f	0	100000	723321.7229732312	0	2024-08-28 05:48:24.039	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2742141350576128	t	Justice	Eileen O'Keefe	2024-08-28 05:48:24.04	\N	\N
5db49be2-2435-460d-a6f4-f45b2f275436	0	100000	38927.63100520242	0	2024-08-28 05:48:23.824	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7183736286216192	t	Mike	Al Hartmann	2024-08-28 05:48:23.825	\N	\N
e64ccb49-7042-4678-9ab6-a8b8dadee65a	0	100000	372693.7978678383	0	2024-08-28 05:48:23.587	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1281168850812928	t	Edison	Valerie Wisozk MD	2024-08-28 05:48:23.588	\N	\N
a5266896-6503-4e85-a895-a82fe27c14c7	0	100000	603414.2709489446	0	2024-08-28 05:48:24.309	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8260699904016384	t	Cassidy	Pat Daniel DVM	2024-08-28 05:48:24.31	\N	\N
f1ba7109-837e-4fd7-944b-54d3b997fbfb	0	100000	648254.384998465	0	2024-08-28 05:48:23.945	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3058074369654784	t	Lennie	Shaun Cole-Cremin	2024-08-28 05:48:23.946	\N	\N
c49c5171-b397-41e5-a8cc-c3933347189f	0	100000	826885.6396536343	0	2024-08-28 05:48:24.231	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2603269610274816	t	Desmond	Francis Hegmann	2024-08-28 05:48:24.232	\N	\N
a3c59c5b-c711-415c-b371-98ffb520891a	0	100000	663209.3215171015	0	2024-08-28 05:48:24.121	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2797468043444224	t	Else	Wendy Wehner	2024-08-28 05:48:24.122	\N	\N
9100f2ae-e4cd-448b-b40b-251e0eb3572f	0	100000	206105.7783266529	0	2024-08-28 05:55:03.159	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	343057060855808	t	Kirsten	Leslie Watsica	2024-08-28 05:55:03.16	\N	\N
98dd5bf8-d2c3-411f-9fdf-57c51a150113	0	100000	220068.1564943166	0	2024-08-28 05:55:03.621	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2386813918380032	t	Brandyn	Molly West MD	2024-08-28 05:55:03.622	\N	\N
c995dc27-5dc5-44f1-ad05-6f3d0350fe17	0	100000	447086.4172750618	0	2024-08-28 05:55:03.736	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6974303234949120	t	Noble	Kent Olson V	2024-08-28 05:55:03.737	\N	\N
aef64f27-4ed3-47d5-8620-68378fb412ef	0	100000	525034.7782317316	0	2024-08-28 05:55:03.831	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8466676915896320	t	Antonetta	Kellie Corkery	2024-08-28 05:55:03.832	\N	\N
85729935-7993-4125-8562-127b29db7e60	0	100000	567177.2004396655	0	2024-08-28 05:55:03.944	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4932175082291200	t	Jaunita	Lena Stanton	2024-08-28 05:55:03.945	\N	\N
3eab8b06-c057-432d-8042-0b15ad87bdc7	0	100000	242939.8269727826	0	2024-08-28 05:55:05.689	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7032844884901888	t	Aletha	Miss Tina Batz	2024-08-28 05:55:05.69	\N	\N
1d7b25d3-d73d-4030-b1d8-5663b1b0a42a	0	100000	110563.3461139398	0	2024-08-28 05:55:04.091	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2572388063510528	t	Cloyd	Kristina Wunsch	2024-08-28 05:55:04.092	\N	\N
7165d010-24ea-45e2-994d-4597b6f7dc05	0	100000	524756.5913619939	0	2024-08-28 05:55:06.909	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	288696058249216	t	Gene	Lora Kreiger	2024-08-28 05:55:06.909	\N	\N
37d990e5-99ac-4bd1-9700-7f0efa185901	0	100000	173560.3765051812	0	2024-08-28 05:55:04.268	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4963851955077120	t	Jaclyn	Jesse Sanford	2024-08-28 05:55:04.269	\N	\N
971f7c33-1a8f-4d58-91c7-9342a9acd69a	0	100000	817706.8791087484	0	2024-08-28 05:55:05.798	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8652165224595456	t	Maia	Essie Koepp	2024-08-28 05:55:05.799	\N	\N
5eca0755-2466-4feb-851d-1e3f407260df	0	100000	746577.998894034	0	2024-08-28 05:55:04.429	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2788791697801216	t	Shania	Stephanie Hilpert III	2024-08-28 05:55:04.43	\N	\N
0582992a-1e2c-4add-863b-b5f10d6b4992	0	100000	779389.7886754014	0	2024-08-28 05:55:07.804	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4566649891979264	t	Jaylin	Brendan Olson	2024-08-28 05:55:07.805	\N	\N
a0a730cb-ef7e-4d49-a0a8-103d50af54fa	0	100000	214582.5131646357	0	2024-08-28 05:55:04.675	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2648536254513152	t	Noemi	Felix Stracke	2024-08-28 05:55:04.675	\N	\N
b7930946-5b11-41ae-9385-a05ff8b0bb77	0	100000	655528.2191039529	0	2024-08-28 05:55:05.923	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	935837963386880	t	Darion	Ben Stehr	2024-08-28 05:55:05.924	\N	\N
de0ce717-6916-4879-a04e-dbbdfadd4545	0	100000	847678.8942507468	0	2024-08-28 05:55:04.778	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3545890061025280	t	Nicolas	Mr. Jody Vandervort II	2024-08-28 05:55:04.779	\N	\N
98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413	0	100000	579421.7112525133	0	2024-08-28 05:55:07.252	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1199141929615360	t	Clovis	Renee Lakin	2024-08-28 05:55:07.253	\N	\N
e0dbe070-d1ef-4573-8391-450a4b3eaaac	0	100000	181581.9838951575	0	2024-08-28 05:55:05.009	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4278284686721024	t	Aracely	Nathaniel Kuvalis	2024-08-28 05:55:05.009	\N	\N
8b99d539-7c3e-4f23-b9e4-1012e7f2a32b	0	100000	547755.8926557191	0	2024-08-28 05:55:06.091	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3488785408983040	t	Quinn	Beth Beier	2024-08-28 05:55:06.093	\N	\N
63e30fe7-562e-4f11-9c47-09fa6e5188a7	0	100000	370594.0784833394	0	2024-08-28 05:55:05.263	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2921086438080512	t	Neva	Salvador Cronin	2024-08-28 05:55:05.264	\N	\N
8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9	0	100000	861625.8349623298	0	2024-08-28 05:55:05.494	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6015131395817472	t	Tianna	Rogelio Volkman	2024-08-28 05:55:05.495	\N	\N
1d8467cd-0105-4e3e-957c-446e325920cb	0	100000	884980.3062341409	0	2024-08-28 05:55:08.368	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	693429189214208	t	Derek	Brendan Beier	2024-08-28 05:55:08.368	\N	\N
77ea0cd2-5f7a-4a82-bcb8-bbf994c80273	0	100000	923962.9866256146	0	2024-08-28 05:55:06.289	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1378812887564288	t	Ana	Moses Walter	2024-08-28 05:55:06.29	\N	\N
8e934c6e-187f-42da-9467-6ebc7ccd08bd	0	100000	639611.639887793	0	2024-08-28 05:55:05.588	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5831186853134336	t	Travis	Miss Janet Reinger	2024-08-28 05:55:05.589	\N	\N
5e0f7570-92f8-4c39-b7d4-e89276778d25	0	100000	45027.82640096266	0	2024-08-28 05:55:07.369	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6500086114680832	t	Jade	Jesse Schneider	2024-08-28 05:55:07.369	\N	\N
a6759a4c-fc93-4995-9a6d-d30488ab7a12	0	100000	255250.9730724152	0	2024-08-28 05:55:07.978	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5291676912320512	t	Halie	Dr. Janis Torp	2024-08-28 05:55:07.979	\N	\N
e84e7f8b-1821-4957-962a-063ce11ec128	0	100000	428937.2424765024	0	2024-08-28 05:55:06.579	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7741695076597760	t	Julio	Andy Hayes	2024-08-28 05:55:06.579	\N	\N
dee1a302-1c56-4b6c-83f9-3bd8bf27323b	0	100000	934501.0213478003	0	2024-08-28 05:55:07.489	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6131819153981440	t	Chanel	Rafael Heathcote	2024-08-28 05:55:07.492	\N	\N
dc5830a1-fb20-4421-ae24-00f9be9f0f04	0	100000	972204.9637762597	0	2024-08-28 05:55:06.686	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6067146457088000	t	Freddy	Casey Schinner IV	2024-08-28 05:55:06.687	\N	\N
e045da04-0570-4317-a560-7cbfeae6f59f	0	100000	314017.9041980766	0	2024-08-28 05:55:08.115	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3400824537481216	t	Demarco	Marcus Jakubowski	2024-08-28 05:55:08.116	\N	\N
5c7b80d2-5a14-4b72-ad4e-b30749b13074	0	100000	936229.9384383718	0	2024-08-28 05:55:07.694	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8959680516718592	t	Darrel	Renee Graham	2024-08-28 05:55:07.695	\N	\N
86d277ca-6952-4753-9e13-ccdffb252b7b	0	100000	248997.9226494906	0	2024-08-28 05:55:09.358	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2381206540779520	t	Emerson	Hubert Schimmel	2024-08-28 05:55:09.359	\N	\N
ff338a1b-41d7-40fe-b370-c88ef7d387f8	0	100000	128054.4068643358	0	2024-08-28 05:55:08.529	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8643394750382080	t	Justyn	Mr. Chad Sipes	2024-08-28 05:55:08.53	\N	\N
573cd423-824d-4f62-bef0-2728da79fcaf	0	100000	843762.664239062	0	2024-08-28 05:55:08.233	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8413895842594816	t	Anibal	Angel Pouros	2024-08-28 05:55:08.233	\N	\N
542780d9-35a1-4582-86d1-d9ff5971f4ae	0	100000	570804.4469074579	0	2024-08-28 05:55:08.73	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2624247597891584	t	Willard	Shelly Smith-Ledner	2024-08-28 05:55:08.731	\N	\N
77d3e7a0-1cee-4856-9308-ae8830306caf	0	100000	90019.77205649018	0	2024-08-28 05:55:09.083	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3328551092748288	t	Kitty	Muriel Quigley	2024-08-28 05:55:09.083	\N	\N
22285a4b-a9a8-4aec-895e-5ea13125722b	0	100000	750421.2493855506	0	2024-08-28 05:55:08.637	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6771343578103808	t	Guido	Erika Stokes	2024-08-28 05:55:08.638	\N	\N
d816ad42-c674-4776-b507-f2ae86133a4c	0	100000	480260.5719459942	0	2024-08-28 05:55:08.923	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3049754896367616	t	Alvera	Ellen Dietrich	2024-08-28 05:55:08.923	\N	\N
ff807dea-119e-487b-9e10-1f7a83b4e172	0	100000	630312.5449431362	0	2024-08-28 05:55:08.833	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8707599885139968	t	Samara	Shane Bradtke	2024-08-28 05:55:08.833	\N	\N
d79cceb2-5cbb-4477-981f-491a969067b6	0	100000	670415.4887663899	0	2024-08-28 05:55:09.207	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3314962510381056	t	Josiah	Carlos Wolff	2024-08-28 05:55:09.209	\N	\N
ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6	0	100000	703052.625767421	0	2024-08-28 05:55:09.446	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4268288162922496	t	Krystina	Faith Mante	2024-08-28 05:55:09.447	\N	\N
40b38dd0-c020-4e26-bccc-14f5bfe21970	0	100000	252456.2778535066	0	2024-08-28 05:55:09.544	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	330198604054528	t	Vada	David Dickens	2024-08-28 05:55:09.544	\N	\N
85b28ae1-f517-423e-bf6f-ef189248faac	0	100000	105687.77330864687	0	2024-08-28 05:55:09.65	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2248428018991104	t	Jayson	Tracy Schuppe-Jacobs	2024-08-28 05:55:09.652	\N	\N
3986bde4-e078-452d-ae3e-fd93454b4ce2	0	100000	593552.5250799488	0	2024-08-28 05:55:09.971	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7121180238544896	t	Selina	Noel Cassin	2024-08-28 05:55:09.972	\N	\N
a2643314-2a6f-4af7-bb1f-11494179d800	0	100000	830833.125217515	0	2024-08-28 05:55:11.225	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8003492985700352	t	Kadin	Betsy Leffler	2024-08-28 05:55:11.225	\N	\N
db7f8158-f71a-4ecf-a0a6-48439a05d657	0	100000	558556.9484777516	0	2024-08-28 05:55:10.117	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6094452194017280	t	Ferne	Geoffrey Bins	2024-08-28 05:55:10.117	\N	\N
7d9c3111-4710-48a5-8e57-42e76f785f6d	0	100000	292163.7546070153	0	2024-08-28 05:55:13.66	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3862440307589120	t	Alana	Evelyn Weissnat	2024-08-28 05:55:13.66	\N	\N
e1e70295-5c37-4c51-8167-9898b9c506f2	0	100000	82388.3747132495	0	2024-08-28 05:55:10.219	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7022471668563968	t	Troy	Claude Turcotte	2024-08-28 05:55:10.22	\N	\N
d1c81fcf-526f-468c-b8f1-1de6fe5ce572	0	100000	81083.15607700497	0	2024-08-28 05:55:12.125	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2773938086084608	t	Trudie	Phyllis Senger	2024-08-28 05:55:12.126	\N	\N
9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce	0	100000	690791.3628353272	0	2024-08-28 05:55:11.355	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	888388475420672	t	Aurelia	Randall Prosacco	2024-08-28 05:55:11.356	\N	\N
37e4bdbe-f7f9-433a-a726-c9990700701f	0	100000	91304.4377605198	0	2024-08-28 05:55:10.378	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6348343846371328	t	Emilie	Mr. Carlton Dicki	2024-08-28 05:55:10.379	\N	\N
9cfbfce2-bb0f-4ac2-a5c9-e144790065a3	0	100000	28603.13836890273	0	2024-08-28 05:55:10.474	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3233950942101504	t	Wilson	Howard Ullrich	2024-08-28 05:55:10.475	\N	\N
f423e5f2-d2de-4a4b-983d-7faeee04b0b2	0	100000	791305.0775201526	0	2024-08-28 05:55:12.751	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8283869037985792	t	Jarod	Kristy Daniel	2024-08-28 05:55:12.751	\N	\N
d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372	0	100000	360630.017969897	0	2024-08-28 05:55:11.455	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6179735547674624	t	Anika	Antonio Erdman DDS	2024-08-28 05:55:11.455	\N	\N
61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec	0	100000	835215.8553167712	0	2024-08-28 05:55:10.593	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4801391159672832	t	Immanuel	Franklin Grady I	2024-08-28 05:55:10.594	\N	\N
d543f357-e99d-4d70-b7be-2a98d055c997	0	100000	297256.0841022292	0	2024-08-28 05:55:10.705	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1641698740404224	t	Laurel	Raymond Skiles V	2024-08-28 05:55:10.706	\N	\N
e1a109e1-01cc-476f-a100-046326507dc2	0	100000	145803.0968961073	0	2024-08-28 05:55:12.209	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5329613569916928	t	Reed	Cameron Christiansen	2024-08-28 05:55:12.21	\N	\N
6a7ed2ef-8b78-44ec-a3cb-b74a5380f965	0	100000	413649.0794703597	0	2024-08-28 05:55:11.537	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3803145503244288	t	Garnet	Fernando Schmidt I	2024-08-28 05:55:11.538	\N	\N
5c5f698f-3444-44bc-8055-c004d592e0f8	0	100000	903129.0510375053	0	2024-08-28 05:55:10.851	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	572166217138176	t	Jermain	Elaine Breitenberg	2024-08-28 05:55:10.857	\N	\N
2a74d774-a7c5-4b5f-839a-b1911e457bc2	0	100000	591672.6286911173	0	2024-08-28 05:55:10.958	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1296246637592576	t	Jeromy	Regina Becker	2024-08-28 05:55:10.959	\N	\N
59be1293-6788-45c2-b12c-d35d03727da2	0	100000	160322.2839202033	0	2024-08-28 05:55:11.639	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5614983880638464	t	Rene	Charlie Wisoky II	2024-08-28 05:55:11.639	\N	\N
1131c61c-771b-4a75-a014-40a4731b9efd	0	100000	832847.5365352584	0	2024-08-28 05:55:11.144	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3085298250547200	t	Bernard	Lillie Conn	2024-08-28 05:55:11.145	\N	\N
bfc42f90-715d-47dd-bc34-8a3983fd76e5	0	100000	244668.0470381165	0	2024-08-28 05:55:13.427	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3153969828331520	t	Angeline	Marta Wuckert	2024-08-28 05:55:13.427	\N	\N
1fdcbf6b-e670-46e6-a1f8-308621c26735	0	100000	823299.040186964	0	2024-08-28 05:55:12.349	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1932896784875520	t	Winston	Ronnie Jaskolski	2024-08-28 05:55:12.35	\N	\N
e11b9a8c-c94f-48b5-b192-1a769c1442a7	0	100000	154296.5105190175	0	2024-08-28 05:55:11.839	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5654791600472064	t	Gia	Patsy Ruecker	2024-08-28 05:55:11.84	\N	\N
21782926-7972-49d8-b5a4-8163dda4d8bb	0	100000	159723.9121984923	0	2024-08-28 05:55:12.968	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7605219110158336	t	Kraig	Gilberto Bode	2024-08-28 05:55:12.968	\N	\N
0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b	0	100000	649075.759864389	0	2024-08-28 05:55:11.972	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	119951195111424	t	Jude	Shawn Shanahan	2024-08-28 05:55:11.972	\N	\N
bd03e8cb-4881-43d1-aaaa-fd192db5b90f	0	100000	872002.9949093936	0	2024-08-28 05:55:12.479	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5937512514060288	t	Hallie	Cameron Lynch	2024-08-28 05:55:12.479	\N	\N
619ff42b-d080-4db1-b808-d769e69bee7f	0	100000	772727.4899182143	0	2024-08-28 05:55:13.862	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7119139529293824	t	Verner	Shelly Beier	2024-08-28 05:55:13.863	\N	\N
0c875a99-42f1-4cb4-88ed-398b1c25b9fa	0	100000	698609.0079294983	0	2024-08-28 05:55:13.171	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8179130111623168	t	Vidal	Sergio Ryan	2024-08-28 05:55:13.172	\N	\N
6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8	0	100000	965704.1804800509	0	2024-08-28 05:55:12.573	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4003037412589568	t	Travon	Essie Becker	2024-08-28 05:55:12.574	\N	\N
38922471-48a4-430b-acf7-80399379a847	0	100000	787924.9844681239	0	2024-08-28 05:55:13.554	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7753801425485824	t	Lilly	Tamara Leannon	2024-08-28 05:55:13.555	\N	\N
3ba67b11-9e37-462d-83b5-ca4defebe4ed	0	100000	547180.1465501543	0	2024-08-28 05:55:13.339	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8549339225915392	t	Ida	Gregory O'Kon	2024-08-28 05:55:13.34	\N	\N
5cdf5b4f-0b52-4adc-a49a-6145cb01c326	0	100000	259721.013381728	0	2024-08-28 05:55:13.745	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	881049968050176	t	Kelton	Ms. Lee Robel	2024-08-28 05:55:13.746	\N	\N
4dd9f659-75d6-44f8-8fae-ac963c6746ab	0	100000	958452.0887195831	0	2024-08-28 05:55:14.359	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	523906274295808	t	Meagan	Robert Klocko	2024-08-28 05:55:14.36	\N	\N
b68c623a-ffa3-4a48-a3c9-76f2f700775b	0	100000	82384.64071599301	0	2024-08-28 05:55:14.102	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5595310854242304	t	Daren	Dr. Wanda Heathcote	2024-08-28 05:55:14.103	\N	\N
c5533212-9300-4d0e-b460-5eabc1fa4a0d	0	100000	396124.9470375478	0	2024-08-28 05:55:13.98	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7344766467440640	t	Elvis	Margaret Douglas Sr.	2024-08-28 05:55:13.981	\N	\N
5cd93a3b-b144-453a-a229-2757cb28df22	0	100000	718611.4329176256	0	2024-08-28 05:55:14.257	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	768293375836160	t	Colin	Van Jones	2024-08-28 05:55:14.258	\N	\N
c357212b-e065-4c65-aaa5-7e8b8a14cfa0	0	100000	69519.6067938814	0	2024-08-28 05:55:14.447	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8411492313464832	t	Robert	Malcolm Koepp	2024-08-28 05:55:14.447	\N	\N
f3fddd33-f77a-40e4-9897-55e61230d643	0	100000	274554.2961812811	0	2024-08-28 05:55:14.698	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4808836990894080	t	Ambrose	Mrs. Lorene Stanton	2024-08-28 05:55:14.699	\N	\N
5434fac2-36e9-4ff9-9955-ba531fbb1ba0	0	100000	717726.3712701388	0	2024-08-28 05:55:14.779	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5835184402333696	t	Nigel	Eugene Rolfson I	2024-08-28 05:55:14.779	\N	\N
1c23cfd4-f4d7-49c5-8760-9600e414027e	0	100000	682143.5441538459	0	2024-08-28 05:55:14.944	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6873161305948160	t	Perry	Ed Zulauf	2024-08-28 05:55:14.945	\N	\N
815ba1e6-a405-4df4-9909-7fbc8e87a4ac	0	100000	103703.67746697739	0	2024-08-28 05:55:16.055	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1648936087453696	t	Lucinda	Marta Ryan	2024-08-28 05:55:16.056	\N	\N
31ae5186-dc5b-42c3-b676-8590c96de53a	0	100000	287130.0869792933	0	2024-08-28 05:55:15.063	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7096189577068544	t	Jackson	Ethel Lesch	2024-08-28 05:55:15.064	\N	\N
bce15c48-3692-4a64-a01c-9ae16080077d	0	100000	105265.07289947476	0	2024-08-28 05:55:17.064	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3223720426471424	t	Amely	Irene Kshlerin	2024-08-28 05:55:17.065	\N	\N
d2615292-a50f-47ff-af73-437ec1eb0fea	0	100000	880200.2433469519	0	2024-08-28 05:55:15.168	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3764610549153792	t	Francesca	Miss Kristie Adams	2024-08-28 05:55:15.169	\N	\N
473b85ee-3707-4f2e-b370-74e791f3fe1e	0	100000	933150.042562373	0	2024-08-28 05:55:16.212	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10585148227584	t	D'angelo	Christina Metz I	2024-08-28 05:55:16.212	\N	\N
9f557edb-8adf-4832-bc25-ca5b00dfcf4a	0	100000	282922.1181486035	0	2024-08-28 05:55:15.282	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7496126129242112	t	Ayden	Blake Harber	2024-08-28 05:55:15.283	\N	\N
9f19df17-a951-4493-944a-cd158fd5ca1a	0	100000	568346.1834677961	0	2024-08-28 05:59:11.488	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5032153370853376	t	Christiana	Mr. Cameron Buckridge	2024-08-28 05:59:11.489	\N	\N
8fbf163b-f453-434e-ad19-10228894ee8c	0	100000	1006380.3023108747	0	2024-08-28 05:55:15.369	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8160600555257856	t	Naomi	Timmy Rau	2024-08-28 05:55:15.37	\N	\N
5438ad6b-5a74-4d31-8122-32b3d7a2c8a2	0	100000	226328.573407745	0	2024-08-28 05:55:16.402	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2050787840622592	t	Norene	Charlie Gerlach	2024-08-28 05:55:16.403	\N	\N
d2834bcb-2154-433e-bb06-e8befbfd7368	0	100000	250556.0133815045	0	2024-08-28 05:55:15.501	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6805173372452864	t	Antonette	Tracy Volkman	2024-08-28 05:55:15.502	\N	\N
d6bec1d0-48c5-4652-8612-b4667cb1c442	0	100000	559187.2103845235	0	2024-08-28 05:55:17.134	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8423209015705600	t	Neil	Woodrow Parker I	2024-08-28 05:55:17.135	\N	\N
88421493-e09c-407b-91b7-a2bf5f633fa6	0	100000	449412.5294789439	0	2024-08-28 05:55:15.615	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7624036142022656	t	Rubye	Dr. Cornelius Rice	2024-08-28 05:55:15.616	\N	\N
e88ff86f-02ae-43ba-9060-727ec1a5558c	0	100000	152997.6568360114	0	2024-08-28 05:55:16.577	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6097691272544256	t	Maximillia	Terence Schmitt DVM	2024-08-28 05:55:16.578	\N	\N
45f32ed2-3673-4022-b0ad-e4d60362361f	0	100000	791062.2817925643	0	2024-08-28 05:55:15.703	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3210789018140672	t	Weldon	Miguel Hyatt	2024-08-28 05:55:15.704	\N	\N
a6975bcc-4113-475c-9da0-5dcb952cf919	0	100000	598369.3882922409	0	2024-08-28 05:55:15.813	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1885333719351296	t	Rod	May Weber	2024-08-28 05:55:15.814	\N	\N
8749fd89-444e-4786-b0cc-6fed521bdc27	0	100000	798432.9926281702	0	2024-08-28 05:59:12.096	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4815098231128064	t	Shayna	Kathryn Bahringer-Labadie	2024-08-28 05:59:12.097	\N	\N
0e562d45-0328-4a97-939d-cd11bb7f2ed2	0	100000	881733.3149703452	0	2024-08-28 05:55:16.72	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5800105915449344	t	Toby	Glen Moen	2024-08-28 05:55:16.721	\N	\N
eb838509-93c4-4e2a-a8c3-3bffd2acc82c	0	100000	392993.2105497224	0	2024-08-28 05:55:15.914	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7573981137731584	t	Vidal	Toby Hyatt	2024-08-28 05:55:15.915	\N	\N
c8434922-ec69-4e01-beef-8cfb6ad0f92b	0	100000	475821.3539343793	0	2024-08-28 05:59:10.913	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8099029896396800	t	Nyasia	Yvette Reilly	2024-08-28 05:59:10.917	\N	\N
f968fe68-30ae-42d2-9e74-08bf8e223215	0	100000	159526.0718050413	0	2024-08-28 05:59:11.681	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	224408702550016	t	Kelvin	Camille O'Hara	2024-08-28 05:59:11.682	\N	\N
6e4e0e64-47ea-44c0-a997-25766e1a85c1	0	100000	555653.4258284839	0	2024-08-28 05:55:16.86	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5929163114414080	t	Buddy	Lora Rohan	2024-08-28 05:55:16.861	\N	\N
cebdc43a-6173-4d07-99df-6ffabe415516	0	100000	369082.8046131181	0	2024-08-28 05:59:11.215	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3635606949199872	t	Lonie	Damon Parker	2024-08-28 05:59:11.216	\N	\N
6ef284cd-4c54-42c0-99a0-619cb8442030	0	100000	539979.5582964551	0	2024-08-28 05:55:16.96	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6182432476758016	t	Leonard	Miss Antoinette Ortiz	2024-08-28 05:55:16.961	\N	\N
380bb01d-d981-4caa-b479-6089a516a075	0	100000	984997.3154732026	0	2024-08-28 05:59:11.814	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7642755736010752	t	Lemuel	Nicole Casper	2024-08-28 05:59:11.815	\N	\N
949c4f91-4f71-4751-8c96-4113f5c1672f	0	100000	185501.5227978583	0	2024-08-28 05:59:11.33	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2618226028576768	t	Verdie	Caroline Langosh	2024-08-28 05:59:11.331	\N	\N
ffb1879e-5a8e-46a4-80ec-fe36bd67e584	0	100000	234656.0261131264	0	2024-08-28 11:42:07.212	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	10954492346368	t	Pattie	Rochelle Marvin	2024-08-28 11:42:07.213	\N	\N
3ecb5f1f-0418-41cd-af4e-93a4f558c522	0	100000	629872.0680623315	0	2024-08-28 05:59:12.211	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7980630495199232	t	Jack	Benny Effertz	2024-08-28 05:59:12.212	\N	\N
70ecb7d4-c0fb-4e26-8471-d06e7a5afd94	0	100000	959550.2182243625	0	2024-08-28 05:59:11.973	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8193852189966336	t	Christine	Justin Harvey-Rowe	2024-08-28 05:59:11.974	\N	\N
c2b5d09f-ff81-4c50-b1c9-a6c46f12df90	0	100000	15738.113293470815	0	2024-08-28 11:33:56.378	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2230454379872256	t	Dexter	Laurie Roberts V	2024-08-28 11:33:56.38	\N	\N
759b3797-b95e-4abc-a83f-c37bd6aa090c	0	100000	202316.9686723733	0	2024-08-28 11:40:20.766	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8339173949833216	t	Hortense	Sam Schoen	2024-08-28 11:40:20.768	\N	\N
7170f559-0812-46be-9851-f1142c91d14c	0	100000	74204.4477456715	0	2024-08-28 05:59:12.325	\N	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8701350233767936	t	Beau	Eugene Hayes	2024-08-28 05:59:12.326	\N	\N
5566b584-2023-42f9-b25c-04d15223cd5b	0	100000	804323.2944949996	0	2024-08-28 11:37:10.043	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2896712232337408	t	Gaetano	Sabrina Bechtelar Jr.	2024-08-28 11:37:10.046	\N	\N
21bc0cfa-c69b-454d-9c5b-4261dea59a6d	0	100000	632070.7210299792	0	2024-08-28 11:36:39.712	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	906640664559616	t	Kaitlin	Lloyd Mante Sr.	2024-08-28 11:36:39.713	\N	\N
1203d0f1-1816-4998-93f0-bdb05c314cd4	0	100000	505869.3017579149	0	2024-08-28 11:40:21.191	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	645675578556416	t	Herta	Leonard Jast	2024-08-28 11:40:21.192	\N	\N
5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c	0	100000	784437.6545256237	0	2024-08-28 11:42:07.457	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4397721083445248	t	Gregorio	Bernard Pollich	2024-08-28 11:42:07.458	\N	\N
d04cb17e-fd2c-4727-acd1-76bad464dd01	0	100000	581171.6310591204	0	2024-08-28 11:42:16.817	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	318289278402560	t	Isaiah	Brett Brown	2024-08-28 11:42:16.818	\N	\N
5cb277d0-f9a3-4de9-9041-470811eeb375	0	100000	876055.3485488519	0	2024-08-28 11:42:17.018	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2587927936761856	t	Gunner	Kenny Kirlin	2024-08-28 11:42:17.019	\N	\N
951ff7cd-7830-4e5a-9e21-eb7b0eca63a6	0	100000	543175.3021415789	0	2024-08-28 11:43:12.122	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	799286952460288	t	Marcelino	Kristi Terry	2024-08-28 11:43:12.123	\N	\N
95f8b881-4861-4f7f-a209-5e6cf25b8d78	0	100000	911940.883202944	0	2024-08-28 12:13:32.651	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1063914987061248	t	Daryl	Chelsea Renner	2024-08-28 12:13:32.652	\N	\N
57734c90-01d3-4f4e-828c-1201f65e42bf	0	100000	441339.6206589881	0	2024-08-28 11:43:12.425	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3426030867972096	t	Dejuan	Lynn Larson IV	2024-08-28 11:43:12.426	\N	\N
145ff272-c8be-4461-b4aa-1a161a921aa8	0	100000	495805.7470611995	0	2024-08-28 11:58:08.73	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2151800136269824	t	Salvatore	Ramiro Ratke	2024-08-28 11:58:08.732	\N	\N
4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad	0	100000	947335.5721725384	0	2024-08-28 11:43:23.247	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5748139841552384	t	Lea	Clinton Leannon	2024-08-28 11:43:23.248	\N	\N
31765d40-d378-420c-a0b4-ca49e7ea59f7	0	100000	947776.1598696467	0	2024-08-28 11:43:23.499	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1872560226566144	t	Mateo	Sadie Stokes	2024-08-28 11:43:23.5	\N	\N
237b4a46-2822-46cd-b0ac-c82739829a00	0	100000	219154.087515315	0	2024-08-28 12:13:34.654	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4764048237264896	t	Lonny	Pat Wehner	2024-08-28 12:13:34.655	\N	\N
bc505c03-f9ae-4e0f-99d5-a29a56830b15	0	100000	771114.6065770416	0	2024-08-28 11:58:08.933	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3812653946372096	t	Molly	Edwin Stokes	2024-08-28 11:58:08.934	\N	\N
d62f5ea4-de23-4db9-afb5-db9334809de1	0	100000	538878.0474975705	0	2024-08-28 12:13:32.772	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5076643043344384	t	Fanny	Ethel Sipes IV	2024-08-28 12:13:32.773	\N	\N
98431e33-b96a-4c71-a52d-07883fe7e945	0	100000	823112.3864199966	0	2024-08-28 12:13:33.457	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5978516646526976	t	Lizzie	Travis Schuppe-Ritchie	2024-08-28 12:13:33.459	\N	\N
3bf937ce-d0c5-43bd-9119-f8590a8d574c	0	100000	1003876.3616014505	0	2024-08-28 12:13:32.849	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4516014408597504	t	Pamela	Stacey Carter	2024-08-28 12:13:32.85	\N	\N
7e5114fc-def2-4929-91d0-7ca9dc68b2ff	0	100000	768938.8290278381	0	2024-08-28 12:13:32.086	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	898241839235072	t	Thelma	Miss Miriam Kuhn	2024-08-28 12:13:32.087	\N	\N
1caaf02e-4ee5-4c2b-b520-5846341805ef	0	100000	558947.8306393372	0	2024-08-28 12:13:33.931	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1031360565215232	t	Cecilia	Erin Bogan	2024-08-28 12:13:33.931	\N	\N
2f0dee24-3f81-4ccf-8244-d6488d087f1f	0	100000	395808.0696797464	0	2024-08-28 11:58:07.884	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	83228828368896	t	Tiara	Devin Schuppe	2024-08-28 11:58:07.885	\N	\N
1e65b0bb-703b-455e-a307-7f82464055e8	0	100000	737645.4391171923	0	2024-08-28 12:13:32.281	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	6991498352525312	t	Christy	Gertrude Murphy	2024-08-28 12:13:32.282	\N	\N
b6c3d582-e6cc-4814-a38f-7df873654608	0	100000	797372.78045821	0	2024-08-28 11:58:08.268	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5045777804034048	t	Abagail	Marguerite Hyatt	2024-08-28 11:58:08.269	\N	\N
616544be-8229-4e20-b1ec-3a286664cef5	0	100000	658462.7558841836	0	2024-08-28 12:13:33.055	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5382506259939328	t	Gloria	Edward Wiegand	2024-08-28 12:13:33.055	\N	\N
53d6dbf5-e190-4641-95a1-d734632637da	0	100000	700735.4105296312	0	2024-08-28 11:58:08.433	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5171437071499264	t	Xavier	Melanie Schulist	2024-08-28 11:58:08.434	\N	\N
e999b8ec-ee7a-4889-bec9-9afc50e88dce	0	100000	566432.0311055053	0	2024-08-28 12:13:32.448	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	696516161306624	t	Mariah	Dianne Auer	2024-08-28 12:13:32.448	\N	\N
d19c8610-487a-48fc-87a1-9de1b1b9cb83	0	100000	200749.4136227295	0	2024-08-28 11:58:08.572	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3682347182456832	t	Mackenzie	Ms. Marie Yost	2024-08-28 11:58:08.573	\N	\N
9eca8ffd-2cf1-4293-af11-ed381f31d2d9	0	100000	932707.6238353737	0	2024-08-28 12:13:33.554	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2003418746978304	t	Tony	Alton Schaefer	2024-08-28 12:13:33.554	\N	\N
afdb12fc-0625-4fbd-a92d-a1d8300d5fb9	0	100000	896279.4673725963	0	2024-08-28 12:13:32.543	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1012677872713728	t	Consuelo	Alexandra Emard	2024-08-28 12:13:32.544	\N	\N
e46a8c26-7345-4fed-b81f-2f3ebe9f3864	0	100000	404432.6916686259	0	2024-08-28 12:13:33.194	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3546504625127424	t	Missouri	Lana Kautzer	2024-08-28 12:13:33.195	\N	\N
9bf4aae9-77f7-485c-8cc1-eb54d94df3c8	0	100000	778417.3527958337	0	2024-08-28 12:13:34.43	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4274633641558016	t	Frank	Lydia Rempel	2024-08-28 12:13:34.431	\N	\N
77d3d92a-1bc8-4648-b22d-401a09d08ab5	0	100000	276223.0751728872	0	2024-08-28 12:13:33.656	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8211344595615744	t	Everette	Janet Labadie-Harvey	2024-08-28 12:13:33.657	\N	\N
1cb6a9e2-f9ba-412f-a284-23e6657ef879	0	100000	444730.2694295533	0	2024-08-28 12:13:33.343	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8194957317767168	t	Cooper	Mrs. Jennie Kuhlman	2024-08-28 12:13:33.344	\N	\N
7d633720-08f4-443c-942d-8da74df41a97	0	100000	367848.2155395439	0	2024-08-28 12:13:34.189	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7685147902083072	t	Marjolaine	Hector Windler	2024-08-28 12:13:34.189	\N	\N
182027a1-551c-4601-9b84-497348f94e1c	0	100000	412307.4162386591	0	2024-08-28 12:13:33.801	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1839529075933184	t	Ford	Dominic Stehr	2024-08-28 12:13:33.802	\N	\N
a080de1e-d906-40a2-9bb6-c3e7528d2b87	0	100000	230724.4408263592	0	2024-08-28 12:13:35.123	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1941998908997632	t	Bernhard	Ms. Jenny Thiel	2024-08-28 12:13:35.124	\N	\N
bf1a2431-a918-4a36-8334-ab6545e430f7	0	100000	681484.0069542872	0	2024-08-28 12:13:34.296	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8764351922044928	t	Isabel	Derek Macejkovic	2024-08-28 12:13:34.297	\N	\N
c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c	0	100000	494024.7200006852	0	2024-08-28 12:13:34.53	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	6300281159548928	t	Charlene	Bryant Goodwin	2024-08-28 12:13:34.53	\N	\N
5e30ec44-bf17-4518-b5c0-2c1d552a9777	0	100000	77025.73864464648	0	2024-08-28 12:13:35.01	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7231411645841408	t	Heather	Gabriel Jenkins	2024-08-28 12:13:35.011	\N	\N
ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f	0	100000	981930.011448916	0	2024-08-28 12:13:34.862	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5625205506441216	t	Murl	Alma Littel	2024-08-28 12:13:34.863	\N	\N
51f92be1-4f22-406b-816a-637ac9c1f180	0	100000	373749.7487318702	0	2024-08-28 12:13:34.778	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7434411949686784	t	Max	Ricky Kirlin	2024-08-28 12:13:34.779	\N	\N
96f14723-7249-4338-a06a-3b6bbb2ca242	6100	100000	125000	0	2024-08-29 11:58:57.976	\N	\N	\N	7440606503	f	gg_pavel_gg	Pavel	2024-08-28 11:48:02.875	\N	\N
20bc764d-59d8-492a-b1e0-3d9814ad034e	0	100000	14695.246435911395	0	2024-08-28 12:24:45.158	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2551769102024704	t	Dee	Bruce Kutch	2024-08-28 12:24:45.16	\N	\N
188e2d5e-977a-4730-a383-0cf6431ec5fe	0	100000	402617.0270633884	0	2024-08-28 12:24:45.457	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8332839151992832	t	Emelie	Lynn O'Conner	2024-08-28 12:24:45.458	\N	\N
6ae32738-74e8-4c49-91cb-e39f7e5df371	0	100000	822611.2485548947	0	2024-08-28 12:24:45.686	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	6192430418231296	t	Alejandrin	Henrietta Trantow III	2024-08-28 12:24:45.686	\N	\N
1e968ba6-7a32-4112-891d-a59c12be57c3	0	100000	365838.6761814356	0	2024-08-28 12:24:45.802	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	190699672698880	t	Amiya	Mrs. Chelsea Fadel	2024-08-28 12:24:45.803	\N	\N
03c031d5-def4-4c9f-9c43-ead660b2ecd8	0	100000	342200.8648489602	0	2024-08-28 12:24:47.481	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4815719095074816	t	Lavern	Christopher Greenfelder	2024-08-28 12:24:47.482	\N	\N
150bc895-b1c4-48b6-8acc-513947236dd1	0	100000	972589.7785124136	0	2024-08-28 12:24:45.957	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1041616567533568	t	Hillard	Ms. Kristin Ortiz	2024-08-28 12:24:45.958	\N	\N
04a2a76c-44ff-46d3-8155-1348edf1828b	0	100000	24111.547547834933	0	2024-08-28 12:26:19.946	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3383142998081536	t	Scarlett	Stewart Johnston	2024-08-28 12:26:19.947	\N	\N
eff4d266-7f89-49e1-a67c-29c28ccd7b9f	0	100000	862051.7972354311	0	2024-08-28 12:24:46.206	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5840552247427072	t	Jakob	Mr. Joshua Feil	2024-08-28 12:24:46.207	\N	\N
c9ccd729-0b35-4fbd-8f52-20014506fa20	0	100000	58593.55041414965	0	2024-08-28 12:24:48.557	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7153684391657472	t	Kelly	Everett Hegmann	2024-08-28 12:24:48.557	\N	\N
85b9217e-e690-4560-862d-523b8ddf7390	0	100000	403385.7928203885	0	2024-08-28 12:24:47.666	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1761004253872128	t	Mya	Tracy Bahringer	2024-08-28 12:24:47.667	\N	\N
a2d36b74-93b8-4b1f-b1c2-c1a9832708b2	0	100000	863816.0954574356	0	2024-08-28 12:24:46.328	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	6144771787587584	t	Verda	Esther Johns V	2024-08-28 12:24:46.329	\N	\N
2bd87bc9-bbe0-4a68-b661-67cfc55995b0	0	100000	843628.480362217	0	2024-08-28 12:24:46.44	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8914385865015296	t	Christop	Camille Torphy	2024-08-28 12:24:46.441	\N	\N
4e6759e0-6ce9-4277-bff6-d6033bb6f479	0	100000	793509.79279147	0	2024-08-28 12:26:19.024	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8405140140720128	t	Evalyn	Mathew Rogahn	2024-08-28 12:26:19.025	\N	\N
3c5d9bb9-923d-4745-a499-06d2421d8b06	0	100000	168624.4630585192	0	2024-08-28 12:24:47.782	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3919201502756864	t	Gunnar	Kendra Daniel	2024-08-28 12:24:47.783	\N	\N
e1f5d089-9099-4909-805c-7ddbdd74e0a3	0	100000	371604.3388075894	0	2024-08-28 12:24:46.807	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3833634836447232	t	Jane	Chris Bartoletti	2024-08-28 12:24:46.808	\N	\N
1532bb49-0e32-4841-8531-eb9f7d831abf	0	100000	96133.56293649413	0	2024-08-28 12:24:46.952	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4495441200676864	t	Velma	Maria Hettinger	2024-08-28 12:24:46.953	\N	\N
199da7e4-25bf-47ff-9e51-b5c412af57c9	0	100000	498780.5955999531	0	2024-08-28 12:24:48.706	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4115907517349888	t	Jeanette	Joan Jaskolski	2024-08-28 12:24:48.707	\N	\N
642a9f33-4469-4b32-b68f-cb043424e73f	0	100000	667314.0330663417	0	2024-08-28 12:24:47.937	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5656342152871936	t	Sonia	Faith Grant	2024-08-28 12:24:47.938	\N	\N
a18c5901-3cba-4f12-913a-2f901f7eda55	0	100000	189177.0900629926	0	2024-08-28 12:24:47.081	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4566096772333568	t	Earline	Tomas Nikolaus	2024-08-28 12:24:47.082	\N	\N
58038a40-5a0c-4a1d-af06-f0d4c4a70b9a	0	100000	727679.2530725477	0	2024-08-28 12:24:47.255	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5108437828501504	t	Jermey	Julio Renner	2024-08-28 12:24:47.256	\N	\N
ba12359e-af2d-44ae-b25e-9430f2d3fdc7	0	100000	92864.6267852746	0	2024-08-28 12:24:48.087	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3638502025592832	t	Jamey	Hattie Daniel	2024-08-28 12:24:48.088	\N	\N
7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd	0	100000	271722.08265936933	0	2024-08-28 12:24:47.34	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4315609407946752	t	Garnett	Patsy Prosacco	2024-08-28 12:24:47.342	\N	\N
02926a21-64dc-477e-880c-cd6b5eb3394f	0	100000	898299.5717615355	0	2024-08-28 12:26:19.688	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2430229287010304	t	Axel	Rebecca O'Connell	2024-08-28 12:26:19.689	\N	\N
fd5550aa-da2e-42af-a466-67e2c59fe268	0	100000	275761.7347948486	0	2024-08-28 12:24:48.813	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3161303176708096	t	Okey	Shannon Schultz	2024-08-28 12:24:48.814	\N	\N
e6286cf3-32ef-43d2-927c-c8c62b50d95c	0	100000	26649.09213730134	0	2024-08-28 12:24:48.244	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2047639180804096	t	Damion	Ms. Sandra Feeney	2024-08-28 12:24:48.244	\N	\N
bda3c9ab-385f-461e-a1cd-37a52d5335c8	0	100000	929687.7591997618	0	2024-08-28 12:26:19.244	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3636830247321600	t	Lavern	Tricia Effertz	2024-08-28 12:26:19.245	\N	\N
3054bbb2-244c-4974-b7e7-c29dac8b1dc3	0	100000	629417.4055306241	0	2024-08-28 12:24:48.432	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1590025437315072	t	Prince	Russell Sanford	2024-08-28 12:24:48.433	\N	\N
f8f489c5-baee-42a7-a22f-ceda8b8d760f	0	100000	590570.3328658128	0	2024-08-28 12:24:49.1	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4632076548571136	t	Mohammed	Maria Ruecker	2024-08-28 12:24:49.101	\N	\N
eb7c53fc-10e1-47f5-a6e7-fae2be8896ea	0	100000	766914.526190958	0	2024-08-28 12:26:20.2	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2157815862919168	t	Faustino	Alice Green	2024-08-28 12:26:20.2	\N	\N
f868438a-b76e-46b3-abaa-f4405a63d0ff	0	100000	557266.5261461167	0	2024-08-28 12:26:19.358	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2715499729256448	t	Tad	Julius Bosco	2024-08-28 12:26:19.359	\N	\N
a7f7e5ef-f3af-4ba4-b048-701b6582821f	0	100000	40076.57374292612	0	2024-08-28 12:26:19.808	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	4819552678445056	t	Onie	Rosalie Jaskolski	2024-08-28 12:26:19.809	\N	\N
5f4a33a0-6d96-44ab-8d8c-24a62013003f	0	100000	786769.9014362646	0	2024-08-28 12:26:19.536	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	92750080901120	t	Amber	Marion Reichel IV	2024-08-28 12:26:19.537	\N	\N
7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8	0	100000	87203.41387987137	0	2024-08-28 12:26:20.075	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8975833584631808	t	Caterina	Jo Kessler	2024-08-28 12:26:20.076	\N	\N
c124d5e0-2509-43fa-8e0c-f07a9db962ed	0	100000	402610.8446311206	0	2024-08-28 12:26:20.761	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7805558084075520	t	Otha	Erica Crooks V	2024-08-28 12:26:20.762	\N	\N
6305399c-c89c-4fb4-8570-42465bd1b79f	0	100000	540985.0248843431	0	2024-08-28 12:26:20.432	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	168359610023936	t	Terrill	Tracy Bailey	2024-08-28 12:26:20.433	\N	\N
b4085128-2dc7-4ed5-9332-959dce9b0cbf	0	100000	656816.168788611	0	2024-08-28 12:26:20.335	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1005702686441472	t	Zachary	Cody Sipes	2024-08-28 12:26:20.336	\N	\N
45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8	0	100000	885864.410577761	0	2024-08-28 12:26:20.571	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	787731517014016	t	Clyde	Maureen Block	2024-08-28 12:26:20.572	\N	\N
c0982b02-cecb-4f73-adb0-327258fe2f8a	0	100000	320016.9152291259	0	2024-08-28 12:26:20.917	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	236112427614208	t	Shyann	Miss Margarita Collier	2024-08-28 12:26:20.917	\N	\N
2ae81c67-7c65-407f-862c-dc6877f856e0	0	100000	936010.101008648	0	2024-08-28 12:26:21.024	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3902748514844672	t	Chasity	Wm VonRueden	2024-08-28 12:26:21.025	\N	\N
e4cc5b33-8083-410e-b92e-60b818343a90	0	100000	437991.7642093729	0	2024-08-28 12:26:21.157	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	2662187147460608	t	Viola	Cesar Senger	2024-08-28 12:26:21.158	\N	\N
b97773e6-a871-4572-bac1-7a6637f059cb	0	100000	658526.8323852681	0	2024-08-28 12:26:21.321	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	6756236332630016	t	Ludie	Leo Kertzmann	2024-08-28 12:26:21.322	\N	\N
a4f0921c-5929-49f3-a2d1-3f0048849db6	0	100000	614648.9400251769	0	2024-08-28 12:26:18.645	\N	\N	r	8644678851231744	t	Elfrieda	Cindy Greenfelder	2024-08-28 12:26:18.647	\N	\N
3c305397-9f6c-4189-aa05-f48fc6d4c02c	0	100000	341791.2761503365	0	2024-08-28 12:26:21.447	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7432034066628608	t	Corine	Tricia Hills	2024-08-28 12:26:21.448	\N	\N
fc057676-e528-4fcb-a729-4f4eb9ee5e5b	0	100000	446512.520823977	0	2024-08-28 12:26:21.636	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5568090511245312	t	Tiana	Pat Langworth-Stracke	2024-08-28 12:26:21.637	\N	\N
38f81c95-5586-40dc-be11-7117fcd90f9f	0	100000	906561.5876724245	0	2024-08-28 12:26:21.745	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	3304602753564672	t	Madelyn	Lynn Green	2024-08-28 12:26:21.746	\N	\N
fa3b4cdc-b7a2-4595-a7e4-ef474d129883	0	100000	262739.3212345196	0	2024-08-28 12:26:21.9	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	5200670946754560	t	Anabel	Daisy Schmeler	2024-08-28 12:26:21.901	\N	\N
c3d9b51f-dfea-40f0-a0d2-7f87737824c3	200	100000	200	0	2024-08-28 19:40:10.241	\N	\N	\N	7454104760	f		lam	2024-08-28 19:38:20.478	\N	\N
adcd3d8a-71e5-4bea-880c-ea9f7284a724	0	100000	610097.3512551747	0	2024-08-28 12:26:22.011	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8156950095200256	t	Nelda	Wilma Bode DDS	2024-08-28 12:26:22.012	\N	\N
9356b60b-8ca4-459e-8347-04943b40dae5	0	100000	898618.869617465	0	2024-08-28 12:26:22.263	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	8281953010712576	t	Claud	Betsy Terry	2024-08-28 12:26:22.264	\N	\N
98b12365-5eed-4f3b-b615-ab87f317c2fd	0	100000	509611.6030201549	0	2024-08-28 12:26:22.456	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1134677421195264	t	Sienna	Erica Lueilwitz	2024-08-28 12:26:22.457	\N	\N
feaeaa90-81a5-4098-b44e-d39b0d059cf9	0	100000	314398.0665119365	0	2024-08-28 12:26:22.618	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	7462828686442496	t	Precious	Vivian Hirthe	2024-08-28 12:26:22.619	\N	\N
a9ad51d1-99d6-4e58-b712-cfbaf6ea5a5b	0	100000	0	0	2024-08-28 20:20:52.812	\N	\N	\N	5444544841	f	krew_stud	Krew Inside	2024-08-28 20:19:47.142	\N	\N
c7437b7a-8e9d-4fd9-a56d-05973ac990df	0	100000	953084.8458589287	0	2024-08-28 12:28:09.894	\N	\N	7b85a40d-2149-44be-a888-438cc50012f7	1641139356565504	t	Wilford	Heidi Haley	2024-08-28 12:28:09.896	\N	\N
dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	50000	100000	175000	0	2024-08-29 12:49:07.54	\N	\N	\N	7270297595	f	nLErt		2024-08-29 11:58:57.92	\N	\N
dd015ecf-9c62-421e-9e5e-91205ad2126a	0	100000	0	0	2024-08-29 13:05:57.001	\N	\N	\N	99281932	t	rogue	Andrew Rogue	2024-08-29 12:05:26.662	\N	\N
\.


--
-- Data for Name: players_orcs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_orcs (id, player_id, "bossStreak", last_boss_date, hp) FROM stdin;
f97bc6fe-d8b7-4316-ac7d-09b85fc641b5	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	\N	97900
0b84b7ab-8182-4d95-a93c-8feccc3d51f9	d22a81a3-c6d1-43ea-a70d-14a4723d3a73	0	\N	100000
7c643bf9-798c-4cdd-a608-40fed9f4941f	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f	0	\N	100000
45687834-ca11-4e35-afc2-ba088ea88be5	0862236d-23aa-40ab-870f-cbd711b4cf49	0	\N	100000
954fcb05-d68e-4f86-8d3f-b15b0f0db517	96f14723-7249-4338-a06a-3b6bbb2ca242	1	2024-08-29 10:40:06.07	0
451e7b0d-15a6-4b5a-8225-30c42a559374	dd015ecf-9c62-421e-9e5e-91205ad2126a	0	\N	100000
57fc1f0d-d964-45eb-be8c-568cdf5d3f3f	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	1	2024-08-28 12:25:00.045	100000
980e4320-6910-4edb-bedb-1671cbf1ebc5	949c4f91-4f71-4751-8c96-4113f5c1672f	0	\N	100000
b81186b5-af82-44b3-8a21-f679936736ca	7b85a40d-2149-44be-a888-438cc50012f7	3	2024-08-29 13:56:30.018	0
b71f180f-7638-4402-95a0-2cfd83cdccd8	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3	2024-08-29 13:59:36.013	0
386b0fe4-07ab-463b-82d3-ddf1a67c57f9	642a9f33-4469-4b32-b68f-cb043424e73f	0	\N	100000
33c84882-ff56-4c8d-b8ce-2eda1669bf50	0956d132-2c95-491d-9168-76b49d248128	0	\N	100000
e9a17cbd-8cc5-4520-a9c8-fc8f139cc53f	6436b365-d1c3-418b-91fe-89ced8f83c29	0	\N	100000
70d77e9d-7a97-4d14-a3e5-4f4b418ad6d8	420937c1-6b5c-4cfc-b5f2-f326fca9aefe	0	\N	100000
7f1bdf92-3321-4f46-8007-15386a331a2d	3179d2c4-c5ed-47ce-801c-086d926d6696	0	\N	100000
9b7b0cc3-398f-46eb-aea5-9c2bc5804d90	d9a810df-ebbd-43b3-bed6-958e9255d059	0	\N	100000
128c258f-4a91-4288-bc17-c61d41d2d300	de1e208f-eef0-49dd-a47c-a7316b98868a	0	\N	100000
ff0ff145-afc1-4def-9f47-8be446100fbb	c50e0244-2708-4828-b435-a538437d7ccf	0	\N	100000
e6c31673-5ca6-4443-9e01-f1cadd131eff	b274d74f-cbb7-497a-a965-5e0b773efb43	0	\N	100000
e8dc3139-a0a0-49e7-a2ab-7161dcea14dc	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1	0	\N	100000
467bd75b-cfe2-4e31-a043-2f867e7a467a	6ec71334-96e8-40e6-88b5-722780e75cdb	0	\N	100000
a7d51587-e207-418c-a5f4-9534c047713a	694885f7-dea1-4c4c-b5d6-69997bb57ed4	0	\N	100000
893d3548-2e35-4a01-8b0c-24ed564f3830	bdf20892-6c04-4799-85b5-0a7ec60d11a4	0	\N	100000
73c566af-1f1d-4d24-8821-a667643b7931	1b41e70c-950c-443d-bf3d-d57c96af8cd4	0	\N	100000
a4de8a8a-b84f-4356-b8fa-0ed67a1203a8	9889a17d-730f-4b7a-8389-8e4c7d0f45a5	0	\N	100000
2d8e2e85-5323-4cb1-88b7-19f387f544d2	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6	0	\N	100000
6842452e-745d-4aa2-8d04-f9068128744f	cb580957-0a49-4957-bd17-dd73c6e5fc1d	0	\N	100000
3f8498cc-8c58-42f3-82aa-8bd461a40574	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	0	\N	100000
3d7f33eb-c586-409d-9f9e-7ee99d9594ce	c442f7d2-81bd-48b2-91dc-4c64d172c548	0	\N	100000
9e2e9159-a4bd-4bc9-aff6-dd6ebd63bd49	32b069c3-007e-49c7-84fd-1231b4a2db4a	0	\N	100000
334169ba-3d22-439f-9217-da2e9f538647	44023214-fb54-41f8-b586-783d108dbaca	0	\N	100000
82c47fd7-01ab-416a-a185-1a8921ed2512	f29d087c-a6fd-45ea-9fd1-8b25224cfb58	0	\N	100000
3b39cbc1-b0e2-4339-8b3d-a1de8f0ebdc9	ba12359e-af2d-44ae-b25e-9430f2d3fdc7	0	\N	100000
0d09ffd0-c2ee-4ba1-870a-e1e1cc4bf961	e6286cf3-32ef-43d2-927c-c8c62b50d95c	0	\N	100000
a5068ba9-e7ad-4259-b862-921ed3d5e138	3054bbb2-244c-4974-b7e7-c29dac8b1dc3	0	\N	100000
9ecb0644-eb96-4752-919a-7a78b6b24191	c9ccd729-0b35-4fbd-8f52-20014506fa20	0	\N	100000
92ee9bb6-9837-4907-9682-bca88efd0bf7	199da7e4-25bf-47ff-9e51-b5c412af57c9	0	\N	100000
0a22e599-127f-4011-8036-1604a0193f64	fd5550aa-da2e-42af-a466-67e2c59fe268	0	\N	100000
e9fa9a2b-743a-4daf-ae7e-5c34403747f1	35ab5d3f-c9db-40fd-a172-e7d5eedf861f	0	\N	100000
4339455c-9d70-4966-9474-347a5b77d9c7	c503dcb2-b7ee-4f15-b557-e25053de9313	0	\N	100000
871b0774-52cb-4b7c-8aa1-650a7f0fce0d	8cbc9163-4ab0-43e6-bc37-9d092c4f8806	0	\N	100000
39deba42-b071-4cb1-bf4a-29d68465428b	7a782bd7-27b9-4f47-a28f-a751d2793a8a	0	\N	100000
b87b3c2f-1187-4d95-aa70-4b2f834fa904	aaae4527-f282-4a98-8c35-d644005b2c71	0	\N	100000
e522273f-6902-4a0c-88cf-870003acdcc1	923c26fb-cbae-43e4-8e2a-700903702517	0	\N	100000
0311abe8-7532-421b-a472-412eb2910b8c	e1848ae3-8949-448b-a578-76726c5b8a59	0	\N	100000
79a3ba89-3957-4b09-9edd-720aeb2206a5	cd4b3dee-e183-4c19-b6e6-a9c607a482e8	0	\N	100000
f53196bd-23f4-41be-9042-fc9c6b205e73	f02a6e78-e89b-4711-9071-f534ec255774	0	\N	100000
89d62954-4e60-4701-a852-506ee5f4416b	73297b7f-b596-4f88-9882-5741d3c5bac6	0	\N	100000
8b1b35d6-fa90-4cf6-8c7f-af68b76eb885	fa3bb8cd-9908-4339-96a8-d61927544541	0	\N	100000
9ae40cb1-dc70-46e1-b7c3-396aae77877d	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8	0	\N	100000
74a6bc4d-b25b-4905-a8ac-4392fd8f48e9	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e	0	\N	100000
f86e3ed3-2685-42cb-8d42-fccab00233d1	4c84519b-ac34-4171-91c3-0c664a03e2cb	0	\N	100000
cb09177d-37d3-4f58-8562-e14e7089565e	be3f0321-d6fb-4442-8146-1eeee301be02	0	\N	100000
bfdf0729-e840-4e80-a834-2ac8d71f1d9c	27aa7650-6bf0-496c-971b-013fe6af4bbb	0	\N	100000
cfe78e11-10c3-4fdd-a08e-00a3e937812c	acd9b172-5bab-4a2a-987d-5b09bcfd94cd	0	\N	100000
bbebeb83-c40b-45ca-b4b1-6514b242efae	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1	0	\N	100000
192b3a02-98ae-4193-81c5-83e7a55bacea	4fac8997-e95e-4fc7-af66-ad553fd9666f	0	\N	100000
1e9ff349-817e-41b0-8126-52f6fd464d1f	77d18071-abfc-4f46-828b-27543aa92f25	0	\N	100000
25b4569b-65a1-4649-8c2d-c2418752635c	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf	0	\N	100000
e4b7f02c-d0bc-4d70-9fdb-45134485df02	068bbdd8-214c-45c5-bbd3-31400b5775ad	0	\N	100000
55743a02-d04d-45cd-b176-454b84b2e421	346af1cf-7bef-45e2-8fc6-9cfcdaa05300	0	\N	100000
9a14e334-1c25-4ea9-8176-1432ebf0f306	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a	0	\N	100000
1a09feae-9614-409d-8b5a-c9bbf4535b8e	93492e19-b481-49c2-a2d6-c5e3644e3b2d	0	\N	100000
d4f00f30-cd3e-41f4-97d8-56b85ae53791	3ae64b94-ddef-401b-b345-1cd8696fd967	0	\N	100000
446fa374-647a-48ef-9b15-2b246d1c446d	97647052-9891-4bd9-be9b-679ca79cb1d1	0	\N	100000
75ecd202-0ceb-4c1f-9aa6-407f0902f6e5	6173e277-f662-4720-a5a1-f34a8bb9221a	0	\N	100000
efc125c8-1e24-4d51-a4b6-cc3099fe5c68	b356cbf9-9aac-4203-922c-7904d844f00c	0	\N	100000
e212553a-8a4d-4e77-b765-3b6a25a97f19	6dcf36ea-cec8-4420-97cf-f665b506fdb6	0	\N	100000
9aeac25e-e33d-4835-a088-43d5d75f2ccb	c1cee951-d219-41cf-a647-a61d07366fe7	0	\N	100000
7796c4ea-a85c-4dec-825d-fb2d9fd49766	0c957416-3d9d-45bd-80a4-780cb657a77b	0	\N	100000
da64c245-433c-49e2-96b9-45b9dcaffe13	2162f56a-8ced-4b3d-b071-1df7dc6760c5	0	\N	100000
4b3c488a-57f9-4710-aac6-1f4eff5d25de	60d6a675-4f9f-463a-b239-9e2643aaa8a9	0	\N	100000
b2ab465f-871d-4150-a296-3721045c5a94	808c6a76-ec6c-4090-af68-b7ee4c8f3630	0	\N	100000
659ffdeb-38a3-43b4-88f8-eff89a6e3c06	51be77b3-787e-4364-8765-273088974e06	0	\N	100000
5c033b40-a60d-42c9-a665-994c690f34d4	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f	0	\N	100000
d9b8cdf7-4b8a-42ed-8050-339f79ff3934	2db49b30-71d7-4b16-affa-c4ae49003071	0	\N	100000
2e99177a-6e0e-4066-bd2c-9ea2c9516d6e	5c1d9e49-c3a0-4198-8f78-654398a73090	0	\N	100000
dff82346-d3ad-49a8-a1f0-e23fca05031f	4c235c4d-1364-415e-a369-827f9aebf9a7	0	\N	100000
fc0b09d8-b5f2-456b-85ab-ba39a0d6885d	efa9d746-3805-4405-8b7b-191b9137f635	0	\N	100000
4ada1a08-fe1b-4ebf-8a82-d5736fc3ee58	45add737-f340-4de6-8273-a3c9b62d7e77	0	\N	100000
f2007cc9-c5a9-4b01-8364-7642de05bc5e	dd39ed92-48b8-45c2-b336-bb8e8b05013d	0	\N	100000
f181a36c-dc06-4ca5-8b94-c07b1097c65e	901d66ce-8dd2-434b-92bc-052e6471a88c	0	\N	100000
9a40104d-9d17-43fd-842a-dac1e1ce9fc3	3c77db66-8cc1-4953-a924-d038408f309b	0	\N	100000
69ac142e-a4ed-4dec-bc87-c3daae7c1f9d	cecebe61-8db3-44cb-b651-29619044d686	0	\N	100000
39f30773-69b3-4cc5-b2ec-6f4fa32b361b	dc58f57a-d332-4991-8059-634d9a50df68	0	\N	100000
781acb4c-fe0c-4f07-bd07-63d615dc218f	f690f183-cc78-44c1-b56d-98814d650919	0	\N	100000
4fc65874-0348-427d-b2c2-7ae2a45c3310	a67b6419-7eac-4a49-816e-2bfdefde7c10	0	\N	100000
e4c870e9-b523-4b1c-a0e1-8f569ad101f4	a8ccaea5-750e-4025-9374-ac12553f823d	0	\N	100000
7cf5e758-9e32-4973-b866-be3e1e3e428f	2292c89f-3fe1-4b0d-8592-ad943a5be66c	0	\N	100000
f58ac9cc-1f2e-45b9-81da-a0033e19d080	755575c5-5262-402d-97d2-7563d211eb9c	0	\N	100000
6e532587-a7e2-457e-96fc-791e265d050c	8982b883-6019-4b06-8215-e28dc2a5914b	0	\N	100000
9e0e19c9-6ef1-4d92-812f-f7442425babc	6ba47e11-ccbb-40e5-bf31-f0f22a10454b	0	\N	100000
077fbe66-a60e-45d0-8ef2-5901bb215db9	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a	0	\N	100000
7828f126-f103-4826-83bd-0ec8f8d6f5a5	83be342f-6be5-4728-9ec8-0aad63fcb18f	0	\N	100000
a9b53071-20e0-4de5-bcee-4254e009cf6e	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6	0	\N	100000
af10d166-eafc-4d88-8888-7bad14be0211	f39447bf-b1df-4970-89f7-a4df15c2a0c4	0	\N	100000
2fdb47ca-243b-4c81-b50b-323618474c91	730c98e5-5ace-47c0-826e-c3543c9686cb	0	\N	100000
76fb351d-1b9d-4ee6-8121-806c6bd490d9	c854f638-c2f6-47c3-8da5-8c688cb1f78c	0	\N	100000
c914f1e4-c0d9-44ac-ba09-5f81f8c50b1d	05ab2789-6d48-4c89-869f-abe089fccb4a	0	\N	100000
f8d7c011-6787-4899-9156-c20068dd94ee	5891f499-7cc8-4d19-b3de-4b15c0624ef7	0	\N	100000
7d4e928d-2ad0-4ca7-a6b8-fb5ea8480c99	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815	0	\N	100000
0185b34f-e56e-441b-8c92-bfd866e696fc	526b8286-c88a-40e8-87ef-b94ebea9e97d	0	\N	100000
cb914a5b-c11e-4858-8622-b674c40af94f	49fe0add-1125-46cd-a368-f8411e43c44a	0	\N	100000
ccc72a66-0f71-49f8-ad68-e50b4b00a417	6d20670c-72c5-45d5-8525-9912c5ec1058	0	\N	100000
e0ad5485-c677-40fe-9d8e-9706799ec427	d33ab7e2-0a7a-4266-912b-55c5f5b18241	0	\N	100000
e1f68bc3-37ed-4bba-8dcc-618e6b2e11d8	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9	0	\N	100000
2e4efb33-b1db-4e87-87fa-3a8fbe15f815	6c1cc459-173c-490c-9990-d222300e188b	0	\N	100000
a2f78798-2dfc-4746-b29b-a312283ed9be	c62c44fd-85cc-4edd-a070-96a4ee09bcf1	0	\N	100000
0ba1669a-f2e1-40b7-9591-cc4e331bc37c	e64ccb49-7042-4678-9ab6-a8b8dadee65a	0	\N	100000
0b2fcbfd-b611-4694-82fa-8d31fcbcd38f	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd	0	\N	100000
d1183adb-0384-45df-9fab-63fbbda26c6a	5db49be2-2435-460d-a6f4-f45b2f275436	0	\N	100000
efd7ccff-b811-4608-ae8f-8e54e7843604	f1ba7109-837e-4fd7-944b-54d3b997fbfb	0	\N	100000
3660ca00-a7f1-4948-8f2c-3efff2a6c5a5	5d4f5985-c330-48e3-a1e0-23760bc73f4f	0	\N	100000
2cec497d-8de3-4a22-a0c4-423b0aea7c9d	a3c59c5b-c711-415c-b371-98ffb520891a	0	\N	100000
83d903ae-39bd-4938-891e-6a55fb52bef6	c49c5171-b397-41e5-a8cc-c3933347189f	0	\N	100000
e0bcb7b1-58d2-4a0a-8b6e-39fb28411739	a5266896-6503-4e85-a895-a82fe27c14c7	0	\N	100000
df6256c6-a5eb-4ba2-9f78-77f358337986	9100f2ae-e4cd-448b-b40b-251e0eb3572f	0	\N	100000
9026b5a5-ff21-4a18-ba7e-530acc1b3a32	c95385ce-966f-49ed-8b4e-7b162d2b0d66	0	\N	100000
5578c89d-1673-4e26-a5a8-8248757fd314	98dd5bf8-d2c3-411f-9fdf-57c51a150113	0	\N	100000
eb781397-4bec-4770-957b-3a62e002b072	c995dc27-5dc5-44f1-ad05-6f3d0350fe17	0	\N	100000
e2e94ac3-1f7a-4033-872a-2a50d197e0d5	aef64f27-4ed3-47d5-8620-68378fb412ef	0	\N	100000
e7fbdf77-d8e6-4f15-9685-32ce824f0f56	85729935-7993-4125-8562-127b29db7e60	0	\N	100000
57c10769-75ff-4023-b88c-58e212afb27d	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a	0	\N	100000
52de32e9-4424-4b3b-b670-34ba6393aebe	37d990e5-99ac-4bd1-9700-7f0efa185901	0	\N	100000
96eb616e-313f-4016-905c-2533aa7fce84	5eca0755-2466-4feb-851d-1e3f407260df	0	\N	100000
2355b921-4f81-4138-a83a-a4f2c14fed95	a0a730cb-ef7e-4d49-a0a8-103d50af54fa	0	\N	100000
e62639c8-0cf9-4522-8078-5d40e06f9e02	de0ce717-6916-4879-a04e-dbbdfadd4545	0	\N	100000
1df8d221-5144-41a1-86d3-466d2b15212c	e0dbe070-d1ef-4573-8391-450a4b3eaaac	0	\N	100000
1991dfe8-84b7-4768-813e-d396e08f40a4	63e30fe7-562e-4f11-9c47-09fa6e5188a7	0	\N	100000
cf6ab454-f25c-4142-8db5-96bbab928a8b	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9	0	\N	100000
0a24e75b-f0ef-44bd-8cc4-e60937f86f25	8e934c6e-187f-42da-9467-6ebc7ccd08bd	0	\N	100000
54cc479c-9bbe-4e3f-bdc9-076ed132c625	3eab8b06-c057-432d-8042-0b15ad87bdc7	0	\N	100000
71e7613a-0b94-455c-9932-d2df59881589	971f7c33-1a8f-4d58-91c7-9342a9acd69a	0	\N	100000
4947b7a0-8339-4785-9d26-4f14880e1f42	b7930946-5b11-41ae-9385-a05ff8b0bb77	0	\N	100000
552e74f9-c661-46fd-96ea-6b4e05fbbc8d	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b	0	\N	100000
3e9b0d27-d6a1-44d1-86f4-c39e70291ecd	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273	0	\N	100000
5446d429-8a90-44c1-a5a0-ae98d50d00d0	e84e7f8b-1821-4957-962a-063ce11ec128	0	\N	100000
2010edc0-6471-47ca-98b3-7da4f64d3a27	dc5830a1-fb20-4421-ae24-00f9be9f0f04	0	\N	100000
815d97ca-1a5d-4daf-a0c7-f6f6ec5c3977	7165d010-24ea-45e2-994d-4597b6f7dc05	0	\N	100000
f900fca1-9d44-416f-981a-1e1f2ded1ee6	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413	0	\N	100000
534a5e85-35fd-4ea3-9cea-10f06dcde25b	5e0f7570-92f8-4c39-b7d4-e89276778d25	0	\N	100000
a50b4447-d66e-449e-98c4-ae5d6ed8aa20	dee1a302-1c56-4b6c-83f9-3bd8bf27323b	0	\N	100000
29c923e7-9358-47c2-941b-587eeafbc4c8	5c7b80d2-5a14-4b72-ad4e-b30749b13074	0	\N	100000
77bc0f16-2df3-4ca2-a78d-c0f5bb18d405	0582992a-1e2c-4add-863b-b5f10d6b4992	0	\N	100000
bc35e26e-5ad7-43ff-96a6-c8ba63c64b23	a6759a4c-fc93-4995-9a6d-d30488ab7a12	0	\N	100000
48ee7b2a-a4f1-47e1-a898-c4a9ac93e937	e045da04-0570-4317-a560-7cbfeae6f59f	0	\N	100000
de9c6f2e-bf98-489e-9f15-2b5038bd121b	573cd423-824d-4f62-bef0-2728da79fcaf	0	\N	100000
38b815d4-ecbd-4f3e-b213-42560bb80372	1d8467cd-0105-4e3e-957c-446e325920cb	0	\N	100000
7f4efbb4-746b-481e-a18d-fe02e88b9892	ff338a1b-41d7-40fe-b370-c88ef7d387f8	0	\N	100000
473b18a4-df5d-4c18-b6a5-b254f4668714	22285a4b-a9a8-4aec-895e-5ea13125722b	0	\N	100000
3deaa576-cee6-4b42-a48b-a1764894f9d5	542780d9-35a1-4582-86d1-d9ff5971f4ae	0	\N	100000
56a1041d-e617-4786-804f-d123e9e1da85	ff807dea-119e-487b-9e10-1f7a83b4e172	0	\N	100000
91b1ab8c-c330-4647-b41f-bd90dc7ccca8	d816ad42-c674-4776-b507-f2ae86133a4c	0	\N	100000
ecec5f49-a523-4e9b-bf54-dcf19588e7b7	77d3e7a0-1cee-4856-9308-ae8830306caf	0	\N	100000
f87b715c-eced-48e9-8f08-6abf1c4f8e7a	d79cceb2-5cbb-4477-981f-491a969067b6	0	\N	100000
93d2a449-bb12-4ee9-9c42-2900be6106ea	86d277ca-6952-4753-9e13-ccdffb252b7b	0	\N	100000
1aa3acb7-472c-4819-a94a-0760d3fcba1c	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6	0	\N	100000
c8f30de8-2ce3-4a28-b6af-4a4fa89507b9	40b38dd0-c020-4e26-bccc-14f5bfe21970	0	\N	100000
573be257-0098-4d19-94e5-06404c2f6eaa	85b28ae1-f517-423e-bf6f-ef189248faac	0	\N	100000
5a4a9379-eae7-4947-9dd4-8fbce11cc878	3986bde4-e078-452d-ae3e-fd93454b4ce2	0	\N	100000
275015dc-537d-4402-8bb1-c38d0b66dbd7	db7f8158-f71a-4ecf-a0a6-48439a05d657	0	\N	100000
8f7273b4-d3d4-4e8d-abca-412f90841f3c	e1e70295-5c37-4c51-8167-9898b9c506f2	0	\N	100000
f95db53a-a3e1-49f4-b9b6-15972f9eefe1	37e4bdbe-f7f9-433a-a726-c9990700701f	0	\N	100000
079316f8-f441-4ff1-bc12-4df8ee547750	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3	0	\N	100000
bd63d2ab-1c70-408e-a47c-0ddde5caf191	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec	0	\N	100000
f3023b50-fb76-4888-a0c2-b388dae1924e	d543f357-e99d-4d70-b7be-2a98d055c997	0	\N	100000
d1d50bc5-4283-4ffc-a31c-5e35568dd82f	5c5f698f-3444-44bc-8055-c004d592e0f8	0	\N	100000
adf132dd-8499-40b6-9c60-73e9a1d40f59	2a74d774-a7c5-4b5f-839a-b1911e457bc2	0	\N	100000
c1110ebb-7092-41d2-b474-a038e5db436c	1131c61c-771b-4a75-a014-40a4731b9efd	0	\N	100000
34669ad7-b32e-4abb-bac5-111d406394a9	a2643314-2a6f-4af7-bb1f-11494179d800	0	\N	100000
8b8a8bab-83b4-47de-b985-5db9ebef95e1	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce	0	\N	100000
f3fcadd3-2de1-4e59-bfce-8832b4c46fff	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372	0	\N	100000
e6ae9f7e-9857-4038-b663-e35c4c6079bd	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965	0	\N	100000
b145328f-4655-457e-a764-6b0ff5b0dabf	59be1293-6788-45c2-b12c-d35d03727da2	0	\N	100000
3760f684-d38b-4e4e-9ba3-4a3cae42d3d0	e11b9a8c-c94f-48b5-b192-1a769c1442a7	0	\N	100000
280439ee-432e-4f03-b6ba-dd7d1af491fe	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b	0	\N	100000
9344c8ee-d8c2-40d6-842b-64e40427b24f	d1c81fcf-526f-468c-b8f1-1de6fe5ce572	0	\N	100000
3cd71a06-44a3-4e47-a4bd-4ad1aaf07c87	e1a109e1-01cc-476f-a100-046326507dc2	0	\N	100000
5a3d7f58-c2e2-4017-a791-d48aba5956c2	1fdcbf6b-e670-46e6-a1f8-308621c26735	0	\N	100000
64c92f85-3ea4-449b-ba99-b86b632207e1	bd03e8cb-4881-43d1-aaaa-fd192db5b90f	0	\N	100000
ada43394-c493-4e9f-8e5c-b7099f077b57	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8	0	\N	100000
40d4b5cd-6b96-4fe8-a2a2-a24ffc044a69	f423e5f2-d2de-4a4b-983d-7faeee04b0b2	0	\N	100000
5486bc01-4b0d-4a5c-bf08-7faeffafc710	21782926-7972-49d8-b5a4-8163dda4d8bb	0	\N	100000
37092a19-4e6d-4873-88c5-d9a56a0cafe7	0c875a99-42f1-4cb4-88ed-398b1c25b9fa	0	\N	100000
50675568-1d23-41b8-8f65-bf855277f354	3ba67b11-9e37-462d-83b5-ca4defebe4ed	0	\N	100000
d2303551-8c92-4dab-a396-346e7b05189b	bfc42f90-715d-47dd-bc34-8a3983fd76e5	0	\N	100000
aaf1b496-c13f-44d0-9a20-95ab89de0bb4	38922471-48a4-430b-acf7-80399379a847	0	\N	100000
6656b009-a8b3-4e9d-8250-444c1d1704d4	7d9c3111-4710-48a5-8e57-42e76f785f6d	0	\N	100000
a4f86479-73c5-4b33-a5e0-64f8b4321d7f	5cdf5b4f-0b52-4adc-a49a-6145cb01c326	0	\N	100000
19ed70b8-7ca3-4f80-a97b-180af82cce82	619ff42b-d080-4db1-b808-d769e69bee7f	0	\N	100000
86389a4e-8767-446b-b09a-04fc4d382578	c5533212-9300-4d0e-b460-5eabc1fa4a0d	0	\N	100000
f7cad6bb-0bbd-4db9-a507-dbe287ab3939	b68c623a-ffa3-4a48-a3c9-76f2f700775b	0	\N	100000
e33f5f69-270a-4921-829b-34ec57660bd0	5cd93a3b-b144-453a-a229-2757cb28df22	0	\N	100000
5b05263f-9a7b-4677-b4ed-013073a2a07b	4dd9f659-75d6-44f8-8fae-ac963c6746ab	0	\N	100000
14a6332e-3ac9-4535-b8c4-fdc7b7b8ef2a	c357212b-e065-4c65-aaa5-7e8b8a14cfa0	0	\N	100000
dd836b7a-b9e3-4454-94a6-28c09d584a70	f3fddd33-f77a-40e4-9897-55e61230d643	0	\N	100000
484abfe2-3bb8-4515-9989-9dd7495e9c4d	5434fac2-36e9-4ff9-9955-ba531fbb1ba0	0	\N	100000
3edec06b-9429-4d53-a845-0c71f55c0fb0	1c23cfd4-f4d7-49c5-8760-9600e414027e	0	\N	100000
23efe193-ceec-4197-b086-381504756d5b	31ae5186-dc5b-42c3-b676-8590c96de53a	0	\N	100000
9f7dfff7-051e-4e5f-ac3f-4e4296e3750b	d2615292-a50f-47ff-af73-437ec1eb0fea	0	\N	100000
2bc33152-b0cc-492c-8aec-d253ae4b7ae1	9f557edb-8adf-4832-bc25-ca5b00dfcf4a	0	\N	100000
105e9ee2-4248-4bc7-9cd9-4e56f49ec0f7	8fbf163b-f453-434e-ad19-10228894ee8c	0	\N	100000
f6f86cf6-d09d-4838-b120-cce9a76a16fa	d2834bcb-2154-433e-bb06-e8befbfd7368	0	\N	100000
0bc4308d-21e1-4bed-a6b7-cacf1452dba7	88421493-e09c-407b-91b7-a2bf5f633fa6	0	\N	100000
72fa1b42-d231-4d18-a880-8dfda9f822bc	45f32ed2-3673-4022-b0ad-e4d60362361f	0	\N	100000
f9717ec9-d3b2-48ab-ad20-6811e6bb91cb	a6975bcc-4113-475c-9da0-5dcb952cf919	0	\N	100000
231021bb-b0c6-49fb-bfdb-f69c022781a0	eb838509-93c4-4e2a-a8c3-3bffd2acc82c	0	\N	100000
d00efed2-d12a-48dc-8e75-3d6aa83e7c8c	815ba1e6-a405-4df4-9909-7fbc8e87a4ac	0	\N	100000
dd9ea3cb-a2fb-47af-aa7b-74096d6943a4	473b85ee-3707-4f2e-b370-74e791f3fe1e	0	\N	100000
71a1a694-7984-4fc4-a942-8557ecc66c1c	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2	0	\N	100000
25d65942-1cae-4536-a968-ce784dd7cf9f	e88ff86f-02ae-43ba-9060-727ec1a5558c	0	\N	100000
2ce4211f-5189-416a-86b5-9b418eaa2568	0e562d45-0328-4a97-939d-cd11bb7f2ed2	0	\N	100000
8f642602-00ba-454a-8bba-a01a603a6b55	6e4e0e64-47ea-44c0-a997-25766e1a85c1	0	\N	100000
89de11a3-ac10-418c-a2de-0695677a9710	6ef284cd-4c54-42c0-99a0-619cb8442030	0	\N	100000
0cb447ce-296b-4b7a-816d-e7797cd47d6b	bce15c48-3692-4a64-a01c-9ae16080077d	0	\N	100000
59bdc01a-4ee5-4bb3-aa23-c7275806dd61	d6bec1d0-48c5-4652-8612-b4667cb1c442	0	\N	100000
48c257f1-2847-4fe1-9e78-cd7cfeefd057	c8434922-ec69-4e01-beef-8cfb6ad0f92b	0	\N	100000
5daadaa5-e57b-4df8-86f3-76d3b3b5b80f	cebdc43a-6173-4d07-99df-6ffabe415516	0	\N	100000
f9317b13-e58e-4e33-862c-16012ed6d343	9f19df17-a951-4493-944a-cd158fd5ca1a	0	\N	100000
62c52b9e-e075-45a5-b16f-a059d918d13d	f968fe68-30ae-42d2-9e74-08bf8e223215	0	\N	100000
938acd2a-6c7f-444b-9ea0-c155e68e03f0	380bb01d-d981-4caa-b479-6089a516a075	0	\N	100000
789ee6db-3c5e-4cee-90e0-6d236290e718	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94	0	\N	100000
0ba9d587-debe-4c50-a6ac-b7edabc49a9b	8749fd89-444e-4786-b0cc-6fed521bdc27	0	\N	100000
75c32912-dbe9-42d6-abd9-52d940deb93a	3ecb5f1f-0418-41cd-af4e-93a4f558c522	0	\N	100000
4d3d09b4-d9ae-4aa1-88ea-76dbf9f43ac6	7170f559-0812-46be-9851-f1142c91d14c	0	\N	100000
4513d79e-9706-4bbb-b080-32d9e61dd5e7	150bc895-b1c4-48b6-8acc-513947236dd1	0	\N	100000
324a31fe-d6a1-4377-a722-016da9938933	eff4d266-7f89-49e1-a67c-29c28ccd7b9f	0	\N	100000
50ba04b7-80fc-4e1e-95a3-8f198d283b93	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2	0	\N	100000
fe1aa493-35c1-4b37-a99f-1f3a4aae6284	2bd87bc9-bbe0-4a68-b661-67cfc55995b0	0	\N	100000
a9034711-fb76-43ed-87a5-0a6553142296	e1f5d089-9099-4909-805c-7ddbdd74e0a3	0	\N	100000
67d87edd-4cb9-4244-b685-5ecbef0e3a5d	e4418041-7cfb-492e-a3dc-0f348e86268d	0	\N	100000
80937f26-49dd-47e7-b4a9-050675e13586	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90	0	\N	100000
61491a6f-c68c-4293-94b6-ef4b21b3f00a	21bc0cfa-c69b-454d-9c5b-4261dea59a6d	0	\N	100000
6bb6a454-080a-469a-a3f9-e67102438e13	5566b584-2023-42f9-b25c-04d15223cd5b	0	\N	100000
7e5019fb-6ea9-460d-8994-ef80ea12ace3	759b3797-b95e-4abc-a83f-c37bd6aa090c	0	\N	100000
c5f8ced7-d975-4f35-aa1e-05a3f9273b2c	1203d0f1-1816-4998-93f0-bdb05c314cd4	0	\N	100000
024f6728-775c-42cf-9ff3-a7f5ea7e54c5	ffb1879e-5a8e-46a4-80ec-fe36bd67e584	0	\N	100000
b1d92b49-6693-4f71-815b-ebae28174eef	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c	0	\N	100000
dbbdc7fe-60f0-4f47-bca5-a77daa252e09	d04cb17e-fd2c-4727-acd1-76bad464dd01	0	\N	100000
50fde236-3156-4863-b410-5a309c565f5c	5cb277d0-f9a3-4de9-9041-470811eeb375	0	\N	100000
227098bd-e6c6-4310-954a-b422df8216a2	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6	0	\N	100000
cff3a50d-47a5-4ab5-8553-5897406e4dac	57734c90-01d3-4f4e-828c-1201f65e42bf	0	\N	100000
83be77bc-20ba-4935-881d-8aea591a0c3e	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad	0	\N	100000
d52611c8-f8c1-4238-a925-2cd0cc6bf043	31765d40-d378-420c-a0b4-ca49e7ea59f7	0	\N	100000
da12d75f-b1ef-4634-8714-a14a2e4c894d	2f0dee24-3f81-4ccf-8244-d6488d087f1f	0	\N	100000
a7ee8a46-986f-42b4-a4e6-b8f031a1dbed	b6c3d582-e6cc-4814-a38f-7df873654608	0	\N	100000
536a6361-89aa-4839-829d-1604d8370db6	53d6dbf5-e190-4641-95a1-d734632637da	0	\N	100000
cb22ab0a-8d97-4efc-8e1b-c392b68e2878	d19c8610-487a-48fc-87a1-9de1b1b9cb83	0	\N	100000
2ff8ee25-e0ed-41d5-9c27-263b6b7dc505	145ff272-c8be-4461-b4aa-1a161a921aa8	0	\N	100000
b3066f8f-125d-45d6-aaad-36e70e3b1e30	bc505c03-f9ae-4e0f-99d5-a29a56830b15	0	\N	100000
d2cf134a-ac37-4dc0-ae58-cd6d2a79d8bb	7e5114fc-def2-4929-91d0-7ca9dc68b2ff	0	\N	100000
db3fdf73-07da-4059-b114-af75f232de54	1e65b0bb-703b-455e-a307-7f82464055e8	0	\N	100000
a46231a7-74d3-47e2-a223-65ccc3d5be23	e999b8ec-ee7a-4889-bec9-9afc50e88dce	0	\N	100000
fdb07924-4ca2-4808-a032-e4b8f15b4171	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9	0	\N	100000
d291b8a1-52b5-44f5-a6fd-369ff2883039	95f8b881-4861-4f7f-a209-5e6cf25b8d78	0	\N	100000
f3ddbb5b-04b6-4e7a-ba2a-d5a567155ea4	d62f5ea4-de23-4db9-afb5-db9334809de1	0	\N	100000
c36bbe6b-0943-43fa-af40-b0de5ad6774d	3bf937ce-d0c5-43bd-9119-f8590a8d574c	0	\N	100000
bce15cd9-5665-4ecb-a00f-d3f77f6fa501	616544be-8229-4e20-b1ec-3a286664cef5	0	\N	100000
d28f0e1b-abb9-4f8c-8034-166e24993331	e46a8c26-7345-4fed-b81f-2f3ebe9f3864	0	\N	100000
817ef8c6-d949-48c5-abd1-1281bb54a174	1cb6a9e2-f9ba-412f-a284-23e6657ef879	0	\N	100000
8b072c3d-a8a7-4b47-a9cf-c7313b6f9c4d	98431e33-b96a-4c71-a52d-07883fe7e945	0	\N	100000
1b8914c8-4134-49c8-afcf-9fc95865afa8	9eca8ffd-2cf1-4293-af11-ed381f31d2d9	0	\N	100000
dd965a6e-dd64-4b84-a406-0b173a69ee9b	77d3d92a-1bc8-4648-b22d-401a09d08ab5	0	\N	100000
60d18a7c-a313-485b-9c03-91c7342dfbbf	182027a1-551c-4601-9b84-497348f94e1c	0	\N	100000
b0244c7e-7c32-461b-bf96-1804793d9cdd	1caaf02e-4ee5-4c2b-b520-5846341805ef	0	\N	100000
b83d3a15-2b09-4e49-a441-c15f32f6df21	7d633720-08f4-443c-942d-8da74df41a97	0	\N	100000
d7b8555f-0758-421d-9f33-60bd1d8289fd	bf1a2431-a918-4a36-8334-ab6545e430f7	0	\N	100000
d0aab62b-cb20-40ea-bd16-e209b934fdcb	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8	0	\N	100000
c2109b7a-0a04-4d64-a039-15d6c1c723d5	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c	0	\N	100000
9aab4881-6593-473b-a8d6-4950cf92661b	237b4a46-2822-46cd-b0ac-c82739829a00	0	\N	100000
49895148-caf4-44c6-80de-b61da393cfcf	51f92be1-4f22-406b-816a-637ac9c1f180	0	\N	100000
fdb3432d-d77e-4bdd-a710-96f698efce07	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f	0	\N	100000
fb9f3a54-e8d4-4a04-bab2-567851c9e9ca	5e30ec44-bf17-4518-b5c0-2c1d552a9777	0	\N	100000
56c40e90-e7be-48c6-aa41-c155f58887ea	a080de1e-d906-40a2-9bb6-c3e7528d2b87	0	\N	100000
46a1018f-cae1-4440-8267-5c226d8e8a88	20bc764d-59d8-492a-b1e0-3d9814ad034e	0	\N	100000
08e33c9f-996c-4e68-8213-25f1f44e7155	188e2d5e-977a-4730-a383-0cf6431ec5fe	0	\N	100000
6079d2b0-7c87-452d-89d4-7985184cf177	6ae32738-74e8-4c49-91cb-e39f7e5df371	0	\N	100000
c83b66ad-52d9-4aec-a7ef-81cdaebfe67c	1e968ba6-7a32-4112-891d-a59c12be57c3	0	\N	100000
79e6a19f-b683-498e-b183-155bc5caf50d	1532bb49-0e32-4841-8531-eb9f7d831abf	0	\N	100000
299802aa-abac-4179-aa6d-23ce949e55ff	a18c5901-3cba-4f12-913a-2f901f7eda55	0	\N	100000
5a7866f8-12fd-4d1f-b27a-31f094aa4f13	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a	0	\N	100000
d47e8cfd-3f4f-427d-88f2-0937ec4c2610	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd	0	\N	100000
1d959537-e295-4f20-ab27-ccd9eaec71a2	03c031d5-def4-4c9f-9c43-ead660b2ecd8	0	\N	100000
f15a6f19-d59e-4620-8e9a-4bdd23c54e2b	85b9217e-e690-4560-862d-523b8ddf7390	0	\N	100000
bfac1d64-12cb-4a14-a02b-48fb0abe0fa0	3c5d9bb9-923d-4745-a499-06d2421d8b06	0	\N	100000
911830e5-8660-4599-9522-722308f73ff9	f8f489c5-baee-42a7-a22f-ceda8b8d760f	0	\N	100000
f12875be-68ec-4a0b-a6ba-262e709764cb	a4f0921c-5929-49f3-a2d1-3f0048849db6	0	\N	100000
b8ffce73-e9c7-4318-a23b-d220ecee473b	4e6759e0-6ce9-4277-bff6-d6033bb6f479	0	\N	100000
dc39f7cd-f0db-474b-9ac4-a2cd9104580f	bda3c9ab-385f-461e-a1cd-37a52d5335c8	0	\N	100000
2cf6efe1-2e1a-4d44-9fd2-ac1119ec3209	f868438a-b76e-46b3-abaa-f4405a63d0ff	0	\N	100000
12767be1-fd4e-47c4-a38d-83b67d9ab573	5f4a33a0-6d96-44ab-8d8c-24a62013003f	0	\N	100000
1764e935-805d-4e48-85e4-9bde7a40fa01	02926a21-64dc-477e-880c-cd6b5eb3394f	0	\N	100000
4a6c9671-a5c5-4e8f-bf2e-268ab614166a	a7f7e5ef-f3af-4ba4-b048-701b6582821f	0	\N	100000
c1199d9b-97cb-4a93-81ea-c131da40bd83	04a2a76c-44ff-46d3-8155-1348edf1828b	0	\N	100000
3e2df13a-5958-420c-8924-84e85162eb9a	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8	0	\N	100000
c4961dae-23bd-4f7f-824b-0ec0957b18b8	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea	0	\N	100000
17b16259-b832-45a9-834b-508b99cf510a	b4085128-2dc7-4ed5-9332-959dce9b0cbf	0	\N	100000
4f5f5c32-aba4-451e-b76c-0b3f5a1dbfb1	6305399c-c89c-4fb4-8570-42465bd1b79f	0	\N	100000
b82fc8e0-96c8-4a8f-97e3-346ced76ba07	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8	0	\N	100000
75f969d4-2aa3-4043-b44e-6f9bddb9db18	c124d5e0-2509-43fa-8e0c-f07a9db962ed	0	\N	100000
0670e738-419d-48a8-9ead-8a8e80c8d321	c0982b02-cecb-4f73-adb0-327258fe2f8a	0	\N	100000
c3520184-7edc-4703-90f6-098861da9ac9	2ae81c67-7c65-407f-862c-dc6877f856e0	0	\N	100000
3b651671-3169-47a7-8495-c990c6dc62cd	e4cc5b33-8083-410e-b92e-60b818343a90	0	\N	100000
20107f3e-b199-4e12-a55a-91f0e4a5c39a	b97773e6-a871-4572-bac1-7a6637f059cb	0	\N	100000
df8bcce1-9f8c-4016-a3b9-8fd4920d99f9	3c305397-9f6c-4189-aa05-f48fc6d4c02c	0	\N	100000
acea774d-91df-4557-a125-be191043d454	fc057676-e528-4fcb-a729-4f4eb9ee5e5b	0	\N	100000
57df55ef-2476-402f-a3a7-b5bef702f8d2	38f81c95-5586-40dc-be11-7117fcd90f9f	0	\N	100000
dcb01174-4b34-493b-875b-3133e56a2f92	fa3b4cdc-b7a2-4595-a7e4-ef474d129883	0	\N	100000
ff35b6a3-3a8f-4594-b603-1b6e1f96c2db	adcd3d8a-71e5-4bea-880c-ea9f7284a724	0	\N	100000
f15d55ac-7d4e-4ea3-8643-009a68fb5d5b	9356b60b-8ca4-459e-8347-04943b40dae5	0	\N	100000
a5ed9e68-8eb7-4618-b979-5744b5c1260e	98b12365-5eed-4f3b-b615-ab87f317c2fd	0	\N	100000
b4b7d622-6a0d-40a3-bbae-04d6f9551b4e	feaeaa90-81a5-4098-b44e-d39b0d059cf9	0	\N	100000
a82ee5ab-7fd2-402c-b1f7-efc0dfb71b16	c7437b7a-8e9d-4fd9-a56d-05973ac990df	0	\N	100000
ebed6f66-5133-4abf-836f-357da747df40	c3d9b51f-dfea-40f0-a0d2-7f87737824c3	0	\N	100000
79d95eef-dffe-4a01-ad33-a68d54117a1e	a9ad51d1-99d6-4e58-b712-cfbaf6ea5a5b	0	\N	100000
\.


--
-- Data for Name: players_quests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_quests (id, player_id, quest_id, is_completed, completed_at, created_at) FROM stdin;
3c45abb6-238d-4198-84dd-89c64f116d11	7b85a40d-2149-44be-a888-438cc50012f7	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	f	2024-08-29 14:02:21.681	2024-08-29 13:57:21.681
0cc5ea86-85c2-4c22-bd06-889188140c66	7b85a40d-2149-44be-a888-438cc50012f7	96c6e4f7-cb0f-46e2-8b32-c948d58d302b	f	2024-08-29 14:02:40.015	2024-08-29 13:57:40.015
1981d4dd-2130-41d4-ba58-487eab45f8d2	7b85a40d-2149-44be-a888-438cc50012f7	1f542c73-89e5-4ab3-bcd0-244ca6bfcccf	t	2024-08-29 14:01:44.703	2024-08-29 13:56:44.703
20737ca7-70d9-49bb-96c2-1b49eac6a4a3	7b85a40d-2149-44be-a888-438cc50012f7	92596306-cf8a-4210-8e6f-b8a4d6acc2b7	t	2024-08-29 14:01:51.019	2024-08-29 13:56:51.019
5ef8694b-600c-4f69-86c9-3f5e6d107b13	7b85a40d-2149-44be-a888-438cc50012f7	0529c270-58c2-42c3-9465-684bd6d33564	t	2024-08-29 14:15:19.376	2024-08-29 14:10:19.376
731da88e-22e1-4c52-a86b-3deeea7afd29	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	f	2024-08-29 11:54:42.786	2024-08-29 11:49:42.786
07ebb74c-314b-4a35-acc9-d1e22582f887	5c88a435-14b9-4c7d-ae97-08c38822e5ad	96c6e4f7-cb0f-46e2-8b32-c948d58d302b	f	2024-08-29 11:54:56.716	2024-08-29 11:49:56.716
24dd7f31-c3ff-413a-96d9-4c826037ac01	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1f542c73-89e5-4ab3-bcd0-244ca6bfcccf	t	2024-08-29 11:54:17.925	2024-08-29 11:49:17.925
cfc1aa66-488c-4060-b8f7-750124bcff72	5c88a435-14b9-4c7d-ae97-08c38822e5ad	92596306-cf8a-4210-8e6f-b8a4d6acc2b7	t	2024-08-29 11:54:22.592	2024-08-29 11:49:22.592
\.


--
-- Data for Name: players_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_tasks (id, player_id, task_id, is_completed, completed_at, created_at) FROM stdin;
0de3517d-52ec-4078-9609-d33497d1fd38	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2d1de81c-cc1b-4efa-a9e2-dd7e9783d2ab	t	2024-08-29 11:49:33.413	2024-08-29 11:49:33.413
69c256f7-51f5-4071-a8c5-b513271271d7	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c405ccf3-450b-46f4-96c1-cf4767732139	t	2024-08-29 11:49:36.951	2024-08-29 11:49:36.951
3af646aa-0739-4ae0-8bc1-020388485426	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a7273587-7d1a-4414-a7bf-798123723560	f	2024-08-29 11:54:42.782	2024-08-29 11:49:39.505
245b7da0-1859-478f-bcfb-40140a4f4556	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3af6506c-f5ba-4b98-8a20-516b80b14ec8	t	2024-08-29 11:49:49.915	2024-08-29 11:49:49.915
7bb02ee1-6989-46cd-aef6-51c5902487a9	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2480f3ab-c4d9-4815-97e8-90e47b24c01e	t	2024-08-29 11:49:54.615	2024-08-29 11:49:54.615
bb70a34d-5d40-4985-b75f-9f03dfb7b089	5c88a435-14b9-4c7d-ae97-08c38822e5ad	420c2a89-be9a-4857-bd05-7e6903ccfebc	t	2024-08-29 11:54:17.917	2024-08-29 11:49:17.917
a09b90c3-baf0-40aa-9205-1c0bc5c08e67	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2b67f178-2dcf-4534-a5d1-a0fddd67a5dd	t	2024-08-29 11:54:22.586	2024-08-29 11:49:22.586
6efc14d1-38a7-4b44-b5a5-acfdaa7d693b	7b85a40d-2149-44be-a888-438cc50012f7	2d1de81c-cc1b-4efa-a9e2-dd7e9783d2ab	t	2024-08-29 13:57:04.237	2024-08-29 13:57:04.237
f46d2b59-6b47-4736-859f-379b9b3e847a	7b85a40d-2149-44be-a888-438cc50012f7	c405ccf3-450b-46f4-96c1-cf4767732139	t	2024-08-29 13:57:11.919	2024-08-29 13:57:11.919
72c3c685-51af-45aa-be52-931e15677bcf	7b85a40d-2149-44be-a888-438cc50012f7	a7273587-7d1a-4414-a7bf-798123723560	f	2024-08-29 14:02:21.676	2024-08-29 13:57:18.618
342585c9-8d4a-43b4-8d86-b424b3852ad3	7b85a40d-2149-44be-a888-438cc50012f7	3af6506c-f5ba-4b98-8a20-516b80b14ec8	t	2024-08-29 13:57:29.795	2024-08-29 13:57:29.795
d862e1dc-e8fa-4f32-bed3-8544ea0df4cb	7b85a40d-2149-44be-a888-438cc50012f7	2480f3ab-c4d9-4815-97e8-90e47b24c01e	t	2024-08-29 13:57:36.104	2024-08-29 13:57:36.104
0f7c188e-aea5-4cb9-bf7d-9f08bf31027e	7b85a40d-2149-44be-a888-438cc50012f7	420c2a89-be9a-4857-bd05-7e6903ccfebc	t	2024-08-29 14:01:44.694	2024-08-29 13:56:44.694
f703996d-b57b-4466-a2c3-cc906b97b6bf	7b85a40d-2149-44be-a888-438cc50012f7	2b67f178-2dcf-4534-a5d1-a0fddd67a5dd	t	2024-08-29 14:01:51.007	2024-08-29 13:56:51.007
06a05a0b-cf73-49a8-8b4d-6a868cba4621	7b85a40d-2149-44be-a888-438cc50012f7	b491f565-c426-4466-b126-368132112f58	t	2024-08-29 14:15:19.363	2024-08-29 14:10:19.363
\.


--
-- Data for Name: profit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profit (id, player_id, profit, profit_type) FROM stdin;
c9b4b994-8c58-486b-be17-1f5fc1395683	7b85a40d-2149-44be-a888-438cc50012f7	2600	click
349955b5-56ea-49a6-afee-2f733616be4f	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
ba7af213-18a3-43d7-8a1a-3e6e45325e26	7b85a40d-2149-44be-a888-438cc50012f7	4800	click
213a8c98-4871-49fa-963e-c1596e11ca33	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
5f3c4e33-131b-4248-b3e3-378bc56d9c71	7b85a40d-2149-44be-a888-438cc50012f7	7400	click
99be4895-a7e9-4d84-9874-3ac8198f9df4	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
817f8aa9-4c70-4546-ba46-9b370787b8d3	7b85a40d-2149-44be-a888-438cc50012f7	85200	click
c8b30a7b-da8c-42cf-a05c-3369ef8a1724	7b85a40d-2149-44be-a888-438cc50012f7	25000	bossKill
75be2392-43d4-4769-a064-e88e04124514	7b85a40d-2149-44be-a888-438cc50012f7	50000	rank
2aeea3bc-b70a-4249-8de5-e39e06de7ec7	7b85a40d-2149-44be-a888-438cc50012f7	875	farming
9e6734cb-79fe-4542-a1aa-f835a086a97a	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	100000	click
97c46074-7d2c-481b-bb2b-407f4f425b40	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	25000	bossKill
804f3749-bc8d-4128-9b0b-51fada33d65c	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	625	farming
de543ee9-1573-431f-8676-ca79a7790773	e3db2078-4a85-44a4-bf97-e165be03f56d	400	click
b61658a0-6ded-4880-aae1-7215893450ad	e3db2078-4a85-44a4-bf97-e165be03f56d	0	bossKill
27a0f57d-bc74-4071-aa7f-32b28691b5e5	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	1600	click
b8065327-e671-47da-a88d-2741017401e0	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	0	bossKill
d1f26221-6ec0-4a27-a98c-7eecf0d7a7a4	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	50000	rank
91844fb7-ec66-4294-8d50-d7490ca32b1e	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
4b17c668-53a3-4430-ba31-edac7593ad4d	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
34f25c96-86b7-4aae-b269-d1e0cc32c71f	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
df19a4a2-de24-4cbc-a71b-3aa3a6f2e333	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
32f50895-e42b-449a-890d-d5b02942ec98	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	200	click
4c189302-7539-41ed-a596-a45872a06243	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
1a912dfc-eb28-4e0b-a2aa-0cefd6f98044	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1800	click
29a85ee6-ffba-43ff-8f25-2977fab86832	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
51ad017a-c14a-478e-bd7c-39d0beec0016	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	2700	click
f97148fb-7716-4229-a821-00dd31a53030	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
7e99375b-9f7a-4196-9df3-e5ed07951aad	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
43babe87-b727-4fd4-b856-f2ad010ef9b4	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
8fe9d1e6-aa45-48db-b564-db436c0b3df8	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1700	click
23216d64-d0aa-4f70-98ef-fdaf616c4948	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
23401ebf-44ad-44f0-91ab-f3ddcb6d57c5	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	33	farming
def92d9c-72e1-4a61-bfe5-8729d1834121	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	600	click
7fbdd4f6-eb47-4f43-81a8-3c33919a40cb	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
7acf064b-299b-4e99-aa46-10b04ebb0a60	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	600	click
ddd90f60-b6a6-4246-b352-df305027e85d	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
c8c292c3-9ebc-4382-8bca-8a4dd3ba9bcb	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	800	click
f86bbcb2-7287-4912-87f9-4fbcf54dc71c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
2f537433-1c27-4f2b-a272-9d8f7f917c85	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1500	click
048614c5-a5b3-4116-b58d-b2de9d021c48	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
1bf7ebb4-571b-47a1-86e6-706a66ef79f1	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
22dbe2b7-e805-40fb-9c2e-4a2dbc2785ca	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
b4a2c100-2658-4e95-b777-1408f2b4b036	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
e6fc0a06-2f05-46da-9924-2f77b75b8424	5c88a435-14b9-4c7d-ae97-08c38822e5ad	25000	bossKill
de6ab374-1adc-4f09-8171-76f734b9877a	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	3600	click
12dec9f5-1ce5-44f3-93cc-bf0a6f2b326c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
aaf60b8d-e631-4c93-832f-1e54aee39bc8	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
f80680fa-54d9-4bc2-a32b-601c7b6cad97	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
39b51833-7f9c-46f4-bc4b-18851b4b8a51	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	21100	click
9f9a36a0-6b5b-4256-b69c-a19c7a56b488	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
40ff774f-4891-4850-88f4-9e87166f8c5c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	200	click
b50b6a5e-8c62-44ad-9a04-45e7ac832fb8	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
c15a6608-be14-4f3f-aadf-a060cb4b30a2	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	200	click
4629366d-8540-43bc-bc6b-558e3c1ea5db	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
caf6949f-9b38-4dd4-a215-67ef75d226d5	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1100	click
41a7f06f-b9c1-49ef-aeae-18baa3e8d946	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
c703e266-3a55-4aca-846e-5f6ef0115f03	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	500	click
9ea3b134-f85b-4e6f-9f5c-3144cc1b3d9c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
6a45ebe9-b45d-4f30-8c43-01861797e199	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	300	click
679d2f7a-ca03-4be4-83cb-ab866beb441f	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
84bcfd24-d8aa-46bb-b0e9-da38e76af686	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	600	click
cc24afc3-58f0-4225-b903-e5f5daad2c81	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
6bf44818-afe6-44f4-ae65-e52dbc71edef	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	300	click
f8b16900-d80d-44e5-b3ad-65294b15e13b	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
087d2b46-2f09-424e-9572-b35afa11cda4	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	200	click
c1413d16-604f-476e-8392-8638ba41bfda	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
11c8a264-c2cc-4543-bdca-afa99a7d1242	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	4500	click
76876a47-f5ec-485d-b454-acba4ef065fc	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
a2afe00d-0997-4b96-83cf-a49e80c9c0d5	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1700	click
d24c2722-1af4-413d-9e91-76120f4ed227	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
ecf70b83-6061-4ef7-8d0d-2a1844ce7310	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1800	click
371f665d-30ea-4137-ad40-d3f952ea267c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
d3254ac4-ab51-4df2-9962-2cd8aee0befe	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1000	click
a37e73ed-d1dc-417e-a3df-eef99fd720e8	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
ac15d356-23c5-4648-83de-bb48cc09f6da	5c88a435-14b9-4c7d-ae97-08c38822e5ad	300	click
413e22c8-c253-42f4-ae18-8472f0281e32	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
312643e0-1e7d-4575-9824-538eef95daee	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	500	click
a0f7ef5e-a415-4efc-a207-8fb19f82dee6	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
a28011a3-247e-4ea0-9197-b644f0438932	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	16300	click
9170ca14-a637-4e5d-8371-f75a2adceb6d	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
13ce678c-0f2b-4f13-ae70-6528174ab996	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	3200	click
331aadd6-59b4-4fcd-b658-521348d11df7	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
ccdc802c-c07d-43f5-9930-f1a3b4be07bf	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
1bc1828d-7350-4933-bfe3-d47b3623a5aa	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
b99764b7-f2d1-4f09-b1f0-e6868f83fbd9	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
50f36df2-d6cf-42c2-baf6-0c5e0858df17	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
cc5638d8-94d9-4168-858a-5a229a86033f	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
95b6f6e2-017e-4278-ae33-a38102a782d4	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
d6a45a96-d085-45a5-bf84-f047c49cfc56	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	2800	click
80177fac-d20e-44d3-aefe-b4dd0150c6c4	fc3cd5c6-17ef-4eb6-80de-4989687a35c3	0	bossKill
107d48a2-13b6-4b9d-a332-887c300212e4	5c88a435-14b9-4c7d-ae97-08c38822e5ad	25000	quest
3e0cdda7-e028-4a4d-af2e-460f9588cb69	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
8ed26004-f2bd-44a4-b1b5-53e62679a6ef	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
48b7ea71-2adc-4b9c-b90f-1997cad8b9df	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
4cffaa11-6602-4042-ac4c-82ec3b8dcf88	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
fddb2cea-aacc-4f3c-9793-9bf2393fab0d	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
327cf805-f1e2-4529-b709-d7c644a65557	5c88a435-14b9-4c7d-ae97-08c38822e5ad	25000	quest
4fd1a93d-e3e2-4dc6-b5b6-d9721e626633	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
8a94a820-3c54-4bb6-9bf1-43e9c25763d8	c442f7d2-81bd-48b2-91dc-4c64d172c548	10000	quest
1449c213-ce40-49c7-b54d-0f6607fba1ac	c442f7d2-81bd-48b2-91dc-4c64d172c548	10000	quest
8e058ce2-009e-4def-8e37-ebb334aa27d5	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
6effa0e6-b7ee-45f1-9cdc-d4f79787e2c0	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
75ceef17-3b2b-4918-9ecf-47342cddfddb	7b85a40d-2149-44be-a888-438cc50012f7	25000	quest
9cbfa4e8-7d68-45ce-8980-49766bc3bee1	32b069c3-007e-49c7-84fd-1231b4a2db4a	10000	referralProfit
e240ce21-7b71-4a4a-ab1d-81af63fd6057	44023214-fb54-41f8-b586-783d108dbaca	10000	referralProfit
563cd485-3274-462e-b77a-b193f1f1befa	f29d087c-a6fd-45ea-9fd1-8b25224cfb58	10000	referralProfit
ab5265da-76a2-4a9c-b57a-d250e142ee39	35ab5d3f-c9db-40fd-a172-e7d5eedf861f	10000	referralProfit
f0294789-f282-41d3-afa8-5ea9fc98ec17	c503dcb2-b7ee-4f15-b557-e25053de9313	10000	referralProfit
0154f1f4-516f-4568-8e44-c9b3fe91d204	8cbc9163-4ab0-43e6-bc37-9d092c4f8806	10000	referralProfit
093cc7e9-f672-4db3-bef8-12ed0c141a38	7a782bd7-27b9-4f47-a28f-a751d2793a8a	10000	referralProfit
59ab4498-8285-4e01-bb16-30c0402a6751	aaae4527-f282-4a98-8c35-d644005b2c71	10000	referralProfit
ad15d234-fdac-48aa-b04b-1a2ad0cbfb7f	923c26fb-cbae-43e4-8e2a-700903702517	10000	referralProfit
a2e6c65c-1e77-4f83-adc0-24bf99f53054	e1848ae3-8949-448b-a578-76726c5b8a59	10000	referralProfit
01583838-b87e-4ffc-84a6-d2a5f707cdd7	cd4b3dee-e183-4c19-b6e6-a9c607a482e8	10000	referralProfit
83e14ca7-07be-4ce5-ba0c-d88b25b0acc6	f02a6e78-e89b-4711-9071-f534ec255774	10000	referralProfit
a44c6af7-18ef-482d-8f88-5e21aaa00de8	73297b7f-b596-4f88-9882-5741d3c5bac6	10000	referralProfit
14911207-2f19-4d01-9f5b-f14e60901a65	fa3bb8cd-9908-4339-96a8-d61927544541	10000	referralProfit
fb8d84cb-873f-44aa-ab79-5e2ce6e7b8b6	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8	10000	referralProfit
88df376d-e092-4eea-bdff-c5f7e0278a7f	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e	10000	referralProfit
ba0f407f-2ff3-483a-8f73-fc30e689867e	4c84519b-ac34-4171-91c3-0c664a03e2cb	10000	referralProfit
5d5dd3e1-23e4-436d-aee0-571b467e387f	be3f0321-d6fb-4442-8146-1eeee301be02	10000	referralProfit
ac5c1793-c8d1-4add-93ea-7f895fcd1a1f	27aa7650-6bf0-496c-971b-013fe6af4bbb	10000	referralProfit
9100dd41-bde6-497d-b138-b63d686c8a75	acd9b172-5bab-4a2a-987d-5b09bcfd94cd	10000	referralProfit
a2de0aa2-8605-4313-8d00-7ffeb3e5049f	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1	10000	referralProfit
9b1862bc-6429-4b43-a0b6-c2f8dd8b2d45	4fac8997-e95e-4fc7-af66-ad553fd9666f	10000	referralProfit
ecfd153b-903c-4873-b3a3-75fb723037fe	77d18071-abfc-4f46-828b-27543aa92f25	10000	referralProfit
b2f90a0b-e2e6-461d-856a-b3978dabf69d	d22a81a3-c6d1-43ea-a70d-14a4723d3a73	10000	referralProfit
7975acdd-0602-4d6d-9192-55d40b0a09e6	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f	10000	referralProfit
22b8dfca-b0fe-482a-b1f5-3e9d0e842b99	0862236d-23aa-40ab-870f-cbd711b4cf49	10000	referralProfit
5c9c1923-832e-4133-9e10-aadc06438020	0956d132-2c95-491d-9168-76b49d248128	10000	referralProfit
536acddc-e767-4d2c-ac69-6f6b7601d5c1	6436b365-d1c3-418b-91fe-89ced8f83c29	10000	referralProfit
f6b4c43b-bf4d-4e30-8ec3-e9db4123e3de	420937c1-6b5c-4cfc-b5f2-f326fca9aefe	10000	referralProfit
72cf5010-ec1e-4dd7-b4fd-50579627eaca	3179d2c4-c5ed-47ce-801c-086d926d6696	10000	referralProfit
1c5561d0-8a5b-4783-b9a7-f0d431a24f10	d9a810df-ebbd-43b3-bed6-958e9255d059	10000	referralProfit
feb46af1-1170-4e53-9193-b36e1bafb0a2	de1e208f-eef0-49dd-a47c-a7316b98868a	10000	referralProfit
45f99431-59c1-402c-86cf-9ff583084ee5	c50e0244-2708-4828-b435-a538437d7ccf	10000	referralProfit
49f69853-82dd-4354-af66-eee4b67403e1	b274d74f-cbb7-497a-a965-5e0b773efb43	10000	referralProfit
aa5e20c6-de1e-4b2e-a667-47d35d57646d	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1	10000	referralProfit
c4da51f1-a233-4fab-826b-fbb13401205d	6ec71334-96e8-40e6-88b5-722780e75cdb	10000	referralProfit
464a90ca-54ed-46a7-a92b-e6f504d9d1db	694885f7-dea1-4c4c-b5d6-69997bb57ed4	10000	referralProfit
3f557799-cfbe-4b3c-b8a8-994a719a7c61	bdf20892-6c04-4799-85b5-0a7ec60d11a4	10000	referralProfit
df765027-906f-42d5-bf51-10af5b5c67ba	1b41e70c-950c-443d-bf3d-d57c96af8cd4	10000	referralProfit
b9e1a0c4-6192-414e-ac6c-b0bb95caa54e	9889a17d-730f-4b7a-8389-8e4c7d0f45a5	10000	referralProfit
9b2f940b-01e6-4089-85f2-12f00aaa749a	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6	10000	referralProfit
f69fb00c-729e-45f0-99aa-d27e5119c523	cb580957-0a49-4957-bd17-dd73c6e5fc1d	10000	referralProfit
41b3790a-8c44-47db-9a24-f074731104ee	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf	10000	referralProfit
6ea3b226-32f7-423c-a1fa-dfbeffe45a88	068bbdd8-214c-45c5-bbd3-31400b5775ad	10000	referralProfit
6e921dca-ff2e-4c49-b3bf-db354626eb5a	346af1cf-7bef-45e2-8fc6-9cfcdaa05300	10000	referralProfit
f771c2a4-0257-4d70-8c73-8d1537c0752e	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a	10000	referralProfit
e915fec7-c47a-4de6-83bc-7fac77232ebc	93492e19-b481-49c2-a2d6-c5e3644e3b2d	10000	referralProfit
b03171f7-3465-4826-b0a8-851d4cfb106b	3ae64b94-ddef-401b-b345-1cd8696fd967	10000	referralProfit
93a3d94d-d6c9-4eab-bb07-8ed84a63caa1	97647052-9891-4bd9-be9b-679ca79cb1d1	10000	referralProfit
489bba8c-10a6-41dd-b0b9-3a541783b511	6173e277-f662-4720-a5a1-f34a8bb9221a	10000	referralProfit
76d37963-1fbe-4c17-81cd-ed5e945f0285	b356cbf9-9aac-4203-922c-7904d844f00c	10000	referralProfit
c22e7e63-87ba-4bf1-8274-e9f8aef444c5	6dcf36ea-cec8-4420-97cf-f665b506fdb6	10000	referralProfit
2ce6233e-362f-46e6-a342-db695db80713	c1cee951-d219-41cf-a647-a61d07366fe7	10000	referralProfit
d8e71ed6-cf16-4e18-ba94-f50d525bb40c	0c957416-3d9d-45bd-80a4-780cb657a77b	10000	referralProfit
e0edf0d8-66e3-453a-90e9-09cb0c73a9da	2162f56a-8ced-4b3d-b071-1df7dc6760c5	10000	referralProfit
6001c8b5-26b9-48e2-9c61-0a82a08b5c55	60d6a675-4f9f-463a-b239-9e2643aaa8a9	10000	referralProfit
6443778a-b00d-4c29-98cc-2904e9f11ffe	808c6a76-ec6c-4090-af68-b7ee4c8f3630	10000	referralProfit
1fab9ce8-6e14-4f2e-ba0b-45d6ee477d3d	51be77b3-787e-4364-8765-273088974e06	10000	referralProfit
aa144a57-e8c4-4443-9262-c9049f9e9d46	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f	10000	referralProfit
54593426-5d70-4392-b873-ef6a20ffdd32	2db49b30-71d7-4b16-affa-c4ae49003071	10000	referralProfit
e2d0d14b-c62d-4276-add3-7b79b2625a3d	5c1d9e49-c3a0-4198-8f78-654398a73090	10000	referralProfit
f1f8f196-1ed3-4518-b59c-7dbc5b01424f	4c235c4d-1364-415e-a369-827f9aebf9a7	10000	referralProfit
dc0a6d13-30ad-4e0a-bf12-dd1f25f16cec	efa9d746-3805-4405-8b7b-191b9137f635	10000	referralProfit
ecf27c01-571a-4331-8205-5deb36ebf85c	45add737-f340-4de6-8273-a3c9b62d7e77	10000	referralProfit
d91ba566-f357-46e4-89cc-6cec05789b68	dd39ed92-48b8-45c2-b336-bb8e8b05013d	10000	referralProfit
7721c57d-2c4e-42ad-aefe-11c7d01d9cf8	901d66ce-8dd2-434b-92bc-052e6471a88c	10000	referralProfit
e2c19694-087c-45ce-8465-5a9453c98cb7	3c77db66-8cc1-4953-a924-d038408f309b	10000	referralProfit
229d7096-cbd4-47da-b414-297aa9129121	cecebe61-8db3-44cb-b651-29619044d686	10000	referralProfit
6a3c90c6-58d7-4dd3-b457-5f099dcdfd7d	dc58f57a-d332-4991-8059-634d9a50df68	10000	referralProfit
ebf65ce4-26e6-493d-ac7d-cfb3cdf71b5f	f690f183-cc78-44c1-b56d-98814d650919	10000	referralProfit
4d7b6d6a-f453-4cb2-a595-3f2f435d1918	a67b6419-7eac-4a49-816e-2bfdefde7c10	10000	referralProfit
ba920fc1-9d89-456e-8a94-7e843e118f7e	a8ccaea5-750e-4025-9374-ac12553f823d	10000	referralProfit
227f6695-e090-4d0c-9c26-22196def35f9	2292c89f-3fe1-4b0d-8592-ad943a5be66c	10000	referralProfit
a812df64-2785-468c-81ab-4dfb9153d830	755575c5-5262-402d-97d2-7563d211eb9c	10000	referralProfit
53779021-ddaa-410a-a09b-69550035eb30	8982b883-6019-4b06-8215-e28dc2a5914b	10000	referralProfit
a9f8a1e0-3195-4686-995a-18e7a3bd0a41	6ba47e11-ccbb-40e5-bf31-f0f22a10454b	10000	referralProfit
5ef245db-8253-4a2d-95af-48ba759ed61d	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a	10000	referralProfit
16608efe-1133-4367-9dee-ab3641855cca	83be342f-6be5-4728-9ec8-0aad63fcb18f	10000	referralProfit
f2e6e816-bbe9-43c9-ba8d-d9734705bc74	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6	10000	referralProfit
b3b16d99-1368-4683-a931-1c3ff6ccde3f	f39447bf-b1df-4970-89f7-a4df15c2a0c4	10000	referralProfit
c875ef03-88da-423f-a197-49ca873c9507	730c98e5-5ace-47c0-826e-c3543c9686cb	10000	referralProfit
e6238692-3b6f-4aa8-953b-321c58e6998f	c854f638-c2f6-47c3-8da5-8c688cb1f78c	10000	referralProfit
9c8522ef-027b-4450-a7af-065b27fb8ec4	05ab2789-6d48-4c89-869f-abe089fccb4a	10000	referralProfit
35d279f7-308c-405d-a2da-9994635f2f40	5891f499-7cc8-4d19-b3de-4b15c0624ef7	10000	referralProfit
50edf268-296d-4935-9382-d8cddc7e2fa1	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815	10000	referralProfit
00f866bf-42c4-41dc-8605-16ada8cd30fc	526b8286-c88a-40e8-87ef-b94ebea9e97d	10000	referralProfit
4cf98eee-1ed1-450a-b071-970b7cb5c3bc	49fe0add-1125-46cd-a368-f8411e43c44a	10000	referralProfit
e53baa6b-ea6e-4657-920f-8630941fae86	6d20670c-72c5-45d5-8525-9912c5ec1058	10000	referralProfit
83e107be-1e9d-42fe-9539-e5d75e944abc	d33ab7e2-0a7a-4266-912b-55c5f5b18241	10000	referralProfit
c34403f2-2372-4133-b442-cd99647fc9ff	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9	10000	referralProfit
884a402e-3124-42b3-a63f-79c0e6424b5d	6c1cc459-173c-490c-9990-d222300e188b	10000	referralProfit
ac0ccee5-8610-4a25-b878-50d9c4f33dc4	c62c44fd-85cc-4edd-a070-96a4ee09bcf1	10000	referralProfit
b6844591-4222-4c2f-bb4a-2d63e06d06e9	e64ccb49-7042-4678-9ab6-a8b8dadee65a	10000	referralProfit
6507053d-651f-420f-b643-90a84f25ce33	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd	10000	referralProfit
7ddd06ab-5161-464e-98c8-e50bd48e64dd	5db49be2-2435-460d-a6f4-f45b2f275436	10000	referralProfit
f6abbb3f-9501-4034-bfe6-d75060d55110	f1ba7109-837e-4fd7-944b-54d3b997fbfb	10000	referralProfit
d374bd73-956e-4a93-9a77-dd45a7393fce	5d4f5985-c330-48e3-a1e0-23760bc73f4f	10000	referralProfit
ae6b5dd7-4e0c-4a6a-b924-79cd4a74fc6b	a3c59c5b-c711-415c-b371-98ffb520891a	10000	referralProfit
2f1ea600-c424-4324-b1f2-d932106970e1	c49c5171-b397-41e5-a8cc-c3933347189f	10000	referralProfit
1494d4b2-f3ca-4945-ae3d-2f75dc822d45	a5266896-6503-4e85-a895-a82fe27c14c7	10000	referralProfit
1573c1b2-27c1-4a09-b844-07e3884f13ed	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1005000	referralProfit
f5fc594c-b781-4cfe-9812-11ff369c6acc	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
1b650da2-5f07-498c-b53a-ed06e978ed2b	9100f2ae-e4cd-448b-b40b-251e0eb3572f	10000	referralProfit
b5e88163-f73e-4f55-a1f6-a3a7c670eded	c95385ce-966f-49ed-8b4e-7b162d2b0d66	10000	referralProfit
ee201d3a-c79d-4ec0-8b68-a2e17887a92c	98dd5bf8-d2c3-411f-9fdf-57c51a150113	10000	referralProfit
c5e6c42b-905f-49d8-864e-ab133e4f6a59	c995dc27-5dc5-44f1-ad05-6f3d0350fe17	10000	referralProfit
8992f756-9d5b-41e4-8bf7-165ea262dd76	aef64f27-4ed3-47d5-8620-68378fb412ef	10000	referralProfit
1080e9c4-045a-4fdd-8713-0be5ee7787be	85729935-7993-4125-8562-127b29db7e60	10000	referralProfit
2a916604-10f5-46bc-8223-5ac0ef2ce11e	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a	10000	referralProfit
013af60c-7b00-4f66-bb55-06c73132e3ff	37d990e5-99ac-4bd1-9700-7f0efa185901	10000	referralProfit
efca7b7d-f79b-44d3-b8a8-b2cb3c5c7bd0	5eca0755-2466-4feb-851d-1e3f407260df	10000	referralProfit
a2219e63-280f-4dbe-ac53-56880e68d1df	a0a730cb-ef7e-4d49-a0a8-103d50af54fa	10000	referralProfit
e9626e8f-c31f-4c3e-8290-d547ed65d1a0	de0ce717-6916-4879-a04e-dbbdfadd4545	10000	referralProfit
7b0bc43c-ea11-4e66-9124-99b892a9b8c3	e0dbe070-d1ef-4573-8391-450a4b3eaaac	10000	referralProfit
fe362bf3-2f3f-4a70-a77e-8ce818098c55	63e30fe7-562e-4f11-9c47-09fa6e5188a7	10000	referralProfit
4d14dac6-3ea9-42e7-bb43-a56be76f62c7	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9	10000	referralProfit
7bda408c-4ac0-4999-8286-72914dda87e1	8e934c6e-187f-42da-9467-6ebc7ccd08bd	10000	referralProfit
c385d19b-3e2c-4cc2-a38b-38b545c7980e	3eab8b06-c057-432d-8042-0b15ad87bdc7	10000	referralProfit
435830f9-7304-47b7-af8a-a8667fa25385	971f7c33-1a8f-4d58-91c7-9342a9acd69a	10000	referralProfit
8b6d4eae-e439-4a72-9f29-7ec6b979b9e4	b7930946-5b11-41ae-9385-a05ff8b0bb77	10000	referralProfit
c1c058d2-4516-4ee2-bb0b-f8488fddb8ab	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b	10000	referralProfit
b7cf19fe-2cb1-4161-828e-9fcf20254726	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273	10000	referralProfit
9e1e176f-2c0b-4779-ac66-4d00d678a49a	e84e7f8b-1821-4957-962a-063ce11ec128	10000	referralProfit
aa2b7f9b-d6eb-4a60-b920-be17102137f9	dc5830a1-fb20-4421-ae24-00f9be9f0f04	10000	referralProfit
2b92524a-965f-44d8-9214-fd07def706e9	7165d010-24ea-45e2-994d-4597b6f7dc05	10000	referralProfit
b3547032-23d1-45e2-b3a8-7932ac010354	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413	10000	referralProfit
5863ef8c-e358-4dd8-a46a-864c3df66b38	5e0f7570-92f8-4c39-b7d4-e89276778d25	10000	referralProfit
a9dedb98-4e42-4d21-a3d7-42add4466e1e	dee1a302-1c56-4b6c-83f9-3bd8bf27323b	10000	referralProfit
8a940196-21ac-4072-8ebc-95e82b7cad60	5c7b80d2-5a14-4b72-ad4e-b30749b13074	10000	referralProfit
9f368989-6609-4eee-929a-16565b4d3793	0582992a-1e2c-4add-863b-b5f10d6b4992	10000	referralProfit
fcbbc8b5-62dc-4309-865d-4c846f37f122	a6759a4c-fc93-4995-9a6d-d30488ab7a12	10000	referralProfit
84f4a984-4133-41bf-ae88-e7f3cdbe96ab	e045da04-0570-4317-a560-7cbfeae6f59f	10000	referralProfit
36fdc9b0-cb9c-4da1-b82b-6527856719b4	573cd423-824d-4f62-bef0-2728da79fcaf	10000	referralProfit
6e887c8b-a250-4704-bd66-d35f4ecacb22	1d8467cd-0105-4e3e-957c-446e325920cb	10000	referralProfit
40c2d9bb-f0cc-4de9-b4e9-42c66ad1c563	ff338a1b-41d7-40fe-b370-c88ef7d387f8	10000	referralProfit
b7c34aab-c304-4e03-a7f8-49623fbcc730	22285a4b-a9a8-4aec-895e-5ea13125722b	10000	referralProfit
7e36e075-1f27-41f4-b583-7288a49e7f33	542780d9-35a1-4582-86d1-d9ff5971f4ae	10000	referralProfit
e57f4a9a-373d-4e0d-9ccd-fc3a53afd169	ff807dea-119e-487b-9e10-1f7a83b4e172	10000	referralProfit
ee4a0c29-19d7-4b26-8dc0-5a74d2cb5308	d816ad42-c674-4776-b507-f2ae86133a4c	10000	referralProfit
da402a6d-4ebe-46b7-8570-244e52906530	77d3e7a0-1cee-4856-9308-ae8830306caf	10000	referralProfit
0113a81b-e6c0-4910-a9a9-b698e2fdc63f	d79cceb2-5cbb-4477-981f-491a969067b6	10000	referralProfit
d3b7a322-c68e-43f6-ad2a-0f036d2b9920	86d277ca-6952-4753-9e13-ccdffb252b7b	10000	referralProfit
8e3e28e1-cebb-4c6f-ba5d-269b9fc80cc6	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6	10000	referralProfit
3dd8d20c-651d-433d-9e50-0c759598802c	40b38dd0-c020-4e26-bccc-14f5bfe21970	10000	referralProfit
15143563-8c90-49e2-8a27-cc594518c7cd	85b28ae1-f517-423e-bf6f-ef189248faac	10000	referralProfit
a758a03e-d13a-416f-8dba-f51a8a30ba26	3986bde4-e078-452d-ae3e-fd93454b4ce2	10000	referralProfit
13d6c790-c3fa-4351-8784-7d858b94aaae	db7f8158-f71a-4ecf-a0a6-48439a05d657	10000	referralProfit
60c7f0f0-f5ca-4cfc-930d-23450b88976f	e1e70295-5c37-4c51-8167-9898b9c506f2	10000	referralProfit
f08d7d72-6074-4fbd-8fc6-569f70463620	37e4bdbe-f7f9-433a-a726-c9990700701f	10000	referralProfit
68a5ae80-8436-4161-9fa2-7bece8f87a85	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3	10000	referralProfit
2a1ffbd9-a3fc-4143-a246-8feeb4d7c3b9	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec	10000	referralProfit
09f5ad59-5d4c-4c46-9735-da8f61a7a960	d543f357-e99d-4d70-b7be-2a98d055c997	10000	referralProfit
b8eb1242-18c4-48d4-9d19-030b9478d7b5	5c5f698f-3444-44bc-8055-c004d592e0f8	10000	referralProfit
5df723f0-fb11-4cca-b33c-fde41762d09f	2a74d774-a7c5-4b5f-839a-b1911e457bc2	10000	referralProfit
db4d3a6e-27d4-44c6-9109-8ae0f589c8cc	1131c61c-771b-4a75-a014-40a4731b9efd	10000	referralProfit
1363a128-7f70-470b-82d2-775c7d180190	a2643314-2a6f-4af7-bb1f-11494179d800	10000	referralProfit
ccc8fe49-3079-46b6-9f03-600dec2d59f9	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce	10000	referralProfit
6a5a777f-a7fa-4ba3-9785-2cf071fe5516	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372	10000	referralProfit
0fb70be6-e033-4bb3-b458-639b5b0c2cb8	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965	10000	referralProfit
5a6fed17-9823-4ed1-8972-bf74d3fd3e9a	59be1293-6788-45c2-b12c-d35d03727da2	10000	referralProfit
d8c212b8-a69c-4b36-bb4f-be2fefebaef4	e11b9a8c-c94f-48b5-b192-1a769c1442a7	10000	referralProfit
a50d13f5-adcc-4124-9683-79ff7bc9d752	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b	10000	referralProfit
747d2a9e-a88b-43d1-aad1-91a831b481f4	d1c81fcf-526f-468c-b8f1-1de6fe5ce572	10000	referralProfit
11c7e4f9-6575-4687-9ba0-3d508b2f7fe8	e1a109e1-01cc-476f-a100-046326507dc2	10000	referralProfit
3a3eb300-06d1-47d2-95da-c88fadf9fa51	1fdcbf6b-e670-46e6-a1f8-308621c26735	10000	referralProfit
b7c1fcac-4247-408a-9487-160704aba5dd	bd03e8cb-4881-43d1-aaaa-fd192db5b90f	10000	referralProfit
33a5e249-4171-4b17-a618-7a1698b7cfd8	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8	10000	referralProfit
8ce41c7e-f07f-4683-b22f-ada5684636ab	f423e5f2-d2de-4a4b-983d-7faeee04b0b2	10000	referralProfit
1e1cb352-359a-4f5a-a45b-d9ee037f0926	21782926-7972-49d8-b5a4-8163dda4d8bb	10000	referralProfit
4c57bb6a-42ec-4530-ac78-9c0822f90e50	0c875a99-42f1-4cb4-88ed-398b1c25b9fa	10000	referralProfit
642fb526-7ab1-49f4-8b1f-4668312043cd	3ba67b11-9e37-462d-83b5-ca4defebe4ed	10000	referralProfit
901691d7-9a5f-4c88-b78c-a349c78c55a0	bfc42f90-715d-47dd-bc34-8a3983fd76e5	10000	referralProfit
5c8a6eb3-4b21-4727-a771-69fdb22c3c49	38922471-48a4-430b-acf7-80399379a847	10000	referralProfit
3a70fc03-9544-4e6a-b378-2ea081646b2b	7d9c3111-4710-48a5-8e57-42e76f785f6d	10000	referralProfit
ccc8282c-8dbf-49ce-919a-e865f838425f	5cdf5b4f-0b52-4adc-a49a-6145cb01c326	10000	referralProfit
40aec632-8011-4be0-8ed2-3841338e8680	619ff42b-d080-4db1-b808-d769e69bee7f	10000	referralProfit
39802bae-c232-4082-884b-b129d4fa4c7f	c5533212-9300-4d0e-b460-5eabc1fa4a0d	10000	referralProfit
96920b4c-1fb8-4900-a875-bd876763e65e	b68c623a-ffa3-4a48-a3c9-76f2f700775b	10000	referralProfit
93e722e8-1a9a-469e-b950-0930fb894d01	5cd93a3b-b144-453a-a229-2757cb28df22	10000	referralProfit
bacb50fd-93bf-4ddd-a0d7-7388c33d5b20	4dd9f659-75d6-44f8-8fae-ac963c6746ab	10000	referralProfit
3542033b-cc6d-47b0-9d45-d6d61cb8523f	c357212b-e065-4c65-aaa5-7e8b8a14cfa0	10000	referralProfit
7b68f661-ae77-4bda-97a6-c0cb03d39f5b	f3fddd33-f77a-40e4-9897-55e61230d643	10000	referralProfit
bc02c5e3-a8e7-4785-ac7d-dfe83f57e0e9	5434fac2-36e9-4ff9-9955-ba531fbb1ba0	10000	referralProfit
d89f8769-3e56-48be-b375-990375d2227f	1c23cfd4-f4d7-49c5-8760-9600e414027e	10000	referralProfit
4ebf2123-8fa4-44be-8c5a-9b929fd5d388	31ae5186-dc5b-42c3-b676-8590c96de53a	10000	referralProfit
004d2072-f136-44cb-9017-62a0f04b64a4	d2615292-a50f-47ff-af73-437ec1eb0fea	10000	referralProfit
b191a010-da78-4cc5-8d57-7afe0d25f4c6	9f557edb-8adf-4832-bc25-ca5b00dfcf4a	10000	referralProfit
6c630801-0919-41fb-92de-f689a8507809	8fbf163b-f453-434e-ad19-10228894ee8c	10000	referralProfit
aac9f2ac-aee1-4eed-a516-984796604baa	d2834bcb-2154-433e-bb06-e8befbfd7368	10000	referralProfit
31f66206-1c8d-4f04-a913-1f8390f994b5	88421493-e09c-407b-91b7-a2bf5f633fa6	10000	referralProfit
b520f540-0a3c-4238-aa6f-e2970de4993e	45f32ed2-3673-4022-b0ad-e4d60362361f	10000	referralProfit
39fde806-cf1f-4c82-afda-d2775b7b3757	a6975bcc-4113-475c-9da0-5dcb952cf919	10000	referralProfit
23b4ff99-ef9a-41ff-a235-1bd6a696ea7e	eb838509-93c4-4e2a-a8c3-3bffd2acc82c	10000	referralProfit
b4747153-e447-4a7e-a8c6-42fea764415d	815ba1e6-a405-4df4-9909-7fbc8e87a4ac	10000	referralProfit
ab959507-f82a-4ca2-9eeb-12e0a87a4fb6	473b85ee-3707-4f2e-b370-74e791f3fe1e	10000	referralProfit
f4ebc71a-5ac6-4dcf-a9ed-bf6f63a524ad	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2	10000	referralProfit
8c6eee19-5d3e-40a7-a5de-6e5fdd230d90	e88ff86f-02ae-43ba-9060-727ec1a5558c	10000	referralProfit
0227bcbc-2b64-4d2f-b3f3-206348cab5d1	0e562d45-0328-4a97-939d-cd11bb7f2ed2	10000	referralProfit
516b69d7-aaec-4a61-832c-8b1607590624	6e4e0e64-47ea-44c0-a997-25766e1a85c1	10000	referralProfit
11c03115-2e04-43f6-89e3-f8a54e34860c	6ef284cd-4c54-42c0-99a0-619cb8442030	10000	referralProfit
80090acc-ce18-47e7-8c3f-6ae6ee6413ec	bce15c48-3692-4a64-a01c-9ae16080077d	10000	referralProfit
715b84da-d603-4e9b-b37c-61cb7ce07e39	d6bec1d0-48c5-4652-8612-b4667cb1c442	10000	referralProfit
62ee4ec3-fae9-4679-8f1c-986843097a57	c8434922-ec69-4e01-beef-8cfb6ad0f92b	10000	referralProfit
994854d5-22ec-4831-a99c-5cff8c358c9a	cebdc43a-6173-4d07-99df-6ffabe415516	10000	referralProfit
92dce5f1-4f5d-4d64-bbc6-8b8e93cd0738	949c4f91-4f71-4751-8c96-4113f5c1672f	10000	referralProfit
2ae459af-e6a3-4a9d-8c64-cedadfd1f2c9	9f19df17-a951-4493-944a-cd158fd5ca1a	10000	referralProfit
f2ba10d9-48c4-421b-9ee1-baa87bf8cfb0	f968fe68-30ae-42d2-9e74-08bf8e223215	10000	referralProfit
1be3bd19-e144-4329-8b29-08a6f9d73058	380bb01d-d981-4caa-b479-6089a516a075	10000	referralProfit
727f8c22-11ff-4160-a779-bfdf7675517b	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94	10000	referralProfit
bea91b7d-ba01-486b-89cf-38b5b35b6d4f	8749fd89-444e-4786-b0cc-6fed521bdc27	10000	referralProfit
9a418992-31da-4887-9125-2e396f0f75a3	3ecb5f1f-0418-41cd-af4e-93a4f558c522	10000	referralProfit
39a21ffc-b5c2-485e-9a6d-d2f33ffa2e1e	7170f559-0812-46be-9851-f1142c91d14c	10000	referralProfit
f92eaea2-bff6-47ba-8b93-20dfe6690d91	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	300	click
237331b0-ee8a-4de1-b205-bcf357292538	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
3271797b-e25a-49fb-9ff1-15b803e9e500	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
caa4b429-7af2-47f8-bd5e-91e136c83bbf	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
bd0dd278-73a8-4b39-bdb0-6603e69c3573	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	300	click
9948432f-a737-42f8-9324-15ac019b4ad0	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
5b3b9f2b-0cbc-4ab8-a014-d013b73b4ada	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
24b2143c-d823-4e59-bb55-a47534788253	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
f428547c-8043-4b02-934b-cf596f52b326	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	25000	quest
fc7d9a68-63b5-4ea8-8735-de87debc11c3	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
f927c11d-aab5-4f64-9c64-1ce8b297bc1e	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
18cdab28-c140-43bf-8147-97407f4f0580	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
29a089a3-c9f5-4732-98cd-94a8793d7994	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
e42fe115-ee13-487f-9b68-b84db056e810	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	200	click
f221a0f0-2541-4975-ab58-e0650c9ae45c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
3376fd04-ba16-4365-b8ed-93ac340a7ebc	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
4d7b1e9b-153e-48d9-93f3-288f5ad92988	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
9ae6e04f-2409-4725-a48b-f59a900d9c65	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90	10000	referralProfit
c3ca21fd-b1e2-40aa-8e48-fd9732faf7bc	21bc0cfa-c69b-454d-9c5b-4261dea59a6d	10000	referralProfit
b6496868-3471-4aed-8970-85d279009307	5566b584-2023-42f9-b25c-04d15223cd5b	10000	referralProfit
04bb12c9-086f-4e41-9aa0-3fe077e7c816	759b3797-b95e-4abc-a83f-c37bd6aa090c	10000	referralProfit
18c22eab-1667-48de-9d3b-dbc435baba0d	1203d0f1-1816-4998-93f0-bdb05c314cd4	10000	referralProfit
fcacdf43-e9bc-4362-877b-eb1fff49da27	ffb1879e-5a8e-46a4-80ec-fe36bd67e584	10000	referralProfit
737417c7-2cbe-4c4c-a781-87d18e0e3007	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c	10000	referralProfit
dd83493f-e981-45f2-af1f-be9e429a18c9	d04cb17e-fd2c-4727-acd1-76bad464dd01	10000	referralProfit
0b71242f-114d-4861-b23e-8d01be210ea0	5cb277d0-f9a3-4de9-9041-470811eeb375	10000	referralProfit
f037764f-c79d-4306-9da2-f271a79ae250	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6	10000	referralProfit
86ed888b-dc46-4310-a122-f903dc9c540b	57734c90-01d3-4f4e-828c-1201f65e42bf	10000	referralProfit
26747b47-12e0-456d-817f-23c7738c5c01	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad	10000	referralProfit
624d126e-4c39-4cea-afd4-1528dd690f7f	31765d40-d378-420c-a0b4-ca49e7ea59f7	10000	referralProfit
1017705b-4c99-4705-8874-2d6480d3188f	7b85a40d-2149-44be-a888-438cc50012f7	130650	referralProfit
10fe37a0-8321-436f-9123-e591752695f0	7b85a40d-2149-44be-a888-438cc50012f7	2700	click
aaa30b99-3482-49a1-af01-82adafe16f77	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
56212ab6-427d-425a-a71b-accee3c39c67	7b85a40d-2149-44be-a888-438cc50012f7	300	click
fb2da443-7d9d-4b42-aee3-27b109f66067	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
9707e0dd-6ebf-4ffb-bb2c-5aee413acf5d	7b85a40d-2149-44be-a888-438cc50012f7	21800	click
9c389b76-399e-4dcf-9fa1-90352ed716d5	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
cb9c3755-28e5-49ab-9719-08bac3059a1c	7b85a40d-2149-44be-a888-438cc50012f7	100000	rank
51f5ab76-b6ce-419c-9185-8d70b45de22e	2f0dee24-3f81-4ccf-8244-d6488d087f1f	10000	referralProfit
3d3dface-c793-492a-a150-372fbde60ad0	b6c3d582-e6cc-4814-a38f-7df873654608	10000	referralProfit
6ca67917-94de-499e-a7e5-318739430847	53d6dbf5-e190-4641-95a1-d734632637da	10000	referralProfit
18ebb1ff-3e26-46d8-b69c-930fcff16a0b	d19c8610-487a-48fc-87a1-9de1b1b9cb83	10000	referralProfit
6acea376-e7a2-4c65-a7c5-3342198c5678	145ff272-c8be-4461-b4aa-1a161a921aa8	10000	referralProfit
c5e80646-31e9-425c-b2e4-022d76e47833	bc505c03-f9ae-4e0f-99d5-a29a56830b15	10000	referralProfit
26191609-89cb-4a9e-95e9-e5813245e69f	7e5114fc-def2-4929-91d0-7ca9dc68b2ff	10000	referralProfit
beeaf8d0-966c-462e-bee5-850bd213f17a	1e65b0bb-703b-455e-a307-7f82464055e8	10000	referralProfit
541a5827-3f27-4c81-b615-b02bd6f7d7ba	e999b8ec-ee7a-4889-bec9-9afc50e88dce	10000	referralProfit
e8538326-1d2f-4595-baab-f8d6b0048c8c	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9	10000	referralProfit
b7ad0700-b443-45b1-86ab-fed3d2706f74	95f8b881-4861-4f7f-a209-5e6cf25b8d78	10000	referralProfit
dffa1d1e-9794-45d7-95c7-69171b4741b3	d62f5ea4-de23-4db9-afb5-db9334809de1	10000	referralProfit
02c76fb5-31c5-4be3-b96d-6208db768ccd	3bf937ce-d0c5-43bd-9119-f8590a8d574c	10000	referralProfit
e62238a6-32aa-4595-9f59-6d5904d716ed	616544be-8229-4e20-b1ec-3a286664cef5	10000	referralProfit
26f28c1c-c2b9-4fe6-8b57-edfac62d541f	e46a8c26-7345-4fed-b81f-2f3ebe9f3864	10000	referralProfit
9bc7b843-b195-43a5-9f86-f45ba9653095	1cb6a9e2-f9ba-412f-a284-23e6657ef879	10000	referralProfit
5c4ad2ec-1634-48c2-a673-7e4195ecb288	98431e33-b96a-4c71-a52d-07883fe7e945	10000	referralProfit
a75edf16-90cc-4251-8a64-6b8cba863ee5	9eca8ffd-2cf1-4293-af11-ed381f31d2d9	10000	referralProfit
09679530-289f-4ae2-9b58-dffef44385af	77d3d92a-1bc8-4648-b22d-401a09d08ab5	10000	referralProfit
0f6c8a02-a2d2-4d71-8ca2-884bf7e57684	182027a1-551c-4601-9b84-497348f94e1c	10000	referralProfit
a39b9f4c-5569-4794-852a-14971357dfd7	1caaf02e-4ee5-4c2b-b520-5846341805ef	10000	referralProfit
b1ade34a-d8d5-4b6a-8632-8fb53063cc29	7d633720-08f4-443c-942d-8da74df41a97	10000	referralProfit
ffcc7bf9-dabe-423e-905f-69968b2b9ab4	bf1a2431-a918-4a36-8334-ab6545e430f7	10000	referralProfit
86992e54-e7ad-4669-a194-d006ea0c683a	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8	10000	referralProfit
cbd624f8-1624-45bb-81b9-4f8671faffb2	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c	10000	referralProfit
462da308-330a-47b5-9c3e-44512945f31f	237b4a46-2822-46cd-b0ac-c82739829a00	10000	referralProfit
00c45d7d-f94c-4603-90ae-98f6fbffb7bb	51f92be1-4f22-406b-816a-637ac9c1f180	10000	referralProfit
3a8a74e2-cffb-4841-b3bd-b0a66502b164	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f	10000	referralProfit
d1791cce-999d-40cf-b2cd-95eee25793b5	5e30ec44-bf17-4518-b5c0-2c1d552a9777	10000	referralProfit
e91786c0-4cbd-45f7-9070-06d6b6ec4337	a080de1e-d906-40a2-9bb6-c3e7528d2b87	10000	referralProfit
5382678b-9710-4a50-b9f2-5e732d1c3a23	20bc764d-59d8-492a-b1e0-3d9814ad034e	10000	referralProfit
d3542902-b215-4eb2-9be2-753b142b4e85	188e2d5e-977a-4730-a383-0cf6431ec5fe	10000	referralProfit
376aac1d-df96-4d90-982d-14985b7407ea	6ae32738-74e8-4c49-91cb-e39f7e5df371	10000	referralProfit
2d58da35-f946-455a-99a7-43408bb0a69f	1e968ba6-7a32-4112-891d-a59c12be57c3	10000	referralProfit
d27061e8-7ace-4a84-a83c-be66cfa3154d	150bc895-b1c4-48b6-8acc-513947236dd1	10000	referralProfit
a6a3459d-62a1-40b5-ad8a-912c352c6db1	eff4d266-7f89-49e1-a67c-29c28ccd7b9f	10000	referralProfit
f3d6055e-2854-451d-a101-b9a012f4c82e	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2	10000	referralProfit
3eb70e9a-7408-485b-bd9f-273a1532f5c3	2bd87bc9-bbe0-4a68-b661-67cfc55995b0	10000	referralProfit
1eae4e92-fe6c-4230-9662-a77340e7ce02	e1f5d089-9099-4909-805c-7ddbdd74e0a3	10000	referralProfit
4626a897-27be-4cfe-b9a8-dc7d2293ac03	1532bb49-0e32-4841-8531-eb9f7d831abf	10000	referralProfit
1285ecc7-3a01-486d-82fb-9205405a0032	a18c5901-3cba-4f12-913a-2f901f7eda55	10000	referralProfit
7debbfa6-a8b1-41b1-814a-222b34737683	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a	10000	referralProfit
d211196a-2f44-4783-8198-7b3a2895c137	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd	10000	referralProfit
3532b687-c45a-4d50-a0b6-f70089a532ca	03c031d5-def4-4c9f-9c43-ead660b2ecd8	10000	referralProfit
5841f7e1-a105-4cf8-98e1-a5950fe0b3ea	85b9217e-e690-4560-862d-523b8ddf7390	10000	referralProfit
e8dc9986-5052-448c-a898-a91ce0b93a46	3c5d9bb9-923d-4745-a499-06d2421d8b06	10000	referralProfit
88e8e507-60bb-4e06-bb0f-64745dceb1a9	642a9f33-4469-4b32-b68f-cb043424e73f	10000	referralProfit
a97c7ff7-f469-480c-b23f-2833201de306	ba12359e-af2d-44ae-b25e-9430f2d3fdc7	10000	referralProfit
6a5c93db-314c-4639-8f77-6de76767edb2	e6286cf3-32ef-43d2-927c-c8c62b50d95c	10000	referralProfit
cda0491f-f3eb-4799-a673-3f473d32b59f	3054bbb2-244c-4974-b7e7-c29dac8b1dc3	10000	referralProfit
71ff776c-db61-4d05-98d8-34ff041d0088	c9ccd729-0b35-4fbd-8f52-20014506fa20	10000	referralProfit
0640f3a7-d757-42ac-a362-dc29668881e4	199da7e4-25bf-47ff-9e51-b5c412af57c9	10000	referralProfit
e6753f58-7798-43ca-bf91-d55bb52379cc	fd5550aa-da2e-42af-a466-67e2c59fe268	10000	referralProfit
c01ba7d8-d54b-4590-ab3b-379c3e95f5a6	f8f489c5-baee-42a7-a22f-ceda8b8d760f	10000	referralProfit
bea77db6-b456-41d8-b38e-04e6e180389a	a4f0921c-5929-49f3-a2d1-3f0048849db6	10000	referralProfit
498d659c-506d-4443-8dc4-e2e52aeca782	4e6759e0-6ce9-4277-bff6-d6033bb6f479	10000	referralProfit
51e82748-5060-4f7d-bdcd-bb055166c098	bda3c9ab-385f-461e-a1cd-37a52d5335c8	10000	referralProfit
45853668-10e2-49fa-89c1-80c09fc3877b	f868438a-b76e-46b3-abaa-f4405a63d0ff	10000	referralProfit
80b9f490-7b81-4a16-abb8-ccd030266e5b	5f4a33a0-6d96-44ab-8d8c-24a62013003f	10000	referralProfit
d3536fe1-b732-4ed1-bb2f-6f3c1b133974	02926a21-64dc-477e-880c-cd6b5eb3394f	10000	referralProfit
dadcb3af-fa42-4922-b7dc-c660bad68f99	a7f7e5ef-f3af-4ba4-b048-701b6582821f	10000	referralProfit
ec7288ba-9e91-47a5-b195-de358ff74202	04a2a76c-44ff-46d3-8155-1348edf1828b	10000	referralProfit
6e87915a-5581-4dfc-9723-ed9f524b3562	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8	10000	referralProfit
d8fbbbca-fdaa-4fc2-b003-25a68ec92bf8	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea	10000	referralProfit
b6d8b835-23a0-4818-bb42-a374881cb78f	b4085128-2dc7-4ed5-9332-959dce9b0cbf	10000	referralProfit
4c6e40f5-010b-43d0-94af-5bea9d226992	6305399c-c89c-4fb4-8570-42465bd1b79f	10000	referralProfit
6988e4b5-662b-4fa1-8bc7-b5868e578f2d	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8	10000	referralProfit
d6b70ad8-4a31-43e3-a8f1-b54d3723308f	c124d5e0-2509-43fa-8e0c-f07a9db962ed	10000	referralProfit
6389784e-fc72-477c-bd1a-7606af4229be	c0982b02-cecb-4f73-adb0-327258fe2f8a	10000	referralProfit
04ea07f2-6ff7-4bd9-8d2c-bab76b754ceb	2ae81c67-7c65-407f-862c-dc6877f856e0	10000	referralProfit
4d864b3a-bc40-4d1a-a352-beea7bc1ab11	e4cc5b33-8083-410e-b92e-60b818343a90	10000	referralProfit
f7217d71-44a3-4890-9234-7a84eb264df1	b97773e6-a871-4572-bac1-7a6637f059cb	10000	referralProfit
72351357-9fd4-4786-9ebb-94aa2e97ca8f	3c305397-9f6c-4189-aa05-f48fc6d4c02c	10000	referralProfit
a82786f2-3e78-4f07-af3a-02da25b31570	fc057676-e528-4fcb-a729-4f4eb9ee5e5b	10000	referralProfit
7dcdf1fc-7ed0-491e-a74f-461b188b4eba	38f81c95-5586-40dc-be11-7117fcd90f9f	10000	referralProfit
7608c8bc-1398-4e78-b12c-095c93afd2ca	fa3b4cdc-b7a2-4595-a7e4-ef474d129883	10000	referralProfit
9ecabb2c-ea3e-4e85-b544-f4497f0636db	adcd3d8a-71e5-4bea-880c-ea9f7284a724	10000	referralProfit
56b6da35-6083-4067-b89a-10a53db2775c	9356b60b-8ca4-459e-8347-04943b40dae5	10000	referralProfit
60258386-38eb-4603-9ea1-497ca29afd46	98b12365-5eed-4f3b-b615-ab87f317c2fd	10000	referralProfit
ad700f4d-f552-4955-93b0-97a9a735b109	feaeaa90-81a5-4098-b44e-d39b0d059cf9	10000	referralProfit
58a8fead-7d0c-424a-97f9-411699d38901	c7437b7a-8e9d-4fd9-a56d-05973ac990df	10000	referralProfit
4f6e8888-117e-4dbc-9aaa-4f2c972e18bb	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
c51c1910-c1d4-4157-88f9-d2d28282a196	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
af1bf469-2e6a-4dce-8d5b-fa274350da5e	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
0419b88d-4949-4450-a811-cd7d9499238f	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
fcc4189c-09ea-4b20-89b4-24fe82312043	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	25000	quest
c8bcceda-db52-4b0e-bfd6-05c91ae85feb	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
0f34d1cc-3277-43f4-845a-2815aacde698	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
540fa214-99b6-453d-86cf-6e992121561a	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	900	click
eaba0325-be63-4036-bc30-d1388cc53586	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
f159cb6f-a9b7-4524-aebc-852a77f24837	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	500	click
245925ce-02e4-4fee-a821-e3ae14c910c9	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
788ffbef-d665-4a15-b460-4f210d6a2189	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	100	click
7231e2cb-18a4-4554-83fe-5f228ca12a8a	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
be9827e0-1e15-4b97-a7d1-6337fed20913	c3d9b51f-dfea-40f0-a0d2-7f87737824c3	200	click
7040d732-e811-428d-9afd-b63428925438	c3d9b51f-dfea-40f0-a0d2-7f87737824c3	0	bossKill
d35cf137-143a-4452-98ea-19844df871dc	7b85a40d-2149-44be-a888-438cc50012f7	100	click
5bd8422a-8cea-44df-8a3a-e62cf6e251aa	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
02191ff6-2025-4c2e-ae41-cf31ff4f38cb	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
c898afcf-e16d-44f2-987a-da720e73d2ec	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
e0e80e9c-2a74-491f-9e8e-05cc79630bd5	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8000	click
824b7a2d-a0b7-4a54-9efc-5a592c544d68	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
62ef7d30-d050-48c7-a715-4bf366b9ce0e	5c88a435-14b9-4c7d-ae97-08c38822e5ad	34600	click
b5528385-d60b-4e86-bf8d-eef8d2066783	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
82ab734d-b9f5-4e65-a7a4-e53ece586495	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9300	click
5e54b611-ac3d-48dd-9526-1a8a251b90ba	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
2e2df55f-c7a5-4463-84aa-cbfa993833d7	5c88a435-14b9-4c7d-ae97-08c38822e5ad	21000	click
ed18a443-238f-4ed2-8b06-0e53757dc692	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
2716f520-e629-41f7-9c1f-06d308723bf7	5c88a435-14b9-4c7d-ae97-08c38822e5ad	800	click
cb662ca3-5c23-4c63-aac2-d77c5278d9e5	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
8b2aa2c1-ecc4-4194-9644-9a24dcfba3c4	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1600	click
c8e036db-f543-416f-a0c3-747eb56aa374	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
05fe1b5e-1617-48fa-b6e6-967ec4ac9084	5c88a435-14b9-4c7d-ae97-08c38822e5ad	24700	click
c5629326-3b5a-49dd-8feb-dd05926327f1	5c88a435-14b9-4c7d-ae97-08c38822e5ad	25000	bossKill
5bf9b0ba-4de2-4c77-9b45-25c911090dd9	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	700	click
824abb2a-5b0c-4be7-81c5-0213a439f372	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
d2bc8d3a-a065-4078-9a3e-d7768b5d42ab	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	25000	quest
41614d94-4bc4-4a10-a4d7-fe53a0251438	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
eaf1f798-69c3-4731-b2f7-87ebcd900a4a	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
a8eff233-6fd4-41d1-beb5-0abd5091be81	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	1000	click
eccf4b0d-9ec3-4b7f-a387-0062ae00cf5f	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
454397ab-a8a8-411a-a614-e23fed2fd22c	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	400	click
ff512164-ac9b-45f4-80a7-60f40d2eb391	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	0	bossKill
d4ed3e6a-6a57-40dd-b306-65c814565c1a	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	25000	quest
ba3eb60e-a293-4a3d-9005-4ababf80df87	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
0575aaf4-14a9-445c-a581-f618e099a373	7c191628-7c7a-4b36-85ca-4c6eb8333aaa	10000	quest
b1472528-e8be-4e64-bf56-3775cd08c2a0	7b85a40d-2149-44be-a888-438cc50012f7	300	click
526346be-8e8c-40ae-ac8d-b8ec95475077	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
e4c2b193-4739-4f56-b01b-d02fae01bbdf	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
bee4578d-0d2b-43b1-ab58-7621edad5265	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
25aca819-8612-4bea-a89d-917c1ad02f07	7b85a40d-2149-44be-a888-438cc50012f7	25000	quest
7209cb71-05f8-4641-acf4-cb60f91212f8	96f14723-7249-4338-a06a-3b6bbb2ca242	17600	click
27b2bcaf-f54c-4bdd-909d-192a95f66432	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
9249537d-e594-427e-acc7-e27b79a1e2d4	96f14723-7249-4338-a06a-3b6bbb2ca242	2400	click
55737ff0-74c0-4200-ade7-82d1a815d034	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
560c66b8-5be8-4501-9618-2ffe5a82dae4	96f14723-7249-4338-a06a-3b6bbb2ca242	31500	click
7fc0653e-ae2a-4b21-9a22-db16e7be0ce9	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
4904ef1b-4e3a-4d65-9d2e-9ea116c779d0	96f14723-7249-4338-a06a-3b6bbb2ca242	19800	click
581e651b-ad3b-4916-854b-4eeeefdf207f	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
f6624d93-e4b9-4700-b784-ed7683b4f3f4	96f14723-7249-4338-a06a-3b6bbb2ca242	16700	click
78037653-2d2e-4783-bbcb-0901dbb3d48d	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
640ccdda-a883-4232-914a-195f2543b438	96f14723-7249-4338-a06a-3b6bbb2ca242	1100	click
6864548a-2540-4b47-9f47-e4d78fa804e2	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
a6d3b4af-ecb1-4642-a885-9901e8f3f297	96f14723-7249-4338-a06a-3b6bbb2ca242	4800	click
ce4fe559-dc71-43b4-a6c3-b33aaabdc703	96f14723-7249-4338-a06a-3b6bbb2ca242	0	bossKill
77df07ee-70ec-434c-995f-1ac6943547c2	96f14723-7249-4338-a06a-3b6bbb2ca242	6100	click
bbb01ebc-89fe-4772-9753-b348b1b21cf9	96f14723-7249-4338-a06a-3b6bbb2ca242	25000	bossKill
127ae3e5-e920-4600-a452-3687e0f382de	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
fdf09aab-acd6-4faa-bd38-da4f95c43e6d	5c88a435-14b9-4c7d-ae97-08c38822e5ad	10000	quest
8988b6ef-15d7-482f-ab2b-de3643afac33	7b85a40d-2149-44be-a888-438cc50012f7	3300	click
32751b21-e61b-4c10-9dba-64ce6026ab9d	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
73d56d5c-1b61-430b-98fb-c24640030aaa	7b85a40d-2149-44be-a888-438cc50012f7	2700	click
406c7e28-bfa2-4a88-b777-0661976366e6	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
b7e9462d-1ceb-4fef-9ed5-e4d263ea3528	7b85a40d-2149-44be-a888-438cc50012f7	3500	click
93f85110-a866-4315-909d-b41bacf9b404	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
2214a298-0ddd-4d59-9577-cd08d039408e	7b85a40d-2149-44be-a888-438cc50012f7	100	click
bbf0ee01-a2c3-4671-8a45-6ecbef07c2d4	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
b9821fe4-4441-46ab-93d7-f074a259b1e5	7b85a40d-2149-44be-a888-438cc50012f7	200	click
89ed4041-b44f-41a7-a27b-a56380e14a3b	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
f393e1c6-3333-41fc-9bf1-3d49338bc5af	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	400	click
5f2d7ee2-2f5f-4948-a626-8e7472af9d47	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	0	bossKill
57031da7-9bfe-472b-9873-44c41a325637	7b85a40d-2149-44be-a888-438cc50012f7	200	click
14a5bbd1-b8fa-4f94-a4b5-2ce389c824ca	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
9147b066-1cb5-42f7-b771-ce907706217f	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	200	click
6e81665b-d3a8-4570-aac9-ae99a863c66d	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	0	bossKill
ebc6112d-006a-4b51-880c-c860ccc10c78	7b85a40d-2149-44be-a888-438cc50012f7	87000	click
13fc9c20-d920-402a-b5f5-8111eb5d028b	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
e1cdcc4f-1611-43b0-a458-cb755076f7ed	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	99400	click
4f46dc11-472d-4c21-8386-6f3dcf02977f	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	25000	bossKill
232ff7ba-e31c-4576-8572-ca08b0165627	7b85a40d-2149-44be-a888-438cc50012f7	2700	click
cb7f4048-5f99-47f6-801d-c72f3d5209f7	7b85a40d-2149-44be-a888-438cc50012f7	25000	bossKill
7857668b-9b27-434b-842c-66c14c25d4b9	dd775ead-f7b8-4c50-a7b1-cf1d90ae119b	50000	rank
2136b92d-e067-44cb-8f6f-bcbaf7a6bed7	7b85a40d-2149-44be-a888-438cc50012f7	5500	click
8d3720ad-f153-4a4d-a51e-40125dec0d76	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
5b1807b2-87c3-4a1c-bb97-373adce2ae7a	7b85a40d-2149-44be-a888-438cc50012f7	2500	click
7c47cafd-c83d-43c6-a21e-805499f828aa	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
64eac61f-5a58-40f6-8fc5-987ff6e124c2	7b85a40d-2149-44be-a888-438cc50012f7	46800	click
4b95dd0e-556a-4530-806e-12413ff0a3cc	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
8c52b7da-7531-43d2-9120-78c81c3b7356	7b85a40d-2149-44be-a888-438cc50012f7	39400	click
ee7bfe58-39ab-4a14-8ac5-4d4d38ae8d1c	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
5b39a8de-17e2-4295-a351-2116541ffc69	5c88a435-14b9-4c7d-ae97-08c38822e5ad	300	click
b0328fbd-cd96-40dc-94fa-d75c841114a2	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
cadeb2a2-6e54-4911-8d9a-af27c78a34d8	5c88a435-14b9-4c7d-ae97-08c38822e5ad	900	click
9e9c34b2-b961-42d9-964f-4a44c9329238	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
6659d584-1ba8-4e67-9c0b-7613551de3b5	5c88a435-14b9-4c7d-ae97-08c38822e5ad	700	click
35aa62e4-439b-46e1-909e-6d2b2d144886	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
3c73cd72-8fc1-448f-918e-fa7b54014b76	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1000	click
cd26b28b-eee0-4eaa-8163-64917eb1bcae	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
b2d33f4b-a03d-4e1c-824f-4e2f5fb8dd7a	5c88a435-14b9-4c7d-ae97-08c38822e5ad	900	click
8bff31d1-85d4-41e6-840b-c22be211ab1c	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
4d089c71-9f92-4499-ab20-b5402a207346	7b85a40d-2149-44be-a888-438cc50012f7	600	click
e4b6cdb4-1d3f-4679-88f3-a28bca6824ac	7b85a40d-2149-44be-a888-438cc50012f7	0	bossKill
f168013f-3891-4945-ae1d-9703b74f3122	5c88a435-14b9-4c7d-ae97-08c38822e5ad	50000	rank
a5f0aab7-cebd-4d90-9069-299bfed2354b	5c88a435-14b9-4c7d-ae97-08c38822e5ad	300	click
009079cf-acf6-4c5e-8c4b-afcbcd81c890	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
90865871-ac5f-4944-bfe9-38344d529a06	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100000	rank
e06267c2-4eca-45f3-bd97-d6e38e0a1c3f	5c88a435-14b9-4c7d-ae97-08c38822e5ad	150000	rank
2aba6bca-a775-483b-ab9f-5ef355731f78	5c88a435-14b9-4c7d-ae97-08c38822e5ad	800	click
eb12586c-2490-40d7-a4f8-2a308e10d6a1	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0	bossKill
6c7fd3d8-3678-45c6-8c00-ff8894043264	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
37cbc3e8-e842-4369-926f-8707f529920d	5c88a435-14b9-4c7d-ae97-08c38822e5ad	50000	bossKill
d2444f30-4799-4949-ab5a-d98e56da4205	7b85a40d-2149-44be-a888-438cc50012f7	5200	click
1060a83e-08c8-4343-abfc-0fd5f3745edf	7b85a40d-2149-44be-a888-438cc50012f7	50000	bossKill
2a7ee7f1-3189-46de-8335-e9a779f85336	7b85a40d-2149-44be-a888-438cc50012f7	150000	rank
0a0fd14f-321d-43ee-861d-ea275a5b5f3d	7b85a40d-2149-44be-a888-438cc50012f7	3100	click
bc3503cb-03dd-4248-ab0a-f321c49eced8	7b85a40d-2149-44be-a888-438cc50012f7	500	click
c391eb39-ff58-4285-871f-00067716efa4	7b85a40d-2149-44be-a888-438cc50012f7	1400	click
e82af6c9-7b7b-41aa-ab04-aed75800155a	7b85a40d-2149-44be-a888-438cc50012f7	75000	bossKill
23bfdad8-9609-4747-a165-114312b99204	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3100	click
361ddc58-fbbf-4cd5-9a41-bd5c62bddbd8	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1500	click
9dac375f-c38f-43b1-b09c-5935fd724bd9	5c88a435-14b9-4c7d-ae97-08c38822e5ad	200	click
b97c2dc4-3e1c-4439-ae5f-bc8fba713e0a	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
e7dde2ad-ed8d-4859-966b-0913be1fbff9	5c88a435-14b9-4c7d-ae97-08c38822e5ad	100	click
a9bce077-a793-4203-8834-add884968fde	5c88a435-14b9-4c7d-ae97-08c38822e5ad	75000	bossKill
b1f37b89-a666-45d6-b83d-29a8de77e1b0	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
c830cb85-8d02-4d69-a3c8-5a9ee9804030	7b85a40d-2149-44be-a888-438cc50012f7	10000	quest
62a0cfdb-341e-42e0-9bd7-cc95257526d2	7b85a40d-2149-44be-a888-438cc50012f7	25000	quest
\.


--
-- Data for Name: quest_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quest_tasks (id, quest_id, description, link, type) FROM stdin;
420c2a89-be9a-4857-bd05-7e6903ccfebc	1f542c73-89e5-4ab3-bcd0-244ca6bfcccf	Join our channel	https://t.me/working_front_2_group	SUBSCRIBE_TELEGRAM
2b67f178-2dcf-4534-a5d1-a0fddd67a5dd	92596306-cf8a-4210-8e6f-b8a4d6acc2b7	Join our chat	https://t.me/working_front_2_group	SUBSCRIBE_TELEGRAM
b491f565-c426-4466-b126-368132112f58	0529c270-58c2-42c3-9465-684bd6d33564	Join our Twitter (X)	https://x.com/beeversedao	OTHER
3af6506c-f5ba-4b98-8a20-516b80b14ec8	96c6e4f7-cb0f-46e2-8b32-c948d58d302b	Join our TEST CHANNEL (LINKED)	https://t.me/subschannel_test	SUBSCRIBE_TELEGRAM
2480f3ab-c4d9-4815-97e8-90e47b24c01e	96c6e4f7-cb0f-46e2-8b32-c948d58d302b	Join our TEST GROUP (LINKED)	https://t.me/working_front_2_group	SUBSCRIBE_TELEGRAM
2d1de81c-cc1b-4efa-a9e2-dd7e9783d2ab	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	Join our TEST GROUP (LINKED)	https://t.me/working_front_2_group	SUBSCRIBE_TELEGRAM
c405ccf3-450b-46f4-96c1-cf4767732139	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	Join our TEST CHANNEL (LINKED)	https://t.me/subschannel_test	SUBSCRIBE_TELEGRAM
a7273587-7d1a-4414-a7bf-798123723560	2f41ed54-3ea7-4968-b18f-a0a68221d7fa	Join our Twitter (X)	https://x.com/elon	OTHER
\.


--
-- Data for Name: quests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quests (id, link, reward, terms, description, "totalLimit", "currentLimit") FROM stdin;
1f542c73-89e5-4ab3-bcd0-244ca6bfcccf	https://t.me/	10000	Join our Telegram channel!	Subscribe to us, react to our posts, leave comments! (English only) You need to wait 24 hours for this quest to be counted. If you unsubscribe - it will fail!	0	16
92596306-cf8a-4210-8e6f-b8a4d6acc2b7	https://t.me/	10000	Join our Telegram chat!	Subscribe to us and chat with us! (English only) You need to wait 24 hours for this quest to be counted. If you unsubscribe, it will fail!	0	14
2f41ed54-3ea7-4968-b18f-a0a68221d7fa	https://t.me/	50000	[Partner quest] Join in our telegram channel, group and Twitter (X)	The conditions are simple - subscription to the Telegram channel, chat and Twitter group (X).	5000	118
96c6e4f7-cb0f-46e2-8b32-c948d58d302b	https://t.me/	25000	[Partner quest] Join in our telegram channels	The conditions are simple - subscription to the Telegram channel and chat.	4000	3522
0529c270-58c2-42c3-9465-684bd6d33564	https://t.me/	25000	Join our Twitter!	Follow us, like our tweets, leave comments! (English only) You need to wait 24 hours for this quest to be counted. If you unfollow - it will fail!	0	15
\.


--
-- Data for Name: ranks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ranks (id, bonus_amount, description, rank, name, required_amount) FROM stdin;
38cd4fd8-aa67-4919-aeb9-69aa873ec20c	0	0 rang	0	R0	0
f66de41e-b6bd-4df7-8d2d-400b8dac5cff	50000	Reward: Improved Boots in the future update + 50,000	1	R1	100000
6e6c1c2a-b108-429f-b7db-8a5a7e43d495	100000	Reward: Improved Gauntlets in the future update + 100,000	2	R2	500000
7c16d8d3-2740-4330-958b-113b1e63b1db	150000	Reward: Improved Cuirass in the future update + 150,000	3	R3	1000000
8fd5febd-c87e-418b-915e-3893cae8695d	250000	Reward: Improved Headgear in the future update + 250,000	4	R4	3000000
155e9cb5-e01e-4cc4-aa5c-5dee945696b3	500000	Reward: Improved Weapon in the future update + 500,000	5	R5	10000000
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referrals (id, created_at, referrer_id, referral_id) FROM stdin;
34658803-18e8-4881-91de-7da3be60e4a9	2024-08-28 05:48:12.626	5c88a435-14b9-4c7d-ae97-08c38822e5ad	32b069c3-007e-49c7-84fd-1231b4a2db4a
3f726556-2cb2-4bec-aed9-6d569889a271	2024-08-28 05:48:12.974	5c88a435-14b9-4c7d-ae97-08c38822e5ad	44023214-fb54-41f8-b586-783d108dbaca
88187d16-c55f-4f56-85ef-7b3455c25b82	2024-08-28 05:48:13.103	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f29d087c-a6fd-45ea-9fd1-8b25224cfb58
94b3735b-c994-401d-91e6-297dc7a02c9b	2024-08-28 05:48:13.223	5c88a435-14b9-4c7d-ae97-08c38822e5ad	35ab5d3f-c9db-40fd-a172-e7d5eedf861f
4e1c500c-f641-48b7-a8f3-a62d0af4baf6	2024-08-28 05:48:13.373	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c503dcb2-b7ee-4f15-b557-e25053de9313
a44968bf-9fc5-44aa-9761-d59c3d61ba08	2024-08-28 05:48:13.496	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8cbc9163-4ab0-43e6-bc37-9d092c4f8806
493f978e-68e9-41ff-b034-c86fda986bc1	2024-08-28 05:48:13.642	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7a782bd7-27b9-4f47-a28f-a751d2793a8a
cc0b1ab3-7b2d-4a13-aa84-b7789b005135	2024-08-28 05:48:13.768	5c88a435-14b9-4c7d-ae97-08c38822e5ad	aaae4527-f282-4a98-8c35-d644005b2c71
c0d756f5-3b8e-4862-9041-14abd616ad02	2024-08-28 05:48:13.869	5c88a435-14b9-4c7d-ae97-08c38822e5ad	923c26fb-cbae-43e4-8e2a-700903702517
87c4cb0a-dabd-4a16-869d-fe9cc4a488bb	2024-08-28 05:48:13.971	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e1848ae3-8949-448b-a578-76726c5b8a59
c11a49a3-ec4f-4147-ad90-d4f3543ad629	2024-08-28 05:48:14.069	5c88a435-14b9-4c7d-ae97-08c38822e5ad	cd4b3dee-e183-4c19-b6e6-a9c607a482e8
e50d5e64-f13b-47af-ab8f-ff353d3be42e	2024-08-28 05:48:14.193	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f02a6e78-e89b-4711-9071-f534ec255774
8188d0bf-7f17-44e0-a291-e85697b283e3	2024-08-28 05:48:14.364	5c88a435-14b9-4c7d-ae97-08c38822e5ad	73297b7f-b596-4f88-9882-5741d3c5bac6
15e32b9c-d28c-4cf8-8478-10ac2e2118a8	2024-08-28 05:48:14.455	5c88a435-14b9-4c7d-ae97-08c38822e5ad	fa3bb8cd-9908-4339-96a8-d61927544541
4c72639d-d587-4fd7-afd9-74372e7d1a20	2024-08-28 05:48:14.626	5c88a435-14b9-4c7d-ae97-08c38822e5ad	aeae88bc-8e6c-4f62-933f-0fa3e5e9f5f8
ca0c530a-f27f-4ccf-8172-b86b05d9a82e	2024-08-28 05:48:14.741	5c88a435-14b9-4c7d-ae97-08c38822e5ad	31f7a6ff-ebc2-4fb2-97ab-99b0ba78af2e
f34a3feb-427f-485a-b233-0634a6bd22f8	2024-08-28 05:48:14.832	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4c84519b-ac34-4171-91c3-0c664a03e2cb
48e6cd97-ff03-454d-9477-995e7dcaf9cc	2024-08-28 05:48:14.943	5c88a435-14b9-4c7d-ae97-08c38822e5ad	be3f0321-d6fb-4442-8146-1eeee301be02
0a78bd5d-7d9d-4e59-8501-fbab3e2cf467	2024-08-28 05:48:15.111	5c88a435-14b9-4c7d-ae97-08c38822e5ad	27aa7650-6bf0-496c-971b-013fe6af4bbb
bcd9eb98-60c8-4791-8a1d-3c18d0a94f68	2024-08-28 05:48:15.196	5c88a435-14b9-4c7d-ae97-08c38822e5ad	acd9b172-5bab-4a2a-987d-5b09bcfd94cd
35a33dec-ebed-4431-8e0f-f6a2919d13c4	2024-08-28 05:48:15.298	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6f26b2f9-41e4-4a1f-9a10-d0fca759f3a1
c3699ddb-a287-4d91-a55f-7b4196ea7628	2024-08-28 05:48:15.406	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4fac8997-e95e-4fc7-af66-ad553fd9666f
04d33eac-1ef3-4ada-81a6-6849bae5c2a4	2024-08-28 05:48:15.495	5c88a435-14b9-4c7d-ae97-08c38822e5ad	77d18071-abfc-4f46-828b-27543aa92f25
52200d60-f68e-4f9e-bf4b-94784b992e4a	2024-08-28 05:48:15.677	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d22a81a3-c6d1-43ea-a70d-14a4723d3a73
17e6dd30-7cdf-4ea1-81e7-3c59248eec0a	2024-08-28 05:48:15.816	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8fe21ee7-ced6-4a9e-86ac-9dbbdbaa003f
b57917a3-9355-4c96-9890-86a46f8af711	2024-08-28 05:48:15.981	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0862236d-23aa-40ab-870f-cbd711b4cf49
e0d7302c-68ee-48c2-bdf8-7bc74aa3dde0	2024-08-28 05:48:16.084	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0956d132-2c95-491d-9168-76b49d248128
96267b8f-03d4-4549-9f3a-5be56b912fb3	2024-08-28 05:48:16.182	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6436b365-d1c3-418b-91fe-89ced8f83c29
ca8871cb-3da0-4c67-b914-59c6e550f9bf	2024-08-28 05:48:16.273	5c88a435-14b9-4c7d-ae97-08c38822e5ad	420937c1-6b5c-4cfc-b5f2-f326fca9aefe
efb4632e-b929-4018-989d-92ea03878ecf	2024-08-28 05:48:16.396	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3179d2c4-c5ed-47ce-801c-086d926d6696
0c16c0a2-f946-4f0f-b708-df21d480196d	2024-08-28 05:48:16.515	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d9a810df-ebbd-43b3-bed6-958e9255d059
20b9f804-c7b5-4b3a-843f-2f7521ca3bca	2024-08-28 05:48:16.633	5c88a435-14b9-4c7d-ae97-08c38822e5ad	de1e208f-eef0-49dd-a47c-a7316b98868a
f9758f7d-f9fa-47c5-8398-3bf178521843	2024-08-28 05:48:16.789	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c50e0244-2708-4828-b435-a538437d7ccf
b9b3fc49-fb59-4723-928a-56bb27344d8c	2024-08-28 05:48:16.909	5c88a435-14b9-4c7d-ae97-08c38822e5ad	b274d74f-cbb7-497a-a965-5e0b773efb43
bcc52c03-4c0d-4509-a303-c7d403850a81	2024-08-28 05:48:17.035	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f937db16-7c3a-4cfb-9fd4-561aa6a0cea1
fc2f8d0a-6c59-409a-aa64-990ff91604f3	2024-08-28 05:48:17.153	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6ec71334-96e8-40e6-88b5-722780e75cdb
b63b2918-fd1f-4f8a-ad79-25900b3c019a	2024-08-28 05:48:17.268	5c88a435-14b9-4c7d-ae97-08c38822e5ad	694885f7-dea1-4c4c-b5d6-69997bb57ed4
b9e440ea-bf4d-4327-9948-fb1f147471fa	2024-08-28 05:48:17.434	5c88a435-14b9-4c7d-ae97-08c38822e5ad	bdf20892-6c04-4799-85b5-0a7ec60d11a4
fbb29d59-5bbe-4d3d-8eec-59cbf0fca67c	2024-08-28 05:48:17.557	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1b41e70c-950c-443d-bf3d-d57c96af8cd4
cd545788-8d22-476f-84e7-2ca27f7573c3	2024-08-28 05:48:17.672	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9889a17d-730f-4b7a-8389-8e4c7d0f45a5
5b407ee2-b24f-4401-8857-5050f1790076	2024-08-28 05:48:17.782	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2c189a3d-6af5-4b1d-81bf-a4d9e3601dd6
2a3c8de3-8806-436d-8071-bce4967e268f	2024-08-28 05:48:17.916	5c88a435-14b9-4c7d-ae97-08c38822e5ad	cb580957-0a49-4957-bd17-dd73c6e5fc1d
6226ea78-8ddb-4cf1-bb49-28ab6aefca07	2024-08-28 05:48:18.017	5c88a435-14b9-4c7d-ae97-08c38822e5ad	69dae976-82f2-45f8-bfc0-6bc2f9aa51bf
dbae032d-ba90-4064-bff2-af3ea8969316	2024-08-28 05:48:18.121	5c88a435-14b9-4c7d-ae97-08c38822e5ad	068bbdd8-214c-45c5-bbd3-31400b5775ad
c160b7a7-19db-442d-a7c4-60f7eb28f476	2024-08-28 05:48:18.207	5c88a435-14b9-4c7d-ae97-08c38822e5ad	346af1cf-7bef-45e2-8fc6-9cfcdaa05300
7119ef53-b175-4bea-86f5-ffc1e9503e75	2024-08-28 05:48:18.308	5c88a435-14b9-4c7d-ae97-08c38822e5ad	13dd2b89-d11a-4289-af0e-93cd7bf3fb1a
d0695fd1-ad6a-45cb-8869-ee3e5ffc0a5b	2024-08-28 05:48:18.395	5c88a435-14b9-4c7d-ae97-08c38822e5ad	93492e19-b481-49c2-a2d6-c5e3644e3b2d
ba980a3e-5b8d-42e2-a045-760d07b9f06c	2024-08-28 05:48:18.5	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3ae64b94-ddef-401b-b345-1cd8696fd967
ad8f60a3-42ff-42dd-b606-25c78d2d9099	2024-08-28 05:48:18.602	5c88a435-14b9-4c7d-ae97-08c38822e5ad	97647052-9891-4bd9-be9b-679ca79cb1d1
395dca84-3191-4196-9034-e1a26dc38ab5	2024-08-28 05:48:18.691	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6173e277-f662-4720-a5a1-f34a8bb9221a
6d4a305d-6beb-410d-9e3e-bd1f072c16a1	2024-08-28 05:48:18.793	5c88a435-14b9-4c7d-ae97-08c38822e5ad	b356cbf9-9aac-4203-922c-7904d844f00c
29c81474-d6ac-4a77-8332-a09fa1e4d027	2024-08-28 05:48:18.921	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6dcf36ea-cec8-4420-97cf-f665b506fdb6
68d2f376-281c-48b6-8890-40860577b891	2024-08-28 05:48:19.015	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c1cee951-d219-41cf-a647-a61d07366fe7
a650c73a-6ba9-417f-a604-3b0cd237b4df	2024-08-28 05:48:19.153	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0c957416-3d9d-45bd-80a4-780cb657a77b
de7ebc72-dbae-4e2d-8441-40d4f4b17756	2024-08-28 05:48:19.284	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2162f56a-8ced-4b3d-b071-1df7dc6760c5
2ef8fdb5-40b7-4ab9-b5bc-12106de26a9f	2024-08-28 05:48:19.407	5c88a435-14b9-4c7d-ae97-08c38822e5ad	60d6a675-4f9f-463a-b239-9e2643aaa8a9
83f19539-17b9-4b7f-adb7-ee94ec934c96	2024-08-28 05:48:19.562	5c88a435-14b9-4c7d-ae97-08c38822e5ad	808c6a76-ec6c-4090-af68-b7ee4c8f3630
fe2dd3ef-4d65-46ca-8c92-86820d0120d2	2024-08-28 05:48:19.677	5c88a435-14b9-4c7d-ae97-08c38822e5ad	51be77b3-787e-4364-8765-273088974e06
7d0893d2-69c0-4afa-851c-da10d9a16cff	2024-08-28 05:48:19.78	5c88a435-14b9-4c7d-ae97-08c38822e5ad	ea01fbc0-7a7d-4380-a6a2-628fb13c9e7f
44f23df8-9459-419a-adab-adebef571ead	2024-08-28 05:48:19.881	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2db49b30-71d7-4b16-affa-c4ae49003071
9c443284-a62d-466f-bdb6-8a60140013a4	2024-08-28 05:48:19.984	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5c1d9e49-c3a0-4198-8f78-654398a73090
161d3deb-208a-4403-ae00-f9828b39f5e8	2024-08-28 05:48:20.118	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4c235c4d-1364-415e-a369-827f9aebf9a7
ab8a69f6-22c9-4160-a2d3-78ad0858e828	2024-08-28 05:48:20.219	5c88a435-14b9-4c7d-ae97-08c38822e5ad	efa9d746-3805-4405-8b7b-191b9137f635
9be1215c-1d4e-4a50-8c0d-b16dccf62a97	2024-08-28 05:48:20.304	5c88a435-14b9-4c7d-ae97-08c38822e5ad	45add737-f340-4de6-8273-a3c9b62d7e77
27c53c2e-9332-464e-bbca-2bf02b177a47	2024-08-28 05:48:20.384	5c88a435-14b9-4c7d-ae97-08c38822e5ad	dd39ed92-48b8-45c2-b336-bb8e8b05013d
a5cd97a2-36ba-4ee7-a7e6-fd1abe1a682d	2024-08-28 05:48:20.502	5c88a435-14b9-4c7d-ae97-08c38822e5ad	901d66ce-8dd2-434b-92bc-052e6471a88c
d738c207-3b12-462b-bf9c-d066b9cb5015	2024-08-28 05:48:20.592	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3c77db66-8cc1-4953-a924-d038408f309b
1fd8f52b-7397-43fb-bffe-c52acc57f244	2024-08-28 05:48:20.694	5c88a435-14b9-4c7d-ae97-08c38822e5ad	cecebe61-8db3-44cb-b651-29619044d686
10b196ca-77dc-4416-9b0a-bebe982a3c00	2024-08-28 05:48:20.803	5c88a435-14b9-4c7d-ae97-08c38822e5ad	dc58f57a-d332-4991-8059-634d9a50df68
0b7be73d-94a5-4876-9ba6-4078ab349b7a	2024-08-28 05:48:20.899	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f690f183-cc78-44c1-b56d-98814d650919
af571cde-3ae3-4e60-8f77-53fca320e0a1	2024-08-28 05:48:21.014	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a67b6419-7eac-4a49-816e-2bfdefde7c10
ad86727e-6083-4ed6-98e0-7825c8f3f6a5	2024-08-28 05:48:21.158	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a8ccaea5-750e-4025-9374-ac12553f823d
c5c9e0b6-f315-48d9-9f30-535547a2c360	2024-08-28 05:48:21.294	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2292c89f-3fe1-4b0d-8592-ad943a5be66c
efeabf13-190f-4e52-ac23-2169d70db6c6	2024-08-28 05:48:21.439	5c88a435-14b9-4c7d-ae97-08c38822e5ad	755575c5-5262-402d-97d2-7563d211eb9c
dfb28d8a-03f3-4f02-ab47-62d53f2ede03	2024-08-28 05:48:21.568	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8982b883-6019-4b06-8215-e28dc2a5914b
56344fb3-851e-4f27-b14e-3c6dc5ff838f	2024-08-28 05:48:21.661	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6ba47e11-ccbb-40e5-bf31-f0f22a10454b
8e7990e3-288f-4218-8ad4-63aec37cab0b	2024-08-28 05:48:21.755	5c88a435-14b9-4c7d-ae97-08c38822e5ad	22c19b3c-f50c-4061-b6ed-e4c4c7a2093a
b1b3aec9-07e3-4726-bcd4-6c378621a9af	2024-08-28 05:48:21.933	5c88a435-14b9-4c7d-ae97-08c38822e5ad	83be342f-6be5-4728-9ec8-0aad63fcb18f
58ba5c31-fe8c-42d6-a19a-d5ce4ad95069	2024-08-28 05:48:22.034	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4ef70c4a-74e0-4cc3-9562-ad2fbb1515f6
a2a46bab-b88e-4064-98f3-17af3d1f1f0e	2024-08-28 05:48:22.212	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f39447bf-b1df-4970-89f7-a4df15c2a0c4
a22d9a1d-794a-4a03-a4f5-6641f802d2b3	2024-08-28 05:48:22.295	5c88a435-14b9-4c7d-ae97-08c38822e5ad	730c98e5-5ace-47c0-826e-c3543c9686cb
28975739-5a8c-4cd7-9139-b190b1d64a1a	2024-08-28 05:48:22.36	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c854f638-c2f6-47c3-8da5-8c688cb1f78c
c94bd758-abbe-44a4-bcfa-1830582cf831	2024-08-28 05:48:22.445	5c88a435-14b9-4c7d-ae97-08c38822e5ad	05ab2789-6d48-4c89-869f-abe089fccb4a
64eb6a9b-cc76-48dd-8afb-2b8c9370ade3	2024-08-28 05:48:22.554	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5891f499-7cc8-4d19-b3de-4b15c0624ef7
153cad03-eefc-4a0c-9106-7384daaf70c2	2024-08-28 05:48:22.677	5c88a435-14b9-4c7d-ae97-08c38822e5ad	b92d5fa5-f0b6-4f61-8ed6-0f5b36da6815
dc080a99-202c-464a-a29c-a821eeccde3d	2024-08-28 05:48:22.804	5c88a435-14b9-4c7d-ae97-08c38822e5ad	526b8286-c88a-40e8-87ef-b94ebea9e97d
68a3d8c3-ef13-4560-ba0f-7ad0841d63e5	2024-08-28 05:48:22.901	5c88a435-14b9-4c7d-ae97-08c38822e5ad	49fe0add-1125-46cd-a368-f8411e43c44a
f7ec53c3-c596-46a5-ba4f-b40a90672320	2024-08-28 05:48:23.041	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6d20670c-72c5-45d5-8525-9912c5ec1058
282e7d2c-ef3a-49e6-8a09-df43bf284879	2024-08-28 05:48:23.194	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d33ab7e2-0a7a-4266-912b-55c5f5b18241
1cf232b8-147f-477f-8933-efad1f181763	2024-08-28 05:48:23.292	5c88a435-14b9-4c7d-ae97-08c38822e5ad	623a9cb9-57fa-48f7-a1dc-fcd67fd076f9
e94058c5-c830-4a1e-aaf9-38fb17a02b49	2024-08-28 05:48:23.412	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6c1cc459-173c-490c-9990-d222300e188b
04f918b1-9742-4a00-a8c9-dbbd2b9c02db	2024-08-28 05:48:23.508	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c62c44fd-85cc-4edd-a070-96a4ee09bcf1
27e0890a-e338-4410-a3ad-1c0f9ed8c403	2024-08-28 05:48:23.599	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e64ccb49-7042-4678-9ab6-a8b8dadee65a
203a848c-7c11-43a8-a364-069b64a6380c	2024-08-28 05:48:23.736	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5a27a32e-f96b-4461-b54b-c5e8dd4c88cd
4a9952d1-971e-4f88-8ce9-6ddf07a7f213	2024-08-28 05:48:23.866	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5db49be2-2435-460d-a6f4-f45b2f275436
9619e635-a47e-4452-99f1-8ca5839910e0	2024-08-28 05:48:23.957	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f1ba7109-837e-4fd7-944b-54d3b997fbfb
ae532b8e-a99d-45c7-9522-c69d5c4a3355	2024-08-28 05:48:24.053	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5d4f5985-c330-48e3-a1e0-23760bc73f4f
0eb72259-919f-49c8-9804-971bfdb38f44	2024-08-28 05:48:24.137	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a3c59c5b-c711-415c-b371-98ffb520891a
53883e2d-9c47-442e-aab7-3c1e34a7091a	2024-08-28 05:48:24.243	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c49c5171-b397-41e5-a8cc-c3933347189f
0e0f117b-2cec-460f-a55b-47adfffd759e	2024-08-28 05:48:24.323	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a5266896-6503-4e85-a895-a82fe27c14c7
5ee7ad3d-98f3-4718-a9c1-9392d34ea08f	2024-08-28 05:55:03.196	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9100f2ae-e4cd-448b-b40b-251e0eb3572f
f853698b-ac1d-48bf-99e9-fa3370647514	2024-08-28 05:55:03.477	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c95385ce-966f-49ed-8b4e-7b162d2b0d66
bb798cc9-c88a-4c0d-9081-ca4f76e10a2c	2024-08-28 05:55:03.641	5c88a435-14b9-4c7d-ae97-08c38822e5ad	98dd5bf8-d2c3-411f-9fdf-57c51a150113
f27a85c4-a4f2-4c60-85b7-45303dcc1bb4	2024-08-28 05:55:03.756	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c995dc27-5dc5-44f1-ad05-6f3d0350fe17
706c3d67-9dc0-4430-a8ed-22a89922ac4b	2024-08-28 05:55:03.845	5c88a435-14b9-4c7d-ae97-08c38822e5ad	aef64f27-4ed3-47d5-8620-68378fb412ef
270bfffa-8798-4532-90c1-64ac81e6f285	2024-08-28 05:55:03.978	5c88a435-14b9-4c7d-ae97-08c38822e5ad	85729935-7993-4125-8562-127b29db7e60
aebf73e8-d15a-41d3-821a-dec7fe237216	2024-08-28 05:55:04.115	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1d7b25d3-d73d-4030-b1d8-5663b1b0a42a
efe10c4e-b29e-4709-9970-99d2f92c693b	2024-08-28 05:55:04.328	5c88a435-14b9-4c7d-ae97-08c38822e5ad	37d990e5-99ac-4bd1-9700-7f0efa185901
98544b9b-c21b-493e-bab3-1f1fe1f1a6ec	2024-08-28 05:55:04.483	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5eca0755-2466-4feb-851d-1e3f407260df
86c4d203-3f6e-4524-838b-0a21b30a1f84	2024-08-28 05:55:04.694	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a0a730cb-ef7e-4d49-a0a8-103d50af54fa
1d216279-0cac-41f3-95bc-859482822ef4	2024-08-28 05:55:04.877	5c88a435-14b9-4c7d-ae97-08c38822e5ad	de0ce717-6916-4879-a04e-dbbdfadd4545
212aa2a7-b567-4fc1-b172-30e55a855a6b	2024-08-28 05:55:05.063	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e0dbe070-d1ef-4573-8391-450a4b3eaaac
cdcbe5ad-7d82-4af1-8e54-b8fda69caef4	2024-08-28 05:55:05.354	5c88a435-14b9-4c7d-ae97-08c38822e5ad	63e30fe7-562e-4f11-9c47-09fa6e5188a7
a9186820-8607-4fa2-9b8a-62e45117fa21	2024-08-28 05:55:05.517	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8fd4ea80-9f8b-41f5-acd7-fb8d9d1a41b9
d7771ebf-1a3a-46d0-8eef-479d6b942c10	2024-08-28 05:55:05.602	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8e934c6e-187f-42da-9467-6ebc7ccd08bd
7b157ce1-c0ac-4c06-9cda-02286fb4fe42	2024-08-28 05:55:05.723	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3eab8b06-c057-432d-8042-0b15ad87bdc7
5ae24ceb-bea8-489b-bf9e-7711e36e5551	2024-08-28 05:55:05.812	5c88a435-14b9-4c7d-ae97-08c38822e5ad	971f7c33-1a8f-4d58-91c7-9342a9acd69a
0fd6ef04-3ae2-4059-ac23-0bae63cd882b	2024-08-28 05:55:05.938	5c88a435-14b9-4c7d-ae97-08c38822e5ad	b7930946-5b11-41ae-9385-a05ff8b0bb77
14a7bb42-28a3-4c11-b46c-e13f229c02af	2024-08-28 05:55:06.105	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8b99d539-7c3e-4f23-b9e4-1012e7f2a32b
e32f2fdd-323f-41c8-9deb-1c0744935087	2024-08-28 05:55:06.364	5c88a435-14b9-4c7d-ae97-08c38822e5ad	77ea0cd2-5f7a-4a82-bcb8-bbf994c80273
4a35c333-42d4-4aa0-af9b-ac62b9b44a21	2024-08-28 05:55:06.6	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e84e7f8b-1821-4957-962a-063ce11ec128
bf2d15eb-8758-4702-96fa-67636be57cb1	2024-08-28 05:55:06.723	5c88a435-14b9-4c7d-ae97-08c38822e5ad	dc5830a1-fb20-4421-ae24-00f9be9f0f04
096d6295-250d-4824-b35d-2ad6c78177bb	2024-08-28 05:55:06.95	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7165d010-24ea-45e2-994d-4597b6f7dc05
be24fdf1-2c5c-4c00-94d7-93260b068842	2024-08-28 05:55:07.3	5c88a435-14b9-4c7d-ae97-08c38822e5ad	98b03e2e-e5a7-4f3a-bd04-a7ad56cd7413
f5454a1d-4d9a-4493-b303-f4fe45849acd	2024-08-28 05:55:07.388	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5e0f7570-92f8-4c39-b7d4-e89276778d25
7e4f52bd-8d05-4a3e-baac-71caa0d7f1b0	2024-08-28 05:55:07.552	5c88a435-14b9-4c7d-ae97-08c38822e5ad	dee1a302-1c56-4b6c-83f9-3bd8bf27323b
bc45b0bb-cc5e-44f2-8bca-db3c7ae55e54	2024-08-28 05:55:07.724	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5c7b80d2-5a14-4b72-ad4e-b30749b13074
f295a68f-789b-4027-8c38-52bd0e6d3309	2024-08-28 05:55:07.826	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0582992a-1e2c-4add-863b-b5f10d6b4992
c873dfc1-a651-4134-abc9-ceb1ef853fc2	2024-08-28 05:55:07.993	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a6759a4c-fc93-4995-9a6d-d30488ab7a12
c8ee14e6-a1ef-4ccc-86db-74bf1b22b64d	2024-08-28 05:55:08.142	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e045da04-0570-4317-a560-7cbfeae6f59f
edd14398-d245-47a1-acf5-2733e5a3f5db	2024-08-28 05:55:08.252	5c88a435-14b9-4c7d-ae97-08c38822e5ad	573cd423-824d-4f62-bef0-2728da79fcaf
90ee5875-c579-431b-b9bc-6c2276e53b14	2024-08-28 05:55:08.39	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1d8467cd-0105-4e3e-957c-446e325920cb
fc4eaf37-ad91-4fad-bad3-eb9303578742	2024-08-28 05:55:08.542	5c88a435-14b9-4c7d-ae97-08c38822e5ad	ff338a1b-41d7-40fe-b370-c88ef7d387f8
50ce471d-9dc1-40a0-b51e-bab988e99371	2024-08-28 05:55:08.653	5c88a435-14b9-4c7d-ae97-08c38822e5ad	22285a4b-a9a8-4aec-895e-5ea13125722b
3ff659b0-456f-4d5f-a7ef-9c62ef1b97ab	2024-08-28 05:55:08.745	5c88a435-14b9-4c7d-ae97-08c38822e5ad	542780d9-35a1-4582-86d1-d9ff5971f4ae
394751be-02f3-4bc9-abd6-87faa59a0b48	2024-08-28 05:55:08.848	5c88a435-14b9-4c7d-ae97-08c38822e5ad	ff807dea-119e-487b-9e10-1f7a83b4e172
23e3bf7e-dc06-4e03-a300-5ee2fa7effb8	2024-08-28 05:55:08.95	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d816ad42-c674-4776-b507-f2ae86133a4c
2a6f827c-7dc3-4873-bac9-465c8c6d8280	2024-08-28 05:55:09.128	5c88a435-14b9-4c7d-ae97-08c38822e5ad	77d3e7a0-1cee-4856-9308-ae8830306caf
4c9e5b2a-7aea-4860-b7e3-0addc1ddab5d	2024-08-28 05:55:09.227	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d79cceb2-5cbb-4477-981f-491a969067b6
b8c29bf4-a889-4cc2-9cdc-17552962b907	2024-08-28 05:55:09.371	5c88a435-14b9-4c7d-ae97-08c38822e5ad	86d277ca-6952-4753-9e13-ccdffb252b7b
fca568bd-6a98-45da-86bc-6d02e23af126	2024-08-28 05:55:09.461	5c88a435-14b9-4c7d-ae97-08c38822e5ad	ba8cb7c3-6c1b-4d99-8ef5-eac602f623b6
874fe5dc-cefa-401d-95a9-51aabcb2e1d9	2024-08-28 05:55:09.557	5c88a435-14b9-4c7d-ae97-08c38822e5ad	40b38dd0-c020-4e26-bccc-14f5bfe21970
538fa54a-0f4b-4cc0-a9aa-efa0a39d597c	2024-08-28 05:55:09.758	5c88a435-14b9-4c7d-ae97-08c38822e5ad	85b28ae1-f517-423e-bf6f-ef189248faac
c921ed3f-a990-44e8-b953-d41d8d4d2242	2024-08-28 05:55:10.029	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3986bde4-e078-452d-ae3e-fd93454b4ce2
0c35e212-9654-4231-acb0-951c07e45829	2024-08-28 05:55:10.131	5c88a435-14b9-4c7d-ae97-08c38822e5ad	db7f8158-f71a-4ecf-a0a6-48439a05d657
c6337b1f-16a3-49a1-b107-33bc37dc6734	2024-08-28 05:55:10.238	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e1e70295-5c37-4c51-8167-9898b9c506f2
58748428-51d7-48d0-87dd-054d008be653	2024-08-28 05:55:10.396	5c88a435-14b9-4c7d-ae97-08c38822e5ad	37e4bdbe-f7f9-433a-a726-c9990700701f
e2664ad9-a5ee-4a6e-a8f1-34c490238360	2024-08-28 05:55:10.516	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9cfbfce2-bb0f-4ac2-a5c9-e144790065a3
d30a2df5-b4ec-4d2e-a51c-147340cbbc4b	2024-08-28 05:55:10.61	5c88a435-14b9-4c7d-ae97-08c38822e5ad	61a72ae7-2a5e-4fd2-bbcd-93c132b8a2ec
762aa40d-da95-4427-9e13-c2421e513626	2024-08-28 05:55:10.742	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d543f357-e99d-4d70-b7be-2a98d055c997
ccc6d1c0-5a05-4d3d-b80f-0e12059db7be	2024-08-28 05:55:10.875	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5c5f698f-3444-44bc-8055-c004d592e0f8
19368d5b-ae86-4508-a7ab-03c87336ce42	2024-08-28 05:55:10.987	5c88a435-14b9-4c7d-ae97-08c38822e5ad	2a74d774-a7c5-4b5f-839a-b1911e457bc2
be7b40fd-b887-4b6c-ac65-94751674832b	2024-08-28 05:55:11.16	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1131c61c-771b-4a75-a014-40a4731b9efd
4d8260b9-8506-4582-8641-f56e2298d7b2	2024-08-28 05:55:11.241	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a2643314-2a6f-4af7-bb1f-11494179d800
f141e5e9-2319-47af-b426-f6ceca6568c4	2024-08-28 05:55:11.374	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9aa27e23-c3ed-4d09-b2c1-1b34fb3450ce
ff54eda3-559d-4e0d-ba29-6657143f487a	2024-08-28 05:55:11.466	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d1d70dc8-eb61-4d4f-ad32-e1fcdfcb4372
83123edc-507c-41dc-acde-1f415cd20180	2024-08-28 05:55:11.554	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6a7ed2ef-8b78-44ec-a3cb-b74a5380f965
461c0269-91f9-4417-b059-ea788b988966	2024-08-28 05:55:11.68	5c88a435-14b9-4c7d-ae97-08c38822e5ad	59be1293-6788-45c2-b12c-d35d03727da2
cc614cfb-17e6-4964-b2db-fbc7e5ed84ed	2024-08-28 05:55:11.874	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e11b9a8c-c94f-48b5-b192-1a769c1442a7
655797d2-520d-4b95-af08-3705e884ff70	2024-08-28 05:55:12.044	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0c1f1e7c-3412-4a30-bdd8-03c2c2a7730b
748ef15f-4093-4e67-b8d2-390baf75087a	2024-08-28 05:55:12.147	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d1c81fcf-526f-468c-b8f1-1de6fe5ce572
2adc9e91-630a-4ced-998b-14fc16e1c907	2024-08-28 05:55:12.246	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e1a109e1-01cc-476f-a100-046326507dc2
2c3d3bd5-82d9-4632-b83a-5b429551f836	2024-08-28 05:55:12.37	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1fdcbf6b-e670-46e6-a1f8-308621c26735
71b7684e-6a5d-4a27-8e2b-b3e9942d54e1	2024-08-28 05:55:12.491	5c88a435-14b9-4c7d-ae97-08c38822e5ad	bd03e8cb-4881-43d1-aaaa-fd192db5b90f
5fab30cf-3a6b-4052-93c8-a473f81d379a	2024-08-28 05:55:12.66	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6f253a9d-efd4-46ac-8693-9aaf4ea5d3f8
5487fc17-d0f8-433a-931e-5c659df5fef1	2024-08-28 05:55:12.824	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f423e5f2-d2de-4a4b-983d-7faeee04b0b2
a2bf317c-ee73-4f63-ba0c-1509edbbe826	2024-08-28 05:55:13.009	5c88a435-14b9-4c7d-ae97-08c38822e5ad	21782926-7972-49d8-b5a4-8163dda4d8bb
c17751ec-8165-4772-804c-e2ece1ec8912	2024-08-28 05:55:13.248	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0c875a99-42f1-4cb4-88ed-398b1c25b9fa
c7258b9d-b002-4b52-a30d-22e390a79c5a	2024-08-28 05:55:13.366	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3ba67b11-9e37-462d-83b5-ca4defebe4ed
b9fa9a73-cce5-4e44-9dd4-5b4159b57bca	2024-08-28 05:55:13.462	5c88a435-14b9-4c7d-ae97-08c38822e5ad	bfc42f90-715d-47dd-bc34-8a3983fd76e5
35fd008e-dc32-4e84-ae6a-165a3b9091ac	2024-08-28 05:55:13.583	5c88a435-14b9-4c7d-ae97-08c38822e5ad	38922471-48a4-430b-acf7-80399379a847
418b7815-9c31-463f-a134-5e330d4f8798	2024-08-28 05:55:13.673	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7d9c3111-4710-48a5-8e57-42e76f785f6d
165c2d86-31dd-4086-88f2-392f1251d2fe	2024-08-28 05:55:13.777	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5cdf5b4f-0b52-4adc-a49a-6145cb01c326
c7868b5f-86d0-4502-913d-32dc4d3d3738	2024-08-28 05:55:13.885	5c88a435-14b9-4c7d-ae97-08c38822e5ad	619ff42b-d080-4db1-b808-d769e69bee7f
d2bfba47-6164-4936-8009-16ffde41e9fc	2024-08-28 05:55:13.993	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c5533212-9300-4d0e-b460-5eabc1fa4a0d
ba1e8090-1164-47cb-8fba-a0e9158c1e3b	2024-08-28 05:55:14.131	5c88a435-14b9-4c7d-ae97-08c38822e5ad	b68c623a-ffa3-4a48-a3c9-76f2f700775b
757742e3-4c66-44ae-8d36-9b3dd6ac05c1	2024-08-28 05:55:14.271	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5cd93a3b-b144-453a-a229-2757cb28df22
454f2145-c6aa-47b7-8a68-0d7e20d2f36f	2024-08-28 05:55:14.379	5c88a435-14b9-4c7d-ae97-08c38822e5ad	4dd9f659-75d6-44f8-8fae-ac963c6746ab
24aa01bb-ba68-42e4-9a40-565f77479896	2024-08-28 05:55:14.486	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c357212b-e065-4c65-aaa5-7e8b8a14cfa0
ab8ec335-db27-4dc8-b1ef-34fcf41e93c9	2024-08-28 05:55:14.711	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f3fddd33-f77a-40e4-9897-55e61230d643
f2c87a6d-75a3-4286-acbf-ab0f9de09007	2024-08-28 05:55:14.794	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5434fac2-36e9-4ff9-9955-ba531fbb1ba0
cf0df756-7c87-4bdd-9761-33021f3516bf	2024-08-28 05:55:14.96	5c88a435-14b9-4c7d-ae97-08c38822e5ad	1c23cfd4-f4d7-49c5-8760-9600e414027e
c7cc8c6e-184f-4466-9d65-f2e3386f8265	2024-08-28 05:55:15.075	5c88a435-14b9-4c7d-ae97-08c38822e5ad	31ae5186-dc5b-42c3-b676-8590c96de53a
5f0e3ff3-8706-4977-9515-fdbb9adc85eb	2024-08-28 05:55:15.183	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d2615292-a50f-47ff-af73-437ec1eb0fea
cb57b2c8-f0b4-4c46-8181-20cb64944c63	2024-08-28 05:55:15.297	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9f557edb-8adf-4832-bc25-ca5b00dfcf4a
058028fa-5eb9-495c-b82b-593866ebe00a	2024-08-28 05:55:15.381	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8fbf163b-f453-434e-ad19-10228894ee8c
ddb51df6-7714-43be-8dd5-d49c5a5e1996	2024-08-28 05:55:15.517	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d2834bcb-2154-433e-bb06-e8befbfd7368
a00f1eb5-f12a-486e-9de0-044c6ab2203d	2024-08-28 05:55:15.627	5c88a435-14b9-4c7d-ae97-08c38822e5ad	88421493-e09c-407b-91b7-a2bf5f633fa6
2d1ad878-0cae-4b35-b088-b9d24ff02b26	2024-08-28 05:55:15.716	5c88a435-14b9-4c7d-ae97-08c38822e5ad	45f32ed2-3673-4022-b0ad-e4d60362361f
32eedd6f-899e-4417-836b-6b6cfd8b2cdc	2024-08-28 05:55:15.826	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a6975bcc-4113-475c-9da0-5dcb952cf919
05261c9a-81d0-4b84-a56d-17b96e799b28	2024-08-28 05:55:15.927	5c88a435-14b9-4c7d-ae97-08c38822e5ad	eb838509-93c4-4e2a-a8c3-3bffd2acc82c
abfbb7a5-c0fb-4293-b1dd-6e709cc00f04	2024-08-28 05:55:16.073	5c88a435-14b9-4c7d-ae97-08c38822e5ad	815ba1e6-a405-4df4-9909-7fbc8e87a4ac
d9e054e6-e8aa-4552-9bf5-5a274717fd5c	2024-08-28 05:55:16.247	5c88a435-14b9-4c7d-ae97-08c38822e5ad	473b85ee-3707-4f2e-b370-74e791f3fe1e
44f32344-7761-4b23-95a7-d4b52b8786ea	2024-08-28 05:55:16.438	5c88a435-14b9-4c7d-ae97-08c38822e5ad	5438ad6b-5a74-4d31-8122-32b3d7a2c8a2
0016b77f-cb1e-4f75-9cee-b42333f04212	2024-08-28 05:55:16.62	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e88ff86f-02ae-43ba-9060-727ec1a5558c
af55cc0a-f3c3-452c-9f86-c7a6b58a9edc	2024-08-28 05:55:16.738	5c88a435-14b9-4c7d-ae97-08c38822e5ad	0e562d45-0328-4a97-939d-cd11bb7f2ed2
5bfa4b90-1c95-4065-bc74-a950de0ad182	2024-08-28 05:55:16.873	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6e4e0e64-47ea-44c0-a997-25766e1a85c1
c95111df-77c0-4827-8705-d5223d0592d3	2024-08-28 05:55:16.973	5c88a435-14b9-4c7d-ae97-08c38822e5ad	6ef284cd-4c54-42c0-99a0-619cb8442030
ecaaf592-94c7-4da2-bbfd-0e916d0a31b0	2024-08-28 05:55:17.076	5c88a435-14b9-4c7d-ae97-08c38822e5ad	bce15c48-3692-4a64-a01c-9ae16080077d
8f8a8808-292c-45d1-bd6b-994a57083660	2024-08-28 05:55:17.166	5c88a435-14b9-4c7d-ae97-08c38822e5ad	d6bec1d0-48c5-4652-8612-b4667cb1c442
46870936-e7c6-4b48-beb1-32b74b9d7cd2	2024-08-28 05:59:10.947	5c88a435-14b9-4c7d-ae97-08c38822e5ad	c8434922-ec69-4e01-beef-8cfb6ad0f92b
656f7472-3473-49ae-8469-e67e39ba4702	2024-08-28 05:59:11.232	5c88a435-14b9-4c7d-ae97-08c38822e5ad	cebdc43a-6173-4d07-99df-6ffabe415516
b1482649-d1ed-4352-864c-b54fde10d7e3	2024-08-28 05:59:11.366	5c88a435-14b9-4c7d-ae97-08c38822e5ad	949c4f91-4f71-4751-8c96-4113f5c1672f
84ac635a-b6a6-4608-9f5e-9ec35bccebe2	2024-08-28 05:59:11.519	5c88a435-14b9-4c7d-ae97-08c38822e5ad	9f19df17-a951-4493-944a-cd158fd5ca1a
b66493f8-7508-40e8-ac30-d563fe9c8260	2024-08-28 05:59:11.704	5c88a435-14b9-4c7d-ae97-08c38822e5ad	f968fe68-30ae-42d2-9e74-08bf8e223215
8131acb9-7d61-4af5-b39a-41ab02893d07	2024-08-28 05:59:11.831	5c88a435-14b9-4c7d-ae97-08c38822e5ad	380bb01d-d981-4caa-b479-6089a516a075
9bdcb7af-a148-40cc-ba90-feabfff38a1c	2024-08-28 05:59:11.992	5c88a435-14b9-4c7d-ae97-08c38822e5ad	70ecb7d4-c0fb-4e26-8471-d06e7a5afd94
025c7d83-1d50-403d-a27e-a7c97d8a6064	2024-08-28 05:59:12.115	5c88a435-14b9-4c7d-ae97-08c38822e5ad	8749fd89-444e-4786-b0cc-6fed521bdc27
28d57fbb-0a24-4bcb-b0a6-64d9df1c675d	2024-08-28 05:59:12.25	5c88a435-14b9-4c7d-ae97-08c38822e5ad	3ecb5f1f-0418-41cd-af4e-93a4f558c522
a0f4d775-8e3f-4da6-97cc-43af13c56b6d	2024-08-28 05:59:12.359	5c88a435-14b9-4c7d-ae97-08c38822e5ad	7170f559-0812-46be-9851-f1142c91d14c
04b8a914-dc46-4fae-afdc-4abdc111cd30	2024-08-28 11:33:56.45	7b85a40d-2149-44be-a888-438cc50012f7	c2b5d09f-ff81-4c50-b1c9-a6c46f12df90
86958cc8-7eca-4f63-8d6b-8c3e3a39cb49	2024-08-28 11:36:39.777	7b85a40d-2149-44be-a888-438cc50012f7	21bc0cfa-c69b-454d-9c5b-4261dea59a6d
7d14d558-f4c4-4045-9ae2-2ef25a015b83	2024-08-28 11:37:10.106	7b85a40d-2149-44be-a888-438cc50012f7	5566b584-2023-42f9-b25c-04d15223cd5b
db517932-1002-4dc5-b72c-4a91efc08c4a	2024-08-28 11:40:20.837	7b85a40d-2149-44be-a888-438cc50012f7	759b3797-b95e-4abc-a83f-c37bd6aa090c
4d22918c-1820-4a54-a7ef-1eedc1598c9a	2024-08-28 11:40:21.249	7b85a40d-2149-44be-a888-438cc50012f7	1203d0f1-1816-4998-93f0-bdb05c314cd4
bc88b1f6-c3ce-4888-93a1-2ffd1615874c	2024-08-28 11:42:07.278	7b85a40d-2149-44be-a888-438cc50012f7	ffb1879e-5a8e-46a4-80ec-fe36bd67e584
08de3237-0b2e-45c7-b168-0fe3643497dd	2024-08-28 11:42:07.475	7b85a40d-2149-44be-a888-438cc50012f7	5fdbb2e4-c6b5-4bcd-8b9d-b0b145c35f9c
e3fb601c-4bd9-4158-b863-36f6ea9028f4	2024-08-28 11:42:16.846	7b85a40d-2149-44be-a888-438cc50012f7	d04cb17e-fd2c-4727-acd1-76bad464dd01
19e7d16b-7d5c-4652-9031-54c567c1e1b0	2024-08-28 11:42:17.033	7b85a40d-2149-44be-a888-438cc50012f7	5cb277d0-f9a3-4de9-9041-470811eeb375
3ed8f465-4a43-4cc8-a754-a431b94a98eb	2024-08-28 11:43:12.215	7b85a40d-2149-44be-a888-438cc50012f7	951ff7cd-7830-4e5a-9e21-eb7b0eca63a6
2ce4dd48-f9c2-4c6d-a731-544d41179eec	2024-08-28 11:43:12.457	7b85a40d-2149-44be-a888-438cc50012f7	57734c90-01d3-4f4e-828c-1201f65e42bf
e9363e50-2a4d-4bc6-be3d-164252f379ba	2024-08-28 11:43:23.309	7b85a40d-2149-44be-a888-438cc50012f7	4b8d5ba9-6cbe-45bf-82ce-c7a7471478ad
fec1c2ce-18ff-405f-ac51-1076bd699721	2024-08-28 11:43:23.596	7b85a40d-2149-44be-a888-438cc50012f7	31765d40-d378-420c-a0b4-ca49e7ea59f7
a3192330-ce1a-4423-95c3-eddf2f75d538	2024-08-28 11:58:08.046	7b85a40d-2149-44be-a888-438cc50012f7	2f0dee24-3f81-4ccf-8244-d6488d087f1f
f30a9028-9c46-4d85-809a-20ab85a7a124	2024-08-28 11:58:08.287	7b85a40d-2149-44be-a888-438cc50012f7	b6c3d582-e6cc-4814-a38f-7df873654608
9f6074e0-d8d6-4d1f-9376-c76ea8afa9f6	2024-08-28 11:58:08.449	7b85a40d-2149-44be-a888-438cc50012f7	53d6dbf5-e190-4641-95a1-d734632637da
5ab26984-ad22-4477-a6e6-bbad0e15e822	2024-08-28 11:58:08.591	7b85a40d-2149-44be-a888-438cc50012f7	d19c8610-487a-48fc-87a1-9de1b1b9cb83
dcd4cc7c-20f2-41de-8428-6adcc04ebcc1	2024-08-28 11:58:08.792	7b85a40d-2149-44be-a888-438cc50012f7	145ff272-c8be-4461-b4aa-1a161a921aa8
94559618-97e2-463a-903c-7c915f517295	2024-08-28 11:58:08.98	7b85a40d-2149-44be-a888-438cc50012f7	bc505c03-f9ae-4e0f-99d5-a29a56830b15
24b29b9f-12f6-49f5-a190-3fa02512f244	2024-08-28 12:13:32.119	7b85a40d-2149-44be-a888-438cc50012f7	7e5114fc-def2-4929-91d0-7ca9dc68b2ff
bc8c9137-380e-426f-9850-5eeac6eb18c5	2024-08-28 12:13:32.304	7b85a40d-2149-44be-a888-438cc50012f7	1e65b0bb-703b-455e-a307-7f82464055e8
b3a66afd-2f03-452c-943a-595db3efba82	2024-08-28 12:13:32.468	7b85a40d-2149-44be-a888-438cc50012f7	e999b8ec-ee7a-4889-bec9-9afc50e88dce
6e1d9421-6f85-49ae-b551-1221c882facc	2024-08-28 12:13:32.566	7b85a40d-2149-44be-a888-438cc50012f7	afdb12fc-0625-4fbd-a92d-a1d8300d5fb9
773c309b-782c-4aa6-a254-5b9fd4f3f6e7	2024-08-28 12:13:32.68	7b85a40d-2149-44be-a888-438cc50012f7	95f8b881-4861-4f7f-a209-5e6cf25b8d78
b0884ac3-a4f5-427e-bc11-afb4071f508c	2024-08-28 12:13:32.787	7b85a40d-2149-44be-a888-438cc50012f7	d62f5ea4-de23-4db9-afb5-db9334809de1
d76fffed-41e1-4777-88dc-5e6905c34f79	2024-08-28 12:13:32.873	7b85a40d-2149-44be-a888-438cc50012f7	3bf937ce-d0c5-43bd-9119-f8590a8d574c
3944abdf-0fb9-4b08-9460-ac7ba25b56a9	2024-08-28 12:13:33.105	7b85a40d-2149-44be-a888-438cc50012f7	616544be-8229-4e20-b1ec-3a286664cef5
20159b1c-2f11-497d-b387-2b0f8365d714	2024-08-28 12:13:33.235	7b85a40d-2149-44be-a888-438cc50012f7	e46a8c26-7345-4fed-b81f-2f3ebe9f3864
91ff39e3-5be9-4cbd-92a4-2e5a8649f8ba	2024-08-28 12:13:33.355	7b85a40d-2149-44be-a888-438cc50012f7	1cb6a9e2-f9ba-412f-a284-23e6657ef879
6f239bf5-98b5-41fa-9d63-56b31bcb9a9d	2024-08-28 12:13:33.485	7b85a40d-2149-44be-a888-438cc50012f7	98431e33-b96a-4c71-a52d-07883fe7e945
8a5fa8d0-3085-46c0-aef6-367f26664cd9	2024-08-28 12:13:33.564	7b85a40d-2149-44be-a888-438cc50012f7	9eca8ffd-2cf1-4293-af11-ed381f31d2d9
1c53de86-8080-4945-9790-4c3cd88a9b48	2024-08-28 12:13:33.67	7b85a40d-2149-44be-a888-438cc50012f7	77d3d92a-1bc8-4648-b22d-401a09d08ab5
bcca62dc-be09-473b-b758-ffa0846066d6	2024-08-28 12:13:33.838	7b85a40d-2149-44be-a888-438cc50012f7	182027a1-551c-4601-9b84-497348f94e1c
0f6619c8-1b07-43be-8213-9522d96ac66f	2024-08-28 12:13:33.946	7b85a40d-2149-44be-a888-438cc50012f7	1caaf02e-4ee5-4c2b-b520-5846341805ef
a5a35c1a-120e-495c-bfa9-4a8ef7297d5d	2024-08-28 12:13:34.204	7b85a40d-2149-44be-a888-438cc50012f7	7d633720-08f4-443c-942d-8da74df41a97
0b4a5318-1a5d-4b4b-9e7c-13d754f87e49	2024-08-28 12:13:34.311	7b85a40d-2149-44be-a888-438cc50012f7	bf1a2431-a918-4a36-8334-ab6545e430f7
3b4277e0-d785-40f8-9d08-28a54132a1c2	2024-08-28 12:13:34.448	7b85a40d-2149-44be-a888-438cc50012f7	9bf4aae9-77f7-485c-8cc1-eb54d94df3c8
b4942042-ea40-4015-9a6d-d4d3e898d771	2024-08-28 12:13:34.549	7b85a40d-2149-44be-a888-438cc50012f7	c9b1180a-cdee-4a8f-9909-e5cd60f4ea1c
19e02d51-b664-41d1-ba57-9b8343cea093	2024-08-28 12:13:34.698	7b85a40d-2149-44be-a888-438cc50012f7	237b4a46-2822-46cd-b0ac-c82739829a00
6ed056d2-fb38-4661-92f6-d233a6bfe618	2024-08-28 12:13:34.791	7b85a40d-2149-44be-a888-438cc50012f7	51f92be1-4f22-406b-816a-637ac9c1f180
cfbc5641-49e7-4ea2-a9b7-4edf0fa735dd	2024-08-28 12:13:34.926	7b85a40d-2149-44be-a888-438cc50012f7	ea7ecc9d-c8c2-4dc6-82a8-35ad13b71f8f
e681143d-ed7a-4821-960c-985afae37d41	2024-08-28 12:13:35.027	7b85a40d-2149-44be-a888-438cc50012f7	5e30ec44-bf17-4518-b5c0-2c1d552a9777
10c8b381-e5ba-46b6-b6c2-c99f111c20fa	2024-08-28 12:13:35.14	7b85a40d-2149-44be-a888-438cc50012f7	a080de1e-d906-40a2-9bb6-c3e7528d2b87
b2928157-082d-43d6-a817-3824e4457618	2024-08-28 12:24:45.192	7b85a40d-2149-44be-a888-438cc50012f7	20bc764d-59d8-492a-b1e0-3d9814ad034e
f29975e9-0613-4574-b03f-041d68d513e8	2024-08-28 12:24:45.527	7b85a40d-2149-44be-a888-438cc50012f7	188e2d5e-977a-4730-a383-0cf6431ec5fe
1205133c-82da-4538-a6e3-9f166c56454c	2024-08-28 12:24:45.701	7b85a40d-2149-44be-a888-438cc50012f7	6ae32738-74e8-4c49-91cb-e39f7e5df371
cb7f0936-0822-433b-985f-88e74df3106c	2024-08-28 12:24:45.821	7b85a40d-2149-44be-a888-438cc50012f7	1e968ba6-7a32-4112-891d-a59c12be57c3
9a1b3826-0c2f-4470-9298-f885e7603947	2024-08-28 12:24:45.975	7b85a40d-2149-44be-a888-438cc50012f7	150bc895-b1c4-48b6-8acc-513947236dd1
6aff2c47-b775-4412-9700-f39ddb933a42	2024-08-28 12:24:46.222	7b85a40d-2149-44be-a888-438cc50012f7	eff4d266-7f89-49e1-a67c-29c28ccd7b9f
eef9fa62-ec99-45b2-90fa-893def90920c	2024-08-28 12:24:46.342	7b85a40d-2149-44be-a888-438cc50012f7	a2d36b74-93b8-4b1f-b1c2-c1a9832708b2
5d230578-d8ed-4b6c-80a3-88863eff37e5	2024-08-28 12:24:46.61	7b85a40d-2149-44be-a888-438cc50012f7	2bd87bc9-bbe0-4a68-b661-67cfc55995b0
59fe835f-75ac-4907-a19e-7bbeef733eb7	2024-08-28 12:24:46.838	7b85a40d-2149-44be-a888-438cc50012f7	e1f5d089-9099-4909-805c-7ddbdd74e0a3
ebb46174-e702-4d86-893b-03bc43dbd4bf	2024-08-28 12:24:46.967	7b85a40d-2149-44be-a888-438cc50012f7	1532bb49-0e32-4841-8531-eb9f7d831abf
5060cbc8-462a-45a7-b570-d942365b4ba8	2024-08-28 12:24:47.15	7b85a40d-2149-44be-a888-438cc50012f7	a18c5901-3cba-4f12-913a-2f901f7eda55
4f022247-c00b-4410-bb2f-1f7e75415a5e	2024-08-28 12:24:47.27	7b85a40d-2149-44be-a888-438cc50012f7	58038a40-5a0c-4a1d-af06-f0d4c4a70b9a
b3ad9b0e-8196-4b7b-a5e5-3589f202710b	2024-08-28 12:24:47.362	7b85a40d-2149-44be-a888-438cc50012f7	7f1ec4fc-d95a-4a98-8ff2-7d639a655dfd
9e885156-b735-4e75-b6b9-2101b38c7392	2024-08-28 12:24:47.5	7b85a40d-2149-44be-a888-438cc50012f7	03c031d5-def4-4c9f-9c43-ead660b2ecd8
f89ae501-5414-4efe-8007-e4033d9ed124	2024-08-28 12:24:47.681	7b85a40d-2149-44be-a888-438cc50012f7	85b9217e-e690-4560-862d-523b8ddf7390
eea1f761-3b1e-4fcd-aa96-9cddb0a8564c	2024-08-28 12:24:47.804	7b85a40d-2149-44be-a888-438cc50012f7	3c5d9bb9-923d-4745-a499-06d2421d8b06
eb1475a5-cd7e-41ae-b959-1154b45cb08e	2024-08-28 12:24:47.959	7b85a40d-2149-44be-a888-438cc50012f7	642a9f33-4469-4b32-b68f-cb043424e73f
8a9b8540-a2b2-44f3-9869-9c252ef32012	2024-08-28 12:24:48.15	7b85a40d-2149-44be-a888-438cc50012f7	ba12359e-af2d-44ae-b25e-9430f2d3fdc7
93557942-ec89-4a8d-b146-a6d72a272e91	2024-08-28 12:24:48.343	7b85a40d-2149-44be-a888-438cc50012f7	e6286cf3-32ef-43d2-927c-c8c62b50d95c
5bf0c228-e5c3-4f7c-ae09-d0b442e78547	2024-08-28 12:24:48.465	7b85a40d-2149-44be-a888-438cc50012f7	3054bbb2-244c-4974-b7e7-c29dac8b1dc3
ad2bd439-9cec-4ed4-b86d-4cb3eb55e19c	2024-08-28 12:24:48.571	7b85a40d-2149-44be-a888-438cc50012f7	c9ccd729-0b35-4fbd-8f52-20014506fa20
1b44a164-e563-4922-b357-7e40576106a4	2024-08-28 12:24:48.723	7b85a40d-2149-44be-a888-438cc50012f7	199da7e4-25bf-47ff-9e51-b5c412af57c9
6983be74-29c6-4ea0-98e9-74f252e1cc16	2024-08-28 12:24:48.835	7b85a40d-2149-44be-a888-438cc50012f7	fd5550aa-da2e-42af-a466-67e2c59fe268
dc55b72c-f984-4de3-9765-3908f163511b	2024-08-28 12:24:49.147	7b85a40d-2149-44be-a888-438cc50012f7	f8f489c5-baee-42a7-a22f-ceda8b8d760f
f8a4caba-0385-4bf9-abbe-b9144451537f	2024-08-28 12:26:18.764	7b85a40d-2149-44be-a888-438cc50012f7	a4f0921c-5929-49f3-a2d1-3f0048849db6
f4ecebac-89fb-4eb6-b241-26d173197f15	2024-08-28 12:26:19.058	7b85a40d-2149-44be-a888-438cc50012f7	4e6759e0-6ce9-4277-bff6-d6033bb6f479
335ae39e-d899-443f-8cb8-24e65f2622a8	2024-08-28 12:26:19.265	7b85a40d-2149-44be-a888-438cc50012f7	bda3c9ab-385f-461e-a1cd-37a52d5335c8
2bf2f79d-4300-4e06-bce4-dc0c744b02aa	2024-08-28 12:26:19.377	7b85a40d-2149-44be-a888-438cc50012f7	f868438a-b76e-46b3-abaa-f4405a63d0ff
c9bb3dea-547e-4df6-b70c-ee264077d2c2	2024-08-28 12:26:19.566	7b85a40d-2149-44be-a888-438cc50012f7	5f4a33a0-6d96-44ab-8d8c-24a62013003f
3b690d30-f54a-4fe5-b101-77c79ec3bf62	2024-08-28 12:26:19.718	7b85a40d-2149-44be-a888-438cc50012f7	02926a21-64dc-477e-880c-cd6b5eb3394f
7ba5495d-4446-4f31-9fe0-3e37789916dc	2024-08-28 12:26:19.821	7b85a40d-2149-44be-a888-438cc50012f7	a7f7e5ef-f3af-4ba4-b048-701b6582821f
a03ce955-10c4-463d-b336-97a35067e28c	2024-08-28 12:26:19.969	7b85a40d-2149-44be-a888-438cc50012f7	04a2a76c-44ff-46d3-8155-1348edf1828b
a3293e60-138c-4be6-8ea6-c8b30a4ae84e	2024-08-28 12:26:20.09	7b85a40d-2149-44be-a888-438cc50012f7	7834e35b-1e29-4e9d-88f1-ddcda3c3f1a8
e0b83c7b-82e8-4ac4-bbf8-163896eab065	2024-08-28 12:26:20.221	7b85a40d-2149-44be-a888-438cc50012f7	eb7c53fc-10e1-47f5-a6e7-fae2be8896ea
3fd30ef9-5a61-49ab-bad0-3946ab1d2c38	2024-08-28 12:26:20.35	7b85a40d-2149-44be-a888-438cc50012f7	b4085128-2dc7-4ed5-9332-959dce9b0cbf
1c5e8cd1-a511-4e5c-92ce-7cec0470ea5d	2024-08-28 12:26:20.489	7b85a40d-2149-44be-a888-438cc50012f7	6305399c-c89c-4fb4-8570-42465bd1b79f
aa56fc15-d506-46bf-be1f-9f550d563c10	2024-08-28 12:26:20.609	7b85a40d-2149-44be-a888-438cc50012f7	45f3f2bf-3a4b-4f0b-bff1-3f477bc629b8
a499c116-c51d-4ced-8eb4-c2abf529e90f	2024-08-28 12:26:20.776	7b85a40d-2149-44be-a888-438cc50012f7	c124d5e0-2509-43fa-8e0c-f07a9db962ed
7278eaa7-7fc8-4013-a974-4f8434e23527	2024-08-28 12:26:20.938	7b85a40d-2149-44be-a888-438cc50012f7	c0982b02-cecb-4f73-adb0-327258fe2f8a
7cc2fbf1-dae3-4c59-8945-d372619a5ae4	2024-08-28 12:26:21.039	7b85a40d-2149-44be-a888-438cc50012f7	2ae81c67-7c65-407f-862c-dc6877f856e0
1f2b93ea-8638-44aa-9b0e-def027bcfe3f	2024-08-28 12:26:21.171	7b85a40d-2149-44be-a888-438cc50012f7	e4cc5b33-8083-410e-b92e-60b818343a90
3dc36030-e6a9-4a47-acf0-c3b644cce042	2024-08-28 12:26:21.336	7b85a40d-2149-44be-a888-438cc50012f7	b97773e6-a871-4572-bac1-7a6637f059cb
2af2c6dc-2638-4c5f-a551-0690741e3612	2024-08-28 12:26:21.463	7b85a40d-2149-44be-a888-438cc50012f7	3c305397-9f6c-4189-aa05-f48fc6d4c02c
96516f8d-274d-4aa7-b35a-7da13fd7a274	2024-08-28 12:26:21.653	7b85a40d-2149-44be-a888-438cc50012f7	fc057676-e528-4fcb-a729-4f4eb9ee5e5b
33bdcae5-649b-4378-97e0-3984795c375d	2024-08-28 12:26:21.779	7b85a40d-2149-44be-a888-438cc50012f7	38f81c95-5586-40dc-be11-7117fcd90f9f
da8da05d-57b3-4519-9503-4dcbed59da9f	2024-08-28 12:26:21.915	7b85a40d-2149-44be-a888-438cc50012f7	fa3b4cdc-b7a2-4595-a7e4-ef474d129883
34aca4ea-f6c9-4fb6-86ec-7a2e60f68156	2024-08-28 12:26:22.078	7b85a40d-2149-44be-a888-438cc50012f7	adcd3d8a-71e5-4bea-880c-ea9f7284a724
4fce5529-ec7a-435c-8301-be2e7f043940	2024-08-28 12:26:22.293	7b85a40d-2149-44be-a888-438cc50012f7	9356b60b-8ca4-459e-8347-04943b40dae5
22eca796-be73-4975-bdcc-5e229a16d1e0	2024-08-28 12:26:22.475	7b85a40d-2149-44be-a888-438cc50012f7	98b12365-5eed-4f3b-b615-ab87f317c2fd
a0773b98-e581-4750-b9cf-f8dd6a4ecd2d	2024-08-28 12:26:22.674	7b85a40d-2149-44be-a888-438cc50012f7	feaeaa90-81a5-4098-b44e-d39b0d059cf9
55664c70-7c7b-44ad-97d6-b368cd97cb3c	2024-08-28 12:28:10.046	7b85a40d-2149-44be-a888-438cc50012f7	c7437b7a-8e9d-4fd9-a56d-05973ac990df
\.


--
-- Data for Name: referrals_early_bonuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referrals_early_bonuses (id, account_type, honey, multiplier, player_id) FROM stdin;
54dce10b-552d-492d-b6b8-0854331e5930	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
28157fea-f723-4f81-8425-f4b5aaee6dfd	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a5775e97-f488-4687-a357-00fe9cf5a791	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d96c0a2f-c894-4395-98e1-c70d1b20e497	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1a4ee0b4-0e50-4840-8359-1a4480fe11b4	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b1fc03da-656a-4da0-b26b-18621e4bd904	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
502ea3cb-f5b2-4f48-b35f-063142ff6136	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
44733b7e-8a53-4343-a49e-42026e967ab1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3246d117-c3e9-45e1-bafa-c4b0b4d87ccb	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b8c52858-d87a-4639-814a-5db32719a5f1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d2464046-6d81-41ad-99d0-99c820872674	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
611d2f17-5717-4945-8264-67444028e5b2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
11de8ec6-23b9-4c40-bc46-d334907b79ac	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ee925974-aeb2-41ae-95e4-ac2d5e3c7e9f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7fa3ab3e-645d-4d91-bed6-78a4ac4df2df	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b99570d8-6e2e-41b6-a08d-50fdc7035c6d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
53a47206-2979-475d-ab7c-2b521a33a45c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4ac96795-d430-4333-bdba-bb609a4ecea0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
db4b2462-3ee9-4365-9924-28a333df6ab0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e407306c-cd7f-48ba-a2c2-4c98d6181ea1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6fec9a51-8de6-4467-b680-6a4d365e84e7	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a7d2e2ad-c2d9-4803-89e8-241da2352b38	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5543f6b2-1d14-4f18-bc50-dc65469c3ffd	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1090894f-0854-4a24-bf80-d506e7640a49	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
96312b56-5adf-4d9e-bcfa-676d57c09ab6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ac85a192-f895-4863-8a77-e8a1b3b84442	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d8250fb4-708c-4968-b557-cdcdef203cc2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
47d09055-0f86-4511-92f3-b3bf87081ea9	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
99272573-8f4e-4526-8443-23926ae199fd	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e0cce92b-063c-457e-be4b-357bfa2f1598	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d4579249-27fb-4a4f-856a-24dc2656d691	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d07febaa-f17b-4e5d-863d-18cf194dcff2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
52fe86ef-000b-4ad1-9ed2-8add8115dc93	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cba347da-3ae8-4a94-a96d-d681532a3b1a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f4317bb5-7555-415d-b15d-32a85cf748ad	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3cffe37e-03de-483e-9429-bff7eaada038	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0c1b2b2c-941e-422f-b141-db4292ecaadd	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1db35c2b-785c-4240-8f6f-ad2aba250bf9	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
afd710c9-905e-441f-bb53-49a1f63599f9	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
43db1f33-4eb6-4864-8d49-0388fa71a4fe	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
070725cb-80ef-4d20-9bfc-8619241cce75	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
24616c75-cb43-4f4f-bafd-5a24c5164953	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
39a5243e-f5c9-46f0-95bc-ae35e8118bbf	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ab7c83dc-9ec4-47e7-a80c-7a55ec237c1e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3085c195-708d-4bfe-aaf6-31f73211b8f1	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0ba3003d-7780-436c-8c92-85517cd89f56	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8a7b78d6-3ccf-4682-b46a-11f6bdcc1fec	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
9578321d-1c1b-4e37-973f-54e99f1c8b96	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c42409cd-1ba5-4d13-bc0f-d91276592647	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
9ba57db8-359a-460c-aafb-0972963725d2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
884deb57-2619-41ca-9efd-8a7393df1c01	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3023d8da-a319-4b6e-b3f8-731f12b2861b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ea6efbe6-18c3-4216-af0e-251ab8ff19bf	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f8dce83c-0069-4601-805b-c12a293ef93d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
50cf9592-ff71-47c3-b03a-55ff6dfd8192	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a242e751-9374-46df-91a5-ab3346dfd770	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a6b20003-bc34-41ff-bd19-d13dcfc987ce	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
25e556d7-65fb-42b2-8b3a-414cbf85bb3b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
302ebeb4-4e52-46e9-957c-bd700d722942	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6fc47d45-d8aa-4dcd-a447-21e47d56086a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2aa80622-fdac-49bd-b5ee-599aac7858a6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4b6b657f-b0b0-4a76-894c-b2279f96d54b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cea5ebc7-f1ff-431b-8bdb-146f0a2a5a20	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8dad574d-2b95-4a4c-9790-fc0127198340	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5bd88591-657b-4451-a2e7-9d6d14b47d7b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fa3bfd4e-eca5-4a81-9a97-588be1ffd26a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2a2f4cf0-e4db-40c1-890f-a1dd52055cd0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6f1d7b20-2a45-450a-a3d5-edab43939c52	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d47b68d6-7867-4b76-9e1b-4dd54ee73ee4	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
935a32ce-c35a-4eee-bd1d-88846f2c6198	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
47b846c1-e3fb-4661-8c00-be27ae4f0aa9	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b2ed3903-c13e-4767-8693-9bac4ea7d6b9	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b5f26f5d-a2c9-4f0d-b6f8-ac5311e73845	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ed6d8edf-0bd4-4c2b-b62e-e2bd4e68cd60	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ec51ed12-adbf-4091-a159-fe5348f8423d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4cfbb5a1-eb02-4c9e-8a8a-9ae9424421e5	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6b79e3d9-fca5-42b0-b88a-a293c51087c6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
be8abffe-9aa5-4ad4-b941-28066311f7c8	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a1a12926-bcae-40f7-a708-cfc858dd6350	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fb60e521-a924-4c7f-89ae-49ff25594203	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a92eaaaf-f55f-4ea1-90f1-77be8c72e787	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f8185253-e92b-41e7-874c-e97a6443722a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0401daf3-53d8-45f2-97c4-3a40989da175	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1177ffb8-2748-403f-ba30-1f3fcd8e2c2f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ebc0847b-8603-4216-bf80-083e95dabe49	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a93f4dd9-6504-4103-9b35-a699974563d1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0a73c2e5-8feb-4a04-9a06-c010745b4e56	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
85de5fac-7ecc-47ff-8f81-3afb25b3ef10	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1d88ed20-ef8d-4fa5-a3f7-281ee8b76256	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
204ac7bb-a841-4ccf-a1e8-cd73927adcb8	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c19601fe-8dcf-448e-8070-84b7e1b4235d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
24e05147-d5ef-40a3-953f-c0aead1f709d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e20d52b3-292b-4bb4-a1fe-1d29474f4b3a	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
43e5d4ea-0c02-4e28-a233-1320c984952e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e9c88c8c-9dfc-41cc-865f-4afbb7009f51	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0d00a888-0c06-41bc-a6c2-e03fd1d477d9	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
44a15381-ccf3-484b-b503-ec41ffa39bbc	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
478d334e-b252-4cee-80ac-93034270e485	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
53831c6b-d478-4d9e-bac0-12c7aea1a566	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5f5bfca0-1dd9-467d-8ada-5ac085862267	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
81aa7eb9-d97c-4ccb-81a5-817eacb09357	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a3cc9f8f-dbe6-4e2d-9d70-b3f03fb650ef	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4118ff24-bec9-4df2-998c-996848f15941	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b51a1338-a636-4c48-a8dd-9d318d904c6f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
78f22732-df10-41aa-9368-a27bbe17f367	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c283bd22-b355-40a5-97c4-db90e0572235	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
82c34e6e-f915-4d81-9f31-11a3637a24d4	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f33f6ca9-ff24-49ad-b255-ee674df36ec0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a1c231b8-1b54-4b71-94f5-6b3523085d8c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d5faeaad-313a-4507-94b5-5c707a7a9988	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f9debe5e-5655-4ebf-acfd-bf95f38becb5	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b4f4d883-77c7-4674-bf0a-d361b577323f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5c0ad608-03ca-451e-904a-8e854c03e6d1	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
eecdc0d2-cee2-46c2-a3bf-df10de89b3d7	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d06213db-7f47-4976-bbb9-43fd0d456e9f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
199af640-10f4-4204-91fd-86d5779cfe76	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
04d51a73-2cca-40d3-a378-a04546f251f2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8a29a67f-15ae-4618-80a8-aac8a5c2e378	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6778f69a-8171-414a-a59a-68f9c164ed10	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2e0c52e8-1aaa-4a6b-9060-a8c7093f4492	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
052e0b24-3b20-4e51-a8d0-0077dff59294	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
46ac52d4-5b31-4b8f-b496-dbddcc3c3d46	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
20b193f5-394e-43fd-918f-910dc2274dcb	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
00181942-88ea-4094-b50f-52ff2c9b47e3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
11aa32ac-6c22-4c95-88b3-9060ca437e5a	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0e09abfd-fed6-4fbd-87a8-59a1b91f364a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4df92526-8faa-4a49-af62-c4be05a8f37c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a9ef13dd-c74f-443b-898a-8eb7adb8322c	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
485f4bf1-4fe1-4055-9029-f3f56a6e540f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0b743207-9f8e-4489-94ab-3d97b4bba84d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bd810767-3fb4-4c3a-a840-d92bf13b37f1	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c8f871b2-4a7e-4d11-833d-22a6ecd7aced	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ac9a57c2-627c-40d7-b954-30563db0db39	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
19d6daaf-5d1e-4ba5-8e1e-397034cbb6dc	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
aca47661-285d-4a9b-b527-e713a2023091	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
55467f3a-daa1-4890-a365-e7a4e23e684a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6cf3b4b0-62c0-4b73-a570-56936a34e932	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b52f8b4e-aa4c-45b5-b1d4-4ec178305841	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
04143b14-ce30-47dc-81b5-b29014ee858e	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
60a0da1f-c6a2-4d74-a204-63e09bd84429	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ff222b7b-1dc1-4049-a845-90973797760f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
db6ca71c-069a-4bcd-8cd8-9a7bdc58e3c5	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2a2ee04e-983e-493c-ae0f-51915e899b8d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c0ede2b8-71c9-4db1-8990-b200dfaadad3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a1d71a59-d445-496d-8ac8-2479065ab562	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
023a63f3-bc53-41af-b5b7-e53eb1b3613f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
677ca22d-c549-48ad-ad77-e471ff3ecd4f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
06346ac5-16df-410a-8ec2-dca60e48c847	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cc635220-4c53-4c03-ac38-3236fc1e459d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7b8a1eb5-5cf6-4569-b2d1-a419b76f3e37	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3937d35f-1f11-4395-bd93-4b17582f543d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5b32be00-fc03-45f8-819f-53256237fbaf	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1f290c59-2e24-4f97-a1ab-f1777efe7250	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f92f6ed6-448c-4638-a595-ba14d067ca50	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
01511b09-cf52-4cea-910d-c8efa6453e6d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
93fbe12f-a3ef-483d-8ccd-5590a2f34dc1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
adb5630b-f2da-4e05-b0a8-b91f54c1dcf6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6cbed167-6cba-4c43-aa31-e5dbdf1adaa6	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
787a9ec9-6e1a-433d-bb59-ff1b5ba44eec	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2c2b9f38-ed61-42e8-88f2-b63fd54967ee	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
33f362af-08a5-4dfe-8b6c-41cf06cb2edf	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a4791d33-9cc2-45f3-a189-6a163d1e55b3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3ef2dd7c-5291-4492-96de-d378af6248ef	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
900b1b09-3d33-44d4-a520-8e3ec4f58a93	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1afc5d0c-f7f1-4913-a665-eb94acaa3b14	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
73c9eb31-df53-4b96-b7cb-252201981ee3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3e68c763-07c6-430a-8f79-0385397e35a7	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5baadb87-17de-41f6-9f56-c27a6fa3eeb4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5f74afb6-b98f-41a4-9ec1-4dc426c8ea39	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a6a8e5f8-7492-4c4a-b64a-58fb5473040e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
da56f7f8-f516-4ce0-81e0-f1b9a99e2451	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fc882a64-cfa5-499e-a609-8b4a699bf0d2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
01a8fcb0-547b-4d4c-80c5-25cfe590088f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d47751ee-dcc8-4c48-90ca-6b20560f0455	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d35d278b-a4c4-411e-bfcc-2689afc43726	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
062b19c1-a834-40c7-be83-0cfd09396342	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2ffe22bf-83f8-4fc2-b1a7-da94edef5638	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b76f8f86-f3e6-49b3-aab7-fada1feab8c2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3ab5ae99-62d4-44f9-83d7-8804442ba424	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
389b47fa-bb6f-47f1-9d74-3129875898ca	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bd7fd6f9-545c-4b87-9c47-93b95adcb9ad	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3b4d023e-457b-470a-86f9-328b7f732ee0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fc4fc6d7-2926-44b5-aef0-8e751e265637	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e2b0cdb0-7dd8-4722-b1a5-d8b37bb54eb3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
62957bee-73ee-4104-9d92-68711a9ef116	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d248b108-c486-44c4-b85c-43708eb9f43b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ea217db8-416c-4bbe-b974-e367e28c3a82	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
853a7f09-a6e5-4a1a-9970-69902dcfd585	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ba826058-0f6c-410d-96cf-48d4f471d403	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
316ad728-f7b8-40dd-974c-031cefa66164	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1e702ab1-4d75-415f-a66b-56fd8536fcbb	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
64c95825-df49-4233-ae57-bf98a303b49d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
34e802c7-53b1-48b0-a1f2-fb010c9ce266	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8e8afd3b-dcc5-4623-a561-1b4b221143df	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ac09b4f2-ccbf-4707-9231-2cebcb243500	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
94897d2a-5d9f-4ae8-9639-7053bb06d0f0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b4ab8bf2-783a-4484-ae49-8d1475743089	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e29cb8ba-1508-4f8c-ba02-abf5fc523f25	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
56274678-2674-410a-a3c7-9dc1fbabac17	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b5f2d987-d5c0-4691-aaeb-0eed1380bde4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
35ec0aa6-d1d6-42db-bc31-18735c8ba80d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b9cee281-fe08-40c4-bf23-7dbc30fb92ff	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
36284185-e2b1-485a-962b-1dad754c2fb7	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
517e1e6c-a098-4aa2-afbc-21c713dfcef4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
be5de00b-3761-48f0-9d47-883848e537ee	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5908861b-2366-4845-aca3-22c108615a5b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4933442c-5003-4b87-8d83-ce563b8855b9	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3931bf11-8ed9-456a-9661-e991b38556b3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b6387b96-2d5f-4a3e-9878-4e9876c02f24	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1ed8a451-be36-4682-8727-9c213e89f2c4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7a660ca7-8947-49b8-90cb-481a3cbe6d67	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ab0c5a31-4dd3-43be-b9f7-a9621c81d1ba	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ade7e36d-9b1b-44df-8619-79957b78bfc0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2a80a1b6-3ef7-46e0-a505-737f0525a91d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
05387f98-eabc-4200-aad6-2fedaa5d7cb6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
342fe8eb-9d74-476a-9482-09d104f5ed37	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
935efeda-0795-4acc-9f35-276c94e75b18	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c742e134-584b-4ceb-82ee-93a134b15605	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7822ff89-98b3-40a3-9d8d-3771b0e5c0e6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1663fcba-fe30-4230-b308-f641c6e0d8df	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f8bfb95b-8f19-44d7-9d62-db493c2cf766	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cbe912e7-c62a-4c80-9eeb-fc50731966aa	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4882e25c-5049-4f6a-ae73-5e3d74dd8453	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e0b55493-5b7c-4326-b7d6-deb2bdabae91	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
9dfbf90c-abbc-4a6e-b11c-706fad74f1d5	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0dc9274e-521c-4d25-9a6e-c8715c0af42a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d4cb47b3-4962-4790-9076-dc59da7c4cee	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7a4dca9e-68da-48ad-abc1-672ac4eafb58	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2e337b04-d565-4619-a847-1ba46f26054e	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d25affd0-ecf2-4208-96d9-5dc85d21ed8c	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8b6a6f7b-2c6d-4a9f-b5dd-e9944d330445	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5eb0d99a-2539-4833-898c-12eac804a12f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e0bd7600-3b54-48d2-a268-658ea5f1ba51	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f7ed91c5-19d9-4825-8a8a-2eb9982025fa	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7eb434e8-514f-4651-a6ac-e7c5855805e4	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
60e3bc0f-1026-4afa-a246-d391e6a8d830	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5297983b-67b1-474b-9e96-56ba570e8cee	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d50df30c-7006-4f4c-805e-71eb7fcfa695	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5c496224-7aeb-4761-a6f6-8c8bb0958e65	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e263ce6f-4b97-412b-8a0d-e12738db6e2e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fa5eb2e6-16d9-4f63-bf5f-8b3002a02169	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
afdf227b-4ff5-4e4e-ada9-55a5297b40eb	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
333470c6-4fae-430d-b961-74d1486906d3	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d840f242-126a-4615-9cf8-33352e59405d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6fea4473-7c27-47e0-b91a-a77689d952e6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4cef2eee-f816-4b9a-8c67-4b311796918e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
03968508-1ec2-495c-8333-00b5784150f5	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
486888b0-6c71-493b-b753-2a396a5b8b28	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
706f281b-1b02-428e-9e98-ae2e72bac750	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c48b8326-d3e8-453e-9b1b-314abd130d5f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1b28a6e8-d7a2-4807-8a37-6b5f0c842c90	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
03936f90-2908-42e4-9396-84ab57aa86c2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
95cae54a-20eb-4a9e-ab0f-42d6a2670f2c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4d5230e6-6b5c-4dff-b3ab-badeaad9eb35	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
99cfd2fa-0c3b-42aa-8d4d-8c72ab6fa0fc	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a5a0332c-e75c-4be6-917d-0b83810b6923	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
dc306695-8762-4b72-8282-d6ee04c9f4ab	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
11c53ff9-2a63-4239-8afe-7a4b34006148	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8006bd5b-c241-432c-8baf-23d09ce4040a	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b7b43e7c-c01f-4596-9060-b2879e41339d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4e689b43-a605-4a02-89b9-96829982a8f2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
37f6cd1e-f9b9-4ed9-9ce7-0f29c7f80ed4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4f2c65a9-928b-4f1f-9330-862c8a9b503c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2049f1b9-14f6-4dbb-bbd2-6c947af5308d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ac84d9f2-7ea7-4632-ae29-3eea2cc178d2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2660b46b-d1b7-4646-849d-8a99362a4af3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
97d1e648-96ea-4072-8a05-c93474521158	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1f96003c-46ca-40ec-9964-7cf7e9aff295	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bcaa756b-d849-4117-9aeb-7719d8005b59	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
012b86dc-a418-4769-a9cb-45d2dcbae32a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bf120a0d-23a9-463f-9369-fad9cd84b8a8	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c2d37840-fec4-4ec1-b106-bac622e4a218	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fc2404a0-f1c1-4c20-bc49-81dcd8b5fb6f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
89fd3033-a9af-423f-b879-6c1a5193519a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a6be68f5-b074-4fb4-9f5a-c6ea64865f0f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2970dbca-fcfc-48bf-b513-2b0064104f6e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5f8bea72-8b35-4ea5-82a1-0877ae1f862b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2d395559-d76f-47ab-9438-efe8f24e8c49	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f0633992-d06a-485a-8df6-d3bedc2f2c0b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
211b4ab4-7ac7-4219-8768-7948e710ad86	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0c57568d-c4c4-46a8-8343-02ff394a1f7d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c6af7cac-1df8-4848-81e5-ebf8da07bbfa	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7911bb50-7f57-4f32-a941-31c4d4c5961b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cbe9847a-39be-4abe-ac92-265d4987217c	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
92bae5ab-0fe4-48e4-a39a-4c3d9f8c7681	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f70bf35d-f7e7-4457-9733-cbd19504b474	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
180a7e06-0693-42be-98d4-0d75bfb1c6eb	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b14b77bc-71e6-4327-b0bd-3e79865c0af5	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ceb7a8c5-5d08-4b60-bcde-4b2dc92ac822	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
871eec8b-f36e-4df2-8cd2-b4bfaf03139b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
9b6fb121-b0f6-4c91-a352-9f7d2e47d964	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6f9cc4af-10d1-4820-9ccd-92ae6c888209	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d20882e4-e5f5-4d5d-8ee7-6df415a59ffe	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2f5ee814-6453-4a78-a9bf-06de49b2bc59	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
44a4b63e-94fd-4f4a-bf3b-46af8954a110	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5f4003c0-8199-4835-b0b7-be984532a12d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7f497931-7996-4832-85d9-7acc0fed8945	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a1680eab-10a1-409f-9e61-e7589a6b401a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4a173177-eba2-4533-98b3-27c7f91e4065	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
18a6c931-302a-4f29-8d27-17c8dbc08b62	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
1011ddad-b693-4acc-b8d1-9417e18ac208	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c898b88a-4af0-46a4-8e94-965273778c61	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
24d37027-7a4f-4cba-88e1-e5ae1bb69fdf	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
87a4ee78-f37a-4cc9-9f55-12af11d6ee5f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
040c0163-7a60-4f68-b3d1-4c7999c160cf	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b0e9fa42-2333-4850-9a7f-6dd8775ec144	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
83c253bc-188b-4b79-b2c2-b1451d1ed678	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a763149c-0d38-4122-8778-da82c5e557c1	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e600a8b7-32ba-4513-8b28-f265ae92c65b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
df2cf3f7-66c0-4c00-ab19-db6e537383e2	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
faf4cbfe-d815-4fa1-bb84-a39b8767c507	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6853181a-914c-4011-81ff-32a225dcfae6	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
aeffb9bb-7f6e-49aa-bb77-b913ad6e7c6d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b4b1c6cf-9345-4bf5-9ee6-2a1e28490017	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a192544b-50dc-4512-86d7-265d7d6912c9	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7ce12856-53c1-49a6-8d66-c0ccd4f05617	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3ac694c0-75f2-4d1c-9662-9fb1dd2a55d2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bdb4c30f-7ff4-4045-b26b-3ce1672851be	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
059fedb4-9465-4ff4-80c0-cb5500d24722	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d2e31f92-c445-4548-91a2-8c997c3befc6	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
40cb62c0-0434-43c0-9dfd-9e8ded863850	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b39dfd6d-507e-44a1-9a46-4228f9cf4590	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
66ca2a91-73b5-4bea-9bbc-31f7bb86c0c3	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5b52a04d-f698-4a9e-a453-9a3146fee24d	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
852675e2-055c-41a0-a4db-76474849b48e	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a2e6a31f-7b76-4c33-a95c-e51179b47315	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
62c1ae05-df12-4af5-aca7-cbf1e1fc270a	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f6f06e47-1e68-4a15-ab90-28a1e2538e5b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d8d1cefc-492f-4fe8-a147-978daccc2f4c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d58f079e-9039-4623-949d-a7adfbdeb248	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
de133a51-6059-4439-a869-ca24782cd749	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
244fc581-cc6e-4ced-9933-712a0c7a9225	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
571a06d0-005d-4469-af74-b472d776c1c0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
18b0ba8b-1d02-4857-ab0a-32f186582fca	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
5dacc21b-2b27-48b3-a71d-a64591048491	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
afca113f-fcfa-4ab4-9c2f-a0a594d0ae72	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a69552bd-99e8-4097-8375-db4c5b620c8e	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3841fc7e-fc3a-45d9-8942-5611117f0e00	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b5e5d7a8-b72e-4b54-88d6-71dfaa3155b1	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8cc93507-dbe6-4c41-9a97-93d00b00392e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
bdeb4494-89b5-44a1-b32e-f0e5afc03017	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
95eafd40-9fb1-4262-90da-6770d048e2f6	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2e10bacb-d913-4f0a-8caf-7d06639beea1	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
44963e13-5a9c-4368-904e-5ee28cb00440	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f9f10453-5e46-4d68-bb75-a3f88c2a1fac	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7cfaa7e5-3998-42e7-8f84-4dfe37a8d5f5	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
63e03fad-28ce-43ee-ba22-a6dca12c2cc2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
afd94d58-abe7-454a-8d73-d0227df060cf	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b81f8eb7-f152-4c62-b864-790467735346	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b5e0a272-d305-4c0a-b10a-f4885933cf00	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
128b7b32-0898-4253-a88c-27018fcfcde0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
be5d1c91-1a96-4e79-9d73-e0ee68e63b06	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fcb142f8-b1fd-4ee4-9059-047ddc4a9847	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
acfa9799-5972-4aff-8f38-d80b0ae6688a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e0669320-ea93-4ff4-a62e-94b2fcf9ec99	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
86543bcf-ca94-4806-84cb-49c93206872c	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2fe81abc-eba1-48e4-bed9-66869d57a113	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
dfa165d8-2629-4bb6-9c16-45e31b9dac81	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
59ac5dfc-b48a-4f97-b1a2-a6e1cdddd540	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3c15d8ba-1b46-41d5-a5c7-da7027ed24cf	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cca8d002-3ebf-41e4-bc25-8db33f6577f6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
257baa6f-e350-4ea7-bc4e-30abf34e9804	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
3519a3ee-f082-471d-886c-b8a331c9bb65	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
63d7bf5a-a7a0-4eed-bea4-3866639b7e50	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
8133b75a-e237-4613-8147-6afddc9a58d6	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
12e89a12-22c8-4ccc-8732-fa095d6876f4	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
da4f3fcf-cc0d-4396-a7ba-e1006927e596	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6c5d4ace-00c7-4ac4-b805-462afa5890c6	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c4f627ea-ffbd-4c45-9593-8cbfc1d6a694	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f86e51f9-1382-4f41-af31-86dedfea332e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
41ec652a-8838-4730-bb03-30ef5597e815	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
ba6b94f9-4c57-472c-959c-9f146ebaffc3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c1cc9b3e-8557-4170-90b6-1ac9e55b8115	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c03d580c-4c6a-4499-8e09-5f0c150a07fd	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
489531af-1eaf-4bd3-9b1c-e5ad7eb1f886	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d700b8c9-fd4b-4364-a811-89021463ef9c	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4ef99395-4661-43b3-8cce-1a2c5885d9b3	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
920a1951-6c01-4c85-8f40-483af71b4cc0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
f9c477c1-20d4-4435-9f86-eef255875260	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
039674d3-32ee-45cf-8142-cce568b30a36	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c3b9d57e-db7f-4481-8d01-e22925c50dc4	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
25cbf255-9b31-4db6-910b-bb9b53139ece	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
53ca19f5-e393-4958-8c99-8af89a25eb09	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e10024b8-d64f-418e-9f6a-cee4ccb95b1e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
9ee5e5c5-9cf2-424b-981e-740b7e805e3f	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
87cec2fe-e366-483d-9ac1-3f5fc449b9b3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
154771b0-d011-41da-8fe1-5a0cf4283d59	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cbd38512-6095-4d4e-a1e9-122d1155340b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
de77ab9a-9b1d-4110-99de-3dd402c08b1c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a6518665-5c08-4728-aea4-36b7e3a4422a	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
aaf3b263-31e9-4b83-9b99-a207bd69f3b0	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
60261b80-70a6-415b-9d23-395beb2b2eee	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
11589715-7da1-4f7b-983d-4450c5c72114	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
276e75ab-a3e2-49ad-bbc7-5c352dff7457	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
49aefd45-4e85-4b06-9063-491aefb4414c	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
21c8e742-6c32-4feb-8a6a-7c345440887e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7da25654-a154-4b04-aa20-a87215d68bbc	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
6aac5d52-51a9-481a-a1c0-291ce66fe3e5	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
4045430c-a450-49b2-919c-0adc05c73999	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
82143f80-ad12-4982-a493-3c448cee66a3	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2c09d351-49f1-499f-841b-3390c7f1be8b	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a97eb2e2-c8f4-413b-bd75-ee1f33407034	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cf9ac57d-3f77-4a28-b0da-3ca48d8897e2	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b468b5d4-27d9-4bde-85f9-6128a045bdb0	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
cdf24080-637a-4869-9d49-201f91fc4677	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
31d54832-4bcf-4fa0-bdd1-c04cd4ec888e	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
e5d7fe6a-8d7b-423b-b1bd-d359b38ee6dc	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
c60d0c78-81d8-4f1b-a4b6-3c9612d62484	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b3652957-5b38-4748-88fd-58340bb4e757	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
aa90ba91-aad8-4124-9e34-6c64e5a1a731	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d6a73aa3-14c8-44e7-ba14-516508667793	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
b417332f-a489-4381-a5e1-8522a538311b	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
7f3db990-01cd-4d51-ab54-54c70371704d	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
a0d5b8ce-5546-479d-8c69-2888c9a98870	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
01542fb1-6e52-45bf-9a0b-9e51c3b364a9	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
2b98620d-4f88-401d-a433-f52703565d45	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
794edecf-85d0-4678-93a5-94bb6567dd86	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
fa4a3ac5-c540-4c32-b7c2-69cdf4b09403	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
01ede037-d15f-4b71-a892-585bed383706	PREMIUM	10000	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
0e319c7d-2081-4637-8a7f-b26c2f8e250f	\N	50	\N	5c88a435-14b9-4c7d-ae97-08c38822e5ad
d103776b-feab-465d-83c7-5aa72932ec3e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6f8ccfc9-bed7-4060-87d3-a49c5c3b4a3f	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
8ead286a-cca0-4b24-b708-ca46155a961d	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
a9a6356c-f6f5-41b5-92be-87cadcbb008a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
6d6f057f-ce1b-455a-aec5-3f0b17991591	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
74520586-27b2-492d-b077-ce70f1ab848a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
ba2d4000-dfe6-44d5-a917-66b1b959e7f0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
063ccd36-a699-4d56-a6cf-96ec18ca574a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
2e7c4962-f580-4d68-bdfa-809b837a79c7	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
cdb668a5-4c29-4a3f-ab7b-77af11f2f73f	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
4268f7d9-28f3-4c2e-bd04-fb2a2038e67e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2e86c7ab-39b4-4178-9fec-04978c7e1bec	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
d31572ea-9554-47ea-8c14-a1badb3ed34a	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
f52db6fb-a631-47c3-93fd-78b79ed8d6cb	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
2786871b-b505-45c8-8baa-61cc59eb85fc	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
1b0b202b-8fc9-436a-8c19-c0941228bbba	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
b3ce8e87-7506-477a-bb75-1abe5fd1f48e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
4a3efe65-a9b4-42a4-ae00-ec4b0b4de975	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
78e28f5f-4d57-4a25-aaab-bba84dd221a0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
37b46f57-3996-4b43-bd0a-00150ae90f62	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
17c3e500-e103-4189-97a9-98c42bcb3ade	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
7e8f404d-c275-4875-a233-6a9c478f382d	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
44b2f058-b714-4819-819e-f629caf7dc74	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c0a004b5-d891-4045-a730-d3ff77a18543	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
4739dd67-65af-4409-8afd-41f757d716e5	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6080e261-da78-4006-8d3a-92a8cb80cd08	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
d8b0e7fe-bead-4a4a-9a1a-2d6e51e39146	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
956a19e1-504e-45d5-be37-7e1bfde9c540	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
a743c484-f2f5-4f3b-9e32-f5e84cbcbd0e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
dda3bbde-861e-41bb-af37-41ee65e48be9	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f9e633cb-9fb7-4162-b574-cb1501fd10fb	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c183ff90-4d0c-4adf-bbec-a10a5cad2192	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
b80dd55a-5715-42a7-b71f-827d0caba153	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
24139285-be14-4090-bc4e-e2a2137d6ca3	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
b74369ac-ea31-46a9-98cb-8ff4dd2a1ec9	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
3ddbe7db-be6f-4880-a608-ef7b828c6260	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
88ee3bd4-b24c-422b-9ff2-563c2ff4b563	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
252d5aab-f5eb-4174-b944-454b7fc1482b	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
fee10f7b-3001-4d85-b341-526551a5772f	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6239c05e-f397-4400-8096-6b65ac8f408a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
4e9028aa-88bc-4811-9143-c7eb95e85142	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
73149b2f-5f54-499e-93c1-4d2045d52cb9	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
e8fa4e36-f519-4251-9cb9-3e70d9215457	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
825de349-88e3-495e-ab12-9b502345eb0e	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c2cffc94-5637-4747-96a6-194d8efac209	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
733893ba-6052-4996-9902-01fd7b146a5c	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c400d548-0616-4f29-a6fe-f2e2e86f30d9	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
9bfb2a5a-faa1-4b8c-a096-a51e570af19d	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
ad793695-88f6-4e53-80cc-85d4650abed2	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
1b537953-126b-4060-89f0-573af73406a5	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
6aeea083-a07e-46d8-b572-2e8e199fed32	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
62517c45-0e3f-4c89-8922-9a5f72b60485	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
2169f44c-90d9-4616-bcb8-baf27a44c6eb	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
b9d1fac0-2992-44fb-bd7a-d94bd95c604c	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
0ddbf6d8-5fed-4b3b-b660-975fbe919c00	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c70dedf4-a11a-47d8-aae8-40d4cdc1fc55	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
6582383c-cc89-47e9-a6c7-666a125c8d1d	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
25c2cac5-0952-4eb2-bf86-ceccfa58ffca	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
72f034ae-8280-46e7-9b5a-731fc42105d7	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
1044e59d-9c50-489c-a53b-b11686bfd651	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
4ce60ede-edfd-4eb2-b967-02c16297d7a8	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
d6d4ab25-f350-450c-a5c9-3a2bd9fd477a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
672f23c1-49bc-46a3-9764-28292db592e5	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
35ffe0b3-456f-4d6c-8987-5fc7fd1955ac	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
d2332818-3705-4d4b-ad6e-bfcefe832dc0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
22053b80-1a09-4bc3-9a33-8dfc99e9661f	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f9f72a8a-d918-4d66-b377-79d21e99aa1c	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
cc628188-6a91-4c61-b8c9-210a3dd4c43d	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
96e87574-94d3-4a53-87ab-094d0633d78c	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
25ea5454-6c35-498a-b117-4bddf7e31fe1	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
6b7f95af-dcd3-4b3e-ae75-9c7ca8d603a0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6794e782-06db-4f52-939a-dcd1eca556ba	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
179490be-a0fe-4839-812a-dcf4ffb1a5e3	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
e18cc133-e69a-4818-96c8-fa1f0cfc3cb4	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
e6d09392-2b3b-4916-8c6b-51c8146372ee	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
7e52ca5f-ccae-4ed6-97d4-442f47e9a5c8	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f5c8aa16-6940-4072-be8e-0d5ef95d5ba4	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
7f3f6424-2826-4e8b-88a9-5d64df141c05	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
035cd60e-ebe0-4052-b44e-f61f006c136b	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
f96f177d-43f0-4950-8d1d-ea3836a8ca2d	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
2f54d295-c300-40f5-8b14-1bc3898a0598	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
636381f6-f69a-487f-87fa-1a79a16e2414	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
e752b95b-e321-4dbd-b7a6-2b5e45078827	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
beb30059-62ee-4908-adc6-3ac3ed6490e3	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
1228f78e-fb34-4f1e-8112-9ac49b1bb51a	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2bf8beca-14ed-4c15-90d7-20f5993e951c	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
fbef350b-3b0e-4093-a117-031b3081ed67	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
ae60e47c-7f66-4187-b5cd-837bcd56e085	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
839bebea-ed60-498e-9a73-414e67036b85	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
978fe360-78c6-4fb9-9faf-4116981b19de	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c223b85b-7783-4ccf-b9d6-86109c241459	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
9926e067-0f29-4a8f-beee-ca32380b1558	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
1125a057-02ca-4c48-8f6f-023a6a54bdf8	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
0206632d-c059-4977-a4f5-3b49df645337	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
d759b0b3-c780-482a-888b-0eea6d25ae57	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
7095e574-c665-4475-b7ce-9de79117e1a2	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
bfef0c04-ffd7-480f-9625-68fb375452d5	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
d7ee7c25-8189-4862-8076-52a09103a53c	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
527f9af6-62c9-48bb-b4b6-d5a5021d93ac	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c100cb07-95ae-42cf-9f39-f95ab3b31ed5	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
884e6626-d0bf-40ec-a064-2ddda7299b9e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
029227d4-88f8-48a1-b22e-3d93ef0dd34a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
cc052784-39a0-40e5-ba51-c7ccfdc65dbd	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
81201642-ecff-46ef-b593-1d7d9a50fb18	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c9129192-a144-4c2a-b624-be85c1477cab	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
76c13ba6-b589-42dc-a97c-a7a27396293e	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c69a142f-122d-4ccd-b3ee-35b5d9d602fb	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
f7532d8a-01f8-42b6-9d7f-c412b54e6cc6	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
c50c1cf2-ea7a-415b-b42e-af1e8850d0aa	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2a32991d-e213-4bdf-ae41-d3cbdbf7d825	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
90e7b5ec-2f1a-453e-9f1e-bfc4af5d3785	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2acb23df-2e97-439f-b165-bbb3142d06cf	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
787527a4-55a4-4d79-84f7-58c70edc94ed	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
35840b5b-b9d2-4724-bd82-72cc9be231c0	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
23e3fad7-8900-4dbc-9740-c65086515a19	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c379d8c9-f889-470c-b0a2-758f0f7f3b56	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
dda6792d-2e86-4fb4-a493-992d6cbe4770	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
db3c91a7-057d-41e9-bd1e-c90fe79531dd	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
05cbcadc-f41a-44b3-9c45-6cc9c88fc566	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c10ec9c4-8584-4f6e-9f07-44838f7880e3	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
6831db67-bbc9-4a51-b39e-7174db24e6dc	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
ab520d16-b365-4ded-b963-563358fa6135	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
3cc84af7-5e53-4a31-9ae6-fc571ccc18d8	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
65992a94-d065-49f3-888c-9f6bd1c74784	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
becff050-292b-4285-8452-b74a1a579ead	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
0e3771c6-1081-4c04-a3af-117e7f606c0a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
686ad63e-2a91-43f5-ae4b-e7e0d6d1de03	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
ff3f87cf-d9e9-43d5-a4c1-cf056a4ac6fd	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
e21c169f-31a2-4c97-a819-7527240461bc	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2d31b493-364a-46bc-849e-7983e71fff91	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
309237cc-a002-4345-880f-a66f34848f82	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
476fe198-d3e0-4111-9796-c29b178b4de2	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
5f1fc37d-caf7-4f14-8334-c16c6bdc357e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
4310add5-8b04-41f0-bce2-e5e3e34e16b2	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
77db02c5-bfa2-456f-ba14-2562cffd01c3	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
93d12e45-c7dc-4d5b-b70e-63a8b42cd988	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
8eb847b7-128c-4c37-ba53-787b5e7c41dd	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
f77a3821-ce94-4b14-9432-e0608b5f0868	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
dcbc5e68-e48c-45f4-8907-ff11e96cb7c0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
9724fd31-cab7-4723-b6bf-110d62fb39a4	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
7531122a-0f42-4d94-97f5-823b02880183	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
93904750-5917-4b29-85f8-871731220471	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
08fdb5ff-f7ae-44d1-af09-4361913c2ed0	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
3f486989-6884-48e6-8ea5-fb56fffd3cf1	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
b3ce7132-ef03-45b4-abe6-32f954ed54ff	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
0844332a-9490-47e0-9100-fe319527cc5e	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f939ed5d-9e37-4c0d-8764-bdecfbbf35e4	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
38deb61b-1734-4a0e-9b80-53625f9ba21a	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f6381f25-681e-426d-8c4a-2108092faf3a	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
041a989e-1a9f-45de-9059-19efdb90fa9f	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
159d4b9d-cc59-4297-b865-09465afa8ff7	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
1c46f8f2-6670-44d2-a739-ccc207e305d2	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
1cf5a83e-1e5a-426e-bbea-6edfdaf9cf53	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
2baaefed-a85f-4dc8-a1c5-6ed31ee3a95b	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
fafba8c5-3147-4fcf-b5ff-5b463fedb301	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
8831db4f-39b5-4e47-aa0e-e8a2c41b15a7	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
ac7bf450-674f-47ec-a82b-92bb05cacfca	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
779ad5a5-5378-4585-a0ca-56e586c9441d	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
1207a0a8-8825-4c08-876c-52ebdd2be817	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
a708fb60-bcb8-490a-940d-2d02ad8c23d2	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
3f52b424-3542-4c4e-a4e8-02bd68a88c43	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6ebe26e3-c73f-4d63-9e4d-2721e6182a77	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
bb506f35-4262-46c1-a5a5-7bfe4372c98e	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
1e1ecbb3-9d68-4d90-a6d1-8350539f9992	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
d72a6d73-f334-4c66-9f5e-60ec93a642ca	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
4dc314b1-4e5a-4e81-a9da-a87ab5cc89e1	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
cf2dcdf2-ae89-47e6-a3fe-5c496102bc18	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
725aa899-f88c-490f-b68a-75c441a14f38	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
7dd24d51-4d33-4654-87d6-15af46ada626	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
c1280154-e779-48a6-8e62-6b89b39b40e3	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
be65a5c3-f6ea-40c8-b68f-ee255e823921	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
d9ef22b4-fbc9-4793-9bfa-888f89f47385	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
83b50eb0-6b41-4761-bef9-5ecccf20cd20	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
ae324333-b725-41ea-be9d-50c8aa7827cc	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
7d92236c-634a-4a9a-9416-4cb8cc2750c1	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
a6738eef-0e50-4a09-954d-22bc9d7e8722	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
a2b7d096-b4a2-4067-b160-1857b986a81b	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
826f2757-6153-4028-94dc-198c2f129789	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
39adf435-c0bb-44a7-b737-ad24af49756d	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
6408c95a-5c4c-409b-a699-5bbb31107007	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
22caecc1-df79-4bae-b374-1493e22b2799	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
0d8b863e-40d8-4a50-a449-a5859b84a257	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
f37e7400-b224-45a7-b57d-99d681b7ce87	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
43bef92a-5a52-44cb-a25b-933deeeb8763	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
5b963e7e-7ec7-4f9d-ae6c-05a997746d72	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
22e36a53-aa1f-4a8c-a069-7cac9be94f1b	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
e7e92838-0064-4c05-ad6b-c261d36c71c4	PREMIUM	10000	\N	7b85a40d-2149-44be-a888-438cc50012f7
e07e89c2-7f8f-4a61-8994-fe1eedb6c9d8	\N	50	\N	7b85a40d-2149-44be-a888-438cc50012f7
\.


--
-- Data for Name: referrals_profit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referrals_profit (id, honey, player_id) FROM stdin;
0ebda2e5-8a1c-42d1-94ce-d9e6bc686b10	814050	7b85a40d-2149-44be-a888-438cc50012f7
39a633a4-79fa-4091-8191-24a2d04415db	1105500	5c88a435-14b9-4c7d-ae97-08c38822e5ad
\.


--
-- Data for Name: referrals_quests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referrals_quests (id, referral_count, reward, description, level) FROM stdin;
a08b1ced-7b3f-42a8-b66c-0a3e9ffe4c27	1	50000	LVL 1 - Invite your friend! To complete this quest, your friend must be your referral.	1
98efc2d7-c913-4cfe-a870-f7140823037b	3	75000	LVL 2 - Invite 3 your friends! To complete this quest, your friends must be your referrals.	2
e2825aa5-62bd-4d90-8e7f-4b0e95e4dc6a	5	100000	LVL 3 - Invite 5 your friends! To complete this quest, your friends must be your referrals.	3
d909ef0e-55c3-43c0-a6ce-76b78afc6514	10	150000	LVL 4 - Invite 10 your friends! To complete this quest, your friends must be your referrals.	4
8c743738-4abc-48d8-a109-3cefae9fe684	25	200000	LVL 5 - Invite 25 your friends! To complete this quest, your friends must be your referrals.	5
16614cd5-e4df-4c23-868c-56138f139864	50	250000	LVL 6 - Invite 50 your friends! To complete this quest, your friends must be your referrals.	6
\.


--
-- Data for Name: referrals_quests_profit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referrals_quests_profit (id, referral_count, reward, claimed, player_id, referral_quest_id) FROM stdin;
6384857f-046b-48f3-abd2-a7d7657d6e88	1	50000	t	5c88a435-14b9-4c7d-ae97-08c38822e5ad	a08b1ced-7b3f-42a8-b66c-0a3e9ffe4c27
ca397718-b196-4fc2-8cc9-f4d09770ccc4	3	75000	t	5c88a435-14b9-4c7d-ae97-08c38822e5ad	98efc2d7-c913-4cfe-a870-f7140823037b
3b556076-a8e8-45c4-95af-885be69b0568	5	100000	t	5c88a435-14b9-4c7d-ae97-08c38822e5ad	e2825aa5-62bd-4d90-8e7f-4b0e95e4dc6a
28e5d08e-55ef-4d7b-9054-abb807cf5c20	1	50000	t	7b85a40d-2149-44be-a888-438cc50012f7	a08b1ced-7b3f-42a8-b66c-0a3e9ffe4c27
ed41b07e-de65-4d33-9c82-08893033e5a9	3	75000	t	7b85a40d-2149-44be-a888-438cc50012f7	98efc2d7-c913-4cfe-a870-f7140823037b
eb4eaa5e-7cf9-4a8e-9561-69aa492f2acc	5	100000	t	7b85a40d-2149-44be-a888-438cc50012f7	e2825aa5-62bd-4d90-8e7f-4b0e95e4dc6a
ca5a11bd-7974-4238-ae4f-54cdbf0bf7ce	10	150000	t	7b85a40d-2149-44be-a888-438cc50012f7	d909ef0e-55c3-43c0-a6ce-76b78afc6514
396a4fd2-ad1e-43d7-abfd-093d5e7b484d	25	200000	t	7b85a40d-2149-44be-a888-438cc50012f7	8c743738-4abc-48d8-a109-3cefae9fe684
a21a20ab-90c1-4774-a897-71fd49cc7e39	50	250000	t	7b85a40d-2149-44be-a888-438cc50012f7	16614cd5-e4df-4c23-868c-56138f139864
\.


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 1, false);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: bonuses bonuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bonuses
    ADD CONSTRAINT bonuses_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: medias medias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medias
    ADD CONSTRAINT medias_pkey PRIMARY KEY (id);


--
-- Name: orcs orcs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orcs
    ADD CONSTRAINT orcs_pkey PRIMARY KEY (id);


--
-- Name: player_bonuses player_bonuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonuses
    ADD CONSTRAINT player_bonuses_pkey PRIMARY KEY (id);


--
-- Name: player_progress player_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_progress
    ADD CONSTRAINT player_progress_pkey PRIMARY KEY (id);


--
-- Name: player_rank_profit player_rank_profit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_rank_profit
    ADD CONSTRAINT player_rank_profit_pkey PRIMARY KEY (id);


--
-- Name: player_ranks player_ranks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_ranks
    ADD CONSTRAINT player_ranks_pkey PRIMARY KEY (id);


--
-- Name: player_tokens player_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_tokens
    ADD CONSTRAINT player_tokens_pkey PRIMARY KEY (id);


--
-- Name: players_orcs players_orcs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_orcs
    ADD CONSTRAINT players_orcs_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: players_quests players_quests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_quests
    ADD CONSTRAINT players_quests_pkey PRIMARY KEY (id);


--
-- Name: players_tasks players_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_tasks
    ADD CONSTRAINT players_tasks_pkey PRIMARY KEY (id);


--
-- Name: profit profit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profit
    ADD CONSTRAINT profit_pkey PRIMARY KEY (id);


--
-- Name: quest_tasks quest_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quest_tasks
    ADD CONSTRAINT quest_tasks_pkey PRIMARY KEY (id);


--
-- Name: quests quests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quests
    ADD CONSTRAINT quests_pkey PRIMARY KEY (id);


--
-- Name: ranks ranks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranks
    ADD CONSTRAINT ranks_pkey PRIMARY KEY (id);


--
-- Name: referrals_early_bonuses referrals_early_bonuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_early_bonuses
    ADD CONSTRAINT referrals_early_bonuses_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: referrals_profit referrals_profit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_profit
    ADD CONSTRAINT referrals_profit_pkey PRIMARY KEY (id);


--
-- Name: referrals_quests referrals_quests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_quests
    ADD CONSTRAINT referrals_quests_pkey PRIMARY KEY (id);


--
-- Name: referrals_quests_profit referrals_quests_profit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_quests_profit
    ADD CONSTRAINT referrals_quests_profit_pkey PRIMARY KEY (id);


--
-- Name: medias_quest_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX medias_quest_id_key ON public.medias USING btree (quest_id);


--
-- Name: player_tokens_player_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX player_tokens_player_id_key ON public.player_tokens USING btree (player_id);


--
-- Name: players_orcs_player_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX players_orcs_player_id_key ON public.players_orcs USING btree (player_id);


--
-- Name: referrals_profit_player_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX referrals_profit_player_id_key ON public.referrals_profit USING btree (player_id);


--
-- Name: medias medias_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medias
    ADD CONSTRAINT medias_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quests(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: player_bonuses player_bonuses_bonus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonuses
    ADD CONSTRAINT player_bonuses_bonus_id_fkey FOREIGN KEY (bonus_id) REFERENCES public.bonuses(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: player_bonuses player_bonuses_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonuses
    ADD CONSTRAINT player_bonuses_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_progress player_progress_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_progress
    ADD CONSTRAINT player_progress_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_rank_profit player_rank_profit_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_rank_profit
    ADD CONSTRAINT player_rank_profit_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_rank_profit player_rank_profit_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_rank_profit
    ADD CONSTRAINT player_rank_profit_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.ranks(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: player_ranks player_ranks_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_ranks
    ADD CONSTRAINT player_ranks_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_ranks player_ranks_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_ranks
    ADD CONSTRAINT player_ranks_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.ranks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_tokens player_tokens_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_tokens
    ADD CONSTRAINT player_tokens_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_orcs players_orcs_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_orcs
    ADD CONSTRAINT players_orcs_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_quests players_quests_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_quests
    ADD CONSTRAINT players_quests_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_quests players_quests_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_quests
    ADD CONSTRAINT players_quests_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_tasks players_tasks_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_tasks
    ADD CONSTRAINT players_tasks_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: players_tasks players_tasks_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_tasks
    ADD CONSTRAINT players_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.quest_tasks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profit profit_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profit
    ADD CONSTRAINT profit_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: quest_tasks quest_tasks_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quest_tasks
    ADD CONSTRAINT quest_tasks_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: referrals_early_bonuses referrals_early_bonuses_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_early_bonuses
    ADD CONSTRAINT referrals_early_bonuses_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: referrals_profit referrals_profit_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_profit
    ADD CONSTRAINT referrals_profit_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: referrals_quests_profit referrals_quests_profit_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_quests_profit
    ADD CONSTRAINT referrals_quests_profit_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: referrals_quests_profit referrals_quests_profit_referral_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals_quests_profit
    ADD CONSTRAINT referrals_quests_profit_referral_quest_id_fkey FOREIGN KEY (referral_quest_id) REFERENCES public.referrals_quests(id) ON UPDATE CASCADE;


--
-- Name: referrals referrals_referral_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referral_id_fkey FOREIGN KEY (referral_id) REFERENCES public.players(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

