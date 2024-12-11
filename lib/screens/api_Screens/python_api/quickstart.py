from __future__ import print_function

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

rob3_sa3a=900000000000
# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/fitness.activity.read']

# The ID of a sample document.
DOCUMENT_ID = '195j9eDD3ccgjQRttHhJPymLJUCOUjs-jmwTrekvdjFE'


def main():
    """Shows basic usage of the Docs API.
    Prints the title of a sample document.
    """
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
                'H:/biomedecal engineering/GP/api/python_api/credentials.json', SCOPES)
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
        respon = service2.users().dataSources().datasets().get(dataSourceId="raw:com.google.step_count.cumulative:HUAWEI:MAR-LX1M:8bccd6d0:step counter",datasetId='1684674000000000000-1684677600000000000',userId='me').execute()
        # print('The title of the document is: {}'.format(document.get('title')))
        print('The response of the request is: {}'.format(respon))
    except HttpError as err:
        print(err)
    # print(dir(respon))
    step=list(respon)
    print('the data itself : ',respon['point'])

if __name__ == '__main__':
    main()

    # 1684749600000
    # https://fitness.googleapis.com/fitness/v1/users/me/dataSources/"raw:com.google.step_count.cumulative:HUAWEI:MAR-LX1M:8bccd6d0:step counter"/datasets/1684674000000000000-1684749600000000000