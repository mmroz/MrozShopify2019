Mark Mroz Shopify 2019 Application
========================

### General Notes

My solution for: https://docs.google.com/document/d/1h3TFW9HhFxBVrmgd33dNrUiJx31NQFn6dpZHrbrSP-U/edit#

Design:

Network Manager - used to coordinate all network calls and acts as a cental API for shopfiy data
Router - The base class to make network call and instatiate new EndPoints
ImageLibrary - an image cacher to reduce network calls

CustomCollection View Controller - list of all cust collections
CustomCollectionDetail View Controller - All products for a custom collection
