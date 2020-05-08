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