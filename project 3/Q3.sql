/**
The first index is on the area code of the phone number of organizations. This index is useful because it speeds up
organization search queries. In our application, users can choose to include their living location. Therefore, organization
searches can inlcude the option "organizations in my area", which limits the results to organizations that are in the same
area code as the users location (This is different from filtering the organizations searches by location, as area codes may include more than one
locations or citites, but they are still geographically nearby).
 */
CREATE INDEX area_code ON Organization(substring(phone_number, 2, 3));

/**
The second index is on the first name and last name of users. This index is useful because it speeds up user search queries.
In our application, users can enter names in the search bar, and when they press the search button, the get a list of users
that have the name they entered (like in facebook). The index includes both the first name and last name as the search bar filter
is for the users' full names.
 */
CREATE INDEX user_name ON Users(first_name, last_name);