# EverlyWell Backend Challenge

### Overview

Using a language and framework of your choice, we'd like you to create a simple experts directory search tool. The tool can either be a full featured application or API only.

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
* Create a new branch to push your commits as you work
* When complete, create a PR to the master branch (of your personal repo) so we can see the code that you added!
* Somehow share your repository with us
* __Important:__ If there are credentials required (.env or master.key file), please email these to us directly or we can’t review your project
