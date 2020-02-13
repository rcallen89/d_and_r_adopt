# Adopt Don't Shop Paired Project
BE Mod 2 Week 2/3 Pair Project

## Application Description

"Adopt Don't Shop Paired" is a fictitious pet adoption platform where visitors can favorite pets and apply to adopt their newest furry friend.

There are no different user levels so all visitors can do the following:
* Create, Edit, and Delete Shelters
* Create, Edit, and Delete Pets
* Create, Edit, and Delete Reviews for Shelters

### Pets
* Pets are created by going through a Shelter page into their pet page.  Pets require a name, sex, age, description and image.  Image is a url path to an image.  Failure to input all the correct information will result in a flash message with what is missing.
* Pets can be edited through the Pet show page.  Similar requirements to creating a pet.
* Pets can also be favorited through the Pet Show page.
* Pets can only be deleted if they don't have an approved application on them.

### Shelters
* Shelters can be created through the Shelter index page.  All fields are required.
* Shelters can be deleted from the Shelter Index page as well as their show page.  Deleting a shelter will remove all of it's pets as long as they don't have an approved application.
* Reviews for shelters can be left through each Shelter Review page.  They require a title, rating, and description.  If an image isn't provided a default one will be used.

### Applications
* Any favorited pet can be applied for adoption.
* All favorited pets will appear as an option on the Adoption Application.  A minimum of one pet has to be applied for.
* Any pets applied for are removed from the favorites.
* Pets can be approved through the application.  To revoke an approval, it has to be done through the apporving Application.

## Installation
* Clone down the repo
* Run `bundle install`
* Run `rails db:{create,migrate,seed}` to setup the database
* Run ` rails s` and navigate your browser to localhost:3000 to use the development database

## Production
* The production side is located at https://d-and-r-adopt.herokuapp.com/shelters

