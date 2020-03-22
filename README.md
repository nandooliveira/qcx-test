# README

## Webhook endpoint

> POST /api/v1/webhooks/handle

This endpoint can receive any data. Payload is going to be saved on database, and some github header is going to be used to get other data, like event type and signature.

## Endpoints:

### Get all events of a issue:
```bash
curl http://localhost:3000/api/v1/issues/:issue_number/events --user email:password | python -m json.tool
```

Example result:
```json
[
    {
        "created_at": "2020-03-21T22:31:57.176Z",
        "delivery": "bdbb21d4-6bd9-11ea-974e-cdb49a2bd262",
        "event_type": "issues",
        "id": 8,
        "payload": {
            "action": "opened",
            "issue": {
                "number": 1349,
                "url": "https://api.github.com/repos/octocat/Hello-World/issues/1347"
            },
            "repository": {
                "full_name": "octocat/Hello-World",
                "id": 1296269,
                "owner": {
                    "id": 1,
                    "login": "octocat"
                }
            },
            "sender": {
                "id": 1,
                "login": "octocat"
            }
        },
        "updated_at": "2020-03-21T22:31:57.176Z"
    }
]
```

* Ruby version

ruby 2.6.3p62 (2019-04-16 revision 67580)

* How to run this project locally

1. Clone this repository:

```sh
git clone git@github.com:nandooliveira/qcx-test.git
```

2. Go inside the directory:

```sh
cd qcx-test
```

3. Install all required gems:

```sh
bundle install
```

4. Create database and tables:

```sh
rails db:create
rails db:migrate
```

5. Configure Environment Variables. To do that in development and test environment, just copy the `.env-sample` file renaming it to `.env` and edit the file with your configuration:

```sh
cp .env-sample .env
```

Example of a valid `.env` file:

```sh
EMAIL=test@gmail.com
PASSWORD=123456
SECRET_TOKEN=d42fb616d55a3f066f066b9cf8aae59bc2479115c6e52a4ac70e30f49882b973
```

**Obs1.:** This `SECRET_TOKEN` is going to be used to protect your webhook endpoint, if you do not add this token when configuring the webhook on your repository the request are going to return `Unhautorized`.
**Obs2.:** To generate a good `SECRET_TOKEN` you can use ruby to generate a 32 bit hex key:

```sh
" Enter in rails console
rails c

" In rails console generate a new key
2.6.3 :001 > p SecureRandom.hex(32)
"440080ec279c90c85b6be9cca342142396323ff6b2ac356962bdd42ff4ab12e1"
```

6. Last step, just run the server:

```sh
rails s
```

* How to run the test suite

```sh
bundle exec rspec spec
```
