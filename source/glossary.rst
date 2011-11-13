============================================
A Glossary for Cyborg Systems Administrators
============================================

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
