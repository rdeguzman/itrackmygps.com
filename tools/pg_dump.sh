# Dumps location table only
# pg_dump -h robin -U rupert -W -t locations -a -f locations.backup itrackmygps_development

# Dumps whole database
pg_dump -h robin -U rupert -W -f itrackmygps.backup itrackmygps_production

# Loads the database
echo "To load the data:"
echo "psql -h 127.0.0.1 -U rupert -d itrackmygps_development -f itrackmygps.backup"
