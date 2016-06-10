from flask import Flask, jsonify
from flask_restful import reqparse, Api, Resource, abort
from jsonBuilder import json_data, json_load
from jsonParser import json_parser
from procRunner import procRunner


app = Flask(__name__)
api = Api(app)

json_data()
json_load()

Observations = json_data.jsonData
LastLoad = json_load.jsonLastLoad

print Observations
print ''
print LastLoad
print ''

REST = {'observations': Observations,
        'lastLoad': LastLoad
        }

#RESTLastObservation = {'lastLoad': LastLoad
#                      }


def abort_if_json_doesnt_exist(rest_id):
    if rest_id not in REST:
        abort(404, message="Deeply sorry but Json {} doesn't exist".format(rest_id))


parser = reqparse.RequestParser()
parser.add_argument('name', type=str)
parser.add_argument('startDate', type=str)
parser.add_argument('endDate', type=str)
parser.add_argument('uPhotometry', type=str)
parser.add_argument('vPhotometry', type=str)
parser.add_argument('bPhotometry', type=str)

class Rest(Resource):
    def get(self, rest_id):
        abort_if_json_doesnt_exist(rest_id)
        return REST[rest_id]


class RestNewObservation(Resource):
    def post(self):
        args = parser.parse_args()
        REST["observations"].append({'name': args['name'],
                                 'startDate': args['startDate'],
                                 'endDate': args['endDate'],
                                 'uPhotometry': args['uPhotometry'],
                                 'vPhotometry': args['vPhotometry'],
                                 'bPhotometry': args['bPhotometry']})
        json_parser(args['name'], args['startDate'], args['endDate'], args['uPhotometry'], args['vPhotometry'], args['bPhotometry'])

        return REST["observations"], 201


class RestLastObservation(Resource):
    def get(self):
        #abort_if_json_doesnt_exist(rest_id)
        return REST["lastLoad"]

    def put(self):
        procRunner()
        return LastLoad

api.add_resource(Rest, '/<rest_id>')
api.add_resource(RestNewObservation, '/observations')
api.add_resource(RestLastObservation, '/lastLoad')

# Handling COR requests
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    response.headers.add("Access-Control-Max-Age", "3600");
    response.headers.add("Access-Control-Allow-Headers", "x-requested-with");
    response.headers.add("Connection", "keep-alive");
    return response


if __name__ == '__main__':
    app.run(debug=True)
