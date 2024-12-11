import firebase_admin
from firebase_admin import credentials , db , firestore

cred = credentials.Certificate('serviceAccountKey3.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://elderhome-25df1-default-rtdb.firebaseio.com/'
})

ref = db.reference('pelo/melo/mana')
data = ref.get()
print(data)

db = firestore.client()
city_ref = db.collection('sensors').document('sensors')
# doc_ref.set(data)
city_ref.update({"temp": data})