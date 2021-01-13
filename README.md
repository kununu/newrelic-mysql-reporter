# A MySQL Database Custom Metrics Reporter for New Relic

- Create an .env file with all configurations needed (see .env-example)
- Create a configuration file with your metrics (see config-example.yaml)
- Build the image: `make docker`

## Running the example
```bash
docker run -d --name newrelic-mysql-reporter-example-db -e MYSQL_ROOT_PASSWORD=example -p 3306:3306 mysql:5.7
sleep 30
cat >.env <<ENV
NR_ACCOUNT_ID=1234567
NR_API_KEY=xxx
METRICS_FILE=/metrics.yaml
#ATTRIBUTES_FILE=/attributes.yaml
DATABASE_URL=root:example@tcp(172.17.0.1:3306)/information_schema
ENV
make example
docker rm -f newrelic-mysql-reporter-example-db
```
