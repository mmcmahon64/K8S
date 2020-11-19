from flask import Flask
helloworld = Flask(__name__)
@helloworld.route("/")
def run():
    return "{\"message\":\"Hello world from Python\"}"
if __name__ == "__main__":
    helloworld.run(host="0.0.0.0", port=int("80"), debug=True)