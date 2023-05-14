insert into sliced_routes
SELECT
nextval('sliced_routes_gid_seq'::regclass),
tabelredus.car_name as car_name,
tabelredus.dusintors as dusintors,
tabelredus.ruta as route_name,
tabelredus.timestamp as timestamp,
(ST_DumpSegments(ST_LineSubstring(tabelredus.geom,part1,part2))).geom as sliced_geom,
--ST_LineSubstring(tabelredus.geom,part1,part2) as sliced_geom,
(ST_Length(ST_LineSubstring(tabelredus.geom,part1,part2)::geography))/(tabelredus.travel_time)/16.66667 as viteza ---transf in km/h

FROM
(SELECT
  v.nume as car_name,
  v.dusintors as dusintors,
  v.dataora as timestamp,
  ST_LineLocatePoint(r.geom, ST_ClosestPoint(r.geom, v.geom)) as part1,
  ST_LineLocatePoint(r.geom, ST_ClosestPoint(r.geom, (SELECT v1.geom FROM vehicule_test v1 WHERE v1.nume = v.nume AND v1.dataora > v.dataora ORDER BY v1.dataora LIMIT 1))) as part2,
  (SELECT Extract(epoch FROM (v3.dataora-v.dataora))/60 from vehicule_test v3 WHERE v3.nume = v.nume AND v3.dusintors = v.dusintors and v.dataora < v3.dataora ORDER BY v3.dataora LIMIT 1) as travel_time,
  v.ruta as ruta,
  r.geom as geom
FROM vehicule_test v
JOIN routelines r ON v.ruta = r.ruta
WHERE v.dusintors = r.dusintors 
--and date_part ('hour', v.dataora )>=7 and date_part ('hour', v.dataora )<9
ORDER BY v.dataora) as tabelredus
where part1<part2 and travel_time>1  and travel_time<30;



with sliced_agg as (
select
s.sliced_geom,
(
select 
AVG (viteza) as avgspeed
--count(*) as numar
from sliced_routes i
where ST_Equals(s.sliced_geom, i.sliced_geom)
)
from sliced_routes s)
update traseeUnice
set avgspeed=sliced_agg.avgspeed
 --numar=sliced_agg.numar
from
sliced_agg
where
ST_Equals (traseeUnice.geom, sliced_agg.sliced_geom)






----------------------------------------------------------------------------------
insert into sliced_routes
SELECT
nextval('sliced_routes_gid_seq'::regclass),
tabelredus.car_name as car_name,
tabelredus.dusintors as dusintors,
tabelredus.ruta as route_name,
tabelredus.timestamp as timestamp,
(ST_DumpSegments(ST_LineSubstring(tabelredus.geom,part1,part2))).geom as sliced_geom,
--ST_LineSubstring(tabelredus.geom,part1,part2) as sliced_geom,
(ST_Length(ST_LineSubstring(tabelredus.geom,part1,part2)::geography))/(tabelredus.travel_time)/16.66667 as viteza ---transf in km/h

FROM
(SELECT
  v.nume as car_name,
  v.dusintors as dusintors,
  v.dataora as timestamp,
  ST_LineLocatePoint(r.geom, ST_ClosestPoint(r.geom, v.geom)) as part1,
  ST_LineLocatePoint(r.geom, ST_ClosestPoint(r.geom, (SELECT v1.geom FROM vehicule_test v1 WHERE v1.nume = v.nume AND v1.dusintors = v.dusintors AND v1.dataora > v.dataora ORDER BY v1.dataora LIMIT 1))) as part2,
  (SELECT Extract(epoch FROM (v3.dataora-v.dataora))/60 from vehicule_test v3 WHERE v3.nume = v.nume AND v3.dusintors = v.dusintors and v.dataora < v3.dataora ORDER BY v3.dataora LIMIT 1) as travel_time,
  v.ruta as ruta,
  r.geom as geom
FROM vehicule_test v
JOIN routelines r ON v.ruta = r.ruta
WHERE v.dusintors = r.dusintors 
-- selectie pe ziua saptamanii (dow) si pe interval orar (7-9)
and date_part('dow', v.dataora )>=1 and date_part('dow', v.dataora )<6 and date_part ('hour', v.dataora )>=7 and date_part ('hour', v.dataora )<9
ORDER BY v.dataora) as tabelredus
where part1<part2 and travel_time>1  and travel_time<20;
---------------------------------------------------------------------------------------

with sliced_agg as (
select
s.sliced_geom,
(
select 
AVG (viteza) as avgspeed
--count(*) as numar
from sliced_routes i
where ST_Equals(s.sliced_geom, i.sliced_geom)
)
from sliced_routes s)
update traseeUnice
set avgspeed=sliced_agg.avgspeed
 --numar=sliced_agg.numar
from
sliced_agg
where
ST_Equals (traseeUnice.geom, sliced_agg.sliced_geom)
---------------------------------------------------------------------------------------
update traseeunice set avgspeed = NULL
--------------------------------------------
CREATE INDEX IF NOT EXISTS vehicule_test_geom_idx
    ON public.vehicule_test USING gist
    (geom)
    TABLESPACE pg_default;
