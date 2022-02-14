
using { sap.capire.bookshop as my } from '../db/schema';
service CatalogService @(path:'/browse') {

//we get all the property of the book entity (*)
  @readonly entity Books as SELECT from my.Books {*,
    //for the author assosiation we use only the author name
    author.name as author
    //exclude those properties
  } excluding { createdBy, modifiedBy };

  @requires_: 'authenticated-user'
  @insertonly entity Orders as projection on my.Orders;
}