namespace sap.capire.bookshop;
using { Currency, managed } from '@sap/cds/common';

entity Books : managed {
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

entity Orders : managed {
  key ID   : UUID;
  OrderNo  : String @title:'Order Number'; //> readable key
  //composed of many order items, an item cannot exist without an order
  Items    : Composition of many OrderItems on Items.parent = $self;
}
entity OrderItems {
  key ID   : UUID;
  parent   : Association to Orders;
  //order items are books
  book     : Association to Books;
  amount   : Integer;
}