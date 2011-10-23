=======================================
Database Scaling for Frightened Cyborgs
=======================================

This document provides an overview of database systems, database
system design, and database administration. It's goal is provide
context about database administration and architecture for developers
of web applications who have never developed or administered large
database systems and systems administrations without database
administration experience.

.. contents:

Background
----------

About Me
~~~~~~~~

I'm a technical writer who specializes in systems administration, web
development and architecture using open source tools, and more recently
"non-relational" or "NoSQL" databases. I've never worked as a DBA, but
I've watched other people do this kind of work, and I'm familiar with
the process and common challenges in the problem space.

Technical Background
~~~~~~~~~~~~~~~~~~~~

**Database systems**, are high performance engines meant to provide high
throughput read/write and processing for data. Data can literally be
*anything*, but are databases all optimized to handle specific data
structures (arrays, lists, numbers, strings, binary blobs, etc.) that
obeys specific kinds of standard usage patterns. In most cases, these
are the same kinds of data that programming languages deal with.

Files Systems
`````````````

Files and file systems can, of course, also store data. Using certain
kinds of regular formats including delineated (e.g. CSV,) or specific
file formats (e.g. JSON, YAML, or XML) or even binary formats, it's
possible to reap some of the structured benefits of a database. Although
storing data on file systems is intuitively easier to understand, there
are problems with storing data in files and on file systems:

-  *Access times* and *overhead*. There are a number of operational
   limitation with files. In short, to read a few bytes of information
   from files, your program probably has to spend a lot of time finding
   the file from among the thousands or millions of files on your
   system, Then the program has to parse through the entire file
   (likely) and it has to repeat this process anytime it needs to find
   data.

-  *Data aggregation.* Most use cases for data in applications don't
   require simply finding and returning data in a format that is the
   same or substantially similar to the format in which it is stored.
   Applications take some amount of disparate data and aggregate them
   together dynamically (more or less) to provide interesting features.
   The aggregation requirements in even simple programs often outstrip
   the ability of files and file systems to supply data fast enough.

-  *Concurrency.* File systems are conventionally bad for concurrent
   operations, which is largely a result of their design and history. If
   two processes need to read or write to a file they have to wait for
   their turn. If more than one process can modify a file, then programs
   need to be constantly re-reading files to ensure that their data is
   consistent and up to date. If you need more than one system to read
   data from a single file system, you're basically out of luck.

To add insult to injury, if you have lots of data in a single file, you
run into problems where reading data takes too long. If you put little
bits of data into lots of different files you can typically skirt around
the concurrency issues and to a lesser extent the data aggregation
issues, but you spend more time finding files, and if the "little bits"
of data is consistently below (or around) the block size (i.e. 4kb) of
your file system, the file system becomes ineffective at storing the
data.

Then there's permissions and access control issues, which is so complex
that I'm going to mostly ignore it here, except to say that security is
also an issue.

There are workarounds to some of these solutions, but the required
sacrifices and complexity are high. This is, basically *why* we use
databases, and you probably knew all of these things. I went through
files and file systems because databases, at some level operate on file
systems. While databases solve or reduce many of the problems created by
the above limitations, these systems are also subject to some of the
limitations of file systems, and we'll address aggregation, overhead,
and concurrency later.

Databases
`````````

Database systems provide single applications and interfaces, built
around a server daemon (process,) that control and direct access to your
data. Because the database server controls access to the data it
provides, a way to ensure that data modifications and additions are can
happen quickly and reliably and it can allow multiple process to read
and write a single set of data without placing the consistency or
integrity of the data at risk.

Furthermore, the database system can optimize your data storage and
access. By enforcing structural requirements (this is particularly true
in the relational model) the database can store the data efficiently and
provide some level of memory caching. Databases typically index the data
to decrease the amount of time "finding" data. Finally, because
databases have ready access to "hot" copies of the data, efficient
indexes, and some basic information about the data types and structure
they are the ideal location for doing the first pass of data
aggregation, analysis, and processing.

Because they provide such a crucial component of nearly every piece of
software, and the bounds of problem space are fairly well known database
software has become very advanced and very powerful. There are dozens of
different databases all tuned to serve different usage profiles and to
provide different kinds of functionality. This article is not meant as a
comparison guide between different database products or even database
paradigms; however, it is fair to say that despite all of their benefits
and strengths, there are limitations with every database system.

Scaling and Bottlenecks
-----------------------

Databases systems provide many performance advantages over using file
systems for data storage; however, there are some hard limitations that
are hard to overcome as a result of their design. Basically, databases
are able to achieve their performance benefits by optimizing data
storage, organization, and indexing *and* by placing the indexes and as
much data as possible in working memory. When applications need to
regularly and frequently access and write data in volumes that exceeds
the capacity of your database server's RAM, performance drops off.

Beyond, size constrains, there are also potential limitations around the
number of connections. For the purposes of these examples, assume that
you have a system with one very large database server with 4-32
gigabytes of RAM, and a number of application server. The available
bandwidth and network configuration between the application instances
and the database can be a limitation. Beyond that, operating systems
have hard limits with regards to the number of simultaneous connections
that they can track. The limit's high, but it exists.

If you're running into scaling problems, it will almost always be the
first problem (space relative to available ram;) the connection-based
problems are very difficult to reach. Having said that, some database
servers are less able to process requests at volume than others so there
is a reachable practical concurrency limit.

Every application needs a unique scaling strategy because the way that
applications consume data is unique. While a large part of the "scaling"
problem deals directly with the database architecture, database planning
is only a small part database scaling. While you can (and should!) begin
writing your application with good database practices in mind, there's a
limited amount of preemptive optimization that's possible before testing
the application in the "real use." Most scaling work requires working in
response to actual usage data.

As you begin developing a term strategy for scaling your database you
need to have a clear understanding of the following factors:

-  a grasp of the actual limitations of your database server software.

-  an understanding of the usage pattern of your database. This should
   include:

   -  the distribution of activity between reads and writes.

   -  peak and average utilization.

   -  expected growth.

-  an idea bout the ways that your application stores and accesses data.
   Know your scheme and the ways that your queries are built, as well as
   (generally) what aspect of your applications access the database.

Advanced Architectures for Database Systems
-------------------------------------------

This section provides an overview, some shorthand, and a few specific
ideas about scaling strategies. These, architectures provide an overview
of the possible tools that you can use to help increase the capacity of
your system and application.

Horizontal Scale
~~~~~~~~~~~~~~~~

There are two ways to scale a database system "horizontally," that is to
distribute the load across a cluster of machines: **sharding**, or
partitioning the data so that each machine is responsible for only a
small part of the data; and **replication** where multiple instances of
the database exist in parallel so that load can be distributed angst the
cluster. There are advantages and disadvantages to both strategies.

Partitioning is a great strategy and provides a way to avoid write
contention problems that replicated databases often encounter. However,
partitioned databases are much more complicated to manage, both from
administration perspective and from a code perspective. Data needs to be
effectively distributed among the partitions, and per-partition backups
and administration is much more complex. Also the code needs to be smart
enough to be able to direct queries to different servers as needed. In
some cases database tooling may be able to address these challenges
well, but partitions are easier on some systems than others.

Replication is simple to set up and adds great availability/fail-over
possibilities. Most database systems have some support for simple
"master-slave" replication at the very least, and the administration of
these clusters is straight forward. The downside, is that it's very
difficult to distribute write operations to more than one database
sernver without risking the concurrency of the database. Database systems
that need to support read-heavy loads can flourish in replicated
environments; however, if the system is write heavy, replication
provides limited benefits.

Vertical Scale
~~~~~~~~~~~~~~

There's really only one way to scale a database vertically: buy better
hardware. Some may also consider optimization of the code and indexing
to be part of vertical scaling. The options for this kind of scaling, of
course, depend on the environment and use of your software but there are
a few consistent high-level concerns.

The first step in scaling vertically, and indeed in any kind of scaling,
is to segregate processes and functions to unique servers. Run
application servers, web servers, and load balancers on different
instances. This will reduce contention across your entire system, and
once your deployment has functional/process segregation, it becomes
easier to optimize specific bottlenecks horizontally.

If your application is running in a shared/virtualized environment,
begin by increasing the amount of memory allocated to the server. Then,
do whatever you can to decrease the amount of disk contention.
Eventually cost or disk contention will force you to running your
*actual* hardware. In that case:

-  If you use conventional disks, run in RAID 1+0 (or "10")
   configuration. RAID 1+0 takes four disks in two pairs. Disk 1 and 2
   are duplicates of each other while disk 3 and 4 are duplicates of
   each other. Then data is striped across each pair. This provides
   redundancy (the pair duplication) and doubles the potential
   performance of the disk (the striping.)

-  If you use SSDs RAID 1 (pair duplication) is sufficient, performance
   should be great, particularly for reads.

There are limitations to how large you can scale a system vertically,
the operational requirements and complexity of horizontal scale are
often far greater than vertical scaling. Additionally, vertical scaling
is at least cost competitive with horizontal scaling in the final
analysis. Having said that, the extra redundancy provided by horizontal
scaling strategies has its own value.

Creative Scale
~~~~~~~~~~~~~~

The proliferation of large, powerful database servers have helped create
the notion that the only way to increase the scale of an application is
to increase the power and resources of the database server. Indeed even
the new database systems that are designed to be scalable, have
contributed to the idea that the only real way to increase application
performance is to increase the size and capacity of the database engine
itself. While there are some senses where this is true, I think focusing
on the database may prevent administrators and database architects from
developing innovative and creative solutions to scaling problems.

Consider the following recommendation: always scale your database up or
out as last-resort solution. See improving capacity for some other
element or providing another caching layer helps improve performance or
capacity before you move on to database architecture. Also consider the
scale of your own environment: will deploying a new architecture or
additional database infrastructure enhance performance commensurate to
the amount of time required to develop the solution or money required to
support that infrastructure long term. Consider the following:

-  Application servers are single threaded and often become bottlenecks
   first.

-  Caching is often a stop gap measure, but good caching can help things
   significantly both on the database level (i.e. memcache) and on the
   HTTP level (i.e. Varnish or Squid.)

-  This won't actually help solve any caching problems, but you should
   become very familiar comfortable with your load balancing software.
   If you're familiar with nginx, that's probably good enough.

-  Design with non-database scaling in mind: make sure you can deploy a
   cluster of application servers without needing to rewrite code. Make
   sure it's easy to insert layers in your code architecture between
   components so you can put a caching layer between the database and
   the application server.

-  Attempt to think about your database servers (and application as a
   whole) less a monolithic requirement, and more as a collection of
   services and functions. It's well within the realm of possibility
   that there are natural partitions within your data and use that can
   be handled in various ways.

Even if your application is huge, there's probably a lot of data that
could be archived off out of the high-performance and high-availability
system because it isn't being used very much. Some portion of your
application might be really well suited to running on top of
relational/SQL database and parts might make more sense running off of a
non-relational/NoSQL database. One component might work best as a simple
RESTful interface on-top of SQLite database ruining on ``/dev/shm`` for
all I know.

Be creative. See where it gets you.

NoSQL and Non-Relational Databases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I have taken the approach that "databases are databases are databases"
in this document. While this simplifies my arguments and explanations,
it ignores the fact that since 2005-2007 there's been a lot of work and
development on new and different database paradigms. Typically this work
has been called non-relations (i.e. NoSQL) databases, but I think these
monikers obscure the important shifts that are going in the database
space, particularly in so far as administrators and developers are
concerned.

There are two major aspects or lessons of this ongoing paradigm shift:

1. Databases systems need to be specialized to the task at hand.
   Different applications and different aspects of applications require
   different things from a database system, and having database tools
   that are great for different kinds of structure, for analytic
   operations, data processing, and distribution models is important for
   being able to scale appropriately.

2. Having horizontal scalability slightly more important than
   super-optimized general purpose vertical scalability. The
   ACID-compliant relational database paradigm is powerful and having
   these kinds of tools is important, but ACID effectively prohibits
   horizontal scalability, in situations where raw throughput often
   matters more than instant consistency.

These dimensions lead to, and interact with a number of other ongoing
trends and shifts in database, software development, and systems
administration:

-  Strictly enforced schemas and relational databases, are not as
   valuable in all interactions.

-  Data normalization makes applications more difficult to develop
   without providing significant performance benefits.

-  Concurrent writes are an open problem, and we need more ways of
   addressing the horizontal scaling problem.

-  Application architectures and database architectures need to be
   integrated into application systems, and deployments need to be
   analyzed and managed as a whole.

-  The historic split between administration (operations) and
   engineering (development) has been crumbling, and the project of
   building, deploying, and administering applications needs to be
   addressed holistically.

Scaling Pragmatically
---------------------

What you Think Will Happen and How to Prepare for It
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inevitably, most developers and architects see scaling problems on the
horizon and they get really scared. This is probably the worst response.
If nothing else, all scaling problems can be solved--at least
temporally--within a day by increasing the amount of resources (i.e.
RAM) allotted. This will buy you more time to figure out how to scale
more efficiently.

The first response to the threat of a scaling problem: too much
contention or slowing performance is to address *all* scaling problems,
and to build a system that's impervious to every availability threat.
You start thinking about sharding (horizontal partitions,) and
replication, and fail over. The results is inevitably near total
overwhelm.

If special scaling is required, and you should be sure that this is the
case, the way to prepare for the inevitable is as follows:

-  Develop some sort of business plan. No matter how you have to scale
   it will require additional resources in the end: more development to
   optimize the code, more money for servers, and/or better servers. If
   you have a purse of some sort, you'll be able to buy time and afford
   the solution.

   The upside: if you have an application that's getting enough use to
   require scaling, you're hopefully providing value to actual users, so
   this part might be easier than you think.

-  Consider easier ways to decrease the load on your database that don't
   require fancy database architectures. Sometimes the bottleneck is in
   the application server. Sometimes it's the code. Sometimes putting a
   more application servers and load balancing connections amongs them
   works better. Sometimes the best solution is to put caching layer
   in-front of the web-server.

   In *most* cases, simply separating different services onto discrete
   systems is enough to get you most of the way there. Preventing your
   application and database server from contending with the same pool
   of resources is often immensely helpful. The same goes for
   splitting static content from your application server.

-  Address systems administration challenges in the same way that you'd
   address optimization problems in code: identify the bottlenecks and
   optimize strategically.

What Will Really Happen And How To Deal With It
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Practically there are only so many different ways that applications need
to scale and the process of implementing scaling proceeds along a fairly
conventional pattern. Consider the following.

1. The application, the database, your email server, and probably the
   machine you connect to IRC from are all running on a single instance.
   It works well until you have more than 5 concurrent users, and 100 MB
   of data at which point the server starts crawling along. It's time to
   do something.

2. Partition services onto different systems. Put the database on the
   biggest server you van afford, and keep everything but the database
   off this system. RAM is what matters here, and you don't want any
   processes running here taking up ram.

   Application servers are typically single threaded and are often a
   bottleneck far before the database. So you want to run as many of
   those as you have processor cores for (taking RAM into
   consideration.) Put everything behind an HTTP server/load balancer
   (i.e. nginx) that proxies the dynamic requests back to the
   application servers and provides static content (javascript, CUSS,
   etc.) directly.

3. Begin replicating the database. Hopefully you're already running
   regular backups on your database system. Replication has some
   overhead, but it provides a reasonably hot standby so if anything
   happens to the "primary," database, you have a running copy to use
   while you fix things. That's very useful.

   The problem with replicated databases, is that making sure that
   write options are consistent is difficult. If you tell the database
   to write data, does the write have to propagate to the secondary
   before it returns? (typically yes.) Is it safe to write to the
   non-primary, and if so how does the system deal with possible
   collisions that come from concurrent writes? (typically database
   systems only allow writes to the primary node.)

   Despite the potential issues with concurrency, collisions and
   writing data to replicated databases, there are no issues simply
   reading data from the "non-primary," database. Typically at this
   stage, you develop a method in your code to split reads and writes
   between two databases. Read from the non-master/non-primary
   database, and write to the master.

   Splitting reading and writing works great if your application has a
   clear split between read operation and write operations. It's easy
   enough to add additional non-master databases, or slave off of a
   slave database, so for "read heavy" systems you can actually get a
   lot of benefit from simple replication. If your application is
   "write heavy," you need to explore other options.

4. Once you've reached the end of what simple replication alone can
   provide in terms of increase performance, the only option is to
   partition your database or to create "shards." Some systems make this
   easier than others: typically relational databases are terrible at
   this. Basically, the database is split between several master
   processes each of which store and write separate "slices" of the
   data.

   Sometimes sharding requires a good deal of thought about how to
   most effectively partition your data so that data will be both:
   evenly distributed among the slices and so that operations won't
   necessarily need to aggregate results from more than one partition
   (i.e. avoid cross-partition ``JOIN`` operations.) Depending on your
   database system and the structure of your application, you may need
   to rewrite parts of your code to make this work effectively.

6.  At this point, if demand on the database again begins to grow
    consider the following 4 options for increasing performance:

    - Make more shards so that each shard holds less data.

    - Replicate the shards to split read and write operations between the
      database.

    - Increase the hardware resources for each shard/instance.

    - Improve caching and application design to require less from the
      database.

    These are the tools to deal with scaling on the database level,
    and as demand continues to increase (which it might,) take an
    analysis of your data use and use these insights to enhance or
    bolster your architecture accordingly.

7.  Finally, throw money at it. If you're running into scaling problems
    with your database, presumably you have users and you're providing a
    valuable service. *Someone*, ought to be able to pay you for that,
    and with more resources many options are available:

8.  Bigger hardware. Throwing more RAM behind a database node is almost
    always helpful.

9.  More hardware. If you have a solid distributed setup, and an
    application that can handle distribution growing the cluster
    horizontally is helpful.

10. If you're a developer, and you're having scaling problems, consider
    hiring a "real" systems administrator or database administrator to
    do the heavy work. Scaling is a lot of work, and having someone to
    own it is important.

11. Better hardware. The trend today is to run everything off of
    vitalized "cloud," servers. Which is great, but with big data-sets
    under high demand you will likely see some benefit for using "real"
    hardware with fast RAID 1+0 disks or SSDs.

Lessons for Cyborgs
-------------------

While this background, examples, and context is potentially
enlightening, all of the information presented above may not be
immediately useful to you, and developing a plan for "how to scale
applications in the future," may be an exercise in futility and
premature optimization.

Developers of open source web applications [1]_ find themselves in a
unique situation: most of the time the applications run as single
instances in very small deployments, but sometimes they run as massive
instances. It's helpful to have an application that can run with the
same code on top of clusters and small instances as needed. But only as
you need.

The take home message of this document should not be that you need to
begin scaling your application and database infrastructure *now*, but
rather that the problem of scaling is largely knowable, it's possible to
accomplish, and can be delayed for as long as possible. Some
preparations for scaling are easily made and do not risk premature
optimization: choose the right database system for your application,
integrate with caching, have a sane and flexible application design,
don't store users' application state in weird places, understand how
sharding/portioning works with your system, and if possible avoid doing
something that may block or complicate the sharding process down the
road.

If any of these preparations are possible, then write your application
to make things possible or easy for users down the road. But don't
stress about them. Having said that, no matter what kind of application
you're developing I think it's easy to get lost in trying to solve
fundamental problems in web application architecture when problems of
audience, community, and powerful compelling features are really much
more challenging, much more difficult, and incredibly important.

Onward and Upward!

-------

.. [1]
   I've glossed over the argument that many free network services
   developers and proponents make which is to say that FNS web apps
   scale horizontally by virtue of federation rather than by virtue of
   complex database systems and architectures. I'm not sure if this is a
   practically useful yet, but it's a useful idea.
