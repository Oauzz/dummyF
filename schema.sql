

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: address_standardizer; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS address_standardizer WITH SCHEMA public;


--
-- Name: EXTENSION address_standardizer; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer IS 'Used to parse an address into constituent elements. Generally used to support geocoding address normalization step.';


--
-- Name: ogr_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ogr_fdw WITH SCHEMA public;


--
-- Name: EXTENSION ogr_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ogr_fdw IS 'foreign-data wrapper for GIS data access';


--
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- Name: pointcloud; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pointcloud WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud IS 'data type for lidar point clouds';


--
-- Name: pointcloud_postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pointcloud_postgis WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud_postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud_postgis IS 'integration for pointcloud LIDAR data and PostGIS geometry data';


--
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = public, pg_catalog;

--
-- Name: addbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_addBBOX';


ALTER FUNCTION public.addbbox(geometry) OWNER TO postgres;

--
-- Name: addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addpoint(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_addpoint';


ALTER FUNCTION public.addpoint(geometry, geometry) OWNER TO postgres;

--
-- Name: addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION addpoint(geometry, geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_addpoint';


ALTER FUNCTION public.addpoint(geometry, geometry, integer) OWNER TO postgres;

--
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


ALTER FUNCTION public.affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_affine';


ALTER FUNCTION public.affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: area(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_area_polygon';


ALTER FUNCTION public.area(geometry) OWNER TO postgres;

--
-- Name: area2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_area_polygon';


ALTER FUNCTION public.area2d(geometry) OWNER TO postgres;

--
-- Name: asbinary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(geometry) OWNER TO postgres;

--
-- Name: asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(geometry, text) OWNER TO postgres;

--
-- Name: asewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'WKBFromLWGEOM';


ALTER FUNCTION public.asewkb(geometry) OWNER TO postgres;

--
-- Name: asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'WKBFromLWGEOM';


ALTER FUNCTION public.asewkb(geometry, text) OWNER TO postgres;

--
-- Name: asewkt(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asEWKT';


ALTER FUNCTION public.asewkt(geometry) OWNER TO postgres;

--
-- Name: asgml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asgml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, 15, 0, null, null)$_$;


ALTER FUNCTION public.asgml(geometry) OWNER TO postgres;

--
-- Name: asgml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION asgml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, 0, null, null)$_$;


ALTER FUNCTION public.asgml(geometry, integer) OWNER TO postgres;

--
-- Name: ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.ashexewkb(geometry) OWNER TO postgres;

--
-- Name: ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asHEXEWKB';


ALTER FUNCTION public.ashexewkb(geometry, text) OWNER TO postgres;

--
-- Name: askml(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_Transform($1,4326), 15, null)$_$;


ALTER FUNCTION public.askml(geometry) OWNER TO postgres;

--
-- Name: askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, ST_transform($1,4326), $2, null)$_$;


ALTER FUNCTION public.askml(geometry, integer) OWNER TO postgres;

--
-- Name: askml(integer, geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION askml(integer, geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML($1, ST_Transform($2,4326), $3, null)$_$;


ALTER FUNCTION public.askml(integer, geometry, integer) OWNER TO postgres;

--
-- Name: assvg(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asSVG';


ALTER FUNCTION public.assvg(geometry) OWNER TO postgres;

--
-- Name: assvg(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asSVG';


ALTER FUNCTION public.assvg(geometry, integer) OWNER TO postgres;

--
-- Name: assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION assvg(geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asSVG';


ALTER FUNCTION public.assvg(geometry, integer, integer) OWNER TO postgres;

--
-- Name: astext(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asText';


ALTER FUNCTION public.astext(geometry) OWNER TO postgres;

--
-- Name: azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION azimuth(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_azimuth';


ALTER FUNCTION public.azimuth(geometry, geometry) OWNER TO postgres;

--
-- Name: bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_Multi(ST_BuildArea(mline));

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.bdmpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


ALTER FUNCTION public.bdpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: boundary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'boundary';


ALTER FUNCTION public.boundary(geometry) OWNER TO postgres;

--
-- Name: buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'buffer';


ALTER FUNCTION public.buffer(geometry, double precision) OWNER TO postgres;

--
-- Name: buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Buffer($1, $2, $3)$_$;


ALTER FUNCTION public.buffer(geometry, double precision, integer) OWNER TO postgres;

--
-- Name: buildarea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'ST_BuildArea';


ALTER FUNCTION public.buildarea(geometry) OWNER TO postgres;

--
-- Name: centroid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'centroid';


ALTER FUNCTION public.centroid(geometry) OWNER TO postgres;

--
-- Name: collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION collect(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-3', 'LWGEOM_collect';


ALTER FUNCTION public.collect(geometry, geometry) OWNER TO postgres;

--
-- Name: combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-3', 'BOX2D_combine';


ALTER FUNCTION public.combine_bbox(box2d, geometry) OWNER TO postgres;

--
-- Name: combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-3', 'BOX3D_combine';


ALTER FUNCTION public.combine_bbox(box3d, geometry) OWNER TO postgres;

--
-- Name: contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contains(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'contains';


ALTER FUNCTION public.contains(geometry, geometry) OWNER TO postgres;

--
-- Name: convexhull(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'convexhull';


ALTER FUNCTION public.convexhull(geometry) OWNER TO postgres;

--
-- Name: crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosses(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'crosses';


ALTER FUNCTION public.crosses(geometry, geometry) OWNER TO postgres;

--
-- Name: difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION difference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'difference';


ALTER FUNCTION public.difference(geometry, geometry) OWNER TO postgres;

--
-- Name: dimension(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_dimension';


ALTER FUNCTION public.dimension(geometry) OWNER TO postgres;

--
-- Name: disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION disjoint(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'disjoint';


ALTER FUNCTION public.disjoint(geometry, geometry) OWNER TO postgres;

--
-- Name: distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_mindistance2d';


ALTER FUNCTION public.distance(geometry, geometry) OWNER TO postgres;

--
-- Name: distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance_sphere(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_distance_sphere';


ALTER FUNCTION public.distance_sphere(geometry, geometry) OWNER TO postgres;

--
-- Name: distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION distance_spheroid(geometry, geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_distance_ellipsoid';


ALTER FUNCTION public.distance_spheroid(geometry, geometry, spheroid) OWNER TO postgres;

--
-- Name: dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_dropBBOX';


ALTER FUNCTION public.dropbbox(geometry) OWNER TO postgres;

--
-- Name: dump(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_dump';


ALTER FUNCTION public.dump(geometry) OWNER TO postgres;

--
-- Name: dumprings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_dump_rings';


ALTER FUNCTION public.dumprings(geometry) OWNER TO postgres;

--
-- Name: endpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_endpoint_linestring';


ALTER FUNCTION public.endpoint(geometry) OWNER TO postgres;

--
-- Name: envelope(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_envelope';


ALTER FUNCTION public.envelope(geometry) OWNER TO postgres;

--
-- Name: estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-3', 'geometry_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text) OWNER TO postgres;

--
-- Name: estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-3', 'geometry_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text, text) OWNER TO postgres;

--
-- Name: etat1(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION etat1(sz integer) RETURNS TABLE(list_noms_pres text, num_parcelle_prov character varying, num_parcelle_def character varying, nom_parcelle_ar character varying, nom_parcelle_fr character varying, adresse character varying, adresse_ar character varying, douar character varying, mappe_dat character varying, natures text)
    LANGUAGE plpgsql
    AS $_$
BEGIN
 RETURN QUERY 

SELECT 
string_agg(CONCAT (presume.nom_fr ,' ',presume.prenom_fr), ', ') as "list_noms_pres",
parcelle.num_parcelle as "num_parcelle_prov",
parcelle.num_parcelle_def as "num_parcelle_def",
parcelle.nom_parcelle_ar as "nom_parcelle_ar",
parcelle.nom_parcelle_fr as "nom_parcelle_fr" ,
parcelle.adresse as "adresse",
parcelle.adresse_ar as "adresse_ar",
douar.nom as "douar", 
parcelle.mappe_dat as "Mappe", 
string_agg(("Lib_Consistance_ar"), ', ') as "Natures"
from parcelle 
inner join douar on douar.id_douar= parcelle.id_douar
inner join consistance_parcelle on (consistance_parcelle.num_parcelle= parcelle.num_parcelle and consistance_parcelle.id_douar= parcelle.id_douar)
inner join "RefConsistances" on "RefConsistances"."Id_Consistance"= consistance_parcelle."Id_Consistance"
inner join presume_parcelle on (presume_parcelle.num_parcelle= parcelle.num_parcelle and presume_parcelle.id_douar= parcelle.id_douar)
inner join presume on presume.cin = presume_parcelle.cin
inner join sous_zone on sous_zone.id_sous_zone= douar.id_sous_zone
where  etat!='Deleted'
and sous_zone.id_sous_zone= $1

GROUP BY 

id_synchronisation,
parcelle.num_parcelle,
parcelle.num_parcelle_def,
parcelle.nom_parcelle_ar,
parcelle.nom_parcelle_fr,
parcelle.adresse,
parcelle.adresse_ar, 
douar.nom, 
parcelle.mappe_dat

order by parcelle.num_parcelle

;

END; $_$;


ALTER FUNCTION public.etat1(sz integer) OWNER TO postgres;

--
-- Name: expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX2D_expand';


ALTER FUNCTION public.expand(box2d, double precision) OWNER TO postgres;

--
-- Name: expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_expand';


ALTER FUNCTION public.expand(box3d, double precision) OWNER TO postgres;

--
-- Name: expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_expand';


ALTER FUNCTION public.expand(geometry, double precision) OWNER TO postgres;

--
-- Name: exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_exteriorring_polygon';


ALTER FUNCTION public.exteriorring(geometry) OWNER TO postgres;

--
-- Name: find_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT ST_Extent("' || columnname || '") As extent FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.find_extent(text, text) OWNER TO postgres;

--
-- Name: find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT ST_Extent("' || columnname || '") FROM "' || schemaname || '"."' || tablename || '" As extent ' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


ALTER FUNCTION public.find_extent(text, text, text) OWNER TO postgres;

--
-- Name: fix_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fix_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	mislinked record;
	result text;
	linked integer;
	deleted integer;
	foundschema integer;
BEGIN

	-- Since 7.3 schema support has been added.
	-- Previous postgis versions used to put the database name in
	-- the schema column. This needs to be fixed, so we try to
	-- set the correct schema for each geometry_colums record
	-- looking at table, column, type and srid.
	
	return 'This function is obsolete now that geometry_columns is a view';

END;
$$;


ALTER FUNCTION public.fix_geometry_columns() OWNER TO postgres;

--
-- Name: force_2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_2d';


ALTER FUNCTION public.force_2d(geometry) OWNER TO postgres;

--
-- Name: force_3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_3dz';


ALTER FUNCTION public.force_3d(geometry) OWNER TO postgres;

--
-- Name: force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_3dm';


ALTER FUNCTION public.force_3dm(geometry) OWNER TO postgres;

--
-- Name: force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_3dz';


ALTER FUNCTION public.force_3dz(geometry) OWNER TO postgres;

--
-- Name: force_4d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_4d';


ALTER FUNCTION public.force_4d(geometry) OWNER TO postgres;

--
-- Name: force_collection(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_collection';


ALTER FUNCTION public.force_collection(geometry) OWNER TO postgres;

--
-- Name: forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_clockwise_poly';


ALTER FUNCTION public.forcerhr(geometry) OWNER TO postgres;

--
-- Name: geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromtext(text) OWNER TO postgres;

--
-- Name: geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromtext(text, integer) OWNER TO postgres;

--
-- Name: geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromwkb(bytea) OWNER TO postgres;

--
-- Name: geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.geomcollfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_from_text';


ALTER FUNCTION public.geometryfromtext(text) OWNER TO postgres;

--
-- Name: geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_from_text';


ALTER FUNCTION public.geometryfromtext(text, integer) OWNER TO postgres;

--
-- Name: geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_geometryn_collection';


ALTER FUNCTION public.geometryn(geometry, integer) OWNER TO postgres;

--
-- Name: geomfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeomFromText($1)$_$;


ALTER FUNCTION public.geomfromtext(text) OWNER TO postgres;

--
-- Name: geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeomFromText($1, $2)$_$;


ALTER FUNCTION public.geomfromtext(text, integer) OWNER TO postgres;

--
-- Name: geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_from_WKB';


ALTER FUNCTION public.geomfromwkb(bytea) OWNER TO postgres;

--
-- Name: geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SetSRID(ST_GeomFromWKB($1), $2)$_$;


ALTER FUNCTION public.geomfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: geomunion(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geomunion(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'geomunion';


ALTER FUNCTION public.geomunion(geometry, geometry) OWNER TO postgres;

--
-- Name: get_etat_bornage_pos_detaille(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_etat_bornage_pos_detaille(marche character varying, service integer, idsz integer) RETURNS TABLE("NomSE" character varying, "IdSE" integer, "Marche" character varying, "SousZone" character varying, "NumParcelle" character varying, "EtatCAD" character varying, "EtatCF" character varying, "EtatLivraisonCF" text, "EtatLivraisonCAD" text, "EtatBornage" text, "EligibiliteContrCF" text)
    LANGUAGE plpgsql
    AS $_$

--declare 

   -- variable declaration

begin

RETURN QUERY

select 

"ServiceExterieur"."NomSE" as "NomSE",

parcelle."serviceExt" as "IdSE", 

marche.num_marche as "Marche",

sous_zone.nom as  "SousZone",  

parcelle.num_parcelle_def as "NumParcelle", 

parcelle."EtatCAD", 

parcelle."EtatCF",

CASE WHEN parcelle."Id_LivraisonCF" is not null  THEN 'Livrée CF'  END as "EtatLivraisonCF",

CASE WHEN parcelle."Id_LivraisonCAD" is not null  THEN 'Livrée CAD'  END "EtatLivraisonCAD",



CASE 

WHEN parcelle."EtatBornage"='BornageIns' THEN 'Bornage en instance'  

WHEN parcelle."EtatBornage"='BornageDecl' THEN 'Bornage Déclenché' 

WHEN parcelle."EtatBornage"='BornagePrg' THEN 'Bornage Programmé'   

WHEN parcelle."EtatBornage"='BornagePos'  THEN 'Bornage Positif' 

WHEN parcelle."EtatBornage"='BornagePosAcMJP'  THEN 'Bornage Positif ac MJP'  

WHEN parcelle."EtatBornage"='BornageRen'  THEN 'Bornage Renvoyé'   

WHEN parcelle."EtatBornage"='BornageRenRej' THEN 'Bornage Renvoyé ac Rejet'  

END "EtatBornage",

CASE WHEN parcelle."EtatCAD"='ValidCAD' AND parcelle."EtatCF"='ValidIgtCF' THEN 'Eligible pr Contr. CF' END "EligibiliteContrCF"





from parcelle 

inner join douar on douar.id_douar=parcelle.id_douar

inner join sous_zone on sous_zone.id_sous_zone= douar.id_sous_zone

inner join zone on zone.id_zone= sous_zone.id_zone

inner join marche on marche.id_zone= zone.id_zone

inner join "ServiceExterieur" on "ServiceExterieur"."IdSE"= marche."serviceExt"

where marche.num_marche=$1 and parcelle."serviceExt"=$2 and (parcelle."EtatBornage"='BornagePos' or parcelle."EtatBornage"='BornagePosAcMJP') AND  sous_zone.id_sous_zone=$3

order by marche.num_marche ;



  

end;

$_$;


ALTER FUNCTION public.get_etat_bornage_pos_detaille(marche character varying, service integer, idsz integer) OWNER TO postgres;

--
-- Name: get_marches(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_marches(igt integer) RETURNS json
    LANGUAGE plpgsql
    AS $$

DECLARE



BEGIN



  -- Build the JSON Response:

  RETURN (SELECT json_agg(Marche.*) 

FROM Marche where Marche.id_igt=IGT );







END

$$;


ALTER FUNCTION public.get_marches(igt integer) OWNER TO postgres;

--
-- Name: get_marches(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_marches(igt character varying) RETURNS json
    LANGUAGE plpgsql
    AS $$

DECLARE



BEGIN



  -- Build the JSON Response:

  RETURN (SELECT json_agg(Marche.*) 

FROM Marche where Marche.id_igt=IGT );







END

$$;


ALTER FUNCTION public.get_marches(igt character varying) OWNER TO postgres;

--
-- Name: get_val_cad_detaille(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_val_cad_detaille(marche character varying, service integer, idsz integer) RETURNS TABLE("NomSE" character varying, "IdSE" integer, "Marche" character varying, "SousZone" character varying, "NumParcelle" character varying, "EtatCAD" character varying, "EtatCF" character varying, "EtatLivraisonCF" text, "EtatLivraisonCAD" text, "EtatBornage" text, "EligibiliteContrCF" text)
    LANGUAGE plpgsql
    AS $_$

--declare 

   -- variable declaration

begin

RETURN QUERY

select 

"ServiceExterieur"."NomSE" as "NomSE",

parcelle."serviceExt" as "IdSE", 

marche.num_marche as "Marche",

sous_zone.nom as  "SousZone",  

parcelle.num_parcelle_def as "NumParcelle", 

parcelle."EtatCAD", 

parcelle."EtatCF",

CASE WHEN parcelle."Id_LivraisonCF" is not null  THEN 'Livrée CF'  END as "EtatLivraisonCF",

CASE WHEN parcelle."Id_LivraisonCAD" is not null  THEN 'Livrée CAD'  END "EtatLivraisonCAD",



CASE 

WHEN parcelle."EtatBornage"='BornageIns' THEN 'Bornage en instance'  

WHEN parcelle."EtatBornage"='BornageDecl' THEN 'Bornage Déclenché' 

WHEN parcelle."EtatBornage"='BornagePrg' THEN 'Bornage Programmé'   

WHEN parcelle."EtatBornage"='BornagePos'  THEN 'Bornage Positif' 

WHEN parcelle."EtatBornage"='BornagePosAcMJP'  THEN 'Bornage Positif ac MJP'  

WHEN parcelle."EtatBornage"='BornageRen'  THEN 'Bornage Renvoyé'   

WHEN parcelle."EtatBornage"='BornageRenRej' THEN 'Bornage Renvoyé ac Rejet'  

END "EtatBornage",

CASE WHEN parcelle."EtatCAD"='ValidCAD' AND parcelle."EtatCF"='ValidIgtCF' THEN 'Eligible pr Contr. CF' END "EligibiliteContrCF" 





from parcelle 

inner join douar on douar.id_douar=parcelle.id_douar

inner join sous_zone on sous_zone.id_sous_zone= douar.id_sous_zone

inner join zone on zone.id_zone= sous_zone.id_zone

inner join marche on marche.id_zone= zone.id_zone

inner join "ServiceExterieur" on "ServiceExterieur"."IdSE"= marche."serviceExt"

where marche.num_marche=$1 and parcelle."serviceExt"=$2 and parcelle."EtatCAD"='ValidCAD' AND  sous_zone.id_sous_zone=$3

order by marche.num_marche ;



  

end;

$_$;


ALTER FUNCTION public.get_val_cad_detaille(marche character varying, service integer, idsz integer) OWNER TO postgres;

--
-- Name: getbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_BOX2D';


ALTER FUNCTION public.getbbox(geometry) OWNER TO postgres;

--
-- Name: getsrid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getsrid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_get_srid';


ALTER FUNCTION public.getsrid(geometry) OWNER TO postgres;

--
-- Name: hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_hasBBOX';


ALTER FUNCTION public.hasbbox(geometry) OWNER TO postgres;

--
-- Name: interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_interiorringn_polygon';


ALTER FUNCTION public.interiorringn(geometry, integer) OWNER TO postgres;

--
-- Name: intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intersection(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'intersection';


ALTER FUNCTION public.intersection(geometry, geometry) OWNER TO postgres;

--
-- Name: intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intersects(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'intersects';


ALTER FUNCTION public.intersects(geometry, geometry) OWNER TO postgres;

--
-- Name: isclosed(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_isclosed';


ALTER FUNCTION public.isclosed(geometry) OWNER TO postgres;

--
-- Name: isempty(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_isempty';


ALTER FUNCTION public.isempty(geometry) OWNER TO postgres;

--
-- Name: isring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'isring';


ALTER FUNCTION public.isring(geometry) OWNER TO postgres;

--
-- Name: issimple(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'issimple';


ALTER FUNCTION public.issimple(geometry) OWNER TO postgres;

--
-- Name: isvalid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'isvalid';


ALTER FUNCTION public.isvalid(geometry) OWNER TO postgres;

--
-- Name: length(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_length_linestring';


ALTER FUNCTION public.length(geometry) OWNER TO postgres;

--
-- Name: length2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_length2d_linestring';


ALTER FUNCTION public.length2d(geometry) OWNER TO postgres;

--
-- Name: length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_length2d_ellipsoid';


ALTER FUNCTION public.length2d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: length3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_length_linestring';


ALTER FUNCTION public.length3d(geometry) OWNER TO postgres;

--
-- Name: length3d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length3d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.length3d_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.length_spheroid(geometry, spheroid) OWNER TO postgres;

--
-- Name: line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_line_interpolate_point';


ALTER FUNCTION public.line_interpolate_point(geometry, double precision) OWNER TO postgres;

--
-- Name: line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_locate_point(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_line_locate_point';


ALTER FUNCTION public.line_locate_point(geometry, geometry) OWNER TO postgres;

--
-- Name: line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_line_substring';


ALTER FUNCTION public.line_substring(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_line_from_mpoint';


ALTER FUNCTION public.linefrommultipoint(geometry) OWNER TO postgres;

--
-- Name: linefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'LINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromtext(text) OWNER TO postgres;

--
-- Name: linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'LINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromtext(text, integer) OWNER TO postgres;

--
-- Name: linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromwkb(bytea) OWNER TO postgres;

--
-- Name: linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: linemerge(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'linemerge';


ALTER FUNCTION public.linemerge(geometry) OWNER TO postgres;

--
-- Name: linestringfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1)$_$;


ALTER FUNCTION public.linestringfromtext(text) OWNER TO postgres;

--
-- Name: linestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT LineFromText($1, $2)$_$;


ALTER FUNCTION public.linestringfromtext(text, integer) OWNER TO postgres;

--
-- Name: linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'LINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linestringfromwkb(bytea) OWNER TO postgres;

--
-- Name: linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.linestringfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_locate_between_measures($1, $2, $2) $_$;


ALTER FUNCTION public.locate_along_measure(geometry, double precision) OWNER TO postgres;

--
-- Name: locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_locate_between_m';


ALTER FUNCTION public.locate_between_measures(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: m(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_m_point';


ALTER FUNCTION public.m(geometry) OWNER TO postgres;

--
-- Name: maj_nb_prop(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION maj_nb_prop() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR FOR

select parcelle.num_parcelle, parcelle.id_douar , count(*)as nb_prop from 
parcelle inner join proprietaire_parcelle 
on parcelle.num_parcelle= proprietaire_parcelle.num_parcelle and parcelle.id_douar= proprietaire_parcelle.id_douar
group by parcelle.num_parcelle, parcelle.id_douar 

; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update parcelle 
   
   set nb_prop = myrec.nb_prop 
     
   where parcelle.num_parcelle = myrec.num_parcelle and parcelle.id_douar = myrec.id_douar  ; 
  
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.maj_nb_prop() OWNER TO postgres;

--
-- Name: makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makebox2d(geometry, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX2D_construct';


ALTER FUNCTION public.makebox2d(geometry, geometry) OWNER TO postgres;

--
-- Name: makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_construct';


ALTER FUNCTION public.makebox3d(geometry, geometry) OWNER TO postgres;

--
-- Name: makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makeline(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makeline';


ALTER FUNCTION public.makeline(geometry, geometry) OWNER TO postgres;

--
-- Name: makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makeline_garray';


ALTER FUNCTION public.makeline_garray(geometry[]) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoint';


ALTER FUNCTION public.makepoint(double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoint3dm';


ALTER FUNCTION public.makepointm(double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoly';


ALTER FUNCTION public.makepolygon(geometry) OWNER TO postgres;

--
-- Name: makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makepoly';


ALTER FUNCTION public.makepolygon(geometry, geometry[]) OWNER TO postgres;

--
-- Name: matching_ayant_droit(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION matching_ayant_droit(_num_marche character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE 
myparam character varying(255);
myparam2 character varying(255);
myrec1 RECORD;
myrec2 RECORD;
myrec3 RECORD;

mycurs1 CURSOR
FOR SELECT
distinct cin, num_marche
from temp_ayant_droit_matching
where num_marche =myparam;

mycurs2 CURSOR
FOR SELECT
* 
from ayant_droit
where cin = myparam2;

mycurs3 CURSOR
FOR SELECT
cin, id_douar, num_parcelle, num_marche
from temp_ayant_droit_matching
where num_marche =myparam;

count INTEGER := 0;

BEGIN
myparam:=_num_marche; 
OPEN mycurs1;
LOOP
FETCH mycurs1 INTO myrec1;
EXIT WHEN NOT FOUND;

IF ( (select count(*) from ayant_droit where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
	myparam2:=myrec1.cin; 						
	OPEN mycurs2;
	LOOP
		FETCH mycurs2 INTO myrec2;
		EXIT WHEN NOT FOUND;
			IF (myrec2.num_marche = 'xxxxxxxxx') THEN
			UPDATE ayant_droit set num_marche = myrec1.num_marche where ayant_droit.cin = myrec1.cin; 
			END IF; 

			IF (myrec2.num_marche <> 'xxxxxxxxx' and myrec2.num_marche <> 'Deleted') THEN
				IF ( (select count(*) from ayant_droit where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
				INSERT INTO public.ayant_droit(cin, num_marche)
			    VALUES (myrec1.cin, myrec1.num_marche);
				END IF;			  
			END IF;
	END LOOP; 
	CLOSE mycurs2;
END IF; 

count := count + 1;
    END LOOP; 
CLOSE mycurs1;

OPEN mycurs3;

	LOOP
		FETCH mycurs3 INTO myrec3;
		EXIT WHEN NOT FOUND;
		update ayant_droit_parcelle set num_marche=myparam 
		where (ayant_droit_parcelle.cin=myrec3.cin 
		and ayant_droit_parcelle.num_parcelle=myrec3.num_parcelle
		and ayant_droit_parcelle.id_douar=myrec3.id_douar); 
		
	END LOOP; 
	
CLOSE mycurs3;

return(count);
		
	   
END;

$$;


ALTER FUNCTION public.matching_ayant_droit(_num_marche character varying) OWNER TO postgres;

--
-- Name: matching_opposant(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION matching_opposant(_num_marche character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE 
myparam character varying(255);
myparam2 character varying(255);
myrec1 RECORD;
myrec2 RECORD;
myrec3 RECORD;

mycurs1 CURSOR
FOR SELECT
distinct cin, num_marche
from temp_opposant_matching
where num_marche =myparam;

mycurs2 CURSOR
FOR SELECT
* 
from opposant
where cin = myparam2;

mycurs3 CURSOR
FOR SELECT
cin, id_douar, num_parcelle, num_marche
from temp_opposant_matching
where num_marche =myparam;

count INTEGER := 0;

BEGIN
myparam:=_num_marche; 
OPEN mycurs1;
LOOP
FETCH mycurs1 INTO myrec1;
EXIT WHEN NOT FOUND;

IF ( (select count(*) from opposant where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
	myparam2:=myrec1.cin; 						
	OPEN mycurs2;
	LOOP
		FETCH mycurs2 INTO myrec2;
		EXIT WHEN NOT FOUND;
			IF (myrec2.num_marche = 'xxxxxxxxx') THEN
			UPDATE opposant set num_marche = myrec1.num_marche where opposant.cin = myrec1.cin; 
			END IF; 

			IF (myrec2.num_marche <> 'xxxxxxxxx' and myrec2.num_marche <> 'Deleted') THEN
				IF ( (select count(*) from opposant where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
				INSERT INTO public.opposant(cin, num_marche)
			    VALUES (myrec1.cin, myrec1.num_marche);
				END IF;			  
			END IF;
	END LOOP; 
	CLOSE mycurs2;
END IF; 

count := count + 1;
    END LOOP; 
CLOSE mycurs1;

OPEN mycurs3;

	LOOP
		FETCH mycurs3 INTO myrec3;
		EXIT WHEN NOT FOUND;
		update opposant_parcelle set num_marche=myparam 
		where (opposant_parcelle.cin=myrec3.cin 
		and opposant_parcelle.num_parcelle=myrec3.num_parcelle
		and opposant_parcelle.id_douar=myrec3.id_douar); 
		
	END LOOP; 
	
CLOSE mycurs3;

return(count);
		
	   
END;

$$;


ALTER FUNCTION public.matching_opposant(_num_marche character varying) OWNER TO postgres;

--
-- Name: matching_presume(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION matching_presume(_num_marche character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE 
myparam character varying(255);
myparam2 character varying(255);
myrec1 RECORD;
myrec2 RECORD;
myrec3 RECORD;

mycurs1 CURSOR
FOR SELECT
distinct cin, num_marche
from temp_presume_matching
where num_marche =myparam;

mycurs2 CURSOR
FOR SELECT
* 
from presume
where cin = myparam2;

mycurs3 CURSOR
FOR SELECT
cin, id_douar, num_parcelle, num_marche
from temp_presume_matching
where num_marche =myparam;

count INTEGER := 0;

BEGIN
myparam:=_num_marche; 
OPEN mycurs1;
LOOP
FETCH mycurs1 INTO myrec1;
EXIT WHEN NOT FOUND;

IF ( (select count(*) from presume where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
	myparam2:=myrec1.cin; 						
	OPEN mycurs2;
	LOOP
		FETCH mycurs2 INTO myrec2;
		EXIT WHEN NOT FOUND;
			IF (myrec2.num_marche = 'xxxxxxxxx') THEN
			UPDATE presume set num_marche = myrec1.num_marche where presume.cin = myrec1.cin; 
			END IF; 

			IF (myrec2.num_marche <> 'xxxxxxxxx' and myrec2.num_marche <> 'Deleted') THEN
				IF ( (select count(*) from presume where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
				INSERT INTO public.presume(cin, num_marche)
			    VALUES (myrec1.cin, myrec1.num_marche);
				END IF;			  
			END IF;
	END LOOP; 
	CLOSE mycurs2;
END IF; 

count := count + 1;
    END LOOP; 
CLOSE mycurs1;

OPEN mycurs3;

	LOOP
		FETCH mycurs3 INTO myrec3;
		EXIT WHEN NOT FOUND;
		update presume_parcelle set num_marche=myparam 
		where (presume_parcelle.cin=myrec3.cin 
		and presume_parcelle.num_parcelle=myrec3.num_parcelle
		and presume_parcelle.id_douar=myrec3.id_douar); 
		
	END LOOP; 
	
CLOSE mycurs3;

return(count);
		
	   
END;

$$;


ALTER FUNCTION public.matching_presume(_num_marche character varying) OWNER TO postgres;

--
-- Name: matching_proprietaire(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION matching_proprietaire(_num_marche character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE 
myparam character varying(255);
myparam2 character varying(255);
myrec1 RECORD;
myrec2 RECORD;
myrec3 RECORD;

mycurs1 CURSOR
FOR SELECT
distinct cin, num_marche
from temp_proprietaire_matching
where num_marche =myparam;

mycurs2 CURSOR
FOR SELECT
* 
from proprietaire
where cin = myparam2;

mycurs3 CURSOR
FOR SELECT
cin, id_douar, num_parcelle, num_marche
from temp_proprietaire_matching
where num_marche =myparam;

count INTEGER := 0;

BEGIN
myparam:=_num_marche; 
OPEN mycurs1;
LOOP
FETCH mycurs1 INTO myrec1;
EXIT WHEN NOT FOUND;

IF ( (select count(*) from proprietaire where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
	myparam2:=myrec1.cin; 						
	OPEN mycurs2;
	LOOP
		FETCH mycurs2 INTO myrec2;
		EXIT WHEN NOT FOUND;
			IF (myrec2.num_marche = 'xxxxxxxxx') THEN
			UPDATE proprietaire set num_marche = myrec1.num_marche where proprietaire.cin = myrec1.cin; 
			END IF; 

			IF (myrec2.num_marche <> 'xxxxxxxxx' and myrec2.num_marche <> 'Deleted') THEN
				IF ( (select count(*) from proprietaire where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
				INSERT INTO public.proprietaire(cin, num_marche)
			    VALUES (myrec1.cin, myrec1.num_marche);
				END IF;			  
			END IF;
	END LOOP; 
	CLOSE mycurs2;
END IF; 

count := count + 1;
    END LOOP; 
CLOSE mycurs1;

OPEN mycurs3;

	LOOP
		FETCH mycurs3 INTO myrec3;
		EXIT WHEN NOT FOUND;
		update proprietaire_parcelle set num_marche=myparam 
		where (proprietaire_parcelle.cin=myrec3.cin 
		and proprietaire_parcelle.num_parcelle=myrec3.num_parcelle
		and proprietaire_parcelle.id_douar=myrec3.id_douar); 
		
	END LOOP; 
	
CLOSE mycurs3;

return(count);
		
	   
END;

$$;


ALTER FUNCTION public.matching_proprietaire(_num_marche character varying) OWNER TO postgres;

--
-- Name: matching_temoin(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION matching_temoin(_num_marche character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE 
myparam character varying(255);
myparam2 character varying(255);
myrec1 RECORD;
myrec2 RECORD;
myrec3 RECORD;

mycurs1 CURSOR
FOR SELECT
distinct cin, num_marche
from temp_temoin_matching
where num_marche =myparam;

mycurs2 CURSOR
FOR SELECT
* 
from temoin
where cin = myparam2;

mycurs3 CURSOR
FOR SELECT
cin, id_douar, num_parcelle, num_marche
from temp_temoin_matching
where num_marche =myparam;

count INTEGER := 0;

BEGIN
myparam:=_num_marche; 
OPEN mycurs1;
LOOP
FETCH mycurs1 INTO myrec1;
EXIT WHEN NOT FOUND;

IF ( (select count(*) from temoin where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
	myparam2:=myrec1.cin; 						
	OPEN mycurs2;
	LOOP
		FETCH mycurs2 INTO myrec2;
		EXIT WHEN NOT FOUND;
			IF (myrec2.num_marche = 'xxxxxxxxx') THEN
			UPDATE temoin set num_marche = myrec1.num_marche where temoin.cin = myrec1.cin; 
			END IF; 

			IF (myrec2.num_marche <> 'xxxxxxxxx' and myrec2.num_marche <> 'Deleted') THEN
				IF ( (select count(*) from temoin where cin=myrec1.cin and num_marche=myrec1.num_marche) = 0 ) THEN
				INSERT INTO public.temoin(cin, num_marche)
			    VALUES (myrec1.cin, myrec1.num_marche);
				END IF;			  
			END IF;
	END LOOP; 
	CLOSE mycurs2;
END IF; 

count := count + 1;
    END LOOP; 
CLOSE mycurs1;

OPEN mycurs3;

	LOOP
		FETCH mycurs3 INTO myrec3;
		EXIT WHEN NOT FOUND;
		update temoin_parcelle set num_marche=myparam 
		where (temoin_parcelle.cin=myrec3.cin 
		and temoin_parcelle.num_parcelle=myrec3.num_parcelle
		and temoin_parcelle.id_douar=myrec3.id_douar); 
		
	END LOOP; 
	
CLOSE mycurs3;

return(count);
		
	   
END;

$$;


ALTER FUNCTION public.matching_temoin(_num_marche character varying) OWNER TO postgres;

--
-- Name: max_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION max_distance(geometry, geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_maxdistance2d_linestring';


ALTER FUNCTION public.max_distance(geometry, geometry) OWNER TO postgres;

--
-- Name: mem_size(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_mem_size';


ALTER FUNCTION public.mem_size(geometry) OWNER TO postgres;

--
-- Name: migration_ayant_droit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION migration_ayant_droit() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR
FOR SELECT
*
from temp_ayant_droit; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update ayant_droit 
   
   set nom_ar = myrec.nom_ar , 
   prenom_ar= myrec.prenom_ar,
   nom_fr= myrec.nom_fr, 
   prenom_fr = myrec.prenom_fr, 
   date_naissance = myrec.date_naissance, 
   adresse= myrec.adresse, 
   adresse_ar = myrec.adresse_ar, 
   nom_pere= myrec.nom_pere, 
   nom_mere= myrec.nom_mere,
   nom_pere_ar= myrec.nom_pere_ar, 
   nom_mere_ar= myrec.nom_mere_ar, 
   nom_conjoint= myrec.nom_conjoint, 
   tel = myrec.tel, 
   situation_famille= myrec.situation_famille, 
   nationalite = myrec.nationalite
  
  
   where ayant_droit.cin = myrec.cin; 
  
   
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.migration_ayant_droit() OWNER TO postgres;

--
-- Name: migration_opposant(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION migration_opposant() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR
FOR SELECT
*
from temp_opposant; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update opposant 
   
   set nom_ar = myrec.nom_ar , 
   prenom_ar= myrec.prenom_ar,
   nom_fr= myrec.nom_fr, 
   prenom_fr = myrec.prenom_fr, 
   date_naissance = myrec.date_naissance, 
   adresse= myrec.adresse, 
   adresse_ar = myrec.adresse_ar, 
   nom_pere= myrec.nom_pere, 
   nom_mere= myrec.nom_mere,
   nom_pere_ar= myrec.nom_pere_ar, 
   nom_mere_ar= myrec.nom_mere_ar, 
   nom_conjoint= myrec.nom_conjoint, 
   tel = myrec.tel, 
   situation_famille= myrec.situation_famille, 
   nationalite = myrec.nationalite
  
  
   where opposant.cin = myrec.cin; 
  
   
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.migration_opposant() OWNER TO postgres;

--
-- Name: migration_presume(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION migration_presume() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR
FOR SELECT
*
from temp_presume; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update presume 
   
   set nom_ar = myrec.nom_ar , 
   prenom_ar= myrec.prenom_ar,
   nom_fr= myrec.nom_fr, 
   prenom_fr = myrec.prenom_fr, 
   date_naissance = myrec.date_naissance, 
   adresse= myrec.adresse, 
   adresse_ar = myrec.adresse_ar, 
   nom_pere= myrec.nom_pere, 
   nom_mere= myrec.nom_mere,
   nom_pere_ar= myrec.nom_pere_ar, 
   nom_mere_ar= myrec.nom_mere_ar, 
   nom_conjoint= myrec.nom_conjoint, 
   tel = myrec.tel, 
   situation_famille= myrec.situation_famille, 
   nationalite = myrec.nationalite
  
  
   where presume.cin = myrec.cin; 
  
   
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.migration_presume() OWNER TO postgres;

--
-- Name: migration_proprietaire(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION migration_proprietaire() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR
FOR SELECT
*
from temp_proprietaire; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update proprietaire 
   
   set nom_ar = myrec.nom_ar , 
   prenom_ar= myrec.prenom_ar,
   nom_fr= myrec.nom_fr, 
   prenom_fr = myrec.prenom_fr, 
   date_naissance = myrec.date_naissance, 
   adresse= myrec.adresse, 
   adresse_ar = myrec.adresse_ar, 
   nom_pere= myrec.nom_pere, 
   nom_mere= myrec.nom_mere,
   nom_pere_ar= myrec.nom_pere_ar, 
   nom_mere_ar= myrec.nom_mere_ar, 
   nom_conjoint= myrec.nom_conjoint, 
   tel = myrec.tel, 
   situation_famille= myrec.situation_famille, 
   nationalite = myrec.nationalite
  
  
   where proprietaire.cin = myrec.cin; 
  
   
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.migration_proprietaire() OWNER TO postgres;

--
-- Name: migration_temoin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION migration_temoin() RETURNS integer
    LANGUAGE plpgsql
    AS $$


DECLARE 
myrec RECORD;
count INTEGER := 0;

mycurs CURSOR
FOR SELECT
*
from temp_temoin; 

BEGIN
   
   OPEN mycurs;
 
   LOOP
   
   FETCH mycurs INTO myrec;
   
   EXIT WHEN NOT FOUND;
  
   update temoin 
   
   set nom_ar = myrec.nom_ar , 
   prenom_ar= myrec.prenom_ar,
   nom_fr= myrec.nom_fr, 
   prenom_fr = myrec.prenom_fr, 
   date_naissance = myrec.date_naissance, 
   adresse= myrec.adresse, 
   adresse_ar = myrec.adresse_ar, 
   nom_pere= myrec.nom_pere, 
   nom_mere= myrec.nom_mere,
   nom_pere_ar= myrec.nom_pere_ar, 
   nom_mere_ar= myrec.nom_mere_ar, 
   nom_conjoint= myrec.nom_conjoint, 
   tel = myrec.tel, 
   situation_famille= myrec.situation_famille, 
   nationalite = myrec.nationalite
  
  
   where temoin.cin = myrec.cin; 
  
   
   count := count + 1;


   END LOOP; 

   CLOSE mycurs;
   
   return(count);
   
END;

$$;


ALTER FUNCTION public.migration_temoin() OWNER TO postgres;

--
-- Name: mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTILINESTRING'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromtext(text) OWNER TO postgres;

--
-- Name: mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromtext(text, integer) OWNER TO postgres;

--
-- Name: mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromwkb(bytea) OWNER TO postgres;

--
-- Name: mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mlinefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromtext(text) OWNER TO postgres;

--
-- Name: mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1,$2)) = 'MULTIPOINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromtext(text, integer) OWNER TO postgres;

--
-- Name: mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromwkb(bytea) OWNER TO postgres;

--
-- Name: mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'MULTIPOLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromtext(text) OWNER TO postgres;

--
-- Name: mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromtext(text, integer) OWNER TO postgres;

--
-- Name: mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.mpolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multi(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_force_multi';


ALTER FUNCTION public.multi(geometry) OWNER TO postgres;

--
-- Name: multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multilinefromwkb(bytea) OWNER TO postgres;

--
-- Name: multilinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multilinefromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


ALTER FUNCTION public.multilinestringfromtext(text) OWNER TO postgres;

--
-- Name: multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MLineFromText($1, $2)$_$;


ALTER FUNCTION public.multilinestringfromtext(text, integer) OWNER TO postgres;

--
-- Name: multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1)$_$;


ALTER FUNCTION public.multipointfromtext(text) OWNER TO postgres;

--
-- Name: multipointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPointFromText($1, $2)$_$;


ALTER FUNCTION public.multipointfromtext(text, integer) OWNER TO postgres;

--
-- Name: multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipointfromwkb(bytea) OWNER TO postgres;

--
-- Name: multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipolyfromwkb(bytea) OWNER TO postgres;

--
-- Name: multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.multipolyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1)$_$;


ALTER FUNCTION public.multipolygonfromtext(text) OWNER TO postgres;

--
-- Name: multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT MPolyFromText($1, $2)$_$;


ALTER FUNCTION public.multipolygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: ndims(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_ndims';


ALTER FUNCTION public.ndims(geometry) OWNER TO postgres;

--
-- Name: noop(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-3', 'LWGEOM_noop';


ALTER FUNCTION public.noop(geometry) OWNER TO postgres;

--
-- Name: npoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_npoints';


ALTER FUNCTION public.npoints(geometry) OWNER TO postgres;

--
-- Name: nrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_nrings';


ALTER FUNCTION public.nrings(geometry) OWNER TO postgres;

--
-- Name: numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_numgeometries_collection';


ALTER FUNCTION public.numgeometries(geometry) OWNER TO postgres;

--
-- Name: numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.numinteriorring(geometry) OWNER TO postgres;

--
-- Name: numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_numinteriorrings_polygon';


ALTER FUNCTION public.numinteriorrings(geometry) OWNER TO postgres;

--
-- Name: numpoints(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_numpoints_linestring';


ALTER FUNCTION public.numpoints(geometry) OWNER TO postgres;

--
-- Name: overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "overlaps"(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'overlaps';


ALTER FUNCTION public."overlaps"(geometry, geometry) OWNER TO postgres;

--
-- Name: perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_perimeter2d_poly';


ALTER FUNCTION public.perimeter2d(geometry) OWNER TO postgres;

--
-- Name: perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_perimeter_poly';


ALTER FUNCTION public.perimeter3d(geometry) OWNER TO postgres;

--
-- Name: point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_inside_circle_point';


ALTER FUNCTION public.point_inside_circle(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: pointfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POINT'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromtext(text) OWNER TO postgres;

--
-- Name: pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POINT'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromtext(text, integer) OWNER TO postgres;

--
-- Name: pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POINT'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromwkb(bytea) OWNER TO postgres;

--
-- Name: pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POINT'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.pointfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_pointn_linestring';


ALTER FUNCTION public.pointn(geometry, integer) OWNER TO postgres;

--
-- Name: pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'pointonsurface';


ALTER FUNCTION public.pointonsurface(geometry) OWNER TO postgres;

--
-- Name: polyfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1)) = 'POLYGON'
	THEN GeomFromText($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromtext(text) OWNER TO postgres;

--
-- Name: polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromText($1, $2)) = 'POLYGON'
	THEN GeomFromText($1,$2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromtext(text, integer) OWNER TO postgres;

--
-- Name: polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromwkb(bytea) OWNER TO postgres;

--
-- Name: polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1, $2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polyfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1)$_$;


ALTER FUNCTION public.polygonfromtext(text) OWNER TO postgres;

--
-- Name: polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT PolyFromText($1, $2)$_$;


ALTER FUNCTION public.polygonfromtext(text, integer) OWNER TO postgres;

--
-- Name: polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1)) = 'POLYGON'
	THEN GeomFromWKB($1)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polygonfromwkb(bytea) OWNER TO postgres;

--
-- Name: polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(GeomFromWKB($1,$2)) = 'POLYGON'
	THEN GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


ALTER FUNCTION public.polygonfromwkb(bytea, integer) OWNER TO postgres;

--
-- Name: polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'polygonize_garray';


ALTER FUNCTION public.polygonize_garray(geometry[]) OWNER TO postgres;

--
-- Name: probe_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION probe_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted integer;
	oldcount integer;
	probed integer;
	stale integer;
BEGIN


	RETURN 'This function is obsolete now that geometry_columns is a view';
END

$$;


ALTER FUNCTION public.probe_geometry_columns() OWNER TO postgres;

--
-- Name: relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relate(geometry, geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'relate_full';


ALTER FUNCTION public.relate(geometry, geometry) OWNER TO postgres;

--
-- Name: relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relate(geometry, geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'relate_pattern';


ALTER FUNCTION public.relate(geometry, geometry, text) OWNER TO postgres;

--
-- Name: removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_removepoint';


ALTER FUNCTION public.removepoint(geometry, integer) OWNER TO postgres;

--
-- Name: rename_geometry_table_constraints(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rename_geometry_table_constraints() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT 'rename_geometry_table_constraint() is obsoleted'::text
$$;


ALTER FUNCTION public.rename_geometry_table_constraints() OWNER TO postgres;

--
-- Name: reverse(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_reverse';


ALTER FUNCTION public.reverse(geometry) OWNER TO postgres;

--
-- Name: rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_rotateZ($1, $2)$_$;


ALTER FUNCTION public.rotate(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


ALTER FUNCTION public.rotatex(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


ALTER FUNCTION public.rotatey(geometry, double precision) OWNER TO postgres;

--
-- Name: rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


ALTER FUNCTION public.rotatez(geometry, double precision) OWNER TO postgres;

--
-- Name: scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_scale($1, $2, $3, 1)$_$;


ALTER FUNCTION public.scale(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


ALTER FUNCTION public.scale(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: se_envelopesintersect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_envelopesintersect(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 && $2
	$_$;


ALTER FUNCTION public.se_envelopesintersect(geometry, geometry) OWNER TO postgres;

--
-- Name: se_is3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_is3d(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_hasz';


ALTER FUNCTION public.se_is3d(geometry) OWNER TO postgres;

--
-- Name: se_ismeasured(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_ismeasured(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_hasm';


ALTER FUNCTION public.se_ismeasured(geometry) OWNER TO postgres;

--
-- Name: se_locatealong(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_locatealong(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT SE_LocateBetween($1, $2, $2) $_$;


ALTER FUNCTION public.se_locatealong(geometry, double precision) OWNER TO postgres;

--
-- Name: se_locatebetween(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_locatebetween(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_locate_between_m';


ALTER FUNCTION public.se_locatebetween(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: se_m(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_m_point';


ALTER FUNCTION public.se_m(geometry) OWNER TO postgres;

--
-- Name: se_z(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION se_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_z_point';


ALTER FUNCTION public.se_z(geometry) OWNER TO postgres;

--
-- Name: segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_segmentize2d';


ALTER FUNCTION public.segmentize(geometry, double precision) OWNER TO postgres;

--
-- Name: setgeometry(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setgeometry(id integer, geom character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

        BEGIN





                RETURN id*10;

        END;

$$;


ALTER FUNCTION public.setgeometry(id integer, geom character varying) OWNER TO postgres;

--
-- Name: setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_setpoint_linestring';


ALTER FUNCTION public.setpoint(geometry, integer, geometry) OWNER TO postgres;

--
-- Name: setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_set_srid';


ALTER FUNCTION public.setsrid(geometry, integer) OWNER TO postgres;

--
-- Name: shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_longitude_shift';


ALTER FUNCTION public.shift_longitude(geometry) OWNER TO postgres;

--
-- Name: show_parcels(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_parcels() RETURNS TABLE(_lat double precision, _long double precision, _name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN QUERY SELECT

st_x(st_transform(ST_Centroid(the_geom),4326)) as lat, 
st_y(st_transform(ST_Centroid(the_geom),4326)) as long, 
num_parcelle

FROM parcelle;

END; $$;


ALTER FUNCTION public.show_parcels() OWNER TO postgres;

--
-- Name: simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_simplify2d';


ALTER FUNCTION public.simplify(geometry, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $2)$_$;


ALTER FUNCTION public.snaptogrid(geometry, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $3)$_$;


ALTER FUNCTION public.snaptogrid(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_snaptogrid';


ALTER FUNCTION public.snaptogrid(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_snaptogrid_pointoff';


ALTER FUNCTION public.snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: srid(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_get_srid';


ALTER FUNCTION public.srid(geometry) OWNER TO postgres;

--
-- Name: st_asbinary(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_asbinary(text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsBinary($1::geometry);$_$;


ALTER FUNCTION public.st_asbinary(text) OWNER TO postgres;

--
-- Name: st_astext(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_astext(bytea) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsText($1::geometry);$_$;


ALTER FUNCTION public.st_astext(bytea) OWNER TO postgres;

--
-- Name: st_box(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_to_BOX';


ALTER FUNCTION public.st_box(box3d) OWNER TO postgres;

--
-- Name: st_box(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_BOX';


ALTER FUNCTION public.st_box(geometry) OWNER TO postgres;

--
-- Name: st_box2d(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_to_BOX2D';


ALTER FUNCTION public.st_box2d(box3d) OWNER TO postgres;

--
-- Name: st_box2d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_BOX2D';


ALTER FUNCTION public.st_box2d(geometry) OWNER TO postgres;

--
-- Name: st_box3d(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX2D_to_BOX3D';


ALTER FUNCTION public.st_box3d(box2d) OWNER TO postgres;

--
-- Name: st_box3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_BOX3D';


ALTER FUNCTION public.st_box3d(geometry) OWNER TO postgres;

--
-- Name: st_box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_in';


ALTER FUNCTION public.st_box3d_in(cstring) OWNER TO postgres;

--
-- Name: st_box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_out';


ALTER FUNCTION public.st_box3d_out(box3d) OWNER TO postgres;

--
-- Name: st_bytea(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_bytea';


ALTER FUNCTION public.st_bytea(geometry) OWNER TO postgres;

--
-- Name: st_geometry(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_from_bytea';


ALTER FUNCTION public.st_geometry(bytea) OWNER TO postgres;

--
-- Name: st_geometry(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'parse_WKT_lwgeom';


ALTER FUNCTION public.st_geometry(text) OWNER TO postgres;

--
-- Name: st_geometry(box2d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX2D_to_LWGEOM';


ALTER FUNCTION public.st_geometry(box2d) OWNER TO postgres;

--
-- Name: st_geometry(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_to_LWGEOM';


ALTER FUNCTION public.st_geometry(box3d) OWNER TO postgres;

--
-- Name: st_geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_cmp(geometry, geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_cmp';


ALTER FUNCTION public.st_geometry_cmp(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_eq(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_eq';


ALTER FUNCTION public.st_geometry_eq(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_ge(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_ge';


ALTER FUNCTION public.st_geometry_ge(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_gt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_gt';


ALTER FUNCTION public.st_geometry_gt(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_le(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_le';


ALTER FUNCTION public.st_geometry_le(geometry, geometry) OWNER TO postgres;

--
-- Name: st_geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_geometry_lt(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'lwgeom_lt';


ALTER FUNCTION public.st_geometry_lt(geometry, geometry) OWNER TO postgres;

--
-- Name: st_length3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_length_linestring';


ALTER FUNCTION public.st_length3d(geometry) OWNER TO postgres;

--
-- Name: st_length_spheroid3d(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_length_spheroid3d(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'LWGEOM_length_ellipsoid_linestring';


ALTER FUNCTION public.st_length_spheroid3d(geometry, spheroid) OWNER TO postgres;

--
-- Name: st_makebox3d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makebox3d(geometry, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_construct';


ALTER FUNCTION public.st_makebox3d(geometry, geometry) OWNER TO postgres;

--
-- Name: st_makeline_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_makeline_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_makeline_garray';


ALTER FUNCTION public.st_makeline_garray(geometry[]) OWNER TO postgres;

--
-- Name: st_perimeter3d(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_perimeter3d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_perimeter_poly';


ALTER FUNCTION public.st_perimeter3d(geometry) OWNER TO postgres;

--
-- Name: st_polygonize_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_polygonize_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-3', 'polygonize_garray';


ALTER FUNCTION public.st_polygonize_garray(geometry[]) OWNER TO postgres;

--
-- Name: st_text(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_to_text';


ALTER FUNCTION public.st_text(geometry) OWNER TO postgres;

--
-- Name: st_unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION st_unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'pgis_union_geometry_array';


ALTER FUNCTION public.st_unite_garray(geometry[]) OWNER TO postgres;

--
-- Name: startpoint(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_startpoint_linestring';


ALTER FUNCTION public.startpoint(geometry) OWNER TO postgres;

--
-- Name: summary(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_summary';


ALTER FUNCTION public.summary(geometry) OWNER TO postgres;

--
-- Name: symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION symdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'symdifference';


ALTER FUNCTION public.symdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION symmetricdifference(geometry, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'symdifference';


ALTER FUNCTION public.symmetricdifference(geometry, geometry) OWNER TO postgres;

--
-- Name: touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION touches(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'touches';


ALTER FUNCTION public.touches(geometry, geometry) OWNER TO postgres;

--
-- Name: transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'transform';


ALTER FUNCTION public.transform(geometry, integer) OWNER TO postgres;

--
-- Name: translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_translate($1, $2, $3, 0)$_$;


ALTER FUNCTION public.translate(geometry, double precision, double precision) OWNER TO postgres;

--
-- Name: translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


ALTER FUNCTION public.translate(geometry, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT st_affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


ALTER FUNCTION public.transscale(geometry, double precision, double precision, double precision, double precision) OWNER TO postgres;

--
-- Name: unite_garray(geometry[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION unite_garray(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'pgis_union_geometry_array';


ALTER FUNCTION public.unite_garray(geometry[]) OWNER TO postgres;

--
-- Name: updaregeom(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updaregeom() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

 

    NEW.the_geom := NEW.the_geom_s;

  

  RETURN NEW;

END$$;


ALTER FUNCTION public.updaregeom() OWNER TO postgres;

--
-- Name: updaregeomandprojection(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updaregeomandprojection() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    NEW.the_geom := NEW.the_geom_s;
    
    NEW.projection := st_srid(NEW.the_geom);
    
  
  RETURN NEW;
END$$;


ALTER FUNCTION public.updaregeomandprojection() OWNER TO postgres;

--
-- Name: updatebornefortetouan(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updatebornefortetouan() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE nbr_brn int;
i INTEGER := 1;
parts text;
name varchar;
rec_parc   RECORD;
rec_born   RECORD;

cur_parcelles CURSOR 
FOR SELECT id_synchronisation, num_parcelle,p.id_douar,the_geom
from parcelle p, referentiel r where num_marche in ('26/2018/ANCFCC/DC'  )and p.id_douar=r.id_douar;
-- 
-- cur_bornes CURSOR(num_parcelle varchar,id_douar INTEGER) 
-- FOR SELECT *
-- FROM borne
-- WHERE borne.num_parcelle=num_parcelle and borne.id_douar=id_douar;

BEGIN


OPEN cur_parcelles;
	
   LOOP
    -- fetch row into the film
      FETCH cur_parcelles INTO rec_parc;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;


				   nbr_brn :=count(*) from borne where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar;
				   if nbr_brn !=0 then
						i:=1;
					--raise notice 'Value: %', nbr_brn;

					LOOP 
							
							parts:= split_part( cast (replace(replace(substring(st_astext(rec_parc.the_geom),'\((.+)\)'),'(','' ),')','' ) as varchar) ,',' ,i) ;--from parcelle where id_synchronisation=rec_parc.id_synchronisation ;

							update borne set ordre=i where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar and cast( CONCAT ( cast(x as varchar),' ',  cast(y as varchar)) as varchar)=cast(parts as varchar);

					--		name := borne.name from borne  where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar and cast( CONCAT ( cast(x as varchar),' ',  cast(y as varchar)) as varchar)=cast(parts as varchar);
					 
					--raise notice 'Part % : _%_ : %',i, parts,name;
							i := i + 1 ; 
							
							EXIT WHEN i = nbr_brn+1 ; 
						END LOOP ; 

					end if ;




   END LOOP;
  
   -- Close the cursor
   CLOSE cur_parcelles;
 
--    NEW.the_geom := NEW.the_geom_s;

RETURN parts;
END$$;


ALTER FUNCTION public.updatebornefortetouan() OWNER TO postgres;

--
-- Name: updatebornefortetouanpp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updatebornefortetouanpp() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE nbr_brn int;
i INTEGER := 1;
parts text;
name varchar;
rec_parc   RECORD;
rec_born   RECORD;

cur_parcelles CURSOR 
FOR SELECT id_synchronisation, num_parcelle,p.id_douar,the_geom
from parcelle p, referentiel r where num_marche in ('13/2018/ANCFCC/DC'  )and p.id_douar=r.id_douar;
-- 
-- cur_bornes CURSOR(num_parcelle varchar,id_douar INTEGER) 
-- FOR SELECT *
-- FROM borne
-- WHERE borne.num_parcelle=num_parcelle and borne.id_douar=id_douar;

BEGIN


OPEN cur_parcelles;
	
   LOOP
    -- fetch row into the film
      FETCH cur_parcelles INTO rec_parc;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;


				   nbr_brn :=count(*) from borne where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar;
				   if nbr_brn !=0 then
						i:=1;
					--raise notice 'Value: %', nbr_brn;

					LOOP 
							
							parts:= split_part( cast (replace(replace(substring(st_astext(rec_parc.the_geom),'\((.+)\)'),'(','' ),')','' ) as varchar) ,',' ,i) ;--from parcelle where id_synchronisation=rec_parc.id_synchronisation ;

							update borne set ordre=i where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar and cast( CONCAT ( cast(x as varchar),' ',  cast(y as varchar)) as varchar)=cast(parts as varchar);

							--name := borne.name from borne  where num_parcelle=rec_parc.num_parcelle and id_douar=rec_parc.id_douar and cast( CONCAT ( cast(x as varchar),' ',  cast(y as varchar)) as varchar)=cast(parts as varchar);
					 
					--raise notice 'Part % : _%_ : %',i, parts,name;
							i := i + 1 ; 
							
							EXIT WHEN i = nbr_brn+1 ; 
						END LOOP ; 

					end if ;




   END LOOP;
  
   -- Close the cursor
   CLOSE cur_parcelles;
 
--    NEW.the_geom := NEW.the_geom_s;

RETURN parts;
END$$;


ALTER FUNCTION public.updatebornefortetouanpp() OWNER TO postgres;

--
-- Name: within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION within(geometry, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Within($1, $2)$_$;


ALTER FUNCTION public.within(geometry, geometry) OWNER TO postgres;

--
-- Name: x(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_x_point';


ALTER FUNCTION public.x(geometry) OWNER TO postgres;

--
-- Name: xmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_xmax';


ALTER FUNCTION public.xmax(box3d) OWNER TO postgres;

--
-- Name: xmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_xmin';


ALTER FUNCTION public.xmin(box3d) OWNER TO postgres;

--
-- Name: y(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_y_point';


ALTER FUNCTION public.y(geometry) OWNER TO postgres;

--
-- Name: ymax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_ymax';


ALTER FUNCTION public.ymax(box3d) OWNER TO postgres;

--
-- Name: ymin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_ymin';


ALTER FUNCTION public.ymin(box3d) OWNER TO postgres;

--
-- Name: z(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_z_point';


ALTER FUNCTION public.z(geometry) OWNER TO postgres;

--
-- Name: zmax(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_zmax';


ALTER FUNCTION public.zmax(box3d) OWNER TO postgres;

--
-- Name: zmflag(geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_zmflag';


ALTER FUNCTION public.zmflag(geometry) OWNER TO postgres;

--
-- Name: zmin(box3d); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'BOX3D_zmin';


ALTER FUNCTION public.zmin(box3d) OWNER TO postgres;

--
-- Name: accum(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--
--
--CREATE AGGREGATE accum(geometry) (
--    SFUNC = public.pgis_geometry_accum_transfn,
--    STYPE = pgis_abs,
--    FINALFUNC = pgis_geometry_accum_finalfn
--);
--

--ALTER AGGREGATE public.accum(geometry) OWNER TO postgres;

--
-- Name: extent(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

--CREATE AGGREGATE extent(geometry) (
--    SFUNC = public.st_combine_bbox,
  --  STYPE = box3d,
    --FINALFUNC = public.box2d
--);


--ALTER AGGREGATE public.extent(geometry) OWNER TO postgres;

--
-- Name: extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE extent3d(geometry) (
    SFUNC = public.combine_bbox,
    STYPE = box3d
);


ALTER AGGREGATE public.extent3d(geometry) OWNER TO postgres;

--
-- Name: makeline(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

--CREATE AGGREGATE makeline(geometry) (
--    SFUNC = public.pgis_geometry_accum_transfn,
--    STYPE = pgis_abs,
--   FINALFUNC = pgis_geometry_makeline_finalfn
--);


--ALTER AGGREGATE public.makeline(geometry) OWNER TO postgres;

--
-- Name: memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


ALTER AGGREGATE public.memcollect(geometry) OWNER TO postgres;

--
-- Name: memgeomunion(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE memgeomunion(geometry) (
    SFUNC = geomunion,
    STYPE = geometry
);


ALTER AGGREGATE public.memgeomunion(geometry) OWNER TO postgres;

--
-- Name: st_extent3d(geometry); Type: AGGREGATE; Schema: public; Owner: postgres
--

--CREATE AGGREGATE st_extent3d(geometry) (
--    SFUNC = public.st_combine_bbox,
--    STYPE = box3d
--);


--ALTER AGGREGATE public.st_extent3d(geometry) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Action; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Action" (
    "CodeAction" character varying(128) NOT NULL,
    "LibelleAction" character varying(255)
);


ALTER TABLE "Action" OWNER TO postgres;

--
-- Name: ActionMarche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ActionMarche" (
    num_marche character varying(255),
    "CodeAction" character varying(125),
    "Observation" text,
    "IdUser" character varying(125),
    "Id" integer NOT NULL,
    "DateAction" timestamp without time zone
);


ALTER TABLE "ActionMarche" OWNER TO postgres;

--
-- Name: AspNetRoles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "AspNetRoles" (
    "Id" character varying(128) NOT NULL,
    "Name" character varying(256) NOT NULL
);


ALTER TABLE "AspNetRoles" OWNER TO postgres;

--
-- Name: AspNetUserClaims; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "AspNetUserClaims" (
    "Id" integer NOT NULL,
    "ClaimType" character varying(256),
    "ClaimValue" character varying(256),
    "UserId" character varying(128) NOT NULL
);


ALTER TABLE "AspNetUserClaims" OWNER TO postgres;

--
-- Name: AspNetUserClaims_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "AspNetUserClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AspNetUserClaims_Id_seq" OWNER TO postgres;

--
-- Name: AspNetUserClaims_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "AspNetUserClaims_Id_seq" OWNED BY "AspNetUserClaims"."Id";


--
-- Name: AspNetUserLogins; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "AspNetUserLogins" (
    "UserId" character varying(128) NOT NULL,
    "LoginProvider" character varying(128) NOT NULL,
    "ProviderKey" character varying(128) NOT NULL
);


ALTER TABLE "AspNetUserLogins" OWNER TO postgres;

--
-- Name: AspNetUserRoles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "AspNetUserRoles" (
    "UserId" character varying(128) NOT NULL,
    "RoleId" character varying(128) NOT NULL
);


ALTER TABLE "AspNetUserRoles" OWNER TO postgres;

--
-- Name: AspNetUsers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "AspNetUsers" OWNER TO postgres;

--
-- Name: ServiceExterieur; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ServiceExterieur" (
    "IdSE" integer NOT NULL,
    "NomSE" character varying(255),
    mail_cad character varying(256),
    mail_cf character varying(256),
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);


ALTER TABLE "ServiceExterieur" OWNER TO postgres;

--
-- Name: seq_douar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_douar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_douar OWNER TO postgres;

--
-- Name: douar; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE douar OWNER TO postgres;

--
-- Name: COLUMN douar."EstimParc"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN douar."EstimParc" IS '
';


--
-- Name: marche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE marche OWNER TO postgres;

--
-- Name: parcelle_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE parcelle_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parcelle_gid_seq OWNER TO postgres;

--
-- Name: parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE parcelle OWNER TO postgres;

--
-- Name: seq_sous_zone; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_sous_zone
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_sous_zone OWNER TO postgres;

--
-- Name: seq_zone; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_zone
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_zone OWNER TO postgres;

--
-- Name: sous_zone; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sous_zone (
    id_sous_zone integer DEFAULT nextval('seq_sous_zone'::regclass) NOT NULL,
    nom character varying(255),
    observation character varying(255),
    id_zone integer NOT NULL,
    nom_ar character varying(255),
    "EstimParc" integer NOT NULL
);


ALTER TABLE sous_zone OWNER TO postgres;

--
-- Name: zone; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE zone OWNER TO postgres;

--
-- Name: BI_View; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "BI_View" AS
 SELECT r."DateOS",
    r."DateBO",
    r."IdSE",
    r.num_marche,
    r.id_zone,
    r.zone,
    r.id_sous_zone,
    r.sous_zone,
    r.id_douar,
    r.douar,
        CASE
            WHEN (et.nbreparc IS NULL) THEN (0)::bigint
            ELSE et.nbreparc
        END AS nbreparc,
        CASE
            WHEN (et.synchronisecf IS NULL) THEN (0)::bigint
            ELSE et.synchronisecf
        END AS synchronisecf,
        CASE
            WHEN (et.synchronisecad IS NULL) THEN (0)::bigint
            ELSE et.synchronisecad
        END AS synchronisecad,
        CASE
            WHEN (et.validcf IS NULL) THEN (0)::bigint
            ELSE et.validcf
        END AS validcf,
        CASE
            WHEN (et.validigtcf IS NULL) THEN (0)::bigint
            ELSE et.validigtcf
        END AS validigtcf,
        CASE
            WHEN (et.rejetcf IS NULL) THEN (0)::bigint
            ELSE et.rejetcf
        END AS rejetcf,
        CASE
            WHEN (et.validcad IS NULL) THEN (0)::bigint
            ELSE et.validcad
        END AS validcad,
        CASE
            WHEN (et.validigtcad IS NULL) THEN (0)::bigint
            ELSE et.validigtcad
        END AS validigtcad,
        CASE
            WHEN (et.rejetcad IS NULL) THEN (0)::bigint
            ELSE et.rejetcad
        END AS rejetcad
   FROM (( SELECT se."IdSE",
            m.num_marche,
            m."DateOS",
            m."DateBO",
            z.id_zone,
            z.nom AS zone,
            sz.id_sous_zone,
            sz.nom AS sous_zone,
            d.id_douar,
            d.nom AS douar
           FROM "ServiceExterieur" se,
            marche m,
            zone z,
            sous_zone sz,
            douar d
          WHERE ((((se."IdSE" = m."serviceExt") AND (m.id_zone = z.id_zone)) AND (z.id_zone = sz.id_zone)) AND (sz.id_sous_zone = d.id_sous_zone))) r
     LEFT JOIN ( SELECT p.id_douar,
            sum(1) AS nbreparc,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = ANY (ARRAY[('SynchCF'::character varying)::text, ('CancelIgtCF'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidCF'::text) THEN 1
                    ELSE 0
                END) AS validcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidIgtCF'::text) THEN 1
                    ELSE 0
                END) AS validigtcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN 1
                    ELSE 0
                END) AS rejetcf,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = ANY (ARRAY[('SynchCAD'::character varying)::text, ('CancelIgtCAD'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidCAD'::text) THEN 1
                    ELSE 0
                END) AS validcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidIgtCAD'::text) THEN 1
                    ELSE 0
                END) AS validigtcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN 1
                    ELSE 0
                END) AS rejetcad
           FROM parcelle p
          WHERE ((p.etat)::text <> 'Deleted'::text)
          GROUP BY p.id_douar) et ON ((r.id_douar = et.id_douar)));


ALTER TABLE "BI_View" OWNER TO postgres;

--
-- Name: BienLimitrophe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "BienLimitrophe" (
    "Id_Riverain" integer NOT NULL,
    "Nature" character varying(128),
    "Indice" character varying,
    "IndiceSpe" character varying(128),
    "Numero" character varying(128)
);


ALTER TABLE "BienLimitrophe" OWNER TO postgres;

--
-- Name: Caidat; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Caidat" (
    "IdCaidat" integer NOT NULL,
    "NomCaidat" character varying(255),
    "NomCaidat_ar" character varying(255),
    "Caid" character varying(255),
    "IdProvince" integer
);


ALTER TABLE "Caidat" OWNER TO postgres;

--
-- Name: Categorie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Categorie" (
    "IdCategorie" integer NOT NULL,
    "NomCategorie" character varying(255),
    delai_phase1 integer,
    delai_phase2 integer
);


ALTER TABLE "Categorie" OWNER TO postgres;

--
-- Name: Categorie_Document; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Categorie_Document" (
    "Libelle_Categorie" character varying(255),
    "Code_Categorie" character varying(128) NOT NULL,
    "Type" character varying(128),
    "Obligatoire" boolean
);


ALTER TABLE "Categorie_Document" OWNER TO postgres;

--
-- Name: Cercle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Cercle" (
    "IdCercle" integer NOT NULL,
    "NomCercle" character varying(255),
    "NomCercle_ar" character varying(255),
    "IdProvince" integer,
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);


ALTER TABLE "Cercle" OWNER TO postgres;

--
-- Name: CollabExterne_marche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CollabExterne_marche" (
    id_collab integer NOT NULL,
    num_marche character varying(255) NOT NULL,
    date_affectation timestamp without time zone,
    initiateur character varying(128)
);


ALTER TABLE "CollabExterne_marche" OWNER TO postgres;

--
-- Name: CollabInterne; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CollabInterne" (
    "Id_Personnel" integer NOT NULL,
    "Id_SE" integer NOT NULL,
    "Nom" character varying(128),
    "Prenom" character varying(128),
    "IdUSer" character varying(128),
    "Direction" character varying(128),
    tel character varying(255)
);


ALTER TABLE "CollabInterne" OWNER TO postgres;

--
-- Name: CollabInterne_marche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "CollabInterne_marche" (
    "Id_Personnel" integer NOT NULL,
    "Num_Marche" character varying(128) NOT NULL,
    "Role" character varying(128)
);


ALTER TABLE "CollabInterne_marche" OWNER TO postgres;

--
-- Name: Collaborateur; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Collaborateur" OWNER TO postgres;

--
-- Name: Commune; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Commune" (
    "IdCommune" integer NOT NULL,
    "NomCommune" character varying(255),
    "NomCommune_ar" character varying(255),
    "IdCercle" integer,
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);


ALTER TABLE "Commune" OWNER TO postgres;

--
-- Name: DocCommun; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "DocCommun" (
    "Id_Document" integer NOT NULL,
    id_sous_zone integer,
    "DernierMotifRejet" text,
    "Statut" character varying(128),
    "DateValidation" date,
    "DateRejet" date
);


ALTER TABLE "DocCommun" OWNER TO postgres;

--
-- Name: DocMarche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "DocMarche" (
    "Id_Document" integer NOT NULL,
    "NumMarche" character varying(255)
);


ALTER TABLE "DocMarche" OWNER TO postgres;

--
-- Name: DocParcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "DocParcelle" OWNER TO postgres;

--
-- Name: Document; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Document" (
    "Id_Document" integer NOT NULL,
    "Type_Document" character varying(128),
    "Path_Document" character varying(255),
    "Nom_Document" character varying(255),
    "Categorie_Document" character varying(128)
);


ALTER TABLE "Document" OWNER TO postgres;

--
-- Name: Etat_Document; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Etat_Document" (
    "Id_Etat" integer NOT NULL,
    "Id_Document" integer,
    "DateAction" date,
    "Initiateur" character varying(128),
    "Action" character varying(128),
    "Observ_Controle" text
);


ALTER TABLE "Etat_Document" OWNER TO postgres;

--
-- Name: Etat_Parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Etat_Parcelle" OWNER TO postgres;

--
-- Name: geoife_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE geoife_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geoife_id_seq OWNER TO postgres;

--
-- Name: Geoife; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Geoife" OWNER TO postgres;

--
-- Name: GroupesDesMarches; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "GroupesDesMarches" (
    num_marche character varying(255),
    groupe character varying(255)
);


ALTER TABLE "GroupesDesMarches" OWNER TO postgres;

--
-- Name: LimiteNat; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "LimiteNat" (
    "Nom_LN" character varying(255),
    "Id_Riverain" integer NOT NULL,
    "Code_LN" character varying(10)
);


ALTER TABLE "LimiteNat" OWNER TO postgres;

--
-- Name: Livraison; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Livraison" OWNER TO postgres;

--
-- Name: id_notif_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_notif_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_notif_seq OWNER TO postgres;

--
-- Name: Notification; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Notification" (
    "id_Notif" integer DEFAULT nextval('id_notif_seq'::regclass) NOT NULL,
    objet character varying(255),
    statut character varying(128),
    "dateVisualisation" date,
    destinataire character varying(128),
    "dateNotification" timestamp without time zone,
    num_marche character varying(255)
);


ALTER TABLE "Notification" OWNER TO postgres;

--
-- Name: Opposition; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Opposition" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    indice integer NOT NULL,
    the_geom geometry,
    the_geom_s text
);


ALTER TABLE "Opposition" OWNER TO postgres;

--
-- Name: Opposition_Opposant; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Opposition_Opposant" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    indice integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255) NOT NULL
);


ALTER TABLE "Opposition_Opposant" OWNER TO postgres;

--
-- Name: Prep_Marche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Prep_Marche" OWNER TO postgres;

--
-- Name: Prop_morale; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Prop_morale" (
    "Id_Riverain" integer NOT NULL,
    "Nom" character varying(255),
    rc character varying(255)
);


ALTER TABLE "Prop_morale" OWNER TO postgres;

--
-- Name: Prop_physique; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Prop_physique" (
    "Id_Riverain" integer NOT NULL,
    "CIN" character varying(128),
    "Nom" character varying(255),
    "Prenom" character varying(255),
    "Adresse" character varying(255),
    "GSM" character varying(255)
);


ALTER TABLE "Prop_physique" OWNER TO postgres;

--
-- Name: Province; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Province" (
    "IdProvince" integer NOT NULL,
    "NomProvince" character varying(255),
    "NomProvince_ar" character varying(255),
    "Initiateur" character varying(128),
    "DateCreation" timestamp without time zone,
    "DateMAJ" timestamp without time zone
);


ALTER TABLE "Province" OWNER TO postgres;

--
-- Name: RefConsistances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "RefConsistances" (
    "Id_Consistance" integer NOT NULL,
    "Lib_Consistance_fr" character varying(255),
    "Lib_Consistance_ar" character varying(255)
);


ALTER TABLE "RefConsistances" OWNER TO postgres;

--
-- Name: RefLimiteNat; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "RefLimiteNat" (
    "Code_Type" character varying(10) NOT NULL,
    "Libelle_Type" character varying(255),
    "Obsolete" boolean
);


ALTER TABLE "RefLimiteNat" OWNER TO postgres;

--
-- Name: RefMotifRejet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "RefMotifRejet" OWNER TO postgres;

--
-- Name: RefSpeculation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "RefSpeculation" (
    "Libelle" character varying(255),
    id_speculation character varying(20) NOT NULL
);


ALTER TABLE "RefSpeculation" OWNER TO postgres;

--
-- Name: RefTypeSol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "RefTypeSol" (
    "Libelle" character varying(128),
    "id_typeSol" character varying(20) NOT NULL
);


ALTER TABLE "RefTypeSol" OWNER TO postgres;

--
-- Name: Rejet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Rejet" OWNER TO postgres;

--
-- Name: Rejet_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Rejet_parcelle" (
    id_douar integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    "Id_Rejet" integer NOT NULL
);


ALTER TABLE "Rejet_parcelle" OWNER TO postgres;

--
-- Name: Remarque; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Remarque" OWNER TO postgres;

--
-- Name: Riverain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Riverain" OWNER TO postgres;

--
-- Name: COLUMN "Riverain"."Direction"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "Riverain"."Direction" IS '
';


--
-- Name: SatRej_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "SatRej_parcelle" (
    "Id_SatRejet" integer NOT NULL,
    "Id_douar" integer NOT NULL,
    num_parcelle character varying(255) NOT NULL
);


ALTER TABLE "SatRej_parcelle" OWNER TO postgres;

--
-- Name: Satisfaction_Rejet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE "Satisfaction_Rejet" OWNER TO postgres;

--
-- Name: Type_Livraison; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Type_Livraison" (
    "Libelle_TypeLiv" character varying(128),
    "Id_TypeLiv" character varying(128) NOT NULL
);


ALTER TABLE "Type_Livraison" OWNER TO postgres;

--
-- Name: ViewPMIS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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

ALTER TABLE ONLY "ViewPMIS" REPLICA IDENTITY NOTHING;


ALTER TABLE "ViewPMIS" OWNER TO postgres;

--
-- Name: ZonesLambert; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ZonesLambert" (
    "IdZL" integer NOT NULL,
    "NomZL" character varying(255),
    "NomZL_ar" character varying(255)
);


ALTER TABLE "ZonesLambert" OWNER TO postgres;

--
-- Name: seq_type; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_type OWNER TO postgres;

--
-- Name: acte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE acte (
    id_acte integer DEFAULT nextval('seq_type'::regclass) NOT NULL,
    libelle character varying(255),
    libelle_ar character varying(255) NOT NULL,
    nature character varying(255)
);


ALTER TABLE acte OWNER TO postgres;

--
-- Name: actionmarche_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE actionmarche_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actionmarche_id_seq OWNER TO postgres;

--
-- Name: actionmarche_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE actionmarche_id_seq OWNED BY "ActionMarche"."Id";


--
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actions (
    id_action integer NOT NULL,
    nom_action character varying(500)
);


ALTER TABLE actions OWNER TO postgres;

--
-- Name: adjudicataire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE adjudicataire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adjudicataire_id_seq OWNER TO postgres;

--
-- Name: adjudicataire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE adjudicataire (
    id_adjudicataire integer DEFAULT nextval('adjudicataire_id_seq'::regclass) NOT NULL,
    lib_adjudicataire character varying(255),
    est_groupement boolean DEFAULT false NOT NULL
);


ALTER TABLE adjudicataire OWNER TO postgres;

--
-- Name: auth_action; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_action (
    id_auth_action integer NOT NULL,
    id_action integer,
    token text NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE auth_action OWNER TO postgres;

--
-- Name: auth_act_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_act_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_act_id_seq OWNER TO postgres;

--
-- Name: auth_act_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_act_id_seq OWNED BY auth_action.id_auth_action;


--
-- Name: authentification; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE authentification (
    "idUser" character varying(128),
    token text NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE authentification OWNER TO postgres;

--
-- Name: ayant_droit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE ayant_droit OWNER TO postgres;

--
-- Name: ayant_droit_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ayant_droit_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    code_droit integer NOT NULL,
    num_marche character varying(255) NOT NULL
);


ALTER TABLE ayant_droit_parcelle OWNER TO postgres;

--
-- Name: etatsynthesecad; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etatsynthesecad AS
 SELECT se."NomSE",
    se."IdSE",
    se."DateOS",
    z.id_zone,
    sz.id_sous_zone,
    sz."EstimParc",
    z.nom AS zone,
    sz.nom AS sous_zone,
    etat.execut,
    etat.synchronisecad,
    etat.declenchecad,
    etat.validcad,
    etat.rejetcad,
    etat.livrcad,
    etat.eligprcontrcf,
    etat.bornageelig,
    etat.bornagedecl,
    etat.bornageins,
    etat.bornageprg,
    etat.bornagepos,
    etat.bornageposacmjp,
    etat.bornageren,
    etat.bornagerenrej
   FROM ( SELECT d.id_sous_zone,
            sum(
                CASE
                    WHEN ((p.etat)::text <> 'Deleted'::text) THEN 1
                    ELSE 0
                END) AS execut,
            sum(
                CASE
                    WHEN (((p."EtatCAD")::text = ANY (ARRAY[('SynchCAD'::character varying)::text, ('CancelIgtCAD'::character varying)::text])) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS synchronisecad,
            sum(
                CASE
                    WHEN (((p."EtatCAD")::text = 'ValidIgtCAD'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS declenchecad,
            sum(
                CASE
                    WHEN (((p."EtatCAD")::text = 'ValidCAD'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS validcad,
            sum(
                CASE
                    WHEN (((p."EtatCAD")::text = 'RejetCAD'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS rejetcad,
            sum(
                CASE
                    WHEN ((p."Id_LivraisonCAD" <> 0) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS livrcad,
            sum(
                CASE
                    WHEN ((((p."EtatCF")::text = 'ValidIgtCF'::text) AND ((p."EtatCAD")::text = 'ValidCAD'::text)) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS eligprcontrcf,
            sum(
                CASE
                    WHEN ((((((p."EtatCAD")::text = 'ValidIgtCAD'::text) OR ((p."EtatCAD")::text = 'ValidCAD'::text)) AND (p.date_juridique IS NOT NULL)) AND (p.nb_prop <> 0)) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS bornageelig,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornageDecl'::text) THEN 1
                    ELSE 0
                END) AS bornagedecl,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornageIns'::text) THEN 1
                    ELSE 0
                END) AS bornageins,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornagePos'::text) THEN 1
                    ELSE 0
                END) AS bornagepos,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornagePosAcMJP'::text) THEN 1
                    ELSE 0
                END) AS bornageposacmjp,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornagePrg'::text) THEN 1
                    ELSE 0
                END) AS bornageprg,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornageRenRej'::text) THEN 1
                    ELSE 0
                END) AS bornagerenrej,
            sum(
                CASE
                    WHEN ((p."EtatBornage")::text = 'BornageRen'::text) THEN 1
                    ELSE 0
                END) AS bornageren
           FROM parcelle p,
            douar d
          WHERE (p.id_douar = d.id_douar)
          GROUP BY d.id_sous_zone) etat,
    sous_zone sz,
    zone z,
    ( SELECT m.id_zone,
            s."NomSE",
            s."IdSE",
            m."DateOS"
           FROM marche m,
            "ServiceExterieur" s
          WHERE (m."serviceExt" = s."IdSE")) se
  WHERE (((etat.id_sous_zone = sz.id_sous_zone) AND (sz.id_zone = z.id_zone)) AND (z.id_zone = se.id_zone));


ALTER TABLE etatsynthesecad OWNER TO postgres;

--
-- Name: barchart; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW barchart AS
 SELECT m.num_marche,
    ref."NomSE",
    ref."IdSE",
    ref.zone,
    m.id_zone,
    ref."Execute",
    ref.synchronisecad,
    ref.declenchecad,
    ref.validcad,
    ref.rejetcad,
    ref.livrcad,
    m."NbreParEstime" AS "Estime",
    m."DateOS"
   FROM ( SELECT etatsynthesecad."NomSE",
            etatsynthesecad."IdSE",
            etatsynthesecad.zone,
            etatsynthesecad.id_zone,
            sum(etatsynthesecad.execut) AS "Execute",
            sum(etatsynthesecad.synchronisecad) AS synchronisecad,
            sum(etatsynthesecad.declenchecad) AS declenchecad,
            sum(etatsynthesecad.validcad) AS validcad,
            sum(etatsynthesecad.rejetcad) AS rejetcad,
            sum(etatsynthesecad.livrcad) AS livrcad
           FROM etatsynthesecad
          GROUP BY etatsynthesecad.id_zone, etatsynthesecad.zone, etatsynthesecad."NomSE", etatsynthesecad."IdSE") ref,
    ( SELECT marche.num_marche,
            marche.id_zone,
            marche."DateOS",
            marche."NbreParEstime"
           FROM marche) m
  WHERE (ref.id_zone = m.id_zone);


ALTER TABLE barchart OWNER TO postgres;

--
-- Name: bornes_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bornes_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bornes_gid_seq OWNER TO postgres;

--
-- Name: borne; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE borne OWNER TO postgres;

--
-- Name: bornes_opposition_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bornes_opposition_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bornes_opposition_gid_seq OWNER TO postgres;

--
-- Name: borne_opposition; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE borne_opposition OWNER TO postgres;

--
-- Name: bornesparcelaire_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bornesparcelaire_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bornesparcelaire_gid_seq OWNER TO postgres;

--
-- Name: borne_parcelaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE borne_parcelaire OWNER TO postgres;

--
-- Name: referentiel; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW referentiel AS
 SELECT se."IdSE",
    m.num_marche,
    z.id_zone,
    z.nom AS zone,
    sz.id_sous_zone,
    sz.nom AS sous_zone,
    d.id_douar,
    d.nom AS douar
   FROM "ServiceExterieur" se,
    marche m,
    zone z,
    sous_zone sz,
    douar d
  WHERE ((((se."IdSE" = m."serviceExt") AND (m.id_zone = z.id_zone)) AND (z.id_zone = sz.id_zone)) AND (sz.id_sous_zone = d.id_sous_zone));


ALTER TABLE referentiel OWNER TO postgres;

--
-- Name: caddifcf; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW caddifcf AS
 SELECT r.zone,
    r.id_zone,
    r.douar,
    p.num_parcelle_def AS "Numéro_Def",
    p.id_synchronisation,
    p.nom_parcelle_fr AS "Nom_Parcelle",
    concat(p."EtatCAD", '-', p."EtatCF") AS "Etat",
        CASE
            WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN concat('@CAD: ', p."Observ_Cont_CAD")
            WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN concat('@CF: ', p."Observ_Cont_CF")
            ELSE NULL::text
        END AS motifs
   FROM referentiel r,
    parcelle p
  WHERE ((((p.etat)::text <> 'Deleted'::text) AND ((((p."EtatCAD")::text = 'ValidCAD'::text) AND ((p."EtatCF")::text = 'RejetCF'::text)) OR (((p."EtatCF")::text = 'ValidCF'::text) AND ((p."EtatCAD")::text = 'RejetCAD'::text)))) AND (p.id_douar = r.id_douar));


ALTER TABLE caddifcf OWNER TO postgres;

--
-- Name: cadrejdoc; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW cadrejdoc AS
 SELECT parc.id_zone,
    parc.zone,
    parc.douar,
    parc.num_parcelle_def AS "Numéro_Def",
    parc.nom_parcelle_fr AS "Nom_Parcelle",
    parc."EtatCAD",
    parc."Observ_Cont_CAD" AS "Observation_CAD",
    docrej.string_agg AS "Documents_Rejetés"
   FROM (( SELECT r.zone,
            r.id_zone,
            r.douar,
            p.num_parcelle_def,
            p.nom_parcelle_fr,
            p."EtatCAD",
            p."Observ_Cont_CAD",
            p.id_synchronisation
           FROM referentiel r,
            parcelle p
          WHERE ((((p.etat)::text <> 'Deleted'::text) AND ((p."EtatCAD")::text = 'RejetCAD'::text)) AND (p.id_douar = r.id_douar))) parc
     LEFT JOIN ( SELECT docparcrej."Id_Synchronisation",
            string_agg(concat(doc."Nom_Document", '(', docparcrej."DateRejet", '): ', docparcrej."DernierMotifRejet"), ', '::text) AS string_agg
           FROM ( SELECT "DocParcelle"."Id_Document",
                    "DocParcelle"."Id_Synchronisation",
                    "DocParcelle"."DernierMotifRejet",
                    "DocParcelle"."Statut",
                    "DocParcelle"."DateRejet"
                   FROM "DocParcelle"
                  WHERE (("DocParcelle"."Statut")::text = 'Rejete'::text)) docparcrej,
            ( SELECT "Document"."Id_Document",
                    "Document"."Nom_Document"
                   FROM "Document") doc
          WHERE (doc."Id_Document" = docparcrej."Id_Document")
          GROUP BY docparcrej."Id_Synchronisation") docrej ON ((parc.id_synchronisation = docrej."Id_Synchronisation")))
  ORDER BY parc.id_synchronisation;


ALTER TABLE cadrejdoc OWNER TO postgres;

--
-- Name: cfrejdoc; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW cfrejdoc AS
 SELECT parc.id_zone,
    parc.zone,
    parc.douar,
    parc.num_parcelle_def AS "Numéro_Def",
    parc.nom_parcelle_fr AS "Nom_Parcelle",
    parc."EtatCF",
    parc."Observ_Cont_CF" AS "Observation_CF",
    docrej.string_agg AS "Documents_Rejetés"
   FROM (( SELECT r.zone,
            r.id_zone,
            r.douar,
            p.num_parcelle_def,
            p.nom_parcelle_fr,
            p."EtatCF",
            p."Observ_Cont_CF",
            p.id_synchronisation
           FROM referentiel r,
            parcelle p
          WHERE ((((p.etat)::text <> 'Deleted'::text) AND ((p."EtatCF")::text = 'RejetCF'::text)) AND (p.id_douar = r.id_douar))) parc
     LEFT JOIN ( SELECT docparcrej."Id_Synchronisation",
            string_agg(concat(doc."Nom_Document", '(', docparcrej."DateRejet", '): ', docparcrej."DernierMotifRejet"), ', '::text) AS string_agg
           FROM ( SELECT "DocParcelle"."Id_Document",
                    "DocParcelle"."Id_Synchronisation",
                    "DocParcelle"."DernierMotifRejet",
                    "DocParcelle"."Statut",
                    "DocParcelle"."DateRejet"
                   FROM "DocParcelle"
                  WHERE (("DocParcelle"."Statut")::text = 'Rejete'::text)) docparcrej,
            ( SELECT "Document"."Id_Document",
                    "Document"."Nom_Document"
                   FROM "Document") doc
          WHERE (doc."Id_Document" = docparcrej."Id_Document")
          GROUP BY docparcrej."Id_Synchronisation") docrej ON ((parc.id_synchronisation = docrej."Id_Synchronisation")))
  ORDER BY parc.id_synchronisation;


ALTER TABLE cfrejdoc OWNER TO postgres;

--
-- Name: charge; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE charge (
    "CODE_charge" character varying(4) NOT NULL,
    "LIBELLE_charge" character varying(100) NOT NULL,
    "CODE_DEPOT" integer,
    "CODE_charge_OLD" character varying(4),
    CONSTRAINT "charge_CODE_charge_check" CHECK (("CODE_charge" IS NOT NULL)),
    CONSTRAINT "charge_LIBELLE_charge_check" CHECK (("LIBELLE_charge" IS NOT NULL))
);


ALTER TABLE charge OWNER TO postgres;

--
-- Name: charge_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE charge_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    code_charge character varying(4) NOT NULL
);


ALTER TABLE charge_parcelle OWNER TO postgres;

--
-- Name: collabetatsouszonecad; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW collabetatsouszonecad AS
 SELECT c."Id_Personnel" AS idcntr,
    c."Nom",
    c."Prenom",
    r.id_sous_zone,
    r.sous_zone,
    sum(
        CASE
            WHEN ((p."EtatCAD")::text = 'ValidCAD'::text) THEN 1
            ELSE 0
        END) AS validcad,
    sum(
        CASE
            WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN 1
            ELSE 0
        END) AS rejetcad
   FROM ( SELECT "CollabInterne"."Id_Personnel",
            "CollabInterne"."Id_SE",
            "CollabInterne"."Nom",
            "CollabInterne"."Prenom",
            "CollabInterne"."IdUSer",
            "CollabInterne"."Direction",
            "CollabInterne".tel
           FROM "CollabInterne"
          WHERE (("CollabInterne"."Direction")::text = 'CAD'::text)) c,
    parcelle p,
    referentiel r
  WHERE ((c."Id_Personnel" = p."IdContr_CAD") AND (p.id_douar = r.id_douar))
  GROUP BY c."Id_Personnel", r.id_sous_zone, r.sous_zone, c."Nom", c."Prenom"
  ORDER BY r.id_sous_zone;


ALTER TABLE collabetatsouszonecad OWNER TO postgres;

--
-- Name: collabetatsouszonecf; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW collabetatsouszonecf AS
 SELECT c."Id_Personnel" AS idcntr,
    c."Nom",
    c."Prenom",
    r.id_sous_zone,
    r.sous_zone,
    sum(
        CASE
            WHEN ((p."EtatCF")::text = 'ValidCF'::text) THEN 1
            ELSE 0
        END) AS validcf,
    sum(
        CASE
            WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN 1
            ELSE 0
        END) AS rejetcf
   FROM ( SELECT "CollabInterne"."Id_Personnel",
            "CollabInterne"."Id_SE",
            "CollabInterne"."Nom",
            "CollabInterne"."Prenom",
            "CollabInterne"."IdUSer",
            "CollabInterne"."Direction",
            "CollabInterne".tel
           FROM "CollabInterne"
          WHERE (("CollabInterne"."Direction")::text = 'CF'::text)) c,
    parcelle p,
    referentiel r
  WHERE ((c."Id_Personnel" = p."IdContr_CF") AND (p.id_douar = r.id_douar))
  GROUP BY c."Id_Personnel", r.id_sous_zone, r.sous_zone, c."Nom", c."Prenom"
  ORDER BY r.id_sous_zone;


ALTER TABLE collabetatsouszonecf OWNER TO postgres;

--
-- Name: consistance_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE consistance_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    "Id_Consistance" integer NOT NULL,
    "id_typeSol" character varying(20) DEFAULT 'N'::character varying NOT NULL,
    id_speculation character varying(20) DEFAULT 'N'::character varying NOT NULL
);


ALTER TABLE consistance_parcelle OWNER TO postgres;

--
-- Name: dashview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW dashview AS
 SELECT r."IdSE",
    r.num_marche,
    r.id_zone,
    r.zone,
    r.id_sous_zone,
    r.sous_zone,
    r.id_douar,
    r.douar,
    et.id_douar AS dou,
        CASE
            WHEN (et.synchronisecf IS NULL) THEN (0)::bigint
            ELSE et.synchronisecf
        END AS synchronisecf,
        CASE
            WHEN (et.synchronisecad IS NULL) THEN (0)::bigint
            ELSE et.synchronisecad
        END AS synchronisecad,
        CASE
            WHEN (et.validcf IS NULL) THEN (0)::bigint
            ELSE et.validcf
        END AS validcf,
        CASE
            WHEN (et.validigtcf IS NULL) THEN (0)::bigint
            ELSE et.validigtcf
        END AS validigtcf,
        CASE
            WHEN (et.rejetcf IS NULL) THEN (0)::bigint
            ELSE et.rejetcf
        END AS rejetcf,
        CASE
            WHEN (et.validcad IS NULL) THEN (0)::bigint
            ELSE et.validcad
        END AS validcad,
        CASE
            WHEN (et.validigtcad IS NULL) THEN (0)::bigint
            ELSE et.validigtcad
        END AS validigtcad,
        CASE
            WHEN (et.rejetcad IS NULL) THEN (0)::bigint
            ELSE et.rejetcad
        END AS rejetcad
   FROM (referentiel r
     LEFT JOIN ( SELECT p.id_douar,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = ANY (ARRAY[('SynchCF'::character varying)::text, ('CancelIgtCF'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidCF'::text) THEN 1
                    ELSE 0
                END) AS validcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidIgtCF'::text) THEN 1
                    ELSE 0
                END) AS validigtcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN 1
                    ELSE 0
                END) AS rejetcf,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = ANY (ARRAY[('SynchCAD'::character varying)::text, ('CancelIgtCAD'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidCAD'::text) THEN 1
                    ELSE 0
                END) AS validcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidIgtCAD'::text) THEN 1
                    ELSE 0
                END) AS validigtcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN 1
                    ELSE 0
                END) AS rejetcad
           FROM ( SELECT pp.id_synchronisation,
                    pp."EtatCAD",
                    pp."EtatCF",
                    pp.id_douar,
                    pp."serviceExt"
                   FROM parcelle pp
                  WHERE ((pp.etat)::text <> 'Deleted'::text)) p
          GROUP BY p.id_douar) et ON ((r.id_douar = et.id_douar)));


ALTER TABLE dashview OWNER TO postgres;

--
-- Name: detail_acte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE detail_acte (
    id_acte integer NOT NULL,
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255)
);


ALTER TABLE detail_acte OWNER TO postgres;

--
-- Name: droit_reel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE droit_reel (
    droit_reel character varying(3) NOT NULL,
    "LIBELLE" character varying(50) NOT NULL,
    "CODE_DROIT" integer NOT NULL
);


ALTER TABLE droit_reel OWNER TO postgres;

--
-- Name: enqueteur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE enqueteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enqueteur_id_seq OWNER TO postgres;

--
-- Name: enqueteur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE enqueteur_id_seq OWNED BY "Collaborateur".id;


--
-- Name: etat_bornage_positif; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etat_bornage_positif AS
 SELECT "ServiceExterieur"."NomSE" AS service,
    "ServiceExterieur"."IdSE" AS id_service,
    zone.id_zone,
    marche.num_marche,
    (date_part('year'::text, parcelle.date_prg_bornage))::integer AS annee,
    (date_part('month'::text, parcelle.date_prg_bornage))::integer AS mois,
    count(
        CASE
            WHEN (((parcelle."EtatBornage")::text = 'BornagePos'::text) OR ((parcelle."EtatBornage")::text = 'BornagePosAcMJP'::text)) THEN 1
            ELSE NULL::integer
        END) AS nbre_parc_bp,
    count(
        CASE
            WHEN ((parcelle."EtatBornage")::text = 'BornagePrg'::text) THEN 1
            ELSE NULL::integer
        END) AS nbre_parc_prg
   FROM (((((parcelle
     JOIN douar ON ((douar.id_douar = parcelle.id_douar)))
     JOIN sous_zone ON ((sous_zone.id_sous_zone = douar.id_sous_zone)))
     JOIN zone ON ((zone.id_zone = sous_zone.id_zone)))
     JOIN marche ON ((marche.id_zone = zone.id_zone)))
     JOIN "ServiceExterieur" ON (("ServiceExterieur"."IdSE" = marche."serviceExt")))
  WHERE ((parcelle.date_prg_bornage <> '0001-01-01 00:00:00'::timestamp without time zone) AND ((parcelle."EtatBornage")::text = ANY (ARRAY[('BornagePos'::character varying)::text, ('BornagePosAcMJP'::character varying)::text, ('BornagePrg'::character varying)::text])))
  GROUP BY "ServiceExterieur"."NomSE", "ServiceExterieur"."IdSE", zone.id_zone, marche.num_marche, date_part('month'::text, parcelle.date_prg_bornage), date_part('year'::text, parcelle.date_prg_bornage);


ALTER TABLE etat_bornage_positif OWNER TO postgres;

--
-- Name: etat_par_parcelle; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etat_par_parcelle AS
 SELECT p.num_parcelle_def,
    p."EtatCAD",
    p."EtatCF",
    p.id_douar,
    r.id_zone,
    r.num_marche,
    r.douar,
    r.sous_zone,
    r.idd
   FROM (( SELECT parcelle.num_parcelle_def,
            parcelle."EtatCAD",
            parcelle."EtatCF",
            parcelle.id_douar
           FROM parcelle
          WHERE ((parcelle.num_parcelle_def)::text <> 'NEANT'::text)) p
     JOIN ( SELECT referentiel.id_zone,
            referentiel.num_marche,
            referentiel.douar,
            referentiel.sous_zone,
            referentiel.id_douar AS idd
           FROM referentiel) r ON ((p.id_douar = r.idd)))
  ORDER BY r.num_marche, r.sous_zone, r.douar, p.num_parcelle_def, p."EtatCAD", p."EtatCF";


ALTER TABLE etat_par_parcelle OWNER TO postgres;

--
-- Name: etat_parcelle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE etat_parcelle_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE etat_parcelle_id_seq OWNER TO postgres;

--
-- Name: etat_parcelle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE etat_parcelle_id_seq OWNED BY "Etat_Parcelle"."Id_Etat";


--
-- Name: etatcollabcad; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etatcollabcad AS
 SELECT c."Id_Personnel" AS idcntr,
    c."Nom",
    c."Prenom",
    r.id_zone,
    sum(
        CASE
            WHEN ((p."EtatCAD")::text = 'ValidCAD'::text) THEN 1
            ELSE 0
        END) AS validcad,
    sum(
        CASE
            WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN 1
            ELSE 0
        END) AS rejetcad
   FROM ( SELECT "CollabInterne"."Id_Personnel",
            "CollabInterne"."Id_SE",
            "CollabInterne"."Nom",
            "CollabInterne"."Prenom",
            "CollabInterne"."IdUSer",
            "CollabInterne"."Direction",
            "CollabInterne".tel
           FROM "CollabInterne"
          WHERE (("CollabInterne"."Direction")::text = 'CAD'::text)) c,
    parcelle p,
    referentiel r
  WHERE ((c."Id_Personnel" = p."IdContr_CAD") AND (p.id_douar = r.id_douar))
  GROUP BY c."Id_Personnel", r.id_zone, c."Nom", c."Prenom"
  ORDER BY c."Id_Personnel";


ALTER TABLE etatcollabcad OWNER TO postgres;

--
-- Name: etatcollabcf; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etatcollabcf AS
 SELECT c."Id_Personnel" AS idcntr,
    c."Nom",
    c."Prenom",
    r.id_zone,
    sum(
        CASE
            WHEN ((p."EtatCF")::text = 'ValidCF'::text) THEN 1
            ELSE 0
        END) AS validcf,
    sum(
        CASE
            WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN 1
            ELSE 0
        END) AS rejetcf
   FROM ( SELECT "CollabInterne"."Id_Personnel",
            "CollabInterne"."Id_SE",
            "CollabInterne"."Nom",
            "CollabInterne"."Prenom",
            "CollabInterne"."IdUSer",
            "CollabInterne"."Direction",
            "CollabInterne".tel
           FROM "CollabInterne"
          WHERE (("CollabInterne"."Direction")::text = 'CF'::text)) c,
    parcelle p,
    referentiel r
  WHERE ((c."Id_Personnel" = p."IdContr_CF") AND (p.id_douar = r.id_douar))
  GROUP BY c."Id_Personnel", r.id_zone, c."Nom", c."Prenom"
  ORDER BY c."Id_Personnel";


ALTER TABLE etatcollabcf OWNER TO postgres;

--
-- Name: etatsynthesecf; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW etatsynthesecf AS
 SELECT se."NomSE",
    se."IdSE",
    se."DateOS",
    z.id_zone,
    sz.id_sous_zone,
    sz."EstimParc",
    z.nom AS zone,
    sz.nom AS sous_zone,
    etat.execut,
    etat.synchronisecf,
    etat.declenchecf,
    etat.validcf,
    etat.rejetcf,
    etat.livrcf,
    etat.eligprcontrcf
   FROM ( SELECT d.id_sous_zone,
            sum(
                CASE
                    WHEN ((p.etat)::text <> 'Deleted'::text) THEN 1
                    ELSE 0
                END) AS execut,
            sum(
                CASE
                    WHEN (((p."EtatCF")::text = ANY (ARRAY[('SynchCF'::character varying)::text, ('CancelIgtCF'::character varying)::text])) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS synchronisecf,
            sum(
                CASE
                    WHEN (((p."EtatCF")::text = 'ValidIgtCF'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS declenchecf,
            sum(
                CASE
                    WHEN (((p."EtatCF")::text = 'ValidCF'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS validcf,
            sum(
                CASE
                    WHEN (((p."EtatCF")::text = 'RejetCF'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS rejetcf,
            sum(
                CASE
                    WHEN ((p."Id_LivraisonCF" <> 0) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS livrcf,
            sum(
                CASE
                    WHEN ((((p."EtatCF")::text = 'ValidIgtCF'::text) AND ((p."EtatCAD")::text = 'ValidCAD'::text)) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
                    ELSE 0
                END) AS eligprcontrcf
           FROM parcelle p,
            douar d
          WHERE (p.id_douar = d.id_douar)
          GROUP BY d.id_sous_zone) etat,
    sous_zone sz,
    zone z,
    ( SELECT m.id_zone,
            s."NomSE",
            s."IdSE",
            m."DateOS"
           FROM marche m,
            "ServiceExterieur" s
          WHERE (m."serviceExt" = s."IdSE")) se
  WHERE (((etat.id_sous_zone = sz.id_sous_zone) AND (sz.id_zone = z.id_zone)) AND (z.id_zone = se.id_zone));


ALTER TABLE etatsynthesecf OWNER TO postgres;

--
-- Name: fourcats; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fourcats AS
 SELECT "Categorie_Document"."Libelle_Categorie",
    "Categorie_Document"."Code_Categorie",
    "Categorie_Document"."Type",
    "Categorie_Document"."Obligatoire"
   FROM "Categorie_Document"
  WHERE (("Categorie_Document"."Code_Categorie")::text = ANY (ARRAY[('ACTE_NOTORIETE'::character varying)::text, ('IF1'::character varying)::text, ('PV_AQUIESSEMNT'::character varying)::text, ('MINUTE_PV_Parc'::character varying)::text]));


ALTER TABLE fourcats OWNER TO postgres;

--
-- Name: groupe_proprietaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groupe_proprietaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groupe_proprietaire_id_seq OWNER TO postgres;

--
-- Name: groupe_proprietaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE groupe_proprietaire (
    num_ordre integer DEFAULT nextval('groupe_proprietaire_id_seq'::regclass) NOT NULL,
    concat_cins text
);


ALTER TABLE groupe_proprietaire OWNER TO postgres;

--
-- Name: groupement_igt; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE groupement_igt (
    id_adjudicataire integer NOT NULL,
    id_igt integer NOT NULL,
    est_mandataire boolean DEFAULT false NOT NULL
);


ALTER TABLE groupement_igt OWNER TO postgres;

--
-- Name: id_document_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_document_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_document_seq OWNER TO postgres;

--
-- Name: id_document_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE id_document_seq OWNED BY "Document"."Id_Document";


--
-- Name: id_etat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_etat_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_etat_seq OWNER TO postgres;

--
-- Name: id_etat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE id_etat_seq OWNED BY "Etat_Document"."Id_Etat";


--
-- Name: id_igt_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_igt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_igt_seq OWNER TO postgres;

--
-- Name: id_livraison_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_livraison_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_livraison_seq OWNER TO postgres;

--
-- Name: id_livraison_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE id_livraison_seq OWNED BY "Livraison"."Id_Livraison";


--
-- Name: id_prepmarche_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_prepmarche_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_prepmarche_seq OWNER TO postgres;

--
-- Name: id_prepmarche_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE id_prepmarche_seq OWNED BY "Prep_Marche"."Id_PrepMarche";


--
-- Name: id_satrejet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_satrejet_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_satrejet_seq OWNER TO postgres;

--
-- Name: id_satrejet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE id_satrejet_seq OWNED BY "Satisfaction_Rejet"."Id_SatRejet";


--
-- Name: id_situation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE id_situation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE id_situation_seq OWNER TO postgres;

--
-- Name: igt; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE igt OWNER TO postgres;

--
-- Name: synchronisation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE synchronisation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE synchronisation_id_seq OWNER TO postgres;

--
-- Name: synchronisation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE synchronisation OWNER TO postgres;

--
-- Name: linechart; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW linechart AS
 SELECT sx."IdSE",
    sx.num_marche,
    sx.id_zone,
    sx.zone,
        CASE
            WHEN (sx.date IS NULL) THEN (((now())::timestamp without time zone)::date)::character varying
            ELSE (sx.date)::character varying
        END AS date,
        CASE
            WHEN (sum(sx.synchs) IS NULL) THEN (0)::numeric
            ELSE sum(sx.synchs)
        END AS synchs
   FROM ( SELECT r."IdSE",
            r.num_marche,
            r.zone,
            r.id_zone,
            r.id_douar,
            synch.date,
            synch.synchs
           FROM (referentiel r
             LEFT JOIN ( SELECT synchronisation.id_douar,
                    (synchronisation.date)::date AS date,
                    count(*) AS synchs
                   FROM synchronisation
                  GROUP BY (synchronisation.date)::date, synchronisation.id_douar
                  ORDER BY (synchronisation.date)::date) synch ON ((synch.id_douar = r.id_douar)))) sx
  GROUP BY sx.zone, sx.id_zone, sx.date, sx.num_marche, sx."IdSE"
  ORDER BY (sx.date)::character varying;


ALTER TABLE linechart OWNER TO postgres;

--
-- Name: opposant; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE opposant OWNER TO postgres;

--
-- Name: opposant_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE opposant_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    acte character varying(255),
    date_acte character varying(10),
    num_marche character varying(255) NOT NULL
);


ALTER TABLE opposant_parcelle OWNER TO postgres;

--
-- Name: ovtable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ovtable AS
 SELECT se."NomSE",
    se."IdSE",
    et.annee,
        CASE
            WHEN (et.synchronisecf IS NULL) THEN (0)::bigint
            ELSE et.synchronisecf
        END AS synchronisecf,
        CASE
            WHEN (et.synchronisecad IS NULL) THEN (0)::bigint
            ELSE et.synchronisecad
        END AS synchronisecad,
        CASE
            WHEN (et.validcf IS NULL) THEN (0)::bigint
            ELSE et.validcf
        END AS validcf,
        CASE
            WHEN (et.validigtcf IS NULL) THEN (0)::bigint
            ELSE et.validigtcf
        END AS validigtcf,
        CASE
            WHEN (et.rejetcf IS NULL) THEN (0)::bigint
            ELSE et.rejetcf
        END AS rejetcf,
        CASE
            WHEN (et.validcad IS NULL) THEN (0)::bigint
            ELSE et.validcad
        END AS validcad,
        CASE
            WHEN (et.validigtcad IS NULL) THEN (0)::bigint
            ELSE et.validigtcad
        END AS validigtcad,
        CASE
            WHEN (et.rejetcad IS NULL) THEN (0)::bigint
            ELSE et.rejetcad
        END AS rejetcad
   FROM (( SELECT "ServiceExterieur"."IdSE",
            "ServiceExterieur"."NomSE"
           FROM "ServiceExterieur"
          WHERE (("ServiceExterieur".mail_cad IS NOT NULL) AND ("ServiceExterieur".mail_cf IS NOT NULL))) se
     LEFT JOIN ( SELECT p."serviceExt",
            p.annee,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = ANY (ARRAY[('SynchCF'::character varying)::text, ('CancelIgtCF'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidCF'::text) THEN 1
                    ELSE 0
                END) AS validcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'ValidIgtCF'::text) THEN 1
                    ELSE 0
                END) AS validigtcf,
            sum(
                CASE
                    WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN 1
                    ELSE 0
                END) AS rejetcf,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = ANY (ARRAY[('SynchCAD'::character varying)::text, ('CancelIgtCAD'::character varying)::text])) THEN 1
                    ELSE 0
                END) AS synchronisecad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidCAD'::text) THEN 1
                    ELSE 0
                END) AS validcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'ValidIgtCAD'::text) THEN 1
                    ELSE 0
                END) AS validigtcad,
            sum(
                CASE
                    WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN 1
                    ELSE 0
                END) AS rejetcad
           FROM ( SELECT za.annee,
                    za.id_zone,
                    za."serviceExt",
                    p1.id_synchronisation,
                    p1."EtatCAD",
                    p1."EtatCF"
                   FROM (( SELECT split_part((marche.num_marche)::text, '/'::text, 2) AS annee,
                            marche.id_zone,
                            marche."serviceExt"
                           FROM marche) za
                     LEFT JOIN ( SELECT pp.id_synchronisation,
                            pp."EtatCAD",
                            pp."EtatCF",
                            d.id_zone,
                            pp."serviceExt"
                           FROM referentiel d,
                            parcelle pp
                          WHERE ((pp.id_douar = d.id_douar) AND ((pp.etat)::text <> 'Deleted'::text))) p1 ON ((p1.id_zone = za.id_zone)))) p
          GROUP BY p."serviceExt", p.annee) et ON ((et."serviceExt" = se."IdSE")))
  WHERE (et.annee IS NOT NULL)
  ORDER BY (((et.synchronisecad + et.validcad) + et.validigtcad) + et.rejetcad);


ALTER TABLE ovtable OWNER TO postgres;

--
-- Name: parcelaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE parcelaire OWNER TO postgres;

--
-- Name: parcelle_motifrejet; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE parcelle_motifrejet (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    id_motif integer NOT NULL,
    initiateur character varying(128),
    statut boolean
);


ALTER TABLE parcelle_motifrejet OWNER TO postgres;

--
-- Name: parcpvbornagev; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW parcpvbornagev AS
 SELECT parc.zone,
    parc.id_zone,
    parc.douar,
    parc."Numéro_Def",
    parc.id_synchronisation,
    parc."Nom_Parcelle",
    parc."Etat",
    parc.motifs
   FROM (( SELECT r.zone,
            r.id_zone,
            r.douar,
            p.num_parcelle_def AS "Numéro_Def",
            p.id_synchronisation,
            p.nom_parcelle_fr AS "Nom_Parcelle",
            concat(p."EtatCAD", '-', p."EtatCF") AS "Etat",
                CASE
                    WHEN ((p."EtatCAD")::text = 'RejetCAD'::text) THEN concat('@CAD: ', p."Observ_Cont_CAD")
                    WHEN ((p."EtatCF")::text = 'RejetCF'::text) THEN concat('@CF: ', p."Observ_Cont_CF")
                    ELSE NULL::text
                END AS motifs
           FROM referentiel r,
            parcelle p
          WHERE (((p.etat)::text <> 'Deleted'::text) AND (p.id_douar = r.id_douar))) parc
     LEFT JOIN ( SELECT docparcrej."Id_Document",
            docparcrej."Id_Synchronisation",
            docparcrej."DernierMotifRejet",
            docparcrej."Statut",
            docparcrej."DateRejet",
            doc."Nom_Document"
           FROM ( SELECT "DocParcelle"."Id_Document",
                    "DocParcelle"."Id_Synchronisation",
                    "DocParcelle"."DernierMotifRejet",
                    "DocParcelle"."Statut",
                    "DocParcelle"."DateRejet"
                   FROM "DocParcelle"
                  WHERE (("DocParcelle"."Statut")::text = 'Valide'::text)) docparcrej,
            ( SELECT "Document"."Id_Document",
                    "Document"."Nom_Document"
                   FROM "Document"
                  WHERE (("Document"."Categorie_Document")::text = 'PV_Jur'::text)) doc
          WHERE (doc."Id_Document" = docparcrej."Id_Document")) docrej ON ((parc.id_synchronisation = docrej."Id_Synchronisation")))
  ORDER BY parc.id_synchronisation;


ALTER TABLE parcpvbornagev OWNER TO postgres;

--
-- Name: parcst228rej; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW parcst228rej AS
 SELECT parc.zone,
    parc.id_zone,
    parc.douar,
    parc."Numéro_Def",
    parc.id_synchronisation,
    parc."Nom_Parcelle",
    parc."Etat",
    docrej."Id_Document",
    docrej."Id_Synchronisation",
    docrej."DernierMotifRejet",
    docrej."Statut",
    docrej."DateRejet",
    docrej."Nom_Document",
    docrej."DernierMotifRejet" AS "Dernier_Motif_Rejet"
   FROM (( SELECT r.zone,
            r.id_zone,
            r.douar,
            p.num_parcelle_def AS "Numéro_Def",
            p.id_synchronisation,
            p.nom_parcelle_fr AS "Nom_Parcelle",
            concat(p."EtatCAD", '-', p."EtatCF") AS "Etat"
           FROM referentiel r,
            parcelle p
          WHERE (((p.etat)::text <> 'Deleted'::text) AND (p.id_douar = r.id_douar))) parc
     LEFT JOIN ( SELECT docparcrej."Id_Document",
            docparcrej."Id_Synchronisation",
            docparcrej."DernierMotifRejet",
            docparcrej."Statut",
            docparcrej."DateRejet",
            doc."Nom_Document"
           FROM ( SELECT "DocParcelle"."Id_Document",
                    "DocParcelle"."Id_Synchronisation",
                    "DocParcelle"."DernierMotifRejet",
                    "DocParcelle"."Statut",
                    "DocParcelle"."DateRejet"
                   FROM "DocParcelle"
                  WHERE (("DocParcelle"."Statut")::text = 'Rejete'::text)) docparcrej,
            ( SELECT "Document"."Id_Document",
                    "Document"."Nom_Document"
                   FROM "Document"
                  WHERE (("Document"."Categorie_Document")::text = ANY (ARRAY[('ST284_PARC'::character varying)::text, ('ST284_RNB'::character varying)::text]))) doc
          WHERE (doc."Id_Document" = docparcrej."Id_Document")) docrej ON ((parc.id_synchronisation = docrej."Id_Synchronisation")))
  ORDER BY parc.id_synchronisation;


ALTER TABLE parcst228rej OWNER TO postgres;

--
-- Name: personne; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE personne OWNER TO postgres;

--
-- Name: presume; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE presume OWNER TO postgres;

--
-- Name: presume_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE presume_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    lieu_correspondance text,
    num_marche character varying(255) NOT NULL
);


ALTER TABLE presume_parcelle OWNER TO postgres;

--
-- Name: proprietaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE proprietaire OWNER TO postgres;

--
-- Name: proprietaire_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE proprietaire_parcelle OWNER TO postgres;

--
-- Name: proprietaire_presume; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE proprietaire_presume (
    cin character varying(255) NOT NULL,
    ordre integer
);


ALTER TABLE proprietaire_presume OWNER TO postgres;

--
-- Name: riverain_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE riverain_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE riverain_seq OWNER TO postgres;

--
-- Name: riverain_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE riverain_seq OWNED BY "Riverain"."Id_Riverain";


--
-- Name: seq_ayant_droit_parcelle; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_ayant_droit_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_ayant_droit_parcelle OWNER TO postgres;

--
-- Name: seq_gid_parcelaire; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_gid_parcelaire
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_gid_parcelaire OWNER TO postgres;

--
-- Name: seq_id_consistance; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_id_consistance
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_id_consistance OWNER TO postgres;

--
-- Name: seq_id_consistance; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_id_consistance OWNED BY "RefConsistances"."Id_Consistance";


--
-- Name: seq_idcercle; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idcercle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idcercle OWNER TO postgres;

--
-- Name: seq_idcercle; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idcercle OWNED BY "Cercle"."IdCercle";


--
-- Name: seq_idcommune; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idcommune
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idcommune OWNER TO postgres;

--
-- Name: seq_idcommune; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idcommune OWNED BY "Commune"."IdCommune";


--
-- Name: seq_idpersonnel; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idpersonnel
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idpersonnel OWNER TO postgres;

--
-- Name: seq_idpersonnel; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idpersonnel OWNED BY "CollabInterne"."Id_Personnel";


--
-- Name: seq_idprovince; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idprovince
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idprovince OWNER TO postgres;

--
-- Name: seq_idprovince; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idprovince OWNED BY "Province"."IdProvince";


--
-- Name: seq_idrejet; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idrejet
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idrejet OWNER TO postgres;

--
-- Name: seq_idrejet; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idrejet OWNED BY "Rejet"."Id_Rejet";


--
-- Name: seq_idremarque; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idremarque
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idremarque OWNER TO postgres;

--
-- Name: seq_idremarque; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idremarque OWNED BY "Remarque"."Id_rq";


--
-- Name: seq_idriverain; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_idriverain
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_idriverain OWNER TO postgres;

--
-- Name: seq_idriverain; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seq_idriverain OWNED BY "Riverain"."Id_Riverain";


--
-- Name: seq_opposant_parcelle; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_opposant_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_opposant_parcelle OWNER TO postgres;

--
-- Name: seq_parcelle_personne; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_parcelle_personne
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_parcelle_personne OWNER TO postgres;

--
-- Name: seq_temoin_parcelle; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_temoin_parcelle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_temoin_parcelle OWNER TO postgres;

--
-- Name: situation_quotidienne; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE situation_quotidienne OWNER TO postgres;

--
-- Name: COLUMN situation_quotidienne.id_sous_zone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN situation_quotidienne.id_sous_zone IS '
';


--
-- Name: synth_etat_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE synth_etat_parcelle (
    nom character varying(255),
    id_zone integer,
    "DateOS" date,
    rejcad bigint,
    rejcf bigint,
    rejst228 bigint,
    caddifcf bigint
);

ALTER TABLE ONLY synth_etat_parcelle REPLICA IDENTITY NOTHING;


ALTER TABLE synth_etat_parcelle OWNER TO postgres;

--
-- Name: temoin; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temoin OWNER TO postgres;

--
-- Name: temoin_parcelle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temoin_parcelle (
    num_parcelle character varying(255) NOT NULL,
    id_douar integer NOT NULL,
    cin character varying(255) NOT NULL,
    num_marche character varying(255) NOT NULL
);


ALTER TABLE temoin_parcelle OWNER TO postgres;

--
-- Name: temp_ayant_droit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temp_ayant_droit OWNER TO postgres;

--
-- Name: temp_ayant_droit_matching; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_ayant_droit_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);


ALTER TABLE temp_ayant_droit_matching OWNER TO postgres;

--
-- Name: temp_opposant; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temp_opposant OWNER TO postgres;

--
-- Name: temp_opposant_matching; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_opposant_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);


ALTER TABLE temp_opposant_matching OWNER TO postgres;

--
-- Name: temp_presume; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temp_presume OWNER TO postgres;

--
-- Name: temp_presume_matching; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_presume_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);


ALTER TABLE temp_presume_matching OWNER TO postgres;

--
-- Name: temp_proprietaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temp_proprietaire OWNER TO postgres;

--
-- Name: temp_proprietaire_matching; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_proprietaire_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);


ALTER TABLE temp_proprietaire_matching OWNER TO postgres;

--
-- Name: temp_temoin; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

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


ALTER TABLE temp_temoin OWNER TO postgres;

--
-- Name: temp_temoin_matching; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_temoin_matching (
    cin character varying(255),
    id_douar integer,
    num_parcelle character varying(255),
    num_marche character varying(255)
);


ALTER TABLE temp_temoin_matching OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tokens_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO postgres;

--
-- Name: view_collab_access; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_collab_access AS
 SELECT marche.num_marche,
    c.id AS id_collab,
    marche.id_zone,
    sous_zone.id_sous_zone,
    douar.id_douar,
    c."idUser" AS "Id",
    marche."serviceExt",
    c.id_igt
   FROM ((((marche
     JOIN "CollabExterne_marche" cm ON (((cm.num_marche)::text = (marche.num_marche)::text)))
     JOIN "Collaborateur" c ON ((c.id = cm.id_collab)))
     JOIN sous_zone ON ((sous_zone.id_zone = marche.id_zone)))
     JOIN douar ON ((sous_zone.id_sous_zone = douar.id_sous_zone)))
  WHERE ((marche."APDVal" = true) AND (marche."PrgExecVal" = true))
  ORDER BY marche.num_marche;


ALTER TABLE view_collab_access OWNER TO postgres;

--
-- Name: view_igt_access; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_igt_access AS
 SELECT marche.num_marche,
    igt.id AS id_igt,
    groupement_igt.est_mandataire,
    marche.id_zone,
    sous_zone.id_sous_zone,
    douar.id_douar,
    igt."idUser" AS "Id",
    marche."serviceExt"
   FROM (((((marche
     JOIN adjudicataire ON ((marche.id_adj = adjudicataire.id_adjudicataire)))
     JOIN groupement_igt ON ((adjudicataire.id_adjudicataire = groupement_igt.id_adjudicataire)))
     JOIN igt ON ((igt.id = groupement_igt.id_igt)))
     JOIN sous_zone ON ((sous_zone.id_zone = marche.id_zone)))
     JOIN douar ON ((sous_zone.id_sous_zone = douar.id_sous_zone)))
  WHERE ((marche."APDVal" = true) AND (marche."PrgExecVal" = true))
  ORDER BY marche.num_marche;


ALTER TABLE view_igt_access OWNER TO postgres;

--
-- Name: view_igt_marche; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_igt_marche AS
 SELECT marche.num_marche,
    igt.id AS id_igt,
    groupement_igt.est_mandataire,
    marche.id_zone
   FROM (((marche
     JOIN adjudicataire ON ((marche.id_adj = adjudicataire.id_adjudicataire)))
     JOIN groupement_igt ON ((adjudicataire.id_adjudicataire = groupement_igt.id_adjudicataire)))
     JOIN igt ON ((igt.id = groupement_igt.id_igt)));


ALTER TABLE view_igt_marche OWNER TO postgres;

--
-- Name: vt; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vt AS
 SELECT "Etat_Parcelle"."Id_Parcelle",
    "Etat_Parcelle"."Action",
    max("Etat_Parcelle"."DateAction") AS "DateAction"
   FROM "Etat_Parcelle"
  WHERE (("Etat_Parcelle"."Action")::text = ANY (ARRAY[('ValidationParcCAD'::character varying)::text, ('DeclencherContCF'::character varying)::text, ('ValidationParcCF'::character varying)::text, ('RejetParcCF'::character varying)::text]))
  GROUP BY "Etat_Parcelle"."Id_Parcelle", "Etat_Parcelle"."Action"
  ORDER BY "Etat_Parcelle"."Id_Parcelle", "Etat_Parcelle"."Action";


ALTER TABLE vt OWNER TO postgres;

--
-- Name: zoneetatcf; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW zoneetatcf AS
 SELECT etatsynthesecf.id_zone,
    etatsynthesecf.zone,
    etatsynthesecf."IdSE",
    sum(etatsynthesecf.execut) AS execut,
    sum(etatsynthesecf.synchronisecf) AS synchronisecf,
    sum(etatsynthesecf.declenchecf) AS declenchecf,
    sum(etatsynthesecf.validcf) AS validcf,
    sum(etatsynthesecf.rejetcf) AS rejetcf,
    sum(etatsynthesecf.livrcf) AS livrcf
   FROM etatsynthesecf
  GROUP BY etatsynthesecf."IdSE", etatsynthesecf.id_zone, etatsynthesecf.zone
  ORDER BY etatsynthesecf.id_zone;


ALTER TABLE zoneetatcf OWNER TO postgres;

--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActionMarche" ALTER COLUMN "Id" SET DEFAULT nextval('actionmarche_id_seq'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUserClaims" ALTER COLUMN "Id" SET DEFAULT nextval('"AspNetUserClaims_Id_seq"'::regclass);


--
-- Name: IdCercle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cercle" ALTER COLUMN "IdCercle" SET DEFAULT nextval('seq_idcercle'::regclass);


--
-- Name: Id_Personnel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabInterne" ALTER COLUMN "Id_Personnel" SET DEFAULT nextval('seq_idpersonnel'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Collaborateur" ALTER COLUMN id SET DEFAULT nextval('enqueteur_id_seq'::regclass);


--
-- Name: IdCommune; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Commune" ALTER COLUMN "IdCommune" SET DEFAULT nextval('seq_idcommune'::regclass);


--
-- Name: Id_Document; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Document" ALTER COLUMN "Id_Document" SET DEFAULT nextval('id_document_seq'::regclass);


--
-- Name: Id_Etat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Etat_Document" ALTER COLUMN "Id_Etat" SET DEFAULT nextval('id_etat_seq'::regclass);


--
-- Name: Id_Etat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Etat_Parcelle" ALTER COLUMN "Id_Etat" SET DEFAULT nextval('etat_parcelle_id_seq'::regclass);


--
-- Name: Id_Livraison; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Livraison" ALTER COLUMN "Id_Livraison" SET DEFAULT nextval('id_livraison_seq'::regclass);


--
-- Name: Id_PrepMarche; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Prep_Marche" ALTER COLUMN "Id_PrepMarche" SET DEFAULT nextval('id_prepmarche_seq'::regclass);


--
-- Name: IdProvince; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Province" ALTER COLUMN "IdProvince" SET DEFAULT nextval('seq_idprovince'::regclass);


--
-- Name: Id_Consistance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RefConsistances" ALTER COLUMN "Id_Consistance" SET DEFAULT nextval('seq_id_consistance'::regclass);


--
-- Name: Id_Rejet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rejet" ALTER COLUMN "Id_Rejet" SET DEFAULT nextval('seq_idrejet'::regclass);


--
-- Name: Id_rq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Remarque" ALTER COLUMN "Id_rq" SET DEFAULT nextval('seq_idremarque'::regclass);


--
-- Name: Id_Riverain; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Riverain" ALTER COLUMN "Id_Riverain" SET DEFAULT nextval('seq_idriverain'::regclass);


--
-- Name: Id_SatRejet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Satisfaction_Rejet" ALTER COLUMN "Id_SatRejet" SET DEFAULT nextval('id_satrejet_seq'::regclass);


--
-- Name: id_auth_action; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_action ALTER COLUMN id_auth_action SET DEFAULT nextval('auth_act_id_seq'::regclass);


--
-- Name: ActionMarche_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ActionMarche"
    ADD CONSTRAINT "ActionMarche_pkey1" PRIMARY KEY ("Id");


--
-- Name: Action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Action"
    ADD CONSTRAINT "Action_pkey" PRIMARY KEY ("CodeAction");


--
-- Name: AspNetRoles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AspNetRoles"
    ADD CONSTRAINT "AspNetRoles_pkey" PRIMARY KEY ("Id");


--
-- Name: AspNetUserClaims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AspNetUserClaims"
    ADD CONSTRAINT "AspNetUserClaims_pkey" PRIMARY KEY ("Id");


--
-- Name: AspNetUserLogins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AspNetUserLogins"
    ADD CONSTRAINT "AspNetUserLogins_pkey" PRIMARY KEY ("UserId", "LoginProvider", "ProviderKey");


--
-- Name: AspNetUserRoles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "AspNetUserRoles_pkey" PRIMARY KEY ("UserId", "RoleId");


--
-- Name: AspNetUsers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "AspNetUsers"
    ADD CONSTRAINT "AspNetUsers_pkey" PRIMARY KEY ("Id");


--
-- Name: Categorie_Document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Categorie_Document"
    ADD CONSTRAINT "Categorie_Document_pkey" PRIMARY KEY ("Code_Categorie");


--
-- Name: Cercle_NomCercle_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "Cercle_NomCercle_key" UNIQUE ("NomCercle");


--
-- Name: CollabExterne_marche_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT "CollabExterne_marche_pkey" PRIMARY KEY (id_collab, num_marche);


--
-- Name: Commune_NomCommune_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "Commune_NomCommune_key" UNIQUE ("NomCommune");


--
-- Name: Consistances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "RefConsistances"
    ADD CONSTRAINT "Consistances_pkey" PRIMARY KEY ("Id_Consistance");


--
-- Name: Geoife_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Geoife"
    ADD CONSTRAINT "Geoife_pkey" PRIMARY KEY ("Id_Version");


--
-- Name: Nom_Douar_Unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY douar
    ADD CONSTRAINT "Nom_Douar_Unique" UNIQUE (nom);


--
-- Name: Opposition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Opposition"
    ADD CONSTRAINT "Opposition_pkey" PRIMARY KEY (id_douar, num_parcelle, indice);


--
-- Name: PK_BL; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "BienLimitrophe"
    ADD CONSTRAINT "PK_BL" PRIMARY KEY ("Id_Riverain");


--
-- Name: PK_Caidat; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Caidat"
    ADD CONSTRAINT "PK_Caidat" PRIMARY KEY ("IdCaidat");


--
-- Name: PK_Categorie; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Categorie"
    ADD CONSTRAINT "PK_Categorie" PRIMARY KEY ("IdCategorie");


--
-- Name: PK_Cercle; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "PK_Cercle" PRIMARY KEY ("IdCercle");


--
-- Name: PK_CollabInterne; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "PK_CollabInterne" PRIMARY KEY ("Id_Personnel", "Num_Marche");


--
-- Name: PK_Commune; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "PK_Commune" PRIMARY KEY ("IdCommune");


--
-- Name: PK_DocCommun; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "PK_DocCommun" PRIMARY KEY ("Id_Document");


--
-- Name: PK_DocMarche; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "PK_DocMarche" PRIMARY KEY ("Id_Document");


--
-- Name: PK_DocParcelle; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "PK_DocParcelle" PRIMARY KEY ("Id_Document");


--
-- Name: PK_Document; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Document"
    ADD CONSTRAINT "PK_Document" PRIMARY KEY ("Id_Document");


--
-- Name: PK_Etat_Doc; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Etat_Document"
    ADD CONSTRAINT "PK_Etat_Doc" PRIMARY KEY ("Id_Etat");


--
-- Name: PK_Etat_Parcelle; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "PK_Etat_Parcelle" PRIMARY KEY ("Id_Etat");


--
-- Name: PK_LN; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "PK_LN" PRIMARY KEY ("Id_Riverain");


--
-- Name: PK_Livraison; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "PK_Livraison" PRIMARY KEY ("Id_Livraison");


--
-- Name: PK_Notif; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Notification"
    ADD CONSTRAINT "PK_Notif" PRIMARY KEY ("id_Notif");


--
-- Name: PK_PROPMOR; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Prop_morale"
    ADD CONSTRAINT "PK_PROPMOR" PRIMARY KEY ("Id_Riverain");


--
-- Name: PK_PROPPH; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Prop_physique"
    ADD CONSTRAINT "PK_PROPPH" PRIMARY KEY ("Id_Riverain");


--
-- Name: PK_PrepMarche; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Prep_Marche"
    ADD CONSTRAINT "PK_PrepMarche" PRIMARY KEY ("Id_PrepMarche");


--
-- Name: PK_Province; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Province"
    ADD CONSTRAINT "PK_Province" PRIMARY KEY ("IdProvince");


--
-- Name: PK_Riverain; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Riverain"
    ADD CONSTRAINT "PK_Riverain" PRIMARY KEY ("Id_Riverain");


--
-- Name: PK_SE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ServiceExterieur"
    ADD CONSTRAINT "PK_SE" PRIMARY KEY ("IdSE");


--
-- Name: PK_SatRejet; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Satisfaction_Rejet"
    ADD CONSTRAINT "PK_SatRejet" PRIMARY KEY ("Id_SatRejet");


--
-- Name: PK_TypeLiv; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Type_Livraison"
    ADD CONSTRAINT "PK_TypeLiv" PRIMARY KEY ("Id_TypeLiv");


--
-- Name: PK_ZL; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ZonesLambert"
    ADD CONSTRAINT "PK_ZL" PRIMARY KEY ("IdZL");


--
-- Name: PK_acte; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY acte
    ADD CONSTRAINT "PK_acte" PRIMARY KEY (libelle_ar);


--
-- Name: PK_grpProp; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groupe_proprietaire
    ADD CONSTRAINT "PK_grpProp" PRIMARY KEY (num_ordre);


--
-- Name: Personnel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "Personnel_pkey" PRIMARY KEY ("Id_Personnel");


--
-- Name: Province_NomProvince_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Province"
    ADD CONSTRAINT "Province_NomProvince_key" UNIQUE ("NomProvince");


--
-- Name: RefLimiteNat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "RefLimiteNat"
    ADD CONSTRAINT "RefLimiteNat_pkey" PRIMARY KEY ("Code_Type");


--
-- Name: RefMotifRejertParc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "RefMotifRejet"
    ADD CONSTRAINT "RefMotifRejertParc_pkey" PRIMARY KEY (id_motif);


--
-- Name: RefSpeculation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "RefSpeculation"
    ADD CONSTRAINT "RefSpeculation_pkey" PRIMARY KEY (id_speculation);


--
-- Name: RefTypeSol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "RefTypeSol"
    ADD CONSTRAINT "RefTypeSol_pkey" PRIMARY KEY ("id_typeSol");


--
-- Name: Rejet_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "Rejet_parcelle_pkey" PRIMARY KEY (id_douar, num_parcelle, "Id_Rejet");


--
-- Name: Rejet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Rejet"
    ADD CONSTRAINT "Rejet_pkey" PRIMARY KEY ("Id_Rejet");


--
-- Name: Remarque_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Remarque"
    ADD CONSTRAINT "Remarque_pkey" PRIMARY KEY ("Id_rq");


--
-- Name: SatRej_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "SatRej_parcelle_pkey" PRIMARY KEY ("Id_SatRejet", "Id_douar", num_parcelle);


--
-- Name: Uniq_Concat; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groupe_proprietaire
    ADD CONSTRAINT "Uniq_Concat" UNIQUE (concat_cins);


--
-- Name: UniqueEmail; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY igt
    ADD CONSTRAINT "UniqueEmail" UNIQUE (email);


--
-- Name: Unique_NomZone_ar; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zone
    ADD CONSTRAINT "Unique_NomZone_ar" UNIQUE (nom_ar);


--
-- Name: Unique_NonZone; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zone
    ADD CONSTRAINT "Unique_NonZone" UNIQUE (nom);


--
-- Name: adjudicataire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY adjudicataire
    ADD CONSTRAINT adjudicataire_pkey PRIMARY KEY (id_adjudicataire);


--
-- Name: auth_act_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT auth_act_pk PRIMARY KEY (id_auth_action);


--
-- Name: authentification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY authentification
    ADD CONSTRAINT authentification_pkey PRIMARY KEY (token);


--
-- Name: ayant_droit_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT ayant_droit_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche, code_droit);


--
-- Name: ayant_droit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ayant_droit
    ADD CONSTRAINT ayant_droit_pkey PRIMARY KEY (cin, num_marche);


--
-- Name: borne_opposition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY borne_opposition
    ADD CONSTRAINT borne_opposition_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar, indice);


--
-- Name: borne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY borne
    ADD CONSTRAINT borne_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar);


--
-- Name: borneparcelaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY borne_parcelaire
    ADD CONSTRAINT borneparcelaire_pkey PRIMARY KEY (name, x, y, num_parcelle, id_douar);


--
-- Name: charge_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT charge_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, code_charge);


--
-- Name: charge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY charge
    ADD CONSTRAINT charge_pkey PRIMARY KEY ("CODE_charge");


--
-- Name: consistance_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT consistance_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, "Id_Consistance", "id_typeSol", id_speculation);


--
-- Name: douar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY douar
    ADD CONSTRAINT douar_pkey PRIMARY KEY (id_douar);


--
-- Name: droit_reel_LIBELLE_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY droit_reel
    ADD CONSTRAINT "droit_reel_LIBELLE_key" UNIQUE ("LIBELLE");


--
-- Name: droit_reel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY droit_reel
    ADD CONSTRAINT droit_reel_pkey PRIMARY KEY ("CODE_DROIT");


--
-- Name: enqueteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT enqueteur_pkey PRIMARY KEY (id);


--
-- Name: groupement_igt_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT groupement_igt_pk PRIMARY KEY (id_adjudicataire, id_igt);


--
-- Name: id_zone_Unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT "id_zone_Unique" UNIQUE (id_zone);


--
-- Name: igt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY igt
    ADD CONSTRAINT igt_pkey PRIMARY KEY (id);


--
-- Name: marche_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT marche_pkey PRIMARY KEY (num_marche);


--
-- Name: opposant_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT opposant_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);


--
-- Name: opposant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY opposant
    ADD CONSTRAINT opposant_pkey PRIMARY KEY (cin, num_marche);


--
-- Name: opposition_opposant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT opposition_opposant_pkey PRIMARY KEY (num_parcelle, id_douar, indice, cin, num_marche);


--
-- Name: parcelaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parcelaire
    ADD CONSTRAINT parcelaire_pkey PRIMARY KEY (num_parcelle, id_douar);


--
-- Name: parcelle_motifrejet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_pkey PRIMARY KEY (num_parcelle, id_douar, id_motif);


--
-- Name: parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT parcelle_pkey PRIMARY KEY (num_parcelle, id_douar);


--
-- Name: personne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personne
    ADD CONSTRAINT personne_pkey PRIMARY KEY (cin);


--
-- Name: pk_proppres; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proprietaire_presume
    ADD CONSTRAINT pk_proppres PRIMARY KEY (cin);


--
-- Name: pkaction; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT pkaction PRIMARY KEY (id_action);


--
-- Name: pkdetail_act; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT pkdetail_act PRIMARY KEY (id_acte);


--
-- Name: presume_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT presume_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);


--
-- Name: presume_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY presume
    ADD CONSTRAINT presume_pkey PRIMARY KEY (cin, num_marche);


--
-- Name: proprietaire_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT proprietaire_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);


--
-- Name: proprietaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proprietaire
    ADD CONSTRAINT proprietaire_pkey PRIMARY KEY (cin, num_marche);


--
-- Name: situation_quotidienne_date_saisie_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY situation_quotidienne
    ADD CONSTRAINT situation_quotidienne_date_saisie_key UNIQUE (date_saisie);


--
-- Name: situation_quotidienne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY situation_quotidienne
    ADD CONSTRAINT situation_quotidienne_pkey PRIMARY KEY (id_situation);


--
-- Name: sous_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sous_zone
    ADD CONSTRAINT sous_zone_pkey PRIMARY KEY (id_sous_zone);


--
-- Name: synchronisation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT synchronisation_pkey PRIMARY KEY (id);


--
-- Name: temoin_parcelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT temoin_parcelle_pkey PRIMARY KEY (num_parcelle, id_douar, cin, num_marche);


--
-- Name: temoin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY temoin
    ADD CONSTRAINT temoin_pkey PRIMARY KEY (cin, num_marche);


--
-- Name: uniquegid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT uniquegid UNIQUE (id_synchronisation);


--
-- Name: zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (id_zone);


--
-- Name: FKI_Caidat_Province; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Caidat_Province" ON "Caidat" USING btree ("IdProvince");


--
-- Name: FKI_CatDoc_Doc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_CatDoc_Doc" ON "Document" USING btree ("Categorie_Document");


--
-- Name: FKI_Cercle_Province; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Cercle_Province" ON "Cercle" USING btree ("IdProvince");


--
-- Name: FKI_Ciadat_Douar; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Ciadat_Douar" ON douar USING btree ("IdCommune");


--
-- Name: FKI_Commune_Cercle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Commune_Cercle" ON "Commune" USING btree ("IdCercle");


--
-- Name: FKI_Commune_Zone; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Commune_Zone" ON zone USING btree ("IdCommune");


--
-- Name: FKI_Doc_Marche; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Doc_Marche" ON "DocMarche" USING btree ("NumMarche");


--
-- Name: FKI_EtatParcelle_AspNetUsers; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_EtatParcelle_AspNetUsers" ON "Etat_Parcelle" USING btree ("Initiateur");


--
-- Name: FKI_EtatParcelle_Parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_EtatParcelle_Parcelle" ON "Etat_Parcelle" USING btree ("Id_Parcelle");


--
-- Name: FKI_GrpProp; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_GrpProp" ON parcelle USING btree (num_ordre);


--
-- Name: FKI_LN_RefLN; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_LN_RefLN" ON "LimiteNat" USING btree ("Code_LN");


--
-- Name: FKI_Liv_SZ; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Liv_SZ" ON "Livraison" USING btree ("IdSZ");


--
-- Name: FKI_Livraison; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Livraison" ON "Satisfaction_Rejet" USING btree ("Id_Rejet");


--
-- Name: FKI_Livraison_TypeLivraison; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Livraison_TypeLivraison" ON "Livraison" USING btree ("TypeLivraison");


--
-- Name: FKI_March_PrepMarch; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_March_PrepMarch" ON "Prep_Marche" USING btree (num_marche);


--
-- Name: FKI_Marche_Categorie; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Marche_Categorie" ON marche USING btree (categorie_zone);


--
-- Name: FKI_Marche_SE; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Marche_SE" ON marche USING btree ("serviceExt");


--
-- Name: FKI_Opposant_Opposition_Opposant; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Opposant_Opposition_Opposant" ON "Opposition_Opposant" USING btree (cin);


--
-- Name: FKI_Parc_Validateur; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Parc_Validateur" ON parcelle USING btree (id_validateur);


--
-- Name: FKI_Parcelle_Livraison; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Parcelle_Livraison" ON parcelle USING btree ("Id_LivraisonCF");


--
-- Name: FKI_Parcelle_LivraisonCAD; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Parcelle_LivraisonCAD" ON parcelle USING btree ("Id_LivraisonCAD");


--
-- Name: FKI_Personnel_AspNetUser; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Personnel_AspNetUser" ON "CollabInterne" USING btree ("IdUSer");


--
-- Name: FKI_RejetParcelle_Rejet; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_RejetParcelle_Rejet" ON "Rejet_parcelle" USING btree ("Id_Rejet");


--
-- Name: FKI_Rejet_Livraison; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Rejet_Livraison" ON "Rejet" USING btree ("Id_Livraison");


--
-- Name: FKI_Rejet_Parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Rejet_Parcelle" ON "Rejet_parcelle" USING btree (id_douar, num_parcelle);


--
-- Name: FKI_SatRejetParcelle_Parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_SatRejetParcelle_Parcelle" ON "SatRej_parcelle" USING btree ("Id_douar", num_parcelle);


--
-- Name: FKI_UserEtatDoc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_UserEtatDoc" ON "Etat_Document" USING btree ("Initiateur");


--
-- Name: FKI_UserEtatDocument; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_UserEtatDocument" ON "Etat_Document" USING btree ("Initiateur");


--
-- Name: FKI_Zone_ZL; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_Zone_ZL" ON zone USING btree ("IdZoneLambert");


--
-- Name: FKI_charge; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_charge" ON charge_parcelle USING btree (code_charge);


--
-- Name: FKI_droitreel; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_droitreel" ON ayant_droit_parcelle USING btree (code_droit);


--
-- Name: FKI_enq_AspNetUsers; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_enq_AspNetUsers" ON "Collaborateur" USING btree ("idUser");


--
-- Name: FKI_id_enq_J; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_id_enq_J" ON parcelle USING btree ("id_enqueteurJ");


--
-- Name: FKI_igt_enq; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_igt_enq" ON "Collaborateur" USING btree (id_igt);


--
-- Name: FKI_parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "FKI_parcelle" ON charge_parcelle USING btree (num_parcelle, id_douar);


--
-- Name: IX_AspNetUserClaims_UserId; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" USING btree ("UserId");


--
-- Name: IX_AspNetUserLogins_UserId; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" USING btree ("UserId");


--
-- Name: IX_AspNetUserRoles_RoleId; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" USING btree ("RoleId");


--
-- Name: IX_AspNetUserRoles_UserId; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "IX_AspNetUserRoles_UserId" ON "AspNetUserRoles" USING btree ("UserId");


--
-- Name: Index_etatCAD; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Index_etatCAD" ON parcelle USING btree ("EtatCAD");


--
-- Name: Index_id_douar; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Index_id_douar" ON parcelle USING btree (id_douar);


--
-- Name: fki_Speculation; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "fki_Speculation" ON consistance_parcelle USING btree (id_speculation);


--
-- Name: fki_TypeSol; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "fki_TypeSol" ON consistance_parcelle USING btree ("id_typeSol");


--
-- Name: fki_act_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_act_fk ON auth_action USING btree (id_action);


--
-- Name: fki_auth_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_auth_fk ON auth_action USING btree (token);


--
-- Name: fki_consistance; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_consistance ON consistance_parcelle USING btree ("Id_Consistance");


--
-- Name: fki_fkproprietai_parcelle_acte; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_fkproprietai_parcelle_acte ON proprietaire_parcelle USING btree (acte);


--
-- Name: fki_fkzone; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_fkzone ON marche USING btree (id_zone);


--
-- Name: fki_iduserFK; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "fki_iduserFK" ON authentification USING btree ("idUser");


--
-- Name: fki_igt_AspNetUsers_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "fki_igt_AspNetUsers_fkey" ON igt USING btree ("idUser");


--
-- Name: fki_parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_parcelle ON consistance_parcelle USING btree (num_parcelle, id_douar);


--
-- Name: fki_sFK_ServExtAffect; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "fki_sFK_ServExtAffect" ON "CollabInterne" USING btree ("Id_SE");


--
-- Name: id_synchronisation; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX id_synchronisation ON "DocParcelle" USING btree ("Id_Synchronisation");


--
-- Name: idx_id_document; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_id_document ON "DocParcelle" USING btree ("Id_Document");


--
-- Name: idx_id_douar; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_id_douar ON "DocParcelle" USING btree (id_douar);


--
-- Name: idx_num_parcelle; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_num_parcelle ON "DocParcelle" USING btree (num_parcelle);


--
-- Name: _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO "ViewPMIS" DO INSTEAD  SELECT zone.id_zone,
    zone.nom AS "Zone",
    marche.num_marche,
    "ServiceExterieur"."NomSE",
    marche."DateBO",
    marche."DateOS",
    marche."DateValPrgExec",
    marche."PrgExecVal" AS "IsPEValidated",
    marche."DateValAPD",
    marche."APDVal" AS "IsAPDValidated",
    marche."NbreParEstime",
    count(parcelle.id_synchronisation) AS "NbreParcEnqCAD",
    count(parcelle.id_synchronisation) FILTER (WHERE ((parcelle."EtatCAD")::text = 'ValidCAD'::text)) AS "NbreParcValCAD",
    count(parcelle.id_synchronisation) AS "NbreParcEnqCF",
    count(parcelle.id_synchronisation) FILTER (WHERE ((parcelle."EtatCF")::text = 'ValidCF'::text)) AS "NbreParcValCF"
   FROM (((((parcelle
     JOIN douar ON ((douar.id_douar = parcelle.id_douar)))
     JOIN sous_zone ON ((sous_zone.id_sous_zone = douar.id_sous_zone)))
     JOIN zone ON ((zone.id_zone = sous_zone.id_zone)))
     JOIN marche ON ((marche.id_zone = zone.id_zone)))
     JOIN "ServiceExterieur" ON ((marche."serviceExt" = "ServiceExterieur"."IdSE")))
  GROUP BY "ServiceExterieur"."IdSE", marche.num_marche, zone.nom, zone.id_zone;


--
-- Name: _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO synth_etat_parcelle DO INSTEAD  SELECT z.nom,
    z.id_zone,
    m."DateOS",
    sum(
        CASE
            WHEN (((p.etat)::text <> 'Deleted'::text) AND ((p."EtatCAD")::text = 'RejetCAD'::text)) THEN 1
            ELSE 0
        END) AS rejcad,
    sum(
        CASE
            WHEN (((p.etat)::text <> 'Deleted'::text) AND ((p."EtatCF")::text = 'RejetCF'::text)) THEN 1
            ELSE 0
        END) AS rejcf,
    sum(
        CASE
            WHEN (((dp."Statut")::text = 'Rejete'::text) AND ((p.etat)::text <> 'Deleted'::text)) THEN 1
            ELSE 0
        END) AS rejst228,
    sum(
        CASE
            WHEN (((p.etat)::text <> 'Deleted'::text) AND ((((p."EtatCAD")::text = 'RejetCAD'::text) AND ((p."EtatCF")::text = 'ValidCF'::text)) OR (((p."EtatCF")::text = 'RejetCF'::text) AND ((p."EtatCAD")::text = 'ValidCAD'::text)))) THEN 1
            ELSE 0
        END) AS caddifcf
   FROM parcelle p,
    douar dd,
    sous_zone sz,
    zone z,
    marche m,
    ( SELECT "DocParcelle"."Id_Document",
            "DocParcelle"."Id_Synchronisation",
            "DocParcelle"."Statut"
           FROM "DocParcelle") dp,
    ( SELECT "Document"."Id_Document",
            "Document"."Categorie_Document"
           FROM "Document"
          WHERE ((("Document"."Categorie_Document")::text = 'ST284_PARC'::text) OR (("Document"."Categorie_Document")::text = 'ST284_RNB'::text))) d
  WHERE ((((((p.id_synchronisation = dp."Id_Synchronisation") AND (dp."Id_Document" = d."Id_Document")) AND (p.id_douar = dd.id_douar)) AND (dd.id_sous_zone = sz.id_sous_zone)) AND (sz.id_zone = z.id_zone)) AND (m.id_zone = z.id_zone))
  GROUP BY z.id_zone, m."DateOS";


--
-- Name: geom_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER geom_trigger BEFORE INSERT OR UPDATE ON parcelle FOR EACH ROW EXECUTE PROCEDURE updaregeomandprojection();


--
-- Name: geom_trigger_oppos; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER geom_trigger_oppos BEFORE INSERT OR UPDATE ON "Opposition" FOR EACH ROW EXECUTE PROCEDURE updaregeom();


--
-- Name: geom_trigger_riv; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER geom_trigger_riv BEFORE INSERT OR UPDATE ON "Riverain" FOR EACH ROW EXECUTE PROCEDURE updaregeom();


--
-- Name: prc_geom_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER prc_geom_trigger BEFORE INSERT OR UPDATE ON parcelaire FOR EACH ROW EXECUTE PROCEDURE updaregeom();


--
-- Name: Collaborateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT "Collaborateur_fkey" FOREIGN KEY (id_collab) REFERENCES "Collaborateur"(id);


--
-- Name: FK_AspNetUserClaims_AspNetUsers_User_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUserClaims"
    ADD CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_User_Id" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: FK_AspNetUserLogins_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUserLogins"
    ADD CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: FK_AspNetUserRoles_AspNetRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE;


--
-- Name: FK_AspNetUserRoles_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: FK_Caidat_Province; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Caidat"
    ADD CONSTRAINT "FK_Caidat_Province" FOREIGN KEY ("IdProvince") REFERENCES "Province"("IdProvince");


--
-- Name: FK_CatDoc_Doc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Document"
    ADD CONSTRAINT "FK_CatDoc_Doc" FOREIGN KEY ("Categorie_Document") REFERENCES "Categorie_Document"("Code_Categorie");


--
-- Name: FK_Cercle_Province; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cercle"
    ADD CONSTRAINT "FK_Cercle_Province" FOREIGN KEY ("IdProvince") REFERENCES "Province"("IdProvince");


--
-- Name: FK_Collab_Marche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "FK_Collab_Marche" FOREIGN KEY ("Num_Marche") REFERENCES marche(num_marche);


--
-- Name: FK_Collab_Personnel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabInterne_marche"
    ADD CONSTRAINT "FK_Collab_Personnel" FOREIGN KEY ("Id_Personnel") REFERENCES "CollabInterne"("Id_Personnel");


--
-- Name: FK_Commune_Cercle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Commune"
    ADD CONSTRAINT "FK_Commune_Cercle" FOREIGN KEY ("IdCercle") REFERENCES "Cercle"("IdCercle");


--
-- Name: FK_Commune_Zone; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY zone
    ADD CONSTRAINT "FK_Commune_Zone" FOREIGN KEY ("IdCommune") REFERENCES "Commune"("IdCommune");


--
-- Name: CONSTRAINT "FK_Commune_Zone" ON zone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_Commune_Zone" ON zone IS 'Une zone est lié à une commune';


--
-- Name: FK_DocCommun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "FK_DocCommun" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");


--
-- Name: FK_DocCommun_Doucument; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocCommun"
    ADD CONSTRAINT "FK_DocCommun_Doucument" FOREIGN KEY (id_sous_zone) REFERENCES sous_zone(id_sous_zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_DocEtatDoc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Etat_Document"
    ADD CONSTRAINT "FK_DocEtatDoc" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");


--
-- Name: FK_DocParcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "FK_DocParcelle" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");


--
-- Name: FK_Doc_Marche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "FK_Doc_Marche" FOREIGN KEY ("NumMarche") REFERENCES marche(num_marche);


--
-- Name: FK_DouarCommune; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY douar
    ADD CONSTRAINT "FK_DouarCommune" FOREIGN KEY ("IdCommune") REFERENCES "Commune"("IdCommune");


--
-- Name: FK_EtatParcelle_AspNetUsers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "FK_EtatParcelle_AspNetUsers" FOREIGN KEY ("Initiateur") REFERENCES "AspNetUsers"("Id");


--
-- Name: FK_GrpProp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_GrpProp" FOREIGN KEY (num_ordre) REFERENCES groupe_proprietaire(num_ordre);


--
-- Name: FK_LN_RefLN; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "FK_LN_RefLN" FOREIGN KEY ("Code_LN") REFERENCES "RefLimiteNat"("Code_Type");


--
-- Name: FK_Liv_SZ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "FK_Liv_SZ" FOREIGN KEY ("IdSZ") REFERENCES sous_zone(id_sous_zone);


--
-- Name: FK_Livraison_TypeLivraison; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Livraison"
    ADD CONSTRAINT "FK_Livraison_TypeLivraison" FOREIGN KEY ("TypeLivraison") REFERENCES "Type_Livraison"("Id_TypeLiv");


--
-- Name: FK_March_PrepMarch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Prep_Marche"
    ADD CONSTRAINT "FK_March_PrepMarch" FOREIGN KEY (num_marche) REFERENCES marche(num_marche);


--
-- Name: FK_Marche_Categorie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT "FK_Marche_Categorie" FOREIGN KEY (categorie_zone) REFERENCES "Categorie"("IdCategorie");


--
-- Name: FK_Marche_SE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT "FK_Marche_SE" FOREIGN KEY ("serviceExt") REFERENCES "ServiceExterieur"("IdSE");


--
-- Name: FK_Opposition_Borne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY borne_opposition
    ADD CONSTRAINT "FK_Opposition_Borne" FOREIGN KEY (num_parcelle, id_douar, indice) REFERENCES "Opposition"(num_parcelle, id_douar, indice) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_PARCELLE_Doucument; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocParcelle"
    ADD CONSTRAINT "FK_PARCELLE_Doucument" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_PARCELLE_PARCELAIRE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelaire
    ADD CONSTRAINT "FK_PARCELLE_PARCELAIRE" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_PARCELLE_RIV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Riverain"
    ADD CONSTRAINT "FK_PARCELLE_RIV" FOREIGN KEY (num_parcelle, "Id_douar") REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Parc_Validateur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parc_Validateur" FOREIGN KEY (id_validateur) REFERENCES "Collaborateur"(id);


--
-- Name: FK_Parcelle_CollabInterne_Borneur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_CollabInterne_Borneur" FOREIGN KEY ("IdBorneur") REFERENCES "CollabInterne"("Id_Personnel");


--
-- Name: FK_Parcelle_CollabInterne_CAD; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_CollabInterne_CAD" FOREIGN KEY ("IdContr_CAD") REFERENCES "CollabInterne"("Id_Personnel");


--
-- Name: FK_Parcelle_EtatParcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Etat_Parcelle"
    ADD CONSTRAINT "FK_Parcelle_EtatParcelle" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Parcelle_LivraisonCAD; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_LivraisonCAD" FOREIGN KEY ("Id_LivraisonCAD") REFERENCES "Livraison"("Id_Livraison");


--
-- Name: FK_Parcelle_LivraisonCF; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_Parcelle_LivraisonCF" FOREIGN KEY ("Id_LivraisonCF") REFERENCES "Livraison"("Id_Livraison");


--
-- Name: FK_Personnel_AspNetUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "FK_Personnel_AspNetUser" FOREIGN KEY ("IdUSer") REFERENCES "AspNetUsers"("Id");


--
-- Name: FK_RefMotifRejet_CatDoc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RefMotifRejet"
    ADD CONSTRAINT "FK_RefMotifRejet_CatDoc" FOREIGN KEY ("CatDoc") REFERENCES "Categorie_Document"("Code_Categorie");


--
-- Name: FK_RejetParcelle_Parcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "FK_RejetParcelle_Parcelle" FOREIGN KEY (id_douar, num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);


--
-- Name: FK_RejetParcelle_Rejet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rejet_parcelle"
    ADD CONSTRAINT "FK_RejetParcelle_Rejet" FOREIGN KEY ("Id_Rejet") REFERENCES "Rejet"("Id_Rejet");


--
-- Name: FK_Rejet_Livraison; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Rejet"
    ADD CONSTRAINT "FK_Rejet_Livraison" FOREIGN KEY ("Id_Livraison") REFERENCES "Livraison"("Id_Livraison");


--
-- Name: FK_Rejet_SatRejet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Satisfaction_Rejet"
    ADD CONSTRAINT "FK_Rejet_SatRejet" FOREIGN KEY ("Id_Rejet") REFERENCES "Rejet"("Id_Rejet");


--
-- Name: FK_Riverain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "BienLimitrophe"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");


--
-- Name: FK_Riverain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "LimiteNat"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");


--
-- Name: FK_Riverain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Prop_morale"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");


--
-- Name: FK_Riverain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Prop_physique"
    ADD CONSTRAINT "FK_Riverain" FOREIGN KEY ("Id_Riverain") REFERENCES "Riverain"("Id_Riverain");


--
-- Name: FK_SatRejetParcelle_Parcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "FK_SatRejetParcelle_Parcelle" FOREIGN KEY ("Id_douar", num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);


--
-- Name: FK_SatRejetParcelle_SatRej; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SatRej_parcelle"
    ADD CONSTRAINT "FK_SatRejetParcelle_SatRej" FOREIGN KEY ("Id_SatRejet") REFERENCES "Satisfaction_Rejet"("Id_SatRejet");


--
-- Name: FK_User_Personnel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AspNetUsers"
    ADD CONSTRAINT "FK_User_Personnel" FOREIGN KEY ("Id") REFERENCES "AspNetUsers"("Id");


--
-- Name: FK_Zone_ZL; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY zone
    ADD CONSTRAINT "FK_Zone_ZL" FOREIGN KEY ("IdZoneLambert") REFERENCES "ZonesLambert"("IdZL");


--
-- Name: FK_charge_parcelle_charge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT "FK_charge_parcelle_charge" FOREIGN KEY (code_charge) REFERENCES charge("CODE_charge");


--
-- Name: FK_charge_parcelle_parcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY charge_parcelle
    ADD CONSTRAINT "FK_charge_parcelle_parcelle" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: FK_enq_AspNetUsers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT "FK_enq_AspNetUsers" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");


--
-- Name: FK_id_enq_J; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "FK_id_enq_J" FOREIGN KEY ("id_enqueteurJ") REFERENCES "Collaborateur"(id);


--
-- Name: FK_parcelle_Borne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY borne
    ADD CONSTRAINT "FK_parcelle_Borne" FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_synchronisation_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT "FK_synchronisation_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: Fk_DocMarche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DocMarche"
    ADD CONSTRAINT "Fk_DocMarche" FOREIGN KEY ("Id_Document") REFERENCES "Document"("Id_Document");


--
-- Name: Opposition_Opposant_id_douar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT "Opposition_Opposant_id_douar_fkey" FOREIGN KEY (id_douar, num_parcelle, indice) REFERENCES "Opposition"(id_douar, num_parcelle, indice);


--
-- Name: Opposition_id_douar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Opposition"
    ADD CONSTRAINT "Opposition_id_douar_fkey" FOREIGN KEY (id_douar, num_parcelle) REFERENCES parcelle(id_douar, num_parcelle);


--
-- Name: Parcelle_CollabInterne_CF; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT "Parcelle_CollabInterne_CF" FOREIGN KEY ("IdContr_CF") REFERENCES "CollabInterne"("Id_Personnel");


--
-- Name: act_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT act_fk FOREIGN KEY (id_action) REFERENCES actions(id_action);


--
-- Name: act_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT act_fk FOREIGN KEY (id_action) REFERENCES actions(id_action);


--
-- Name: acte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT acte_fkey FOREIGN KEY (acte) REFERENCES acte(libelle_ar);


--
-- Name: acte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT acte_fkey FOREIGN KEY (acte) REFERENCES acte(libelle_ar);


--
-- Name: adjudicataire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT adjudicataire_fkey FOREIGN KEY (id_adjudicataire) REFERENCES adjudicataire(id_adjudicataire);


--
-- Name: adjudicataire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT adjudicataire_fkey FOREIGN KEY (id_adj) REFERENCES adjudicataire(id_adjudicataire);


--
-- Name: auth_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_action
    ADD CONSTRAINT auth_fk FOREIGN KEY (token) REFERENCES authentification(token);


--
-- Name: ayant_droit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT ayant_droit_fkey FOREIGN KEY (cin, num_marche) REFERENCES ayant_droit(cin, num_marche);


--
-- Name: droitreel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT droitreel_fkey FOREIGN KEY (code_droit) REFERENCES droit_reel("CODE_DROIT");


--
-- Name: fk_Speculation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT "fk_Speculation" FOREIGN KEY (id_speculation) REFERENCES "RefSpeculation"(id_speculation);


--
-- Name: fk_TypeSol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT "fk_TypeSol" FOREIGN KEY ("id_typeSol") REFERENCES "RefTypeSol"("id_typeSol");


--
-- Name: fk_consistance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT fk_consistance FOREIGN KEY ("Id_Consistance") REFERENCES "RefConsistances"("Id_Consistance");


--
-- Name: fk_douar_parcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT fk_douar_parcelle FOREIGN KEY (id_douar) REFERENCES douar(id_douar);


--
-- Name: fk_parcelle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consistance_parcelle
    ADD CONSTRAINT fk_parcelle FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: fk_proppres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proprietaire_presume
    ADD CONSTRAINT fk_proppres FOREIGN KEY (cin) REFERENCES personne(cin);


--
-- Name: fkdetail_act320561; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT fkdetail_act320561 FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: fkdouar422474; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY douar
    ADD CONSTRAINT fkdouar422474 FOREIGN KEY (id_sous_zone) REFERENCES sous_zone(id_sous_zone);


--
-- Name: fkparcelaireborne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY borne_parcelaire
    ADD CONSTRAINT fkparcelaireborne FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelaire(num_parcelle, id_douar) ON UPDATE CASCADE;


--
-- Name: fkparcelle774413; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle
    ADD CONSTRAINT fkparcelle774413 FOREIGN KEY ("id_enqueteurP") REFERENCES "Collaborateur"(id);


--
-- Name: fksous_zone995730; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sous_zone
    ADD CONSTRAINT fksous_zone995730 FOREIGN KEY (id_zone) REFERENCES zone(id_zone);


--
-- Name: fksynchronis567424; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY synchronisation
    ADD CONSTRAINT fksynchronis567424 FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: fkzone; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marche
    ADD CONSTRAINT fkzone FOREIGN KEY (id_zone) REFERENCES zone(id_zone);


--
-- Name: iduserFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authentification
    ADD CONSTRAINT "iduserFK" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");


--
-- Name: igt_AspNetUsers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY igt
    ADD CONSTRAINT "igt_AspNetUsers_fkey" FOREIGN KEY ("idUser") REFERENCES "AspNetUsers"("Id");


--
-- Name: igt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groupement_igt
    ADD CONSTRAINT igt_fkey FOREIGN KEY (id_igt) REFERENCES igt(id);


--
-- Name: igt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Collaborateur"
    ADD CONSTRAINT igt_fkey FOREIGN KEY (id_igt) REFERENCES igt(id);


--
-- Name: marche_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabExterne_marche"
    ADD CONSTRAINT marche_fkey FOREIGN KEY (num_marche) REFERENCES marche(num_marche);


--
-- Name: opposant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT opposant_fkey FOREIGN KEY (cin, num_marche) REFERENCES opposant(cin, num_marche);


--
-- Name: opposant_opposition_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Opposition_Opposant"
    ADD CONSTRAINT opposant_opposition_fkey FOREIGN KEY (cin, num_marche) REFERENCES opposant(cin, num_marche);


--
-- Name: parcelle_ayant_droit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ayant_droit_parcelle
    ADD CONSTRAINT parcelle_ayant_droit_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: parcelle_motifrejet_id_motif_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_id_motif_fkey FOREIGN KEY (id_motif) REFERENCES "RefMotifRejet"(id_motif);


--
-- Name: parcelle_motifrejet_num_parcelle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parcelle_motifrejet
    ADD CONSTRAINT parcelle_motifrejet_num_parcelle_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: parcelle_opposant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opposant_parcelle
    ADD CONSTRAINT parcelle_opposant_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: parcelle_presume_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT parcelle_presume_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: parcelle_proprietaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT parcelle_proprietaire_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: parcelle_temoin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT parcelle_temoin_fkey FOREIGN KEY (num_parcelle, id_douar) REFERENCES parcelle(num_parcelle, id_douar);


--
-- Name: presume_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY presume_parcelle
    ADD CONSTRAINT presume_fkey FOREIGN KEY (cin, num_marche) REFERENCES presume(cin, num_marche);


--
-- Name: proprietaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proprietaire_parcelle
    ADD CONSTRAINT proprietaire_fkey FOREIGN KEY (cin, num_marche) REFERENCES proprietaire(cin, num_marche);


--
-- Name: proprietaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detail_acte
    ADD CONSTRAINT proprietaire_fkey FOREIGN KEY (cin, num_marche) REFERENCES proprietaire(cin, num_marche);


--
-- Name: sFK_ServExtAffect; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CollabInterne"
    ADD CONSTRAINT "sFK_ServExtAffect" FOREIGN KEY ("Id_SE") REFERENCES "ServiceExterieur"("IdSE");


--
-- Name: temoin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY temoin_parcelle
    ADD CONSTRAINT temoin_fkey FOREIGN KEY (cin, num_marche) REFERENCES temoin(cin, num_marche);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

