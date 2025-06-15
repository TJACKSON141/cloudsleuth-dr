import boto3
import os

def lambda_handler(event, context):
    accelerator_client = boto3.client('globalaccelerator', region_name=os.environ['eu-west-2'])

    try:
        
        response_primary = accelerator_client.update_endpoint_group(
            EndpointGroupArn=os.environ['PRIMARY_ENDPOINT_GROUP_ARN'],
            EndpointConfigurations=[
                {
                    'EndpointId': os.environ['PRIMARY_ENDPOINT'],
                    'Weight': 0
                }
            ]
        )
        print(f"Primary endpoint weight updated: {response_primary}")

       
        response_secondary = accelerator_client.update_endpoint_group(
            EndpointGroupArn=os.environ['SECONDARY_ENDPOINT_GROUP_ARN'],
            EndpointConfigurations=[
                {
                    'EndpointId': os.environ['SECONDARY_ENDPOINT'],
                    'Weight': 128
                }
            ]
        )
        print(f"Secondary endpoint weight updated: {response_secondary}")
    except Exception as e:
        print(f"Failed to update endpoint weights: {str(e)}")
        raise e