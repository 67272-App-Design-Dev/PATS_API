# PATS API

This is the code used in 67-272 to teach the basics of building an API.  There are several branches here to demonstrate different aspects of API building.  The branches build in a cumulative fashion, so the order to review these branches is:

* basics -- this is the most basic API possible

* swagger -- this version is where we document the API with Swagger docs

* serializers -- this version does some basic serialization to allow us to generate more interesting JSON

* adv_serializers -- a more advanced version of the prior branch 

* serializers-fastjson -- similar to the serializers branch, it uses Netflix's `fast_jsonapi` gem for significant performance improvements

* adv_serial_fastjson -- likewise, a more advanced version of the prior branch using the `fast_jsonapi` gem

* cors -- allowing for cross origin resource sharing

* filtering -- this version adds flexibility to the API allowing us to filter and order results as needed

* adv_filtering -- this version refactors the previous branch to reduce some obvious code duplication

* auth -- adding some authentication for the API to restrict access

* versioning -- creating versions of the API

* rackattack -- throttling access to the API to stop excessive usage


