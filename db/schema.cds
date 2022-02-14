namespace sap.capire.bookshop;
//using common model giving absolute reference
//so the framework is lookinginto node modules and .cds file
using { Currency, managed, cuid } from '@sap/cds/common';

//use the product entity, imported from this project
//using {sap.capire.products.Products} from '../../products';

//additionalInfo aspect is added to books entity
entity Books : managed, additionalInfo {
  key ID   : Integer;
  title    : localized String(111);
  descr    : localized String(1111);
  //assosiation to Authors, no cardinality specified so ass. to 1 author
  //1 book has only 1 author
  author   : Association to Authors;
  stock    : Integer;
  price    : Decimal(9,2);
  currency : Currency;
}

entity Authors : managed {
  key ID   : Integer;
  name     : String(111);
  //ass. to many books, an author can have many books
  books    : Association to many Books on books.author = $self;
}

entity Orders : managed, cuid {
  // this is not needed as cuid is added -> key ID   : UUID;
  OrderNo  : String @title:'Order Number'; //> readable key
  //composed of many order items, an item cannot exist without an order
  Items    : Composition of many OrderItems on Items.parent = $self;
}
entity OrderItems: cuid {
  // this is not needed as cuid is added -> key ID   : UUID;
  parent   : Association to Orders;
  //order items are books
  book     : Association to Books;
  amount   : Integer;
}

//add aspects also to another entity
entity Movies: additionalInfo {
    key ID: Integer;
    name: String(111);

}

aspect additionalInfo {
    genre: String(100);
    language: String(200);
}