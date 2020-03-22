# README

## Webhook endpoint

> POST /api/v1/webhooks/handle

It can receive any data. Payload is going to be saved on database, and some github header is going to be used to get other data, like event type and signature.

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

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
