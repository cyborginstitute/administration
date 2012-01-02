=========================================
Production Systems and Testing Separation
=========================================

The first rule of managing deployments that people actually *use*, is:
don't do anything that will affect the availability of the
service. Ever. Once you get something setup and working, *don't touch
anything* and don't break anything. This is a difficult challenge:
maintenance often interrupts service. Any change to a system,
including required configuration changes, upgrades, or system updates
can break a working system. At the same time every deployment and
system requires configuration changes, upgrades and updates. Balancing
these requirements presents a core problem in systems administration.

This document addresses different ways, techniques, and strategies
that make it possible balance both of these concerns at the same
time.

Key Concepts
------------

.. glossary::

   production environment
      The servers that clients actually interact with. These servers
      are doing the actual work of the deployment. Administrators
      should modify instances and applications running in this
      environment as minimally as possible.

   test environment
      Servers that provide a very accurate reproduction
      of the production environment, use this as a final testing
      substrate before implementing changes or updates on the
      production system. Sometimes it's not feasible to fully
      replicate production environments in test, the differences ought
      to be minimal so that differences between the test and
      production environments don't cause unexpected problems.

      Virtualized production and test environments make it easier to
      more accurately replicate the production environment in test.

   development environment
      A deployment of your application or application that can be
      used for exploratory and development work. While these
      environments resemble the production environment, they are
      often much smaller (in terms of available resources and data.)
      these systems are what administrators and developers use to test
      and experiment with changes before implementing them in the
      :term:`test environment`. These may run in virtual machines that
      resemble the :term:`test environment`, or on developers
      laptops.

   change control
      Systems that monitor production environments for changes and
      modifications and alert administrators of intrusions. As a
      result, change control is typically used as a security
      measure. At the same time, some refer to policies that control
      how changes are made to the production system are often refereed
      to as "change control," and some of the systems used to monitor
      for changes can be used to ensure that changes are correctly
      propagated from :term:`test environment` to :term:`production
      <production environment>`

   fire call
      A method used by administrators to get emergency administrative
      access in deployments where no individual has "root" or
      administrative access. This both allows emergency work on a
      deployment and works to allow administrators to avoid
      accidentally modifying systems.

   rollback
      Taking a change applied to a production environment, and
      reverting to a previous iteration, if an update or upgrade
      produces an undesirable or unforeseen effect rollback procedures
      are used to revert to a previous known working state.

Deployment Processes
--------------------

Change Control
--------------

Rollback
--------

Systems Policy and Auditing
---------------------------

.. seealso:: ":doc:`monitoring-tactics`" and ":doc:`documentation`."
