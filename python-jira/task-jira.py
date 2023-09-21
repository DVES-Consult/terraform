from jira import JIRA 

jira_connection = JIRA(
    basic_auth=('email', 'api_token'),
    server="https://dves-cloud.atlassian.net"
)

issue_dict = {
    'project': {'key': 'DC'},
    'summary': 'Testing issue from Python Jira Handbook',
    'description': 'Detailed ticket description.',
    'issuetype': {'name': 'Task'},
}

issue = jira_connection.create_issue(fields=issue_dict)
jira_connection.add_attachment(issue=issue, attachment='python-jira/teste.json')
