# EverlyWell Backend Challenge

### Overview

Using Ruby on Rails, we'd like you to create a simple experts directory search tool. The tool can either be a full featured application or API only.

* Spend no more than 4 hours coding for the project. Do not include any initial application setup in this time limit.

### Requirements:

The application should fulfill the following requirements:

* A member can be created using their name and a personal website address.
* When a member is created, all the heading (h1-h3) values are pulled in from the website to that members profile.
* The website url is shortened (e.g. using http://goo.gl).
* After the member has been added, I can define their friendships with other existing members. Friendships are bi-directional i.e. If David is a friend of Oliver, Oliver is always a friend of David as well.
* The interface should list all members with their name, short url and the number of friends.
* Viewing an actual member should display the name, website URL, shortening, website headings, and links to their friends' pages.
* Now, looking at Alan's profile, I want to find experts in the application who write about a certain topic and are not already friends of Alan.
* Results should show the path of introduction from Alan to the expert e.g. Alan wants to get introduced to someone who writes about 'Dog breeding'. Claudia's website has a heading tag "Dog breeding in Ukraine". Bart knows Alan and Claudia. An example search result would be Alan -> Bart -> Claudia ("Dog breeding in Ukraine").

We encourage the use of any libraries for everything except the search functionality, in which we want to see your simple algorithm approach.

### Add-ons:

* Sign up/log in functionality
* A UI that expands upon the basic requirements to have a user-friendly look and feel
* Anything else you, as a user, would enjoy seeing in an interface like this

### Things we're looking for:

* Navigable code
* Efficient algorithms
* Good separation of concerns
* Error handling
* Usage of gems/libraries

### Things we like:

* Well commented & well organized code
* Quality over quantity (the code you write should be good) 
* Small, meaningful, commits
* Tests!
* Respect for the time limit - if you are in the midst of some work that you would like to finish, but have hit the 4 hour time limit, please split additional work into a separate branch, to be evaluated separately

### Submission

* __Fork__ this repository to your own git
* Remember to make meaningful commits as you work
* Somehow share your repository with us
* __Important:__ If there are credentials required (.env or master.key file), please email these to us directly or we can’t review your project
* After you fork the repo, you can run the following commands in your terminal:
        
        bin/setup
        bin/rspec
        
* Feel free to add to add/modify existing specs. Just make sure the original request specs are still present.
* Here are the required routes:
        
        [POST] "/friendships"
        [POST] "/members"
         [GET] "/members"
         [GET] "/members/:member_id"

## Reviewer Setup

1. Clone the candidate's branch
1. Execute the following:

        bin/bundle
        bin/rails db:drop
        bin/setup
        bin/rspec
        
1. [Make a copy](https://docs.google.com/spreadsheets/u/0/d/1t6aY1dpVv4jEG1Xq2x5DHkQrXNsMrJfn_fhdSZM6C_8/copy) of the rubric and fill it in
1. Ensure that the requests specs are the same or improved
1. Add a short summary to the Rubric and share it in our engineering-coding-projects
Slack channel  
