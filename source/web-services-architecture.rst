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

There are a few terms with specific meanings in the context of
HTTP. Consider these basic concepts:

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
      :ref:`HTTP requests <http-requests>`.

   status code
      All responses from an HTTP server, include a status code, which
      are outlined in :ref:`HTTP status codes <http-statuses>`.

   header
      The metadata transmitted with a given request or response. See
      :ref:`headers <http-headers>` for more information.

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
  200     Everything's ok.
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

Often server logs will return more useful information regarding the
state of the system.

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
      Fetch a resource from an HTTP server.

   PUT
      Upload a resource to an HTTP server. Often fails as a result of
      file permissions and server configurations, but don't assume
      that it *will* fail. Less common than :term:`POST`

   POST
      Send a response to a web pages. Submitting web-forms are
      conventionally implemented as POSTS.

   DELETE
      Remove a resource from an HTTP server. Often fails as a result of
      file permissions and server configurations, but don't assume
      that it *will* fail. Used infrequently prior to RESTful
      web APIs.

   HEAD
      Retrieve only the headers without fecthing the body of the
      request.

Services and Scaling
~~~~~~~~~~~~~~~~~~~~

I suspect every other introduction to HTTP and web servers, describe
operations in terms of a single client and a single server. Perhaps
there are even multiple clients but the truth of the matter is that
web server technology has advanced such that any configuration where a
single website or domain is powered by a single :term:`httpd` should
be considered trivial. Although its conceivable, though unlikely, that
your systems will never face :doc:`availability <high-availability>`
or scaling challenges, ignorance is not a wise course.

As an additional concern, cases are emerging where HTTP isn't just for
communication between web servers and web browsers. HTTP APIs of
various sorts use HTTP as a method to communicate with remote
application and information providers, CouchDB uses an HTTP interface
for applications to communicate with a database, and Node.js uses HTTP
as an application transport.

Web Server Fundamentals
-----------------------

HTTP and Static Content
~~~~~~~~~~~~~~~~~~~~~~~

HTTP is really designed to serve static content, and most
general-purpose web servers (and browsers) and optimized to do this
really efficiently. Web browsers are configured to make multiple
requests in parallel to download embeded content (i.e. images, style
sheets, JavaScript) or web pages "all at once," rather than
sequentially." General purpose HTTPDs are also pretty good at
efficiently serving this kind of content. The main things to remember
are:

- Make sure that you're not serving static content (i.e. anything that
  the web/application server needs to modify) from a
  low-volume/single-threaded application server. This is an easy one
  to miss depending on how your development/test environment is
  configured.

- Use some sort of caching service, if needed. It's an additional
  layer of complexity, but using a front-end caching proxy like
  `Varnish <https://www.varnish-cache.org/>`_ or `Squid
  <http://www.squid-cache.org/>`_ can cache data in RAM and return
  results more quickly, which is useful in certain kinds of
  high-volume situations with certain kinds of applications. Caches
  are great, but they don't solve underlying problems, and they add an
  additional layer of complexities.

- Make sure all resources/assets originate from the same domain, if
  possible. Use a "``static.example.net``" if necessary, but being
  consistent with your domain usage can help your browser cache things
  more effectively. It also makes it easier for *you* to understand
  your own setups later. Keep things simple and organized.

Serving static content with HTTP is straightforward, when you need to
dynamically assemble content per-request, a more complex system is
required. The kind of dynamic content you require and the kinds of
existing applications and tools that you want to use dictate your
architecture--to some extent--from here.

.. _cgi-app-servers:

Common Gateway Interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~

CGI, FastCGI, SCGI, PSGI, WSGI, and Rack are all protocols used by web
servers to communicate with applications. Simply, users place HTTP
requests with a web server (:term:`httpd`,) which creates or passes
the request to a separate process, which generates a response that it
hands back to the HTTP server that returns the result to the
user. While this seems a bit complex, in practice CGI and related
protocols have simple designs, robust tool-sets, are commonly
understood by many developers, and (generally) provide excellent
process/privilege segregation.

There are fundamental differences between these protocols, even though
their overall method of operation is similar. Consider the following
overview:

.. glossary::

   CGI
      Common Gateway Interface. CGI is the "original" script gateway
      protocol. CGI is simple and easy to implement, but every request
      requires the webserver to create a new process, or copy of the
      application in memory, for the length of the request. The
      per-request process creation and tear-down doesn't scale well
      with database connections and large request loads.

   FastCGI
      FastCGI attempts to solve the process creation/tear-down
      overhead, by daemonizing he application, resources can be reused
      (i.e. process initialization, database connections, etc.) which
      greatly increases performance over conventional
      :term:`CGI`. However, FastCGI is more complex to implement, and
      typically FastCGI application instances have lower
      request-per-second-per-instance capacities than HTTP servers,
      which creates a minor architectural challenge. Also, to deploy
      new application code, FastCGI processes need to be restarted
      which may interrupt client requests.

   WSGI
      Web Server Gateway Interface (sometimes pronounced *wisgy* or
      *wisky*.) WSGI provides a method for web applications to
      communicate with conventional HTTP servers. WSGI was developed
      by the Python community, and is typically used by applications
      written in this language, though the interface is not
      necessarily Python specific. WSGI is easy to use, though the
      exact method of deployment and operation varies slightly by
      implementation.

   PSGI
      Perl Web Server Gateway. PSGI provides an interface, *a la*
      :term:`WSGI` between Perl web applications and other CGI-like
      servers. Indeed, PSGI primarily describes a tool-set for writing
      web applications rather than a particular interface or protocol
      to web servers (as PSGI applications can be made to run with
      CGI, FastCGI or HTTP interfaces.)

   SCGI
      Simple Common Gateway Interface. SCGI is operationally similar
      to :term:`FastCGI`, but the protocol is designed to appear more
      like :term:`CGI` applications.

   Rack
      Rack is a Ruby-centric (and inspired :term:`PSGI`) web-server
      interface that provides an abstraction layer/interface between
      web servers and Ruby applications that "appears native" to Ruby
      developers.

While CGI and FastCGI defined dynamic applications from the earliest
days of HTTP and the web, the other above mentioned interface methods
seem largely emerged in the context of recent web application
development frameworks like "Ruby on Rails" and "Django."

.. _http-app-servers:

HTTP App Servers
~~~~~~~~~~~~~~~~

Recently, a class of application servers have emerged that implement
HTTP instead of some intermediate protocol. While very efficient for
serving dynamic content, they're less efficient for serving static
resources and cannot support heavy loads. As a result these
application servers are typically clustered behind a general purpose
``httpd`` that can proxy requests back to the application server. In
this respect, such servers are operationally similar to
:term:`FastCGI` application servers, but are easier to develop
applications for and are (theoretically) more simple
operationally. Examples of these kinds of application servers include:
Thin, Mongrel, Twisted, and Node.js.

Embeded Interpreters
~~~~~~~~~~~~~~~~~~~~

In contrast to the various web server/gateway interfaces, the other
major paradigm of web application deployment centers on emending the
program or the programming language itself within the webserver
process. Implementations vary by language and by webserver. Typically
these methods are *very* powerful, and *very* fast, but are
idiosyncratic. For a quite a while, these methods were the prevailing
practice for deploying dynamic content.

This practice is most common in context of the Apache HTTPD Server
with Perl (and ``mod_perl``) and PHP (``mod_php``). While there are
also Ruby (``mod_ruby``) and Python (``mod_python``) implementations
of these methods, development on these methods has been abandoned and
other methods are strongly preferred.

With the exception of ``mod_php``, the embeded interpreters all
require you to restart Apache when deploying new code. Additionally,
all code run by way of an interpreter embeded in the web server
process runs with the permissions of the web server. These operational
limitations make this approach less ideal for shared environments.

Because most of the "next wave," web application servers use some sort
of gateway interface or return HTTP itself, I fear the embeded option
is neglected unfairly. While there are limitations that you must
consider, there are a number of very good reasons to deploy
applications using Apache itself as the application server. Consider
the following:

- ``mod_perl`` is very efficient, and not only provides a way to run
  CGI-style scripts, but also exposes most of the operation of Apache
  to Perl-scripting. In some advanced cases this level of flexibility
  may provide enough benefit to indicate using ``mod_perl`` and
  Apache over other options.

- ``mod_php`` has comparable performance to other methods of running
  PHP scripts, and is significantly easier to deploy applications
  using ``mod_php`` than most other methods of deploying PHP.[#fpm]_
  Because ``mod_php`` is so easy to use, I suspect that most PHP code
  is developed in this environment: I suspect that a great deal of
  common conception that "PHP just works," is due to the ease of use
  of ``mod_php``

.. [#fpm] In the last couple of years, `PHP-FPM
   <http://php-fpm.org/>`_ has made PHP much easier to run as
   :term:`FastCGI`.

Distributed Systems
-------------------

TODO write about distributed application architectures.

HTTPD Options
-------------

TODO overview of general purpose HTTP servers.

Lighttpd
~~~~~~~~

nginx
~~~~~

AntiWeb
~~~~~~~

Apache HTTPD
~~~~~~~~~~~~

Application Servers
-------------------


Embedded Interpreters
~~~~~~~~~~~~~~~~~~~~~

Rails, Python, and The New Old
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SGI Maddness: SCGI, WSGI, UWSGI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deploying Application Servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Additional HTTPD Functionality
------------------------------

Load Balancing and Proxies
~~~~~~~~~~~~~~~~~~~~~~~~~~

URL Rewriting
~~~~~~~~~~~~~

Synthetic Architecture Patterns
-------------------------------

Subdomains
~~~~~~~~~~

Proxying
~~~~~~~~
