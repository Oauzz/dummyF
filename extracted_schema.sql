
-- Extracted Sequences
CREATE SEQUENCE "AspNetUserClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_douar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE parcelle_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_sous_zone
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_zone
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE geoife_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_notif_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE actionmarche_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE adjudicataire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE auth_act_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE bornes_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE bornes_opposition_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE bornesparcelaire_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE enqueteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE etat_parcelle_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE groupe_proprietaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_document_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_etat_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_igt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_livraison_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_prepmarche_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_satrejet_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE id_situation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE synchronisation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE riverain_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_ayant_droit_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_gid_parcelaire
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_id_consistance
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idcercle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idcommune
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idpersonnel
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idprovince
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idrejet
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idremarque
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_idriverain
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_opposant_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_parcelle_personne
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_temoin_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



-- Extracted Tables
CREATE TABLE "Action" (
    "CodeAction" character varying(128) NOT NULL,
    "LibelleAction" character varying(255)
);

CREATE TABLE "ActionMarche" (
    num_marche character varying(255),
    "CodeAction" character varying(125),
    "Observation" text,
    "IdUser" character varying(125),
    "Id" integer NOT NULL,
    "DateAction" timestamp without time zone
);

CREATE TABLE "AspNetRoles" (
    "Id" character varying(128) NOT NULL,
    "Name" character varying(256) NOT NULL
);

CREATE TABLE "AspNetUserClaims" (
    "Id" integer NOT NULL,
    "ClaimType" character varying(256),
    "ClaimValue" character varying(256),
    "UserId" character varying(128) NOT NULL
);

CREATE TABLE "AspNetUserLogins" (
    "UserId" character varying(128) NOT NULL,
    "LoginProvider" character varying(128) NOT NULL,
    "ProviderKey" character varying(128) NOT NULL
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" character varying(128) NOT NULL,
    "RoleId" character varying(128) NOT NULL
);

CREATE TABLE "AspNetUsers" (
    "Id" character varying(128) NOT NULL,
    "UserName" character varying(256) NOT NULL,
    "PasswordHash" character varying(256),
    "SecurityStamp" character varying(256),
    "Email" character varying(256) DEFAULT NULL::character varying,
    "EmailConfirmed" boolean DEFAULT false NOT NULL,
    "PhoneNumber" character varying(256),
    "PhoneNumberConfirmed" boolean DEFAULT false NOT NULL,
    "TwoFactorEnabled" boolean DEFAULT false NOT NULL,
    "LockoutEndDateUtc" timestamp without time zone,
    "LockoutEnabled" boolean DEFAULT false NOT NULL,
    "AccessFailedCount" integer DEFAULT 0 NOT NULL,
    "IsEnabled" boolean,
    "CreationDate" timestamp without time zone NOT NULL,
    "LastEnablingDate" timestamp without time zone,
    "LastDisablingDate" timestamp without time zone
);

CREATE TABLE "ServiceExterieur" (
    "IdSE" integer NOT NULL,
    "NomSE" character varying(255),
    mail_cad character varying(256),
    mail_cf character varying(256),
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);

CREATE TABLE douar (
    id_douar integer DEFAULT nextval('seq_douar'::regclass) NOT NULL,
    nom character varying(255) NOT NULL,
    observation character varying(255),
    id_sous_zone integer,
    nom_ar character varying(255),
    "IdCommune" integer NOT NULL,
    mokadem character varying(255),
    cheikh character varying(255),
    "EstimParc" integer NOT NULL
);

CREATE TABLE marche (
    num_marche character varying(255) NOT NULL,
    id_zone integer NOT NULL,
    superficie_immatriculee numeric,
    "serviceExt" integer NOT NULL,
    categorie_zone integer,
    objet text,
    delai integer,
    "NbreParEstime" integer,
    montant double precision NOT NULL,
    "PU_Phase1" double precision,
    "PU_Phase2" double precision,
    "Pourcentage_Phase0" double precision,
    "DateSignatureDG" date,
    "DateVisa" date,
    "DateRecOrthoPhoto" date,
    "DateRecPVCC_RFDC" date,
    "DateRecPVCC_RFDCF" date,
    "DateArrOuv" date,
    "DateEnvoiArrOuvDG" date,
    "DateEnvoiArrOuvMin" date,
    "DateEnvoiArrSGG" date,
    "DateRetourMin" date,
    "DateBO" date,
    "DateOS" date,
    "DateReunionCC" date,
    "NumOS" character varying(128),
    "SourcePVCC" character varying(128),
    "NumVisa" character varying(128),
    "NumBE" character varying(128),
    "NumBO" character varying(128),
    "Montant_Phase0" double precision,
    "PrgExecVal" boolean,
    "PrgExecObs" text,
    "APDVal" boolean,
    "DateValPrgExec" date,
    "DateValAPD" date,
    "PrgExecCFVal" boolean,
    "DateValPrgExecCF" date,
    "PrgExecCFObs" text,
    id_adj integer,
    "DateDepBLPieces" timestamp without time zone,
    "DateDepPrgExec" timestamp without time zone,
    "PU_Phase3" double precision
);

CREATE TABLE parcelle (
    num_parcelle character varying(255) NOT NULL,
    mappe_dat character varying(255),
    nb_borne integer,
    observation character varying(255),
    nom_parcelle_ar character varying(255),
    nom_parcelle_fr character varying(255),
    surface_ha integer,
    surface_a integer,
    surface_ca integer,
    adresse character varying(255),
    adresse_ar character varying(255),
    id_douar integer NOT NULL,
    the_geom geometry,
    id_synchronisation integer DEFAULT nextval('parcelle_gid_seq'::regclass) NOT NULL,
    douar integer,
    num integer NOT NULL,
    num_char character varying(20),
    "id_enqueteurP" integer NOT NULL,
    the_geom_s text,
    date_parcellaire date,
    date_juridique date,
    etat character varying(100),
    date_synchronisation timestamp without time zone NOT NULL,
    "NatureDossier" character varying(128),
    "NumDossier" character varying(128),
    "Indice" character varying(128),
    "IndiceSpe" character varying(128),
    "id_enqueteurJ" integer,
    fournisseur_info character varying(255),
    "EtatCAD" character varying(255),
    "EtatCF" character varying(255),
    "Observ_Cont_CAD" text,
    "Observ_Cont_CF" text,
    id_validateur integer,
    "Id_LivraisonCF" integer,
    "Id_LivraisonCAD" integer,
    "HasAllDocsCAD" boolean,
    "HasAllDocsCF" boolean,
    num_ordre integer,
    "IdContr_CAD" integer,
    "IdContr_CF" integer,
    num_parcelle_def character varying(255) DEFAULT 'NEANT'::character varying NOT NULL,
    surface_adoptee double precision,
    "RejectedCAD" integer DEFAULT 0 NOT NULL,
    "RejectedCF" integer DEFAULT 0 NOT NULL,
    "UpdatedCF" integer DEFAULT 0 NOT NULL,
    "UpdatedCAD" integer DEFAULT 0 NOT NULL,
    "LastUpdateCAD" timestamp without time zone,
    "LastUpdateCF" timestamp without time zone,
    "LastRejCAD" timestamp without time zone,
    "LastRejCF" timestamp without time zone,
    date_decision_enrol timestamp without time zone,
    date_depot timestamp without time zone,
    date_envoi_enrol timestamp without time zone,
    date_op timestamp without time zone,
    "nOP" integer,
    "codeEnvoi" character varying(125),
    "serviceExt" integer NOT NULL,
    projection integer,
    nb_prop integer DEFAULT 0 NOT NULL,
    "EtatBornage" character varying(255),
    "IdBorneur" integer,
    date_bornage timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_prg_bornage timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    "NumPrgBornage" character varying(128),
    "Observ_Bornage" text,
    CONSTRAINT "Parcelle_the_geom_check1" CHECK (((geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT "Parcelle_the_geom_check3" CHECK ((st_ndims(the_geom) = 2))
);

CREATE TABLE sous_zone (
    id_sous_zone integer DEFAULT nextval('seq_sous_zone'::regclass) NOT NULL,
    nom character varying(255),
    observation character varying(255),
    id_zone integer NOT NULL,
    nom_ar character varying(255),
    "EstimParc" integer NOT NULL
);

CREATE TABLE zone (
    id_zone integer DEFAULT nextval('seq_zone'::regclass) NOT NULL,
    carte_topo character varying(255),
    date_leve character varying(255),
    nom character varying(255),
    "IdCommune" integer NOT NULL,
    "IdProvince" integer NOT NULL,
    "IdCercle" integer NOT NULL,
    "IdZoneLambert" integer,
    nom_ar character varying(255),
    "NomCommune_fr" character varying(255),
    "NomCommune_ar" character varying(255),
    "NomProvince_ar" character varying(255),
    "NomProvince_fr" character varying(255),
    "NomCercle_ar" character varying(255),
    "NomCercle_fr" character varying(255),
    "NomCaidat_ar" character varying(255),
    "NomCaidat_fr" character varying(255),
    "IdCaidat" integer NOT NULL
);

CREATE TABLE "BienLimitrophe" (
    "Id_Riverain" integer NOT NULL,
    "Nature" character varying(128),
    "Indice" character varying,
    "IndiceSpe" character varying(128),
    "Numero" character varying(128)
);

CREATE TABLE "Caidat" (
    "IdCaidat" integer NOT NULL,
    "NomCaidat" character varying(255),
    "NomCaidat_ar" character varying(255),
    "Caid" character varying(255),
    "IdProvince" integer
);

CREATE TABLE "Categorie" (
    "IdCategorie" integer NOT NULL,
    "NomCategorie" character varying(255),
    delai_phase1 integer,
    delai_phase2 integer
);

CREATE TABLE "Categorie_Document" (
    "Libelle_Categorie" character varying(255),
    "Code_Categorie" character varying(128) NOT NULL,
    "Type" character varying(128),
    "Obligatoire" boolean
);

CREATE TABLE "Cercle" (
    "IdCercle" integer NOT NULL,
    "NomCercle" character varying(255),
    "NomCercle_ar" character varying(255),
    "IdProvince" integer,
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);

CREATE TABLE "CollabExterne_marche" (
    id_collab integer NOT NULL,
    num_marche character varying(255) NOT NULL,
    date_affectation timestamp without time zone,
    initiateur character varying(128)
);

CREATE TABLE "CollabInterne" (
    "Id_Personnel" integer NOT NULL,
    "Id_SE" integer NOT NULL,
    "Nom" character varying(128),
    "Prenom" character varying(128),
    "IdUSer" character varying(128),
    "Direction" character varying(128),
    tel character varying(255)
);

CREATE TABLE "CollabInterne_marche" (
    "Id_Personnel" integer NOT NULL,
    "Num_Marche" character varying(128) NOT NULL,
    "Role" character varying(128)
);

CREATE TABLE "Collaborateur" (
    id integer NOT NULL,
    nom character varying(255),
    prenom character varying(255),
    tel character varying(255),
    adresse character varying(255),
    id_igt integer NOT NULL,
    "idUser" character varying(128),
    role character varying(128)
);

CREATE TABLE "Commune" (
    "IdCommune" integer NOT NULL,
    "NomCommune" character varying(255),
    "NomCommune_ar" character varying(255),
    "IdCercle" integer,
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);

CREATE TABLE "DocCommun" (
    "Id_Document" integer NOT NULL,
    id_sous_zone integer,
    "DernierMotifRejet" text,
    "Statut" character varying(128),
    "DateValidation" date,
    "DateRejet" date
);

CREATE TABLE "DocMarche" (
    "Id_Document" integer NOT NULL,
    "NumMarche" character varying(255)
);

CREATE TABLE "DocParcelle" (
    "Id_Document" integer NOT NULL,
    "Id_Synchronisation" integer,
    num_parcelle character varying(255),
    id_douar integer,
    id_sous_zone integer,
    "DernierMotifRejet" text,
    "Statut" character varying(128),
    "DateValidation" date,
    "DateRejet" date
);

CREATE TABLE "Document" (
    "Id_Document" integer NOT NULL,
    "Type_Document" character varying(128),
    "Path_Document" character varying(255),
    "Nom_Document" character varying(255),
    "Categorie_Document" character varying(128)
);

CREATE TABLE "Etat_Document" (
    "Id_Etat" integer NOT NULL,
    "Id_Document" integer,
    "DateAction" date,
    "Initiateur" character varying(128),
    "Action" character varying(128),
    "Observ_Controle" text
);

CREATE TABLE "Etat_Parcelle" (
    "Id_Etat" integer NOT NULL,
    "Id_Parcelle" integer NOT NULL,
    "DateAction" date,
    "Initiateur" character varying(128),
    "Action" character varying(255),
    num_parcelle character varying(255),
    id_douar integer,
    "Observ_Controle" text,
    "ListMotifs" text
);

CREATE TABLE "Geoife" (
    "Id_Version" integer DEFAULT nextval('geoife_id_seq'::regclass) NOT NULL,
    "Libelle_Version" character varying(255),
    "Description_MAJ" text,
    "Date_MEL" timestamp without time zone,
    "Type" character varying(128),
    "Initiateur" character varying(128),
    "IsDisplayed" boolean NOT NULL,
    "NomFichier" character varying(128)
);

CREATE TABLE "GroupesDesMarches" (
    num_marche character varying(255),
    groupe character varying(255)
);

CREATE TABLE "LimiteNat" (
    "Nom_LN" character varying(255),
    "Id_Riverain" integer NOT NULL,
    "Code_LN" character varying(10)
);

CREATE TABLE "Livraison" (
    "Id_Livraison" integer NOT NULL,
    "Initiateur" character varying(128),
    "IdSZ" integer NOT NULL,
    "ObjetBL" text,
    "NbreParcLiv" integer,
    "DateLimite" date,
    "NumBL" character varying(128),
    "NumFacture" character varying(128),
    "DateLivraison" timestamp without time zone,
    "TypeLivraison" character varying(128),
    "DateLivSys" date,
    "StatutBL" boolean,
    "Observation" text,
    "DateValidation" timestamp without time zone,
    "DateLimite_FinCont" date
);

CREATE TABLE "Notification" (
    "id_Notif" integer DEFAULT nextval('id_notif_seq'::regclass) NOT NULL,
    objet character varying(255),
    statut character varying(128),
    "dateVisualisation" date,
    destinataire character varying(128),
    "dateNotification" timestamp without time zone,
    num_marche character varying(255)
);

CREATE TABLE "Opposition" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    indice integer NOT NULL,
    the_geom geometry,
    the_geom_s text
);

CREATE TABLE "Opposition_Opposant" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    indice integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255) NOT NULL
);

CREATE TABLE "Prep_Marche" (
    "Id_PrepMarche" integer NOT NULL,
    "NumAO" character varying(128),
    "DateSignatureDG" date,
    "NumVisa" character varying(128),
    "DateVisa" date,
    "DateRecOrthoPhoto" date,
    "DateRecPVCC_RFDC" date,
    "SourcePVCC" character varying(255),
    "DateRecPVCC_RFDCF" date,
    "NumBE" character varying(128),
    "DateArrOuv" date,
    "DateEnvoiArrOuvDG" date,
    "DateEnvoiArrOuvMin" date,
    "DateRetourMin" date,
    "DateEnvoiArrSGG" date,
    "DateBO" date,
    "NumBO" character varying(128),
    "DateOS" date,
    "NumOS" character varying(128),
    num_marche character varying(255),
    objet character varying(255),
    "dateReunionCC" date
);

CREATE TABLE "Prop_morale" (
    "Id_Riverain" integer NOT NULL,
    "Nom" character varying(255),
    rc character varying(255)
);

CREATE TABLE "Prop_physique" (
    "Id_Riverain" integer NOT NULL,
    "CIN" character varying(128),
    "Nom" character varying(255),
    "Prenom" character varying(255),
    "Adresse" character varying(255),
    "GSM" character varying(255)
);

CREATE TABLE "Province" (
    "IdProvince" integer NOT NULL,
    "NomProvince" character varying(255),
    "NomProvince_ar" character varying(255),
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);

CREATE TABLE "RefConsistances" (
    "Id_Consistance" integer NOT NULL,
    "Lib_Consistance_fr" character varying(255),
    "Lib_Consistance_ar" character varying(255)
);

CREATE TABLE "RefLimiteNat" (
    "Code_Type" character varying(10) NOT NULL,
    "Libelle_Type" character varying(255),
    "Obsolete" boolean
);

CREATE TABLE "RefMotifRejet" (
    id_motif integer NOT NULL,
    libelle_motif_ar character varying(255),
    libelle_motif_fr character varying(255),
    ordre integer,
    date_creation date,
    initiateur character varying(128),
    type character varying(128),
    direction character varying(128),
    "CatDoc" character varying(128)
);

CREATE TABLE "RefSpeculation" (
    "Libelle" character varying(255),
    id_speculation character varying(20) NOT NULL
);

CREATE TABLE "RefTypeSol" (
    "Libelle" character varying(128),
    "id_typeSol" character varying(20) NOT NULL
);

CREATE TABLE "Rejet" (
    "Id_Rejet" integer NOT NULL,
    "Id_Livraison" integer NOT NULL,
    "Date_Rejet" date NOT NULL,
    "Num_PVRejet" character varying(128),
    "Initiateur" character varying(128),
    "Motif_Rejet" text,
    "NbreParcRej" integer,
    "Num_Rejet" integer NOT NULL,
    "DateLimite_SatRejet" date
);

CREATE TABLE "Rejet_parcelle" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    "Id_Rejet" integer NOT NULL
);

CREATE TABLE "Remarque" (
    "Id_rq" integer NOT NULL,
    "Objet_rq" character varying(255),
    "Description_rq" text,
    "IdUser" character varying(128),
    "Date_rq" timestamp without time zone,
    tel character varying(255),
    "NomPrenom" character varying(255),
    num_marche character varying(255),
    serviceext character varying(255),
    "Role" character varying(255),
    plateforme character varying(255),
    type character varying(255),
    piece character varying(255)
);

CREATE TABLE "Riverain" (
    "Id_Riverain" integer NOT NULL,
    "Direction" character varying(128),
    num_parcelle character varying(255),
    "Id_douar" integer,
    "Type_Riverain" character varying(255),
    point_debut character varying,
    point_fin character varying,
    the_geom geometry,
    the_geom_s text,
    description text,
    CONSTRAINT riverain_the_geom_check1 CHECK (((geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL)))
);

CREATE TABLE "SatRej_parcelle" (
    "Id_SatRejet" integer NOT NULL,
    "Id_douar" integer NOT NULL,
    num_parcelle character varying(255) NOT NULL
);

CREATE TABLE "Satisfaction_Rejet" (
    "Id_SatRejet" integer NOT NULL,
    "Id_Rejet" integer NOT NULL,
    "Date_SatRej" timestamp without time zone,
    "NumBL_SatRej" character varying(128),
    "Initiateur" character varying(128),
    "TypeLivraison" character varying(10),
    "DateValidation" timestamp without time zone,
    "Observation" text,
    "DateLimite_FinCont" date,
    "NbreParcSat" integer
);

CREATE TABLE "Type_Livraison" (
    "Libelle_TypeLiv" character varying(128),
    "Id_TypeLiv" character varying(128) NOT NULL
);

CREATE TABLE "ViewPMIS" (
    id_zone integer,
    "Zone" character varying(255),
    num_marche character varying(255),
    "NomSE" character varying(255),
    "DateBO" date,
    "DateOS" date,
    "DateValPrgExec" date,
    "IsPEValidated" boolean,
    "DateValAPD" date,
    "IsAPDValidated" boolean,
    "NbreParEstime" integer,
    "NbreParcEnqCAD" bigint,
    "NbreParcValCAD" bigint,
    "NbreParcEnqCF" bigint,
    "NbreParcValCF" bigint
);

CREATE TABLE "ZonesLambert" (
    "IdZL" integer NOT NULL,
    "NomZL" character varying(255),
    "NomZL_ar" character varying(255)
);

CREATE TABLE acte (
    id_acte integer DEFAULT nextval('seq_type'::regclass) NOT NULL,
    libelle character varying(255),
    libelle_ar character varying(255) NOT NULL,
    nature character varying(255)
);

CREATE TABLE actions (
    id_action integer NOT NULL,
    nom_action character varying(500)
);

CREATE TABLE adjudicataire (
    id_adjudicataire integer DEFAULT nextval('adjudicataire_id_seq'::regclass) NOT NULL,
    lib_adjudicataire character varying(255),
    est_groupement boolean DEFAULT false NOT NULL
);

CREATE TABLE auth_action (
    id_auth_action integer NOT NULL,
    id_action integer,
    token text NOT NULL,
    date timestamp without time zone NOT NULL
);

CREATE TABLE authentification (
    "idUser" character varying(128),
    token text NOT NULL,
    date timestamp without time zone NOT NULL
);

CREATE TABLE ayant_droit (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(255),
    nom_mere_ar character(255),
    nom_conjoint character(255),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100),
    num_marche character varying(255) NOT NULL,
    verrou boolean
);

CREATE TABLE ayant_droit_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    code_droit integer NOT NULL,
    num_marche character varying(255) NOT NULL
);

CREATE TABLE borne (
    name character varying(255) NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    titref character varying(255),
    ordre integer,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    the_geom geometry,
    gid integer DEFAULT nextval('bornes_gid_seq'::regclass) NOT NULL,
    "Type_borne" character varying(255),
    the_geom_s text,
    CONSTRAINT bornes_the_geom_check1 CHECK (((geometrytype(the_geom) = 'MULTIPOINT'::text) OR (the_geom IS NULL)))
);

CREATE TABLE borne_opposition (
    name character varying(255) NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    indice integer NOT NULL,
    the_geom geometry,
    gid integer DEFAULT nextval('bornes_opposition_gid_seq'::regclass) NOT NULL,
    "Type_borne" character varying(255),
    CONSTRAINT bornes_opposition_the_geom_check1 CHECK (((geometrytype(the_geom) = 'MULTIPOINT'::text) OR (the_geom IS NULL)))
);

CREATE TABLE borne_parcelaire (
    name character varying(255) NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    titref character varying(255),
    ordre integer,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    the_geom geometry,
    gid integer DEFAULT nextval('bornesparcelaire_gid_seq'::regclass) NOT NULL,
    type character varying(100),
    CONSTRAINT bornesparcelaire_the_geom_check1 CHECK (((geometrytype(the_geom) = 'MULTIPOINT'::text) OR (the_geom IS NULL)))
);

CREATE TABLE charge (
    "CODE_charge" character varying(4) NOT NULL,
    "LIBELLE_charge" character varying(100) NOT NULL,
    "CODE_DEPOT" integer,
    "CODE_charge_OLD" character varying(4),
    CONSTRAINT "charge_CODE_charge_check" CHECK (("CODE_charge" IS NOT NULL)),
    CONSTRAINT "charge_LIBELLE_charge_check" CHECK (("LIBELLE_charge" IS NOT NULL))
);

CREATE TABLE charge_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    code_charge character varying(4) NOT NULL
);

CREATE TABLE consistance_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    "Id_Consistance" integer NOT NULL,
    "id_typeSol" character varying(20) DEFAULT 'N'::character varying NOT NULL,
    id_speculation character varying(20) DEFAULT 'N'::character varying NOT NULL
);

CREATE TABLE detail_acte (
    id_acte integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255)
);

CREATE TABLE droit_reel (
    droit_reel character varying(3) NOT NULL,
    "LIBELLE" character varying(50) NOT NULL,
    "CODE_DROIT" integer NOT NULL
);

CREATE TABLE groupe_proprietaire (
    num_ordre integer DEFAULT nextval('groupe_proprietaire_id_seq'::regclass) NOT NULL,
    concat_cins text
);

CREATE TABLE groupement_igt (
    id_adjudicataire integer NOT NULL,
    id_igt integer NOT NULL,
    est_mandataire boolean DEFAULT false NOT NULL
);

CREATE TABLE igt (
    id integer DEFAULT nextval('id_igt_seq'::regclass) NOT NULL,
    societe character varying(255),
    adresse character varying(255),
    telfixe character varying(255),
    nom character varying(255),
    prenom character varying(255),
    fax character varying(255),
    gsm character varying(255),
    "idUser" character varying(128),
    email character varying(256) NOT NULL
);

CREATE TABLE synchronisation (
    id integer DEFAULT nextval('synchronisation_id_seq'::regclass) NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    etat character varying(25) NOT NULL,
    observation text,
    id_action integer NOT NULL,
    date timestamp without time zone NOT NULL,
    "UserId" character varying(128)
);

CREATE TABLE opposant (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(255),
    nom_mere_ar character(255),
    nom_conjoint character(255),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100),
    num_marche character varying(255) NOT NULL,
    verrou boolean
);

CREATE TABLE opposant_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    acte character varying(255),
    date_acte character varying(10),
    num_marche character varying(255) NOT NULL
);

CREATE TABLE parcelaire (
    num_parcelle character varying(255) NOT NULL,
    nature_principale character varying(255),
    nature_fr character varying(255),
    nature_ar character varying(255),
    observation character varying(255),
    nom_parcelle_ar character varying(255),
    nom_parcelle_fr character varying(255),
    surface_ha integer,
    surface_a integer,
    surface_ca integer,
    adresse character varying(255),
    adresse_ar character varying(255),
    id_douar integer NOT NULL,
    the_geom geometry,
    douar integer,
    num integer,
    num_char character varying(20),
    the_geom_s text,
    CONSTRAINT "Parcelaire_the_geom_check1" CHECK (((geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT "Parcelaire_the_geom_check3" CHECK ((st_ndims(the_geom) = 2))
);

CREATE TABLE parcelle_motifrejet (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    id_motif integer NOT NULL,
    initiateur character varying(128),
    statut boolean
);

CREATE TABLE personne (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE presume (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(255),
    nom_mere_ar character(255),
    nom_conjoint character(255),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100),
    num_marche character varying(255) NOT NULL,
    verrou boolean
);

CREATE TABLE presume_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    lieu_correspondance text,
    num_marche character varying(255) NOT NULL
);

CREATE TABLE proprietaire (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(255),
    nom_mere_ar character(255),
    nom_conjoint character(255),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100),
    num_marche character varying(255) NOT NULL,
    verrou boolean
);

CREATE TABLE proprietaire_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    quote_denominateur integer NOT NULL,
    quote_numerateur integer NOT NULL,
    acte character varying(255),
    lieu_correspondance text,
    date_acte character varying(10),
    num_marche character varying(255) NOT NULL
);

CREATE TABLE proprietaire_presume (
    cin character varying(255) NOT NULL,
    ordre integer
);

CREATE TABLE situation_quotidienne (
    id_situation integer DEFAULT nextval('id_situation_seq'::regclass) NOT NULL,
    date_saisie timestamp without time zone NOT NULL,
    initiateur_saisie character varying(128),
    initiateur_maj character varying(128),
    nom_init_saisie character varying(255),
    nom_init_maj character varying(255),
    num_marche character varying(255) NOT NULL,
    id_zone integer NOT NULL,
    nom_zone character varying(255),
    id_sous_zone integer NOT NULL,
    nom_sous_zone character varying(255),
    id_douar integer NOT NULL,
    nom_douar character varying(255),
    service integer,
    nbre_parc_obj_ep integer,
    nbre_parc_enq_p integer,
    nbre_parc_lev integer,
    nbre_parc_born integer,
    nbre_pv_signes integer,
    nbre_parc_obj_ej integer,
    nbre_dos_liv_cad integer,
    nbre_dos_liv_cf integer,
    direction character varying(128),
    date_maj timestamp without time zone
);

CREATE TABLE synth_etat_parcelle (
    nom character varying(255),
    id_zone integer,
    "DateOS" date,
    rejcad bigint,
    rejcf bigint,
    rejst228 bigint,
    caddifcf bigint
);

CREATE TABLE temoin (
    cin character varying(255) NOT NULL,
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(255),
    nom_mere_ar character(255),
    nom_conjoint character(255),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100),
    num_marche character varying(255) NOT NULL,
    verrou boolean
);

CREATE TABLE temoin_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255) NOT NULL
);

CREATE TABLE temp_ayant_droit (
    cin character varying(255),
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE temp_ayant_droit_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);

CREATE TABLE temp_opposant (
    cin character varying(255),
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE temp_opposant_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);

CREATE TABLE temp_presume (
    cin character varying(255),
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE temp_presume_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);

CREATE TABLE temp_proprietaire (
    cin character varying(255),
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE temp_proprietaire_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);

CREATE TABLE temp_temoin (
    cin character varying(255),
    nom_ar character varying(255),
    prenom_ar character varying(255),
    nom_fr character varying(255),
    prenom_fr character varying(255),
    date_naissance character varying(255),
    adresse character varying(255),
    adresse_ar character varying(255),
    nom_pere character varying(255),
    nom_mere character varying(255),
    nom_pere_ar character(50),
    nom_mere_ar character(50),
    nom_conjoint character(50),
    tel character varying(15),
    situation_famille character varying(20),
    nationalite character varying(100)
);

CREATE TABLE temp_temoin_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);

-- Extracted ALTER TABLE Statements


ALTER TABLE ONLY "ActionMarche" ALTER COLUMN "Id" SET DEFAULT nextval('actionmarche_id_seq'::regclass);

ALTER TABLE ONLY "AspNetUserClaims" ALTER COLUMN "Id" SET DEFAULT nextval('"AspNetUserClaims_Id_seq"'::regclass);

ALTER TABLE ONLY "Cercle" ALTER COLUMN "IdCercle" SET DEFAULT nextval('seq_idcercle'::regclass);

ALTER TABLE ONLY "CollabInterne" ALTER COLUMN "Id_Personnel" SET DEFAULT nextval('seq_idpersonnel'::regclass);

ALTER TABLE ONLY "Collaborateur" ALTER COLUMN id SET DEFAULT nextval('enqueteur_id_seq'::regclass);

ALTER TABLE ONLY "Commune" ALTER COLUMN "IdCommune" SET DEFAULT nextval('seq_idcommune'::regclass);

ALTER TABLE ONLY "Document" ALTER COLUMN "Id_Document" SET DEFAULT nextval('id_document_seq'::regclass);

ALTER TABLE ONLY "Etat_Document" ALTER COLUMN "Id_Etat" SET DEFAULT nextval('id_etat_seq'::regclass);

ALTER TABLE ONLY "Etat_Parcelle" ALTER COLUMN "Id_Etat" SET DEFAULT nextval('etat_parcelle_id_seq'::regclass);

ALTER TABLE ONLY "Livraison" ALTER COLUMN "Id_Livraison" SET DEFAULT nextval('id_livraison_seq'::regclass);

ALTER TABLE ONLY "Prep_Marche" ALTER COLUMN "Id_PrepMarche" SET DEFAULT nextval('id_prepmarche_seq'::regclass);

ALTER TABLE ONLY "Province" ALTER COLUMN "IdProvince" SET DEFAULT nextval('seq_idprovince'::regclass);

ALTER TABLE ONLY "RefConsistances" ALTER COLUMN "Id_Consistance" SET DEFAULT nextval('seq_id_consistance'::regclass);

ALTER TABLE ONLY "Rejet" ALTER COLUMN "Id_Rejet" SET DEFAULT nextval('seq_idrejet'::regclass);

ALTER TABLE ONLY "Remarque" ALTER COLUMN "Id_rq" SET DEFAULT nextval('seq_idremarque'::regclass);

ALTER TABLE ONLY "Riverain" ALTER COLUMN "Id_Riverain" SET DEFAULT nextval('seq_idriverain'::regclass);

ALTER TABLE ONLY "Satisfaction_Rejet" ALTER COLUMN "Id_SatRejet" SET DEFAULT nextval('id_satrejet_seq'::regclass);

ALTER TABLE ONLY auth_action ALTER COLUMN id_auth_action SET DEFAULT nextval('auth_act_id_seq'::regclass);

ALTER TABLE ONLY "ActionMarche"
    ADD CONSTRAINT "ActionMarche_pkey1" PRIMARY KEY ("Id");

ALTER TABLE ONLY "Action"
    ADD CONSTRAINT "Action_pkey" PRIMARY KEY ("CodeAction");

ALTER TABLE ONLY "AspNetRoles"
    ADD CONSTRAINT "AspNetRoles_pkey" PRIMARY KEY ("Id");

ALTER TABLE ONLY "AspNetUserClaims"
    ADD CONSTRAINT "AspNetUserClaims_pkey" PRIMARY KEY ("Id");

ALTER TABLE ONLY "AspNetUserLogins"
    ADD CONSTRAINT "AspNetUserLogins_pkey" PRIMARY KEY ("UserId", "LoginProvider", "ProviderKey");

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "AspNetUserRoles_pkey" PRIMARY KEY ("UserId", "RoleId");

ALTER TABLE ONLY "AspNetUsers"
    ADD CONSTRAINT "AspNetUsers_pkey" PRIMARY KEY ("Id");

ALTER TABLE ONLY "Categorie_Document"
    ADD CONSTRAINT "Categorie_Document_pkey" PRIMARY KEY ("Code_Categorie");

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "Cercle_NomCercle_key" UNIQUE ("NomCercle");

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT "CollabExterne_marche_pkey" PRIMARY KEY (id_collab, num_marche);

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "Commune_NomCommune_key" UNIQUE ("NomCommune");

ALTER TABLE ONLY "RefConsistances"
    ADD CONSTRAINT "Consistances_pkey" PRIMARY KEY ("Id_Consistance");

ALTER TABLE ONLY "Geoife"
    ADD CONSTRAINT "Geoife_pkey" PRIMARY KEY ("Id_Version");

ALTER TABLE ONLY douar
    ADD CONSTRAINT "Nom_Douar_Unique" UNIQUE (nom);

ALTER TABLE ONLY "Opposition"
    ADD CONSTRAINT "Opposition_pkey" PRIMARY KEY (id_douar, num_parcelle, indice);

ALTER TABLE ONLY "BienLimitrophe"
    ADD CONSTRAINT "PK_BL" PRIMARY KEY ("Id_Riverain");

ALTER TABLE ONLY "Caidat"
    ADD CONSTRAINT "PK_Caidat" PRIMARY KEY ("IdCaidat");

ALTER TABLE ONLY "Categorie"
    ADD CONSTRAINT "PK_Categorie" PRIMARY KEY ("IdCategorie");

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "PK_Cercle" PRIMARY KEY ("IdCercle");

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "PK_CollabInterne" PRIMARY KEY ("Id_Personnel", "Num_Marche");

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "PK_Commune" PRIMARY KEY ("IdCommune");

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "PK_DocCommun" PRIMARY KEY ("Id_Document");

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "PK_DocMarche" PRIMARY KEY ("Id_Document");

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "PK_DocParcelle" PRIMARY KEY ("Id_Document");

ALTER TABLE ONLY "Document"
    ADD CONSTRAINT "PK_Document" PRIMARY KEY ("Id_Document");

ALTER TABLE ONLY "Etat_Document"
    ADD CONSTRAINT "PK_Etat_Doc" PRIMARY KEY ("Id_Etat");

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "PK_Etat_Parcelle" PRIMARY KEY ("Id_Etat");

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "PK_LN" PRIMARY KEY ("Id_Riverain");

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "PK_Livraison" PRIMARY KEY ("Id_Livraison");

ALTER TABLE ONLY "Notification"
    ADD CONSTRAINT "PK_Notif" PRIMARY KEY ("id_Notif");

ALTER TABLE ONLY "Prop_morale"
    ADD CONSTRAINT "PK_PROPMOR" PRIMARY KEY ("Id_Riverain");

ALTER TABLE ONLY "Prop_physique"
    ADD CONSTRAINT "PK_PROPPH" PRIMARY KEY ("Id_Riverain");

ALTER TABLE ONLY "Prep_Marche"
    ADD CONSTRAINT "PK_PrepMarche" PRIMARY KEY ("Id_PrepMarche");

ALTER TABLE ONLY "Province"
    ADD CONSTRAINT "PK_Province" PRIMARY KEY ("IdProvince");

ALTER TABLE ONLY "Riverain"
    ADD CONSTRAINT "PK_Riverain" PRIMARY KEY ("Id_Riverain");

ALTER TABLE ONLY "ServiceExterieur"
    ADD CONSTRAINT "PK_SE" PRIMARY KEY ("IdSE");

ALTER TABLE ONLY "Satisfaction_Rejet"
    ADD CONSTRAINT "PK_SatRejet" PRIMARY KEY ("Id_SatRejet");

ALTER TABLE ONLY "Type_Livraison"
    ADD CONSTRAINT "PK_TypeLiv" PRIMARY KEY ("Id_TypeLiv");

ALTER TABLE ONLY "ZonesLambert"
    ADD CONSTRAINT "PK_ZL" PRIMARY KEY ("IdZL");

ALTER TABLE ONLY acte
    ADD CONSTRAINT "PK_acte" PRIMARY KEY (libelle_ar);

ALTER TABLE ONLY groupe_proprietaire
    ADD CONSTRAINT "PK_grpProp" PRIMARY KEY (num_ordre);

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "Personnel_pkey" PRIMARY KEY ("Id_Personnel");

ALTER TABLE ONLY "Province"
    ADD CONSTRAINT "Province_NomProvince_key" UNIQUE ("NomProvince");

ALTER TABLE ONLY "RefLimiteNat"
    ADD CONSTRAINT "RefLimiteNat_pkey" PRIMARY KEY ("Code_Type");

ALTER TABLE ONLY "RefMotifRejet"
    ADD CONSTRAINT "RefMotifRejertParc_pkey" PRIMARY KEY (id_motif);

ALTER TABLE ONLY "RefSpeculation"
    ADD CONSTRAINT "RefSpeculation_pkey" PRIMARY KEY (id_speculation);

ALTER TABLE ONLY "RefTypeSol"
    ADD CONSTRAINT "RefTypeSol_pkey" PRIMARY KEY ("id_typeSol");

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "Rejet_parcelle_pkey" PRIMARY KEY (id_douar, num_parcelle, "Id_Rejet");

ALTER TABLE ONLY "Rejet"
    ADD CONSTRAINT "Rejet_pkey" PRIMARY KEY ("Id_Rejet");

ALTER TABLE ONLY "Remarque"
    ADD CONSTRAINT "Remarque_pkey" PRIMARY KEY ("Id_rq");

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "SatRej_parcelle_pkey" PRIMARY KEY ("Id_SatRejet", "Id_douar", num_parcelle);

ALTER TABLE ONLY groupe_proprietaire
    ADD CONSTRAINT "Uniq_Concat" UNIQUE (concat_cins);

ALTER TABLE ONLY igt
    ADD CONSTRAINT "UniqueEmail" UNIQUE (email);

ALTER TABLE ONLY zone
    ADD CONSTRAINT "Unique_NomZone_ar" UNIQUE (nom_ar);

ALTER TABLE ONLY zone
    ADD CONSTRAINT "Unique_NonZone" UNIQUE (nom);

ALTER TABLE ONLY adjudicataire
    ADD CONSTRAINT adjudicataire_pkey PRIMARY KEY (id_adjudicataire);

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT auth_act_pk PRIMARY KEY (id_auth_action);

ALTER TABLE ONLY authentification
    ADD CONSTRAINT authentification_pkey PRIMARY KEY (token);

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT ayant_droit_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche, code_droit);

ALTER TABLE ONLY ayant_droit
    ADD CONSTRAINT ayant_droit_pkey PRIMARY KEY (cin, num_marche);

ALTER TABLE ONLY borne_opposition
    ADD CONSTRAINT borne_opposition_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar, indice);

ALTER TABLE ONLY borne
    ADD CONSTRAINT borne_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar);

ALTER TABLE ONLY borne_parcelaire
    ADD CONSTRAINT borneparcelaire_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar);

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT charge_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, code_charge);

ALTER TABLE ONLY charge
    ADD CONSTRAINT charge_pkey PRIMARY KEY ("CODE_charge");

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT consistance_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, "Id_Consistance", "id_typeSol", id_speculation);

ALTER TABLE ONLY douar
    ADD CONSTRAINT douar_pkey PRIMARY KEY (id_douar);

ALTER TABLE ONLY droit_reel
    ADD CONSTRAINT "droit_reel_LIBELLE_key" UNIQUE ("LIBELLE");

ALTER TABLE ONLY droit_reel
    ADD CONSTRAINT droit_reel_pkey PRIMARY KEY ("CODE_DROIT");

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT enqueteur_pkey PRIMARY KEY (id);

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT groupement_igt_pk PRIMARY KEY (id_adjudicataire, id_igt);

ALTER TABLE ONLY marche
    ADD CONSTRAINT "id_zone_Unique" UNIQUE (id_zone);

ALTER TABLE ONLY igt
    ADD CONSTRAINT igt_pkey PRIMARY KEY (id);

ALTER TABLE ONLY marche
    ADD CONSTRAINT marche_pkey PRIMARY KEY (num_marche);

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT opposant_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);

ALTER TABLE ONLY opposant
    ADD CONSTRAINT opposant_pkey PRIMARY KEY (cin, num_marche);

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT opposition_opposant_pkey PRIMARY KEY (num_parcelle, id_douar, indice, cin, num_marche);

ALTER TABLE ONLY parcelaire
    ADD CONSTRAINT parcelaire_pkey PRIMARY KEY (num_parcelle, id_douar);

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_pkey PRIMARY KEY (num_parcelle, id_douar, id_motif);

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT parcelle_pkey PRIMARY KEY (num_parcelle, id_douar);

ALTER TABLE ONLY personne
    ADD CONSTRAINT personne_pkey PRIMARY KEY (cin);

ALTER TABLE ONLY proprietaire_presume
    ADD CONSTRAINT pk_proppres PRIMARY KEY (cin);

ALTER TABLE ONLY actions
    ADD CONSTRAINT pkaction PRIMARY KEY (id_action);

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT pkdetail_act PRIMARY KEY (id_acte);

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT presume_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);

ALTER TABLE ONLY presume
    ADD CONSTRAINT presume_pkey PRIMARY KEY (cin, num_marche);

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT proprietaire_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);

ALTER TABLE ONLY proprietaire
    ADD CONSTRAINT proprietaire_pkey PRIMARY KEY (cin, num_marche);

ALTER TABLE ONLY situation_quotidienne
    ADD CONSTRAINT situation_quotidienne_date_saisie_key UNIQUE (date_saisie);

ALTER TABLE ONLY situation_quotidienne
    ADD CONSTRAINT situation_quotidienne_pkey PRIMARY KEY (id_situation);

ALTER TABLE ONLY sous_zone
    ADD CONSTRAINT sous_zone_pkey PRIMARY KEY (id_sous_zone);

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT synchronisation_pkey PRIMARY KEY (id);

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT temoin_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);

ALTER TABLE ONLY temoin
    ADD CONSTRAINT temoin_pkey PRIMARY KEY (cin, num_marche);

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT uniquegid UNIQUE (id_synchronisation);

ALTER TABLE ONLY zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (id_zone);

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT "Collaborateur_fkey" FOREIGN KEY (id_collab) REFERENCES "Collaborateur"(id);

ALTER TABLE ONLY "AspNetUserClaims"
    ADD CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_User_Id" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;

ALTER TABLE ONLY "AspNetUserLogins"
    ADD CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE;

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;

ALTER TABLE ONLY "Caidat"
    ADD CONSTRAINT "FK_Caidat_Province" FOREIGN KEY ("IdProvince") REFERENCES "Province"("IdProvince");

ALTER TABLE ONLY "Document"
    ADD CONSTRAINT "FK_CatDoc_Doc" FOREIGN KEY ("Categorie_Document") REFERENCES "Categorie_Document"("Code_Categorie");

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "FK_Cercle_Province" FOREIGN KEY ("IdProvince") REFERENCES "Province"("IdProvince");

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "FK_Collab_Marche" FOREIGN KEY ("Num_Marche") REFERENCES marche(num_marche);

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "FK_Collab_Personnel" FOREIGN KEY ("Id_Personnel") REFERENCES "CollabInterne"("Id_Personnel");

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "FK_Commune_Cercle" FOREIGN KEY ("IdCercle") REFERENCES "Cercle"("IdCercle");

ALTER TABLE ONLY zone
    ADD CONSTRAINT "FK_Commune_Zone" FOREIGN KEY ("IdCommune") REFERENCES "Commune"("IdCommune");

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "FK_DocCommun" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "FK_DocCommun_Doucument" FOREIGN KEY (id_sous_zone) REFERENCES sous_zone(id_sous_zone) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "Etat_Document"
    ADD CONSTRAINT "FK_DocEtatDoc" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "FK_DocParcelle" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "FK_Doc_Marche" FOREIGN KEY ("NumMarche") REFERENCES marche(num_marche);

ALTER TABLE ONLY douar
    ADD CONSTRAINT "FK_DouarCommune" FOREIGN KEY ("IdCommune") REFERENCES "Commune"("IdCommune");

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "FK_EtatParcelle_AspNetUsers" FOREIGN KEY ("Initiateur") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_GrpProp" FOREIGN KEY (num_ordre) REFERENCES groupe_proprietaire(num_ordre);

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "FK_LN_RefLN" FOREIGN KEY ("Code_LN") REFERENCES "RefLimiteNat"("Code_Type");

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "FK_Liv_SZ" FOREIGN KEY ("IdSZ") REFERENCES sous_zone(id_sous_zone);

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "FK_Livraison_TypeLivraison" FOREIGN KEY ("TypeLivraison") REFERENCES "Type_Livraison"("Id_TypeLiv");

ALTER TABLE ONLY "Prep_Marche"
    ADD CONSTRAINT "FK_March_PrepMarch" FOREIGN KEY (num_marche) REFERENCES marche(num_marche);

ALTER TABLE ONLY marche
    ADD CONSTRAINT "FK_Marche_Categorie" FOREIGN KEY (categorie_zone) REFERENCES "Categorie"("IdCategorie");

ALTER TABLE ONLY marche
    ADD CONSTRAINT "FK_Marche_SE" FOREIGN KEY ("serviceExt") REFERENCES "ServiceExterieur"("IdSE");

ALTER TABLE ONLY borne_opposition
    ADD CONSTRAINT "FK_Opposition_Borne" FOREIGN KEY (num_parcelle, id_douar, indice) REFERENCES "Opposition"(num_parcelle, id_douar, indice) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "FK_PARCELLE_Doucument" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY parcelaire
    ADD CONSTRAINT "FK_PARCELLE_PARCELAIRE" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "Riverain"
    ADD CONSTRAINT "FK_PARCELLE_RIV" FOREIGN KEY (num_parcelle, "Id_douar") REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parc_Validateur" FOREIGN KEY (id_validateur) REFERENCES "Collaborateur"(id);

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_CollabInterne_Borneur" FOREIGN KEY ("IdBorneur") REFERENCES "CollabInterne"("Id_Personnel");

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_CollabInterne_CAD" FOREIGN KEY ("IdContr_CAD") REFERENCES "CollabInterne"("Id_Personnel");

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "FK_Parcelle_EtatParcelle" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_LivraisonCAD" FOREIGN KEY ("Id_LivraisonCAD") REFERENCES "Livraison"("Id_Livraison");

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_LivraisonCF" FOREIGN KEY ("Id_LivraisonCF") REFERENCES "Livraison"("Id_Livraison");

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "FK_Personnel_AspNetUser" FOREIGN KEY ("IdUSer") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY "RefMotifRejet"
    ADD CONSTRAINT "FK_RefMotifRejet_CatDoc" FOREIGN KEY ("CatDoc") REFERENCES "Categorie_Document"("Code_Categorie");

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "FK_RejetParcelle_Parcelle" FOREIGN KEY (id_douar, num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "FK_RejetParcelle_Rejet" FOREIGN KEY ("Id_Rejet") REFERENCES "Rejet"("Id_Rejet");

ALTER TABLE ONLY "Rejet"
    ADD CONSTRAINT "FK_Rejet_Livraison" FOREIGN KEY ("Id_Livraison") REFERENCES "Livraison"("Id_Livraison");

ALTER TABLE ONLY "Satisfaction_Rejet"
    ADD CONSTRAINT "FK_Rejet_SatRejet" FOREIGN KEY ("Id_Rejet") REFERENCES "Rejet"("Id_Rejet");

ALTER TABLE ONLY "BienLimitrophe"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");

ALTER TABLE ONLY "Prop_morale"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");

ALTER TABLE ONLY "Prop_physique"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "FK_SatRejetParcelle_Parcelle" FOREIGN KEY ("Id_douar", num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "FK_SatRejetParcelle_SatRej" FOREIGN KEY ("Id_SatRejet") REFERENCES "Satisfaction_Rejet"("Id_SatRejet");

ALTER TABLE ONLY "AspNetUsers"
    ADD CONSTRAINT "FK_User_Personnel" FOREIGN KEY ("Id") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY zone
    ADD CONSTRAINT "FK_Zone_ZL" FOREIGN KEY ("IdZoneLambert") REFERENCES "ZonesLambert"("IdZL");

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT "FK_charge_parcelle_charge" FOREIGN KEY (code_charge) REFERENCES charge("CODE_charge");

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT "FK_charge_parcelle_parcelle" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT "FK_enq_AspNetUsers" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_id_enq_J" FOREIGN KEY ("id_enqueteurJ") REFERENCES "Collaborateur"(id);

ALTER TABLE ONLY borne
    ADD CONSTRAINT "FK_parcelle_Borne" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT "FK_synchronisation_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "Fk_DocMarche" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT "Opposition_Opposant_id_douar_fkey" FOREIGN KEY (id_douar, num_parcelle, indice) REFERENCES "Opposition"(id_douar, num_parcelle, indice);

ALTER TABLE ONLY "Opposition"
    ADD CONSTRAINT "Opposition_id_douar_fkey" FOREIGN KEY (id_douar, num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "Parcelle_CollabInterne_CF" FOREIGN KEY ("IdContr_CF") REFERENCES "CollabInterne"("Id_Personnel");

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT act_fk FOREIGN KEY (id_action) REFERENCES actions(id_action);

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT act_fk FOREIGN KEY (id_action) REFERENCES actions(id_action);

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT acte_fkey FOREIGN KEY (acte) REFERENCES acte(libelle_ar);

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT acte_fkey FOREIGN KEY (acte) REFERENCES acte(libelle_ar);

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT adjudicataire_fkey FOREIGN KEY (id_adjudicataire) REFERENCES adjudicataire(id_adjudicataire);

ALTER TABLE ONLY marche
    ADD CONSTRAINT adjudicataire_fkey FOREIGN KEY (id_adj) REFERENCES adjudicataire(id_adjudicataire);

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT auth_fk FOREIGN KEY (token) REFERENCES authentification(token);

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT ayant_droit_fkey FOREIGN KEY (cin, num_marche) REFERENCES ayant_droit(cin, num_marche);

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT droitreel_fkey FOREIGN KEY (code_droit) REFERENCES droit_reel("CODE_DROIT");

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT "fk_Speculation" FOREIGN KEY (id_speculation) REFERENCES "RefSpeculation"(id_speculation);

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT "fk_TypeSol" FOREIGN KEY ("id_typeSol") REFERENCES "RefTypeSol"("id_typeSol");

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT fk_consistance FOREIGN KEY ("Id_Consistance") REFERENCES "RefConsistances"("Id_Consistance");

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT fk_douar_parcelle FOREIGN KEY (id_douar) REFERENCES douar(id_douar);

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT fk_parcelle FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY proprietaire_presume
    ADD CONSTRAINT fk_proppres FOREIGN KEY (cin) REFERENCES personne(cin);

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT fkdetail_act320561 FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY douar
    ADD CONSTRAINT fkdouar422474 FOREIGN KEY (id_sous_zone) REFERENCES sous_zone(id_sous_zone);

ALTER TABLE ONLY borne_parcelaire
    ADD CONSTRAINT fkparcelaireborne FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelaire(num_parcelle, id_douar) ON UPDATE CASCADE;

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT fkparcelle774413 FOREIGN KEY ("id_enqueteurP") REFERENCES "Collaborateur"(id);

ALTER TABLE ONLY sous_zone
    ADD CONSTRAINT fksous_zone995730 FOREIGN KEY (id_zone) REFERENCES zone(id_zone);

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT fksynchronis567424 FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY marche
    ADD CONSTRAINT fkzone FOREIGN KEY (id_zone) REFERENCES zone(id_zone);

ALTER TABLE ONLY authentification
    ADD CONSTRAINT "iduserFK" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY igt
    ADD CONSTRAINT "igt_AspNetUsers_fkey" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT igt_fkey FOREIGN KEY (id_igt) REFERENCES igt(id);

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT igt_fkey FOREIGN KEY (id_igt) REFERENCES igt(id);

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT marche_fkey FOREIGN KEY (num_marche) REFERENCES marche(num_marche);

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT opposant_fkey FOREIGN KEY (cin, num_marche) REFERENCES opposant(cin, num_marche);

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT opposant_opposition_fkey FOREIGN KEY (cin, num_marche) REFERENCES opposant(cin, num_marche);

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT parcelle_ayant_droit_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_id_motif_fkey FOREIGN KEY (id_motif) REFERENCES "RefMotifRejet"(id_motif);

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_num_parcelle_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT parcelle_opposant_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT parcelle_presume_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT parcelle_proprietaire_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT parcelle_temoin_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT presume_fkey FOREIGN KEY (cin, num_marche) REFERENCES presume(cin, num_marche);

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT proprietaire_fkey FOREIGN KEY (cin, num_marche) REFERENCES proprietaire(cin, num_marche);

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT proprietaire_fkey FOREIGN KEY (cin, num_marche) REFERENCES proprietaire(cin, num_marche);

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "sFK_ServExtAffect" FOREIGN KEY ("Id_SE") REFERENCES "ServiceExterieur"("IdSE");

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT temoin_fkey FOREIGN KEY (cin, num_marche) REFERENCES temoin(cin, num_marche);

