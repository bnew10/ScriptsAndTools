import json

with open("/Users/Brad/Desktop/classes.json", "r") as myFile:
    data = myFile.read()

courses = json.loads(data)

for course in courses:
    print(course['courseCode'] + " " + course['courseName'])
