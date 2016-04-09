Build simple sinatra API to log and aggregate time series data. Use ruby 2.3 and mongoDB. All API endpoints should work with json body, not form-data. Result should be available as github repo with commit history (not just one commit that uploads all code) and covered by specs


You have multiple data points with unique ID. As result of test task you need to build application that will log measurements for specific ID and calculate statistics (min, max, avg) value for each ID.

#### Logging

Data will be submitted by POST requests with ID in url (POST /ID)
Payload will include hash with timestamp and value and encoded to json

```json
{"1460205628":15.0,"1460205706":21.0}
```

#### Statistics

Aggregate values by timerange. Requests endpoint GET /ID.
Request params will be sumbitted as json and support only one param: range with timestamps array: 
Example: 

```json
{"range":[1460205628,1460205706]}
```

Response should include min/max/avg value for specific range by ID
Example:

```json
{"min":15.0,"max":21.0,"avg":18.0}
```

#### Requirements

* Github project
* Ruby 2.3
* Rspec 3.4 
* MongoDB

