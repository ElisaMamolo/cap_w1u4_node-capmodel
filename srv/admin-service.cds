using { sap.capire.bookshop as my } from '../db/schema';
service AdminService @(_requires:'admin') {
    //expose each entity as they are defined in the data model using projections
  entity Books as projection on my.Books;
  entity Authors as projection on my.Authors;
  entity Orders as select from my.Orders;
  //expose movies entity
  entity Movies as projection on my.Movies;
}