# Matts Member+Friendship API Submission

Hello! The updates in this PR aim to demonstrate my ruby programming abilities and rails API design experience.

Since I am applying for the API Architect position, my changes are all backend with a focus on only the API. ( No UI )

I've implemented the [jsonapi-resources gem](https://jsonapi-resources.com) to model best practices as if this were a real project I might work on at Everly Health.

## Requirement Implementation Details

Here is a re-listing of the readme requirements, along with comments or links to help with understanding my implementation.

> A member can be created using their name and a personal website address
* See [requests/members_spec.rb#L26](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/spec/requests/members_spec.rb#L26) and create curl examples below.

> When a member is created, all the heading (h1-h3) values are pulled in from the website to that members profile.
* See [Member#generate_profile_metadata method](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/app/models/member.rb#L6) and [models/member_spec.rb](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/spec/models/member_spec.rb#L4)

> The website url is shortened
* See "Implement functional url shortener" [commit](https://github.com/EverlyWell/backend-challenge/pull/15/commits/ec34268d78bde29fac831a8dfd92fd691abb2edc)

> After the member has been added, I can define their friendships with other existing members.
* See  "add Friendship model/controller" [commit](https://github.com/EverlyWell/backend-challenge/pull/15/commits/962179392dca0704b8abafe7e78898eea8f89bb7), [requests/friendships_spec.rb#L24](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/spec/requests/friendships_spec.rb#L24), and curl example below. 

> The interface should list all members with their name, short url and the number of friends.
* See [requests/members_spec.rb#L50](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/spec/requests/members_spec.rb#L50) and curl examples below.

> Viewing an actual member should display the name, website URL, shortening, website headings, and links to their friends' pages.
* See [resources/member_resource.rb](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/app/resources/member_resource.rb), and curl examples below. 

> Now, looking at Alan's profile, I want to find experts in the application who write about a certain topic and are not already friends of Alan.
Results should show the path of introduction from Alan to the expert e.g. Alan wants to get introduced to someone who writes about 'Dog breeding'. Claudia's website has a heading tag "Dog breeding in Ukraine". Bart knows Alan and Claudia. An example search result would be Alan -> Bart -> Claudia ("Dog breeding in Ukraine").
* This requirement is tricky since I haven't added any UI. I've implemented filtering functionality that I think could be leveraged to satisfy this requirement by a frontend developer. See [member_resource.rb#L11](https://github.com/EverlyWell/backend-challenge/blob/ec34268d78bde29fac831a8dfd92fd691abb2edc/app/resources/member_resource.rb#L11) and curl example below.

I hope you enjoy reviewing this code! If I had additional time, I would integrate more API tooling such as postman, or a more robust framework, like https://www.graphiti.dev

## Example Curl Requests

( Note, examples require curl and jq CLI installations and some assume data exists. The ids displayed may not match locally. )

### Creating Members

```
curl -X POST http://localhost:3000/members.json -H "Content-Type: application/vnd.api+json" -H "Accept: application/vnd.api+json" --data-binary @- <<DATA
{
 "data": {
  "type": "members",
  "attributes": { "first-name": "Matt", "last-name": "Meyer", "url": "https://mmeyer.dev" }
 }
}
DATA

curl -X POST http://localhost:3000/members.json -H "Content-Type: application/vnd.api+json" -H "Accept: application/vnd.api+json" --data-binary @- <<DATA
{
 "data": {
  "type": "members",
  "attributes": { "first-name": "Sandi", "last-name": "Metz", "url": "https://sandimetz.com" }
 }
}
DATA

curl -X POST http://localhost:3000/members.json -H "Content-Type: application/vnd.api+json" -H "Accept: application/vnd.api+json" --data-binary @- <<DATA
{
 "data": {
  "type": "members",
  "attributes": { "first-name": "Claudia", "last-name": "TheDogExpert", "url": "https://www.dog-breeds-expert.com" }
 }
}
DATA
```

### Viewing an individual member, with included friendship data

```
$ curl -X GET http://localhost:3000/members/4.json?include=friendships | jq
{
  "data": {
    "id": "4",
    "type": "members",
    "links": {
      "self": "http://localhost:3000/members/4"
    },
    "attributes": {
      "first-name": "Matt",
      "last-name": "Meyer",
      "url": "https://mmeyer.dev",
      "short-url": "http://localhost:3000/su/4",
      "profile-metadata": {
        "h1": [
          "Matthew Meyer"
        ],
        "h2": [],
        "h3": [
          " Greetings!",
          " Links"
        ]
      }
    },
    "relationships": {
      "friendships": {
        "links": {
          "self": "http://localhost:3000/members/4/relationships/friendships",
          "related": "http://localhost:3000/members/4/friendships"
        },
        "data": [
          {
            "type": "friendships",
            "id": "2"
          },
          {
            "type": "friendships",
            "id": "3"
          },
          {
            "type": "friendships",
            "id": "4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2",
      "type": "friendships",
      "links": {
        "self": "http://localhost:3000/friendships/2"
      },
      "attributes": {
        "member-id": 4,
        "friend-id": 8,
        "friend-full-name": "Claudia Expert",
        "friend-profile-url": "https://www.dog-breeds-expert.com/"
      }
    },
    {
      "id": "3",
      "type": "friendships",
      "links": {
        "self": "http://localhost:3000/friendships/3"
      },
      "attributes": {
        "member-id": 4,
        "friend-id": 9,
        "friend-full-name": "Foo Expert",
        "friend-profile-url": "https://www.fooexpert.null"
      }
    },
    {
      "id": "4",
      "type": "friendships",
      "links": {
        "self": "http://localhost:3000/friendships/4"
      },
      "attributes": {
        "member-id": 4,
        "friend-id": 10,
        "friend-full-name": "Bar Expert",
        "friend-profile-url": "https://www.barexpert.null"
      }
    }
  ]
}
```

### Creating friendships
```
$ curl -X POST http://localhost:3000/friendships.json -H "Content-Type: application/json" --data '{ "member_id": 4, "friend_id": 8 }' | jq
{
  "id": 2,
  "member_id": 4,
  "friend_id": 8,
  "created_at": "2021-11-16T20:18:40.536Z",
  "updated_at": "2021-11-16T20:18:40.536Z"
}
```

### Filtering members by profile metadata
```
$ curl -X GET -g http://localhost:3000/members.json?filter[profile_metadata]=Dog | jq
{
  "data": [
    {
      "id": "8",
      "type": "members",
      "links": {
        "self": "http://localhost:3000/members/8"
      },
      "attributes": {
        "first-name": "Claudia",
        "last-name": "Expert",
        "url": "https://www.dog-breeds-expert.com/",
        "short-url": "http://localhost:3000/su/8",
        "profile-metadata": {
          "h1": [
            "Dog Breeds Expert"
          ],
          "h2": [
            "October Photo Competition Winner",
            "Breed Photos",
            "Interviews with Breed Owners",
            "Dog Breeds Expert",
            "Dog Breeds By Size",
            "Curious About Other Features?",
            "Maybe Your Curiosity Leads You to...",
            "Dogs to Avoid Unless You're an Expert",
            "Dog of the Month!",
            "Photo Competition",
            "Recent Articles"
          ],
          "h3": [
            "NEW PAGE- Rainbow Bridge",
            "Small Dog Breeds",
            "Medium Dog Breeds",
            "Large Dog Breeds",
            "Giant Dog Breeds",
            "Popular Dog Breeds",
            "Smart Dog Breeds",
            "Non Allergic Dog Breeds",
            "Non-Shedding Dog Breeds",
            "Best Dogs for Kids",
            "Watchdog Breeds",
            "Guard Dog Breeds",
            "Dogs That Drool",
            "Unusual Dog Breeds",
            "Bull Dog Breeds",
            "Calm Dog Breeds",
            "Unique Dog Breeds",
            "Dog Fighting Breeds",
            "Dangerous Dog Breeds",
            "Read The Latest Dog News From Around The World",
            "Dog Photo Competition",
            "BUILD YOUR OWN ONLINE BUSINESS"
          ]
        }
      },
      "relationships": {
        "friendships": {
          "links": {
            "self": "http://localhost:3000/members/8/relationships/friendships",
            "related": "http://localhost:3000/members/8/friendships"
          }
        }
      }
    }
  ]
}
```