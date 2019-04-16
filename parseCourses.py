import json

with open("/Users/Brad/Desktop/courses.json", "r") as myFile:
    data = myFile.read()

courses = json.loads(data)

for course in courses:
    print(course['department'] + str(course['courseNumber']) + " " + course['courseName'])
