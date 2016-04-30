Parsing World City Locations Database
===============================
I have implemented the parsing in two approach

* First approach is simple using of ruby CSV interface.
* Second approach is object oriented way on top ruby CSV interface.


Running parsing ruby scripts
================================
* From the project root directory first run

```
$ bundle
```

* Run following command to get output from First approach. Output will be printed in the STDOUT and also into simple_parsing.txt file (created in the project folder).

```
$ ruby simple_parsing.rb
```

* Run following command to get output from Second approach. Output will be printed in the STDOUT and also into oo_parsing.txt file (created in the project folder).


```
$ ruby oo_parsing.rb
```

* Run following command to run test

```
$ rspec test/unit --format documentation
```

Why second approach?
===============================
* To be modular and will be able to reuse code in other projects by publishing a gem
* Will be able to implement new features easily. For example check Parser#lowest_cities_of_countries


World City Locations Database
===============================

Geographical location (latitude, longitude, altitude) of all main cities of the world. The data has been scrapped from [Aneki World Cities site] (http://www.aneki.com/cities.html)

The repository contains the location database in below formats:

- SQL
- CSV
- CSV for MS EXCEL, MS EXCEL 2000

All of them are exported from MySQL using phpMyAdmin.

The table has in 10,567 rows (means 10,567 unique cities, their locations and 170 countries).

Structure
----------
The table has 5 fields, `id`, `country`, `city`, `latitude`, `longitude`, `altitude`. From their name, I hope you can understand their significance.


Usage
---------

The sql file contains the schema to reproduce the location table in your designated database (assuming you are using mysql database engine. If you aren’t, you can easily convert the sql schema

### Getting all countries of the world (170 countries)

    SELECT DISTINCT(country) FROM location
    
### Getting all cities of a country

    SELECT city FROM location WHERE country = 'YOUR_COUNTRY_NAME_HERE'
  
### Getting the location of a specific city of a specific country
      
    SELECT latitude,longitude,altitude FROM location WHERE country='COUNTRY_NAME' AND city = 'CITY_NAME'




