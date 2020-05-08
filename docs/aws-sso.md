# AWS SSO

## Auth0 and Github

- Sign up for Auth0 account
- Create Auth0 OAuth app in Github and add to Auth0
  - https://auth0.com/docs/connections/social/github?_ga=2.196752940.1815818864.1588900204-194080456.1588900204
- AWS SSO with Auth0
  - https://auth0.com/docs/connections/social/github?_ga=2.196752940.1815818864.1588900204-194080456.1588900204
- AWS SAML 
  - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml_assertions.html
- Issues:
  - Under Github connection had to enable `email address`
  - In Rule parse `user.name` to not have any spaces
  
Here is how my current rule looks like - 

```javascript

function (user, context, callback) {

  user.awsRole = 'arn:aws:iam::XXXXXXXXXXXX:role/AWSViewOnlySAML,arn:aws:iam::XXXXXXXXXXXX:saml-provider/auth0SamlProvider';
  user.awsRoleSession = user.name.split(' ').join('-');

  context.samlConfiguration.mappings = {
    'https://aws.amazon.com/SAML/Attributes/Role': 'awsRole',
    'https://aws.amazon.com/SAML/Attributes/RoleSessionName': 'awsRoleSession'
  };

  callback(null, user, context);

}


```

## Using AWS SSO service 
- https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html
- For this setup to work you need to manually provision the user with their emailAddress as username
  - https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-manually.html
  - Auth0 doesn't support SCIM currently - https://community.auth0.com/t/scim-compliance-auth0/11777
    - So can't do auto provisioning of users - https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-automatically.html
- Issues
  - Look at the CloudTrail log to troubleshoot AWS SAML errors, specifically `ExternalIdPDirectoryLogin` event. 
- Here is the SAML setting that finally worked - 
Application callback url: <SAML ACS Url>
```json
{
  "audience": "https://us-east-1.signin.aws.amazon.com/platform/saml/<issuerId>",
  "mappings": {
    "email": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress",
    "name": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
  },
  "createUpnClaim": false,
  "passthroughClaimsWithNoMapping": false,
  "mapUnknownClaimsAsIs": false,
  "mapIdentities": false,
  "nameIdentifierFormat": "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
  "nameIdentifierProbes": [
    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  ]
}

```