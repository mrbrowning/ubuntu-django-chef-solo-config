package "postgresql"
package "postgresql-client"
package "postgresql-contrib"
package "postgresql-8.4-postgis"
package "python-psycopg2"



script "configure_postgres" do
  interpreter "bash"
  user "postgres"
  code <<-EOH 
  createdb geo_template -E UTF8 -T template0
  createlang plpgsql geo_template
  createuser -s designcc;
  psql -c "create role gisgroup"
  psql -d geo_template -f /usr/share/postgresql/8.4/contrib/postgis-1.5/postgis.sql
  psql -d geo_template -f /usr/share/postgresql/8.4/contrib/postgis-1.5/spatial_ref_sys.sql
  psql -d geo_template -f /usr/share/postgresql/8.4/contrib/postgis_comments.sql
  psql -d geo_template -c "ALTER TABLE geometry_columns OWNER TO gisgroup"
  psql -d geo_template -c "ALTER TABLE spatial_ref_sys OWNER TO gisgroup"
  psql -d geo_template -c "CREATE SCHEMA gis_schema AUTHORIZATION gisgroup;"
  psql -c "grant gisgroup to designcc"
  EOH
end

