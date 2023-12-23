
from firebase_realtime import Auth, Realtime

# Please provide appropriate project_id
# PROJECT_ID = <project_id>
real_db_url = f"https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app/"
auth = Auth()
flg, headers = auth.validate_user("transdig555@gmail.com", "Mohit@2015192", "AIzaSyA5EllEpnbt7PtsyjcVV1OpzhvZn7V5f4I")
print(flg, headers)
realtime = Realtime(real_db_url, headers)
print(realtime)

#PUT, PATCH, GET, DELETE
flg, data = realtime.put("test123", data={"test1": 123})
print(flg, data)
flg, data = realtime.patch("test123", data_tag={"test2": 1232})
print(flg, data)
flg, data = realtime.patch("test123", data_tag={"test3": 1233})
print(flg, data)
flg, data = realtime.get("test123")
print(flg, data)
flg, data = realtime.delete("test123")
print(flg, data)


#Put Tag1
#flg, data = realtime.put("LED01",data="ON")
#print(flg, data)


#Get Tag1
#flg, data = realtime.get("test123")
#print(flg, data)