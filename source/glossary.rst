============================================
A Glossary for Cyborg Systems Administrators
============================================

Terms
-----

.. glossary::
   :sorted:

   rsync
      ``rsync`` is a UNIX application that provides a very efficient
      method for copying files between hosts. It saves transit by
      identifying and only copying that data which is different and
      has been updated. ``rsync`` serves as a replacement for
      utilities like: ``ftp``, ``scp``, and ``rcp``.

   LVM
      The logical volume manager is a Linux subsystem that abstracts
      the storage system so that "disk images" can be re-sized and
      managed independently of the physical disk. Furthermore LVM
      provides a capacity for fast disk snapshots which make it easy
      to duplicate disk images at points in time.

   NoSQL
      The marketing term given to a class of largely non-relational
      databases that have emerged since 2004 in an attempt to deal
      with a number of different architectural and interface problems
      with relational/SQL database systems. Examples include MongoDB,
      CouchDB, Cassandra, Hadoop, Riak, and other. While there
      commonalities, all NoSQL databases are typically quite
      specialized.

   REST
      "Representational state transfer," a distribute application
      design paradigm upon which the HTTP protocol was written. More
      recently it has been espoused as the paradigm for designing
      application programming interfaces (APIs) for web services and
      it is typically posited in contrast to SOAP and XML-RPC.

   key/value
      A way of representing data structures where each datum is
      represented by a pair of two values: a "key" or indexed descriptor,
      and a "value," or data. Using key-value pairs its possible to
      store and represent much more complex data structures.

   metadata
      Secondary information concerning a primary information
      object. For example, classification number, publication date,
      publisher, and author are all potential "metadata" points for
      a book object.

   logrotation
      The process of truncating, moving, compressing, and eventually
      deleting application and daemon log files to prevent the logs
      from growing out of proportion. The application "logrotate" is
      used by most UNIX-like distributions to implement logrotation.

   copy-on-write
      A pattern used to take snapshots and ensure atomic file system
      operation. Simply, rather than "copy" an object by duplicating
      it's representation, references to the original object are
      created, and bits are copied to the "copied object" only as the
      corresponding bits in the original object are written.

   virtual hosting
      A method of including a host name in the request to allow a
      single process to provide multiple services. This is typically
      used in the context of :doc:`HTTP services
      <web-services-architecture>` to provide :term:`multi-tenancy`, but can
      be applied in a number of contexts.

   multi-tenancy
      The practice of using a single system to provide multiple
      services. While this can lead to more efficient use of resources
      in some situations and by some providers, and is therefore
      desirable, mult-tenancy can make it hard to correlate observed
      performance, server configuration changes, and actual
      performance issues.

   inetd
      A core UNIX process that listens to network interfaces and
      spawns processes in response.

   grokable
      Understandable or knowable. From "grok." Derived from Robert
      Heinlein's *Stranger in a Strange Land*.

   NCSA
      National Center for Supercomputing Applications. Located at the
      University of Illinois Campaign-Urbana, the NCSA is notable for
      hosting many developments, including the development of HTTP.

   horizontal scaling
      See ":term:`partitioning`."

   vertical scaling
      See ":term:`replication`."

   syslog
      A multi-system "system logging" system.

   proxy
      Servers or services which do not originate content but assemble
      content or provide a single access point for a number of
      distinct processes or different servers by acting as a "pass
      through," for this content or resource (group.) Proxy servers
      provide a number of distinct intermediary functionality at a
      number of levels of abstraction and operation.

   good enough
      A theory regarding the development and adoption of "bleeding
      edge" technologies that asserts that "the best" or most advanced
      technologies are not always the best solutions or the best
      expenditure of resources.

   virtualization
      The practice of using hypervisor technology to
      provide :term:`multi-tenancy` on a system-level. These
      virtualized hosts (i.e. servers,) provide abstracted hardware
      interfaces so that administrators can deploy multiple systems,
      instances, or nodes on a single piece of hardware. Virtualized
      instances are generally entirely separate from other systems
      running on the same hardware.

   host
      Refers to a single system in a networked environment. With
      virtualization, each instance is a host on the
      network. Typically each host has a single and distinct network
      address but :term:`IPv4 address space depletion` and :term:`NAT`
      obscure this boundary somewhat.

   replication
      A distributed architecture where the resource exists
      *redundantly* in multiple locations. Examples include RAID
      level-1 and master-slave database architectures.

   partitioning
      A distributed architecture where a single copy of a single
      logical resource are split up among a collection of nodes that
      each provide a non-identical portion of the resource. In
      databases this is often called "sharding," but a similar effects
      are possible for other types of services.

   NAT
      Network address translation. The network routing approach that
      allows multiple hosts in the local network to share a single
      publicly routable address.

   IPv4 address space depletion
      The process where the 32-bit space for the global IPv4 network
      (i.e. the "Internet") runs out of usable addresses for
      hosts. The problem is a result of many factors: a much larger
      number of hosts on the internet than expected, poor early
      address allocation methods, and routing requirements that
      consume, on average, 2-4 unusable addresses for every block of
      256 addresses.

   resource
      A specific piece of content provided by a networked
      service. Typically used in the context of HTTP. 
