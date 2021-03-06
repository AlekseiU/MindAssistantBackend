PGDMP     )                    u            mindassistant    9.6.3    9.6.3 )    y	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            z	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            {	           1262    16386    mindassistant    DATABASE        CREATE DATABASE mindassistant WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE mindassistant;
             urivsky    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            |	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12655    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            }	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16409    data    TABLE     �   CREATE TABLE data (
    id integer NOT NULL,
    name character(128) NOT NULL,
    project integer DEFAULT '-1'::integer NOT NULL,
    parent integer DEFAULT 0 NOT NULL,
    coordinates json DEFAULT '{"x":"","y":""}'::json NOT NULL
);
    DROP TABLE public.data;
       public         urivsky    false    3            ~	           0    0    data    ACL     ]   REVOKE ALL ON TABLE data FROM urivsky;
GRANT ALL ON TABLE data TO urivsky WITH GRANT OPTION;
            public       urivsky    false    186            �            1259    16446    data_id_seq    SEQUENCE     m   CREATE SEQUENCE data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.data_id_seq;
       public       urivsky    false    3    186            	           0    0    data_id_seq    SEQUENCE OWNED BY     -   ALTER SEQUENCE data_id_seq OWNED BY data.id;
            public       urivsky    false    188            �            1259    16503    field_groups    TABLE     �   CREATE TABLE field_groups (
    id integer NOT NULL,
    name character(128) NOT NULL,
    ordr integer NOT NULL,
    data integer NOT NULL
);
     DROP TABLE public.field_groups;
       public         postgres    false    3            �	           0    0    field_groups    ACL     >   GRANT ALL ON TABLE field_groups TO urivsky WITH GRANT OPTION;
            public       postgres    false    191            �            1259    16530    field_groups_id_seq    SEQUENCE     u   CREATE SEQUENCE field_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.field_groups_id_seq;
       public       postgres    false    191    3            �	           0    0    field_groups_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE field_groups_id_seq OWNED BY field_groups.id;
            public       postgres    false    192            �	           0    0    field_groups_id_seq    ACL     Q   GRANT SELECT,USAGE ON SEQUENCE field_groups_id_seq TO urivsky WITH GRANT OPTION;
            public       postgres    false    192            �            1259    16472    fields    TABLE     �   CREATE TABLE fields (
    id integer NOT NULL,
    type character(32) NOT NULL,
    ordr integer NOT NULL,
    value character(512),
    group_id integer NOT NULL
);
    DROP TABLE public.fields;
       public         postgres    false    3            �	           0    0    fields    ACL     8   GRANT ALL ON TABLE fields TO urivsky WITH GRANT OPTION;
            public       postgres    false    189            �            1259    16475    fields_id_seq    SEQUENCE     o   CREATE SEQUENCE fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.fields_id_seq;
       public       postgres    false    3    189            �	           0    0    fields_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE fields_id_seq OWNED BY fields.id;
            public       postgres    false    190            �	           0    0    fields_id_seq    ACL     K   GRANT SELECT,USAGE ON SEQUENCE fields_id_seq TO urivsky WITH GRANT OPTION;
            public       postgres    false    190            �            1259    16404    projects    TABLE     y   CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    pages integer NOT NULL
);
    DROP TABLE public.projects;
       public         urivsky    false    3            �	           0    0    projects    ACL     e   REVOKE ALL ON TABLE projects FROM urivsky;
GRANT ALL ON TABLE projects TO urivsky WITH GRANT OPTION;
            public       urivsky    false    185            �            1259    16436    projects_id_seq    SEQUENCE     q   CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.projects_id_seq;
       public       urivsky    false    185    3            �	           0    0    projects_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE projects_id_seq OWNED BY projects.id;
            public       urivsky    false    187            �           2604    16448    data id    DEFAULT     T   ALTER TABLE ONLY data ALTER COLUMN id SET DEFAULT nextval('data_id_seq'::regclass);
 6   ALTER TABLE public.data ALTER COLUMN id DROP DEFAULT;
       public       urivsky    false    188    186            �           2604    16532    field_groups id    DEFAULT     d   ALTER TABLE ONLY field_groups ALTER COLUMN id SET DEFAULT nextval('field_groups_id_seq'::regclass);
 >   ALTER TABLE public.field_groups ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    192    191            �           2604    16477 	   fields id    DEFAULT     X   ALTER TABLE ONLY fields ALTER COLUMN id SET DEFAULT nextval('fields_id_seq'::regclass);
 8   ALTER TABLE public.fields ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    190    189            �           2604    16438    projects id    DEFAULT     \   ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);
 :   ALTER TABLE public.projects ALTER COLUMN id DROP DEFAULT;
       public       urivsky    false    187    185            p	          0    16409    data 
   TABLE DATA               ?   COPY data (id, name, project, parent, coordinates) FROM stdin;
    public       urivsky    false    186   V%       �	           0    0    data_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('data_id_seq', 11, true);
            public       urivsky    false    188            u	          0    16503    field_groups 
   TABLE DATA               5   COPY field_groups (id, name, ordr, data) FROM stdin;
    public       postgres    false    191   s%       �	           0    0    field_groups_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('field_groups_id_seq', 9, true);
            public       postgres    false    192            s	          0    16472    fields 
   TABLE DATA               :   COPY fields (id, type, ordr, value, group_id) FROM stdin;
    public       postgres    false    189   �%       �	           0    0    fields_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('fields_id_seq', 12, true);
            public       postgres    false    190            o	          0    16404    projects 
   TABLE DATA               ,   COPY projects (id, name, pages) FROM stdin;
    public       urivsky    false    185   �%       �	           0    0    projects_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('projects_id_seq', 2, true);
            public       urivsky    false    187            �           826    16401     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     j   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT SELECT,USAGE ON SEQUENCES  TO urivsky WITH GRANT OPTION;
                  postgres    false            �           826    16403    DEFAULT PRIVILEGES FOR TYPES    DEFAULT ACL     ]   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES  TO urivsky WITH GRANT OPTION;
                  postgres    false            �           826    16402     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     a   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS  TO urivsky WITH GRANT OPTION;
                  postgres    false            �           826    16400    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     ^   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO urivsky WITH GRANT OPTION;
                  postgres    false            p	      x������ � �      u	      x������ � �      s	      x������ � �      o	      x������ � �     