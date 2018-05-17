# URL SHORTENER
#### [URL SHORTENER](https://sunny-url-shortener.herokuapp.com/) on Heroku

## Assumptions
1. Statistics on the shortened url is not mission critical, application layer tracker might not work well due to  crawlers.
2. The user experience needs to be smooth.
3. URLs never expire
4. Equal Read/Write requirements in the database
5. If base url exists then application will always return the existing shortened url

## Design Decisions
### Base62 Encoding of char length 6
This allows me to have up to 62^6 different permutations. I wouldnt advice using the other two characters "+" & "/" due to web requirements.

### Data Columns & Types
Due to time constraints, I left the total_visits property as a column in the short_urls table this is the lowest resolution we can get towards tracking the url. I would have liked to move it out into a separate table that held each visit as a row, in doing so I would have been able to track multiple other properties of the visit such as country, device type and time of visit.

I've left the base_url to be of type text as that allows the url to be larger than 255 characters. Because we are keeping the shortened url as small as possible, I feel that the string type would suffice for the shortened url.

### UI/UX
Added little bit of humour, shortening URLs can get pretty mundane. Decided to keep it simple because people are on that page to shorten the url, not to see a 30-second animation.

### Deployment
Deploying it on heroku is okay because this is an exercise. In reality, because I would like to get more insights into the service and it's performance, I would rather host in on AWS. That way, I can better track how the service is growning and add other services to assist with caching requests.

## Things I would have like to do
### User Facing Features
Assuming that we built this to improve sharing of moneysmart's links via the team, here some of the things I would have liked to add:

1. The URL no longer contains any details to the content of the URL. This is not a great user experience for the person doing the clicking. Build a preview feature for the link, that users can preview on the site.

2. Administrative feature to track the different urls through statistics such as total visits, that can then visually further break down the data by attributes such as country, device type and time of visit. This would allow the admins to know who has clout in which segments.

3. Ability to share shortened link via social media, because how else would you reach us millenials. :P

### Development & Technology Improvements
1. Use deterministic hashing algorithm that uses the base10 representation of the url's primary key and encode it into base62. This would allow the reversal of a url to a hash and vice versa without the need to store the values in a database, given that the encoding strategy never changes.

2. Add CI/CD tools to prevent bad code pushes.

3. Optimize site for reads through better caching strategies.

4. Better URL sanitization strategy to look at things like "http://google.com" vs. "http://www.google.com" vs. "http://www.google.com/" and malicious JS code.
