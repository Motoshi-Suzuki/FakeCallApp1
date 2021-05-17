import boto3
from botocore.exceptions import ClientError

client = boto3.client('cognito-idp')

def lambda_handler(event, context):
    print(event)
    print('おはよう')
     
    try:
        response = client.admin_add_user_to_group(
            UserPoolId=event['userPoolId'],
            Username=event['userName'],
            GroupName='SignInUser'
        )
        
    except ClientError as e:
        print(e.response['Error']['Message'])
    
    return event