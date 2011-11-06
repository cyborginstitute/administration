========================
Web Service Architecture
========================

This document provides an overview of administration and architecture
of web-based services. For better or for worse, most "real" systems
administration work involves a fair amount of wrangling HTTP servers,
so the core information in this document will likely be useful to
most. As a secondary benefit, HTTP provides a good basis to
address a number of key service-administration topics and
issues, which are relevant to all systems administrators.

Technology Overview
-------------------

HTTP Protocol
~~~~~~~~~~~~~

There's more to the Internet and to network services than HTTP and
"the web," and while I'm loathe to conflate HTTP and "the Internet,"
for practical purposes, it's too late. I comfort myself by thinking
that HTTP has become the UNIX-pipe of the Internet. Web browsers, of
course implement HTTP, but for testing purposes you should familarize
yourself with ``curl``, which is a versatile command line HTTP
client (among other protocols.)

There are a few terms that you may find useful.

.. glossary::

   client
      The software that sends requests to a server in the of receiving
      data (a :term:`resource`) in response. HTTP clients (typically)
      place requests to servers listening on port 80. HTTPS clients
      pace requests to servers listening on port 443. My applications
      implement HTTP clients and most programming languages have
      robust libraries that provide HTTP support.

   server
      A system that responds to client requests and returns
      resources. HTTP servers listen for requests on port 80; however
      can be configured to run on any port.. HTTPS servers listen for
      requests on port 443. Recently, non-world-wide-web services
      (i.e. RESTful APIs, Application Servers, databases like CouchDB.)

   resource
      The content returned by the :term:`server` in response to a
      :term:`request`, except for that data which is in the
      :term:`header`. The HTTP response header

   request
      The message sent from a :term:`client` to a :term:`server`
      HTTP defines several different types of requests, discussed in
      :ref:`HTTP requests <http-request-types>`.

   status code
      All responses from an HTTP server, include a status code, which
      are outlined in :ref:`HTTP status codes <http-status-codes>`.

   header
      The metadata transmitted with a given request or response. See
      :ref:`headers <http-header>` for more information.

   httpd
      A daemon that implements the HTTP protocol. Historically,
      this has refereed to the NCSA httpd and its successor the Apache
      HTTPD Server, though the name is generic, and can refer to any
      HTTP server, typically multi-purpose ones running on Unix-like
      systems.

This section will use and more thoroughly define these terms.

.. _http-headers:

Headers
```````

HTTP transmits :term:`metadata` regarding content in :term:`key/value`
pairs called headers. Headers are largely arbitrary, though different
kinds of clients have different requirements around headers. Use
"``curl -I``" to return a list of headers. See the following headers
from ``tychoish.com``: ::

      Server: nginx/0.7.67
      Date: Sun, 06 Nov 2011 14:26:07 GMT
      Content-Type: text/html
      Content-Length: 8720
      Last-Modified: Fri, 04 Nov 2011 13:39:02 GMT
      Connection: keep-alive
      Accept-Ranges: bytes

HTTP also provides for a set of headers in the request. They take the
same key/value form as response headers, though with a different set
of keys.

.. _http-statuses:

Status (Error) Codes
````````````````````

When you run "``curl -I``"  the first response line provides the HTTP
status, this (as follows) was omitted from the above example:  ::

      HTTP/1.1 200 OK

This conveys the version of the HTTP protocol used (basically
everything is v1.1, or trying to be,) a status code (e.g. 200,) and
then some human intelligible translation of this code. You likely
already know code ``404`` which is returned when the server can't find
the resource requested. ``200`` is, as above the status code for
"resource returned successfully."

There are a few dozen HTTP codes, you can generally gauge someone's
overall level of geekiness/free time by their ability to translate
HTTP codes without looking at a reference card. In general, 300 series
codes reflect a redirection (e.g. "the resource you're looking for is
somewhere else,") 400 series code reflect some sort of error or
problem that the server has with the request, and 500 series requests
reflect some sort of "internal error," usually related to the server's
configuration or state.

The following codes are useful to know on sight. Use a reference for
everything else:

========  ==============================================================
**Code**  **Meaning**
--------  --------------------------------------------------------------
  200     Everything's ok
  301     Resource Moved Permanently. Update your bookmarks.
  302     Moved Temporarily. Don't update your bookmarks.
  400     Error in request syntax. Client's fault.
  401     Authorization required. Use HTTP Auth to return the resource
  403     Access Denied. Bad HTTP Auth credentials or permissions.
  404     Resource not found. Typo in the request, or data not found.
  410     Resource removed from server. This is infrequently used.
  418     I'm a tea pot. From an April Fools RFC, and socially useful.
  500     Internal server error. Check configuration and error logs.
  501     Requires unimplemented feature. Check config and error logs.
  502     Bad gateway. Check proxy configuration. Upstream server error.
  504     Gateway timeout. Proxy server not responding.
========  ==============================================================

.. _http-requests:

Requests
````````

HTTP provides a very full featured interface for interacting with
remote resources, although it's easy to forget everything beyond the
``GET`` and ``POST`` request types. Requests are generally refereed to
as "methods," in common parlance. Adhering more strictly to HTTP
methods, is one of the defining aspects of ":term:`REST`" but
commonly, application interfaces will just use GET and PUT
operations.

.. glossary::

   GET

   PUT

   POST

   DELETE

   HEAD

Services
~~~~~~~~



Web Server Fundamentals
-----------------------

HTTP and Static Content
~~~~~~~~~~~~~~~~~~~~~~~

HTTP is really designed to serve static text. Most web browsers do
this

CGI and FastCGI
~~~~~~~~~~~~~~~

Embeded Dynamic Content
~~~~~~~~~~~~~~~~~~~~~~~

Distributed Systems
-------------------

Next Wave HTTPDs
----------------

Lighttpd
~~~~~~~~

nginx
~~~~~

AntiWeb
~~~~~~~

Apache HTTPD
------------

Application Servers
-------------------

Rails, Python, and The New Old
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SGI Maddness: SCGI, WSGI, UWSGI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deploying Application Servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Load Balancing and Proxies
--------------------------

URL Rewriting
-------------

