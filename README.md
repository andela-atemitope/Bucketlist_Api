## Bucketlist_API


[![Test Coverage](https://codeclimate.com/repos/5673e866fa66501c2b000c0c/badges/9bec07380d8a95a57416/coverage.svg)](https://codeclimate.com/repos/5673e866fa66501c2b000c0c/coverage)



[![Code Climate](https://codeclimate.com/repos/5673e866fa66501c2b000c0c/badges/9bec07380d8a95a57416/gpa.svg)](https://codeclimate.com/repos/5673e866fa66501c2b000c0c/feed)

### Bucketlist
A list of activities someone wants to do before they die is often called a bucket list, because it is a list of things a person wants to do before they "kick the bucket."
This API provides the features for a bucketlist via a RESTFUL API which uses JSON Web Tokens(JWT) for its Authenticaton. 

Kindly refer to `http://bucketlist-api.herokuapp.com` to view the full documentation for this RESTFUL API

## End Points Functionalities
|End Point| Function  |
|---------------------|:----:|
|**POST /auth/login:** |Logs a user in
| **GET /auth/logout:**| Logs a user out
| **POST /bucketlists:**| Creates a new bucket list
| **GET /bucketlists:**| Lists all the created bucket lists
|**GET /bucketlists/(id):**| Gets a single bucket list
| **PUT /bucketlists/(id):** |Updates this single bucket list
| **DELETE /bucketlists/(id):**| Deletes this single bucket list
| **POST /bucketlists/(id)/items:** |Creates a new item in bucket list
|**PUT /bucketlists/(id)/items/(item_id):**| Updates a bucket list item
|**DELETE /bucketlists/(id)/items/(item_id):**| Deletes an item in a bucket list

## Data Model
 The JSON data model for a bucket list and a bucket list item is shown below.

```
{
    id: 1,
    name: “BucketList1”,
    items: [
           {
               id: 1,
               name: “Visit Zanzibar”,
               date_created: “2015-25-12 12:00:00”,
               date_modified: “2015-25-12 12:00:00”,
               done: False
             }
           ]
    date_created: “2015-25-12 1:00:00”,
    date_modified: “2015-25-12 1:00:00”
    created_by: “Project User's Name”
}
```

## Authentication
Json Web Tokens(JWT), Token Based System was used for this API. With this, some end points are not accessible to unauthenticated users. Access control mapping is listed below.

### End Point and Public Access
|End Point| Publicity  |
|---------------------|:----:|
|**POST /auth/login:**| TRUE |
| **GET /auth/logout:**| FALSE|
| **POST /bucketlists:**| FALSE|
| **GET /bucketlists:**| FALSE|
| **GET /bucketlists/(id):**| FALSE|
| **PUT /bucketlists/(id):**| FALSE|
| **DELETE /bucketlists/(id):**| FALSE |
|**POST /bucketlists/(id)/items:**|  FALSE|
| **PUT /bucketlists/(id)/items/(item_id):**| FALSE|
| **DELETE /bucketlists/(id)/items/(item_id):**| FALSE|

## Pagination
This API is paginated such that users can specify the number of results they would like to have via a `GET parameter` `limit`.

#### Example

**Request:**
```
GET https://bucketlist-api.herokuapp.com/v1/bucketlists?page=2&limit=20
```

**Response:**
```
20 bucket list records belonging to the logged in user starting from the 21st bucket list .
```

  ## Searching by Name
  Users can search for bucket list by its name using a `GET parameter` `q`.
  #### Example

  **Request:**
  ```
  GET https://bucketlist-api.herokuapp.com/v1/bucketlists?q=bucket1
  ```

  **Response:**
  ```
  Bucket lists with the string “bucket1” in their name.
  ```

## Versions
This API has only one version for now, and it can be accessed via -
```
https://bucketlist-api.herokuapp.com/v1/endpoint
```


## Contributing
1. Fork the repo.
2. Run the tests. We only take pull requests with passing tests, and it's great
to know that you have a clean slate: `bundle && bundle exec rake`
3. Add a test for your change. Only refactoring and documentation changes
require no new tests. If you are adding functionality or fixing a bug, we need
a test!
4. Make the test pass.
5. Push to your fork and submit a pull request.

#####Syntax:

* Two spaces, no tabs.
* No trailing whitespace. Blank lines should not have any space.
* Prefer `&&`, `||` over `and`, `or`.
* `MyClass.my_method(my_arg)` not `my_method( my_arg )` or `my_method my_arg`.
* `a = b` and not `a=b`.
* Follow the conventions you see used in the source already.
* Deployment instructions

* .....