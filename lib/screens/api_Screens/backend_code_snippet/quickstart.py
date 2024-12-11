from __future__ import print_function

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/documents.readonly','https://www.googleapis.com/auth/fitness.body.read','https://www.googleapis.com/auth/fitness.activity.read']

# The ID of a sample document.
DOCUMENT_ID = '195j9eDD3ccgjQRttHhJPymLJUCOUjs-jmwTrekvdjFE'


def main():
    """Shows basic usage of the Docs API.
    Prints the title of a sample document.
    """
    sum_of_data=0
    no_of_minutes = 15
    interval = no_of_minutes*60*1000
    current_millis = int(time.time_ns()/1000000)
    past_millis= int(current_millis - interval)
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            print(dir(flow))
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        service = build('docs', 'v1', credentials=creds)
        service2 = build('fitness', 'v1', credentials=creds)
        # Retrieve the documents contents from the Docs service.
        # document = service.documents().get(documentId=DOCUMENT_ID).execute()
        # step = service2.users().get(userId='me').execute()
        # respon = service2.users().dataSources().datasets().get(
        #     dataSourceId="derived:com.google.step_count.delta:com.google.android.fit:HMD Global:Nokia 1.4:24a64d0:top_level",
        #     datasetId='0-1684617040860000000',
        #     userId='me').execute()
        body_of={"aggregateBy": [{
    "dataTypeName": "com.google.step_count.delta",
    "dataSourceId": "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
  }],
  "bucketByTime": { "durationMillis": 86400000 },
  "startTimeMillis": 1684357199000,
  "endTimeMillis": 1684789199000
}
        estek = service2.users().dataset().aggregate(userId='me',body=body_of).execute()
        # print(type(body_of))
        # print(dir(estek))
        # members = [attr for attr in dir(estek) if not callable(getattr(estek, attr)) and not attr.startswith("__")]
        # print (estek)
        for bucket in estek['bucket']:
            # print(bucket['dataset'])
            print(bucket['dataset'][0]['point'][0]['value'][0]['intVal'])
            sum_of_data+=bucket['dataset'][0]['point'][0]['value'][0]['intVal']
        print(sum_of_data)
        # print('The title of the document is: {}'.format(document.get('title')))
        # print('The response of the request is: {}'.format(respon))
    except HttpError as err:
        print(err)
    # print(dir(respon))
    # step=list(respon)
    # print('the data itself : ',respon['point'])

if __name__ == '__main__':
    main()