======================================
Backup Strategies for Cautious Cyborgs
======================================

This document provides an overview of backup strategies, methods of
backup organization, and practices to that ensure your data and
configuration is safe in case of a significant data loss event. This
document is focused on Unix-like (e.g. Linux) systems and server
environments, but the higher level strategies are applicable for users
a diverse array of systems and deployments.

Background
----------

About Me
~~~~~~~~

I'm a technical writer and occasional systems administrator. I have a
load of Linux experience from the perspective of a systems
administrator, and as a routine day-to-day user of Linux. I'm also
neurotic as hell about backups, and very interested in file
organization, and data reliability.

Conceptual Background
~~~~~~~~~~~~~~~~~~~~~

Backups are important for maintaining continuity and guarding against
certain classes of hardware failures, service disruption, and user
errors. Even though many speak of "backups," as one thing, the truth
is that there are many kinds of backups that serve a number of
different ends. There is no singular backup solution that can satisfy
all possible needs. If you don't have any backup strategies at the
moment you should craft *something,*  draw on your existing
experience, the knowledge of your system, your budget, and the
material introduced in this document to develop the strategy for
backing up your deployment.

Backup Systen Requirements
``````````````````````````

In order to have value, there are certain necessary proprieties that
backup systems must possess. They are:

- tested. Regardless of what kind of backup strategies you deploy, if
  you do not *regularly* test your backups to ensure that the data is
  actually being archived and it's possible to restore data from your
  backups, your backups are effectively worthless. There are lots of
  ways to test your backups--and to be honest, a lot of backup schemes
  are not properly tested--but there's nothing worse than putting
  energy into backups that is all for naught when you have to rebuild
  systems and reconstruct data because the backups weren't
  restoreable, or hadn't been saved in 20 minutes because your backup
  system ran out of free space.

- automated. Backups that you have to think about are backups that you
  forget to do, backups that don't get done when you're on vacation,
  or backups that are inconsistent because you enter the command in
  differently every week. Automating backups means they happen
  regularly and that they're consistent. It's important to check
  automated backups to ensure that they're restoreable, but there's no
  reason why you need to run them yourself.

- efficient. Backups are incredibly crucial and almost nobody, not
  even the best cyborgs, do properly. You should design your backup
  system to backup only want you need and what is essential to restore
  your functionality. You should find away to store backups in such a
  way as to minimize the time that they spend in transit without
  sacrificing geographic distribution. Additionally, push yourself to
  dedicate as few resource to the backups as possible without
  scarifying functionality. There's a lot of draws in lots of
  different ideas, but backups while important shouldn't get in the
  way of *actual work.*

- secure. Since you wouldn't store your production data in an
  unsecured environment, don't store your backups in environments with
  less security than your production systems. If you can restore
  systems using these backups, chances are other people can as well.

- redundant. Make sure that you have a few different redundancy
  plans. Assume that your most accessible. Ensure that you can still
  restore using other means and ensure that you can still recover a
  file if you need it from a backup. Test backups to make sure that
  they're working. Make backups redundant to ensure that there are
  multiple different protections between your systems ad data loss or
  system failure.

- consistent. Consistent state is import for quality backups. Data
  needs to be fully flushed to disk, and all parts of the file, group
  of files, or file system need to be captured at the same
  moment. Because of the constraints of input/output systems and
  backup utilities, it's actually exceedingly difficult to capture a
  backup of an active system at a single moment in time. In many
  cases the amount of time that the back up operation takes to run
  doesn't matter, but in some--like databases--it's nearly impossible
  to create a good consistent backup without disrupting the system.

Hardware Concerns
`````````````````

Most of the backup strategies and tactics discussed in this article
will address data loss from the perspective of file loss and
corruption. Hardware redundancy is also important. Having spare
components near where your servers are (or might be) and extra
capacity in case of a demand spike or unexpected hardware failure is
essential to being able to guarantee up-time. This infrastructure
needs to be regularly tested and monitored, as if it were
production. For less drastic changes these systems may also function
as a development or test environment as long as you can roll back to
known good states quickly.

Because of obsolescence cycles it makes a lot of sense to get too far
ahead of yourself here. I keep two laptops/personal systems running at
any time, because it's crucial that I be able to have something that
works nearby. I don't travel with two laptops, but it means most of
the time I'm within an hour of being up and running on the spare
machine. I don't keep spare server infrastructure around, because I've
judged the chance of loss there to be pretty low, and even in the
worst possible case, I can be up and running an hour after I notice
the services are down. Not too bad.

Underlying Backup Tools
```````````````````````

- Block level backup tools.

- RAID and Storage Infrastructure.

- GNU tar, gzip.

- rsync.

TODO provide overview of backup tools.

Other Approaches to Redundancy
``````````````````````````````

In ":doc:`database-scaling`" various strategies for database-level
redundancy. While it's always a good idea to keep backups of
known-good-states to protect against situations where an error,
defect, or mistake propagates across an entire cluster of systems, in
many cases if you can recreate or rebuild a server or instance from
another instance or a collection of scripts, keeping an actual backup
of the files or bit-for-bit data is less relevant.

Similarly, look to ":doc:`high-availability`" and think about
backups as existing on a continuum with fault tolerance and
redundancy, and consider your solutions to these problems as a whole
rather than as two or three separate problems. By looking to address
these problems together you will almost certainly save energy and
probably some base cost as well.

Technical Background
~~~~~~~~~~~~~~~~~~~~

Application Data
````````````````

stuff in databases.
stuff in files

File Data
`````````

dduping


Configuration Data
``````````````````

symlink git repsitory trick

using configuration management tools like puppet.

Managing Backup Costs
---------------------

- compression

- throwing things away

- different levels of storage accessibility

- prioritizing what gets backed up.

- keeping data well organized.

- gzip/CZ compression

- transit / rsync


Backup System Architecture
--------------------------

There are too many different *kinds* of requirements for any one
backup system to sufficiently fulfill. Additionally, at the core,
backup design is practice in balancing the paranoia and knowledge

In order to effectively address Because there are many concerns and requirements components:

- backup systems
- stuff in git
- stuff offsite

Backup Methodologies
--------------------

A large part of figuring out how to backup your data and systems
depends on knowing where and how your applications store data, not
simply in memory, but also on disk. Understand not simply that you
need to back up your database.

Disk Snapshots with LVM
~~~~~~~~~~~~~~~~~~~~~~~

If you're not already managing your systems disk with some sort of
logical volume manager consider it. Volume managers provide an
abstraction layer for disk images and disks which allow you to move
and re-size disks independently of physical disks. Volume managers
also often have the facility to perform snapshots [#snapshots]_, which
captures the exact state of a system in an instant and that in turn
makes quality backups possible.

.. [#snapshots] Linux's LVM (i.e. LVM2) has the limitation that
   snapshots must reside on the same physical disk as the original
   disk image, which has some minor impact on space allocation. Read
   your underlying system's documentation.

In general snapshots are preferable for use in backups because they
allow you to capture the contents of an in-use file system in a single
instant; while this allows you to produce largely consistent backups of
running systems, these backups are not terribly useful if you need to
restore a single file.

When you create LVM snapshots it's crucial that you move this data off
of the system where you're holding the snapshot. While snapshots may
be useful in cases where you want to briefly capture a point-in-time
image of the file-system, most backup applications require moving the
LVM to a different storage format. Use a procedure that resembles the
following: ::

     lvcreate --snapshot wat fox
     dd if=/dev/snap | tar -czf sanp.tar.gz

To restore this backup, reverse this process:

     lvcreate --size wat fox0
     tar -xzf snap.tar.gz | dd of=/dev/vg0/fox0

You can move the snapshot off as part of this process, by sending the
output of ``dd`` to ``tar`` over SSH. Consider the following: ::

     lvcreate --snapshot wat fox
     dd if=/dev/snap | ssh hostname tar -czf sanp.tar.gz

Reverse the procedure to restore as follows: ::

     lvcreate --size fox0
     ssh hostname tar -xzf sanp.tar.gz | dd of=/dev/vg0/fox0
     mount /dev/vg0/fox0





TODO lvm commands: create, lvs, snapshot



Incremental File Backups
~~~~~~~~~~~~~~~~~~~~~~~~

with rsync and rdiff-backup

The :term:`rsync` utility provides a way

rdiff-backup

Redundant File Storage
~~~~~~~~~~~~~~~~~~~~~~


System Level Backups
~~~~~~~~~~~~~~~~~~~~

bootable images

puppet

deployment scripts

Backup Restoration
------------------

Final Backup Thoughts
---------------------
