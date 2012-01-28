===================================================
Fundamental Systems Administration Tools and Skills
===================================================

Synopsis
--------

This document addresses some of the more general aspects of systems
administration. As a whole ":doc:`index`" addresses most general
skills from the perspective of common systems administration problems
and knowledge domains; however, some of the most important skills,
tools, and strategies for systems administrators are quite general,
and apply to a large number of domains.

Skills
------

The following skills, address a collection of non-technical skills
over which effective systems administrators must have some mastery. In
most cases, simply knowing how technology works, or what the "right
way" to use technology is necessary but not sufficient for being able
to solve, predict, and manage most systems administration problems
with the required deft grace.

Time Management
~~~~~~~~~~~~~~~

Systems administration is, in many respects a time management
problem. Moreso than other technical professions, operational work
contains both long-term infrastructural problems and short term
interrupt-driven tasks, which are difficult to integrate into a
typical work week (or into any free or in-between time.) Furthermore,
the workload of most systems administrators tends to be somewhat
overloaded because of budgetary constraints and atypical growth
patterns.

The big infrastructural problems of systems administration tend to
resemble software development problems to a large extent. They require
longer periods of sustained attention [#half-day]_, and often carry
the promise of solving some larger problem. For a small example, you
may have the task of building a tool that reports on the total amount
space used by a database cluster, or detects and repairs broken access
control lists (:term:`ACLs <ACL>`.) These problems likely take tens or
dozens of hours (or more) to solve, and when solved will likely reduce
the overall workload significantly; however, until resolved you may
lose many dozens of hours to "spot fixes" of an overloaded database
cluster, or permissions tweaking when a system or user can't access
required data because of a broken ACL.

Larger examples of these infrastructural problems include big upgrade
cycles, improving or migrating data into new systems, deploying
:term:`monitoring`, or ":term:`higher availability` systems, and so
forth. While abstractly, its easy to see that it makes the most sense
to spend half a week or a week writing and testing scripts that will
save a great deal of the in the long run, it's impossible to find the
kind of sustained time to work on larger projects with incoming
interrupts.

In the end, the best systems administrators have to figure out some
way to resolve these tensions and get work done: both the
infrastructural projects and the interrupt-driven tasks. While there
are entire books on the topic, and a nearly endless collection of
software tools that attempt to provide solutions and tooling around
this problem, there is no single formal solution. Consider the
following suggestions:

- Work transparently, to the greatest extent possible. Often time
  crunches derive from unrealistic expectations or understandings of
  what you do on the part of your coworkers, managers, and
  users. Track requests using some sort of ticketing or issue
  management system, so that people can log what you're doing and so
  that your managers have something empirical to help them understand
  what you're working on. Ensure that project managers and the people
  requesting your time or energies understand the *actual* amount of
  time that it takes to "do something correctly." Ensure that people
  know what the *actual* cost of *not* doing something correctly is,
  both in terms of hours spent and dollars.

- Minimize context switches. When most people begin working on a task
  a few minutes to assess the problem, recall all relevant
  information, and figure out the best tactic, and then actually do
  work. Interruptions often require a context switch: you must assess
  the new task, recall relevant information, and do some amount of
  work even if it's to file it away for later. When you return the
  original task you have to begin again: figure out where you were,
  what you were working on, and recall the relevant information. Even
  short interruptions, incur a context switching penalty, and if your
  work is interrupt driven, you can loose huge swaths of time to
  context switching. Do whatever you can to avoid context switching.

  Managing your tasks, providing users with an asynchronous method of
  communicating with you, and distributing work with coworkers all
  help solve the context-switching problem to some extent.

- Maintain a trusted system to track your own work. While it may be
  tempting to try and manage all of your projects in your mind, this
  memory task distracts from the attention that you can dedicate to
  other projects. Trusted systems have two main requirements: First,
  you must be able to quickly add items and notes to the system
  without context switches. Second, once inserted, the system must be
  able to return your tasks to you reliably so that you do not need to
  spend time or energy remembering what you need to do. If a task or
  note is in the system, then you must *trust* that the system will
  remind you of the task and thus be able to focus on other problems.

- Block off time in your day and week to work on both infrastructural
  and interrupt-driven tasks. Schedule meetings, and user request
  triage for the beginning or end of the day, and/or around the lunch
  hour, to maximize the number of larger blocks of time.

- Distribute and trade work with your collaborators and colleges. In
  many situations it's possible to reduce interrupt driven work using
  a shift system with coworkers. Experiment with this if you can.

.. [#half-day] Like engineers, these problems tend to require a couple
   of hours of serious time without interruption to really understand
   the problem, to develop a solution, to test it, and to iterate on
   the implementation. I tend to think of and schedule this class of
   work in "half-day" intervals. Though the ideal is hardly original,
   half-days tend to be 3 or 4 hours, which seems to provide a good
   balance between sustained energy, and providing a time for
   necessary interruptions like email, meetings, and lunch.

Project Management
~~~~~~~~~~~~~~~~~~

Where "time management" refers to how you organize yourself to be able
to achieve all of the things that you need to get done, "project
management," refers to the problem of understanding larger tasks that
depend on the efforts of multiple people and organizations
(i.e. "resources") and then organizing those resources to ensure that
the larger project is completed (i.e. "delivered") on time.

Some teams may have dedicated project managers who can help you with
this task, but it's good to know how project managers work, and how
you can adopt their techniques to help you ensure that "Things Get
Done." All systems administrators would probably prefer to spend all
of their time working on addressing interesting and challenging
technical issues, in many cases technical operations issues are
collaborative- and task-based, which makes them "project management"
problems. For instance figuring out the best way to upgrade a
production system, developing a purchasing agreement for support
contracts with your vendors, or even scheduling maintenance windows
may actually be "project management" problems.

Attempt to analyze a problem from a project management perspective
whenever you get a task that either requires something from someone
else *or* that you expect to take more than 2-3 days to
complete. Consider the following process:

- Determine what resources you have at your disposal. Figure out how
  much time, support, staffing, and budget you have to solve this
  problem. Throughout the life cycle of the project, ensure that the
  resources are sufficient to get the task done, and constantly
  reassess the holistic "budget" of the project.

- Determine the requirements for the project. It's crucial that you
  have a good understanding of what you need to accomplish. Always
  compare requirements and resources, to ensure that the project is
  "in the black," and viable. If, for any reason, the project looses
  viability, or viability is in question, ensure that the "clients"
  (users, managers, etc.) know this, and prepare contingencies as
  needed. Sometimes project managers refer to the combination of
  requirements and resources as the "scope" of the project.

- Divide project into tasks. This can be ongoing for particularly
  large projects, or can happen at the very beginning of a
  project. It's important to understand what elements of a project
  depend on or block other elements of the project; the best project
  managers can figure out what which tasks can proceed in parallel,
  and what work must happen serially.

  Some methods of task division are more effective depending on the kind
  of project and the team that's working on the project. A keen
  understanding of the capabilities of the team, the scope of the
  project, and the "blocking" tasks is crucial here.

- Throughout the course of the project check in regularly with people
  who have ownership over various tasks to ensure that problems don't
  arise that could affect the scope, time line, or deadline of the
  project. Pay particular attention to elements that could block or
  interrupt progress, and attempt to communicate this global view to
  the people doing the actual work, to provide the appropriate
  inspiration and encouragement.

  Above all, ensure that expectations are properly managed, and that
  work progresses steadily toward the goals.

There are a number of project management methodologies and styles in
software development, to say nothing of the tools. While a formal
understanding of specific approaches to project management can be very
helpful, it is likely true that the real value of project management
lays in having people who are actively keeping track of a project, and
the work that people are doing to ensure that the project gets done on
time.

In many ways, project management addresses the same kinds of logical
problems that exist in systems administration but rather than managing
servers, daemons, and applications, project managers manage people and
tasks.

Problem Solving
~~~~~~~~~~~~~~~

Most work with technology, is in the final analysis an exercise in
problem solving. Developers have to figure out how to write code that
solves a particular problem, or figure out what causes the bug they're
seeing. The vast majority of the work that systems do on a day to day
basis is one kind of problem solving or another. Figuring out why
systems don't work with each other, determining what the best way to
migrate or upgrade systems, and developing the best method to identify
issues before they become crisises are all common systems
administration tasks that require an instinctive problem solving
sense.

Having a greater familiarity with the technologies you use, and their
underlying operation, can aid the troubleshooting process. At the same
time consider the following heuristic for approaching unknown or novel
problems.

1. Collect data.

   Most processes in UNIX-like systems write data to log files. If
   something isn't operating as it should, check the log files and see
   if there's something reflected in the log. Deciphering logs is a
   art onto it's own, but if nothing else copying and pasting lines
   from a log into a search engine usually yields results.

   Beyond logs, you can run basic tests to reproduce the problem and
   understand the precise situation that the problem appears, or the
   use case that you need to support that you can't.

   The more you know about a problem, from as many perspectives as you
   can manage, the better suited you will be to address the issue.

2. Assess behavior and specification.

   In many cases, problems arise from a misunderstanding of a system's
   capability. While "bugs" do happen and there are defects in a lot
   of software, often issues arise because developers fail to
   anticipate a use case or an aspect of a production
   environment. Ensure that you know *exactly* what causes the
   problem, and then make sure that what you're trying to do is
   within the limitations of the design.

   Always check to make sure that you're attempting to produce
   something *possible* before spending time troubleshooting something
   that is impossible.

3. Rule out common problems.

   In UNIX-like systems, there are a set of six, or so, issues that
   are often behind thorny seeming problems. Because they are easy to
   rule out and can produce truly weird behavior, they're a good place
   to begin:

   - Permissions.

     Make sure that the program runs with a user account that has
     permissions to access the files that it needs to access. If the
     process must write to the file system, then insure that those
     permissions exist for the appropriate users. Database systems and
     many other application-level services introduce their own--often
     independent--set of permissions requirements, authentication
     systems, and account/credential systems, which may require
     independent testing.

     While permissions problems are annoying, and can be difficult to
     track down in the absence of good error messages, if you never
     run into permissions problems it may be a sign that your
     permissions are too permissive. Thankfully permissions errors
     almost always easy to fix.

   - Dependencies.

     Ensure that all of the libraries, supporting programs, and
     subsystems are installed. While modern package management tools
     obviate many dependency issues, a missing dependency can generate
     intermittent errors, or cause severe performance
     degradation. Many compile-time and basic deployment issues are
     dependency based.

   - Hardware.

     In most cases its reasonable assume that the hardware is never at
     fault. In the past, intermittent or sporadic hardware issues
     could cause any number of "weird" problems. These days, with
     error correcting RAM, virtualized and "cloud" computing, and more
     standardized hardware, it's safe(er) to say "*it's never the
     hardware*." Nevertheless, if you're doing something at a very
     core level of the system that interacts with the hardware itself:
     ensure that the software you're running is compatible with your
     hardware. Conversely, if *nothing* seems to work, or your seeing
     the same or similar types of errors in multiple programs, its
     worth investigating hardware errors.

   - Networking.

     While hardware components rarely fail as such, networking
     inconsistencies are pretty common, and when deploying a
     client-server application or dealing with any kind of distributed
     architecture always ensure that the network is accessible and
     reliable. Use traceroutes to test latency and path. Ensure that
     there isn't packet loss, and if necessary use :command:`tcpdump`
     to make sure that there aren't too many re-transmissions or fast
     re-transmissions which can degrade network performance on
     apparently stable network links.

   - Known bugs.

     In some cases the bugs and issues that you encounter will be
     unique and novel, but often other users have already run into the
     bugs you find. If bug databases are public, search them to ensure
     that any additional troubleshooting you do will not be
     duplicating existing

   - Global limitations.

     There is a group of common system limitations that servers and
     daemons occasionally run into, which produce weird effects that
     are difficult to troubleshoot. For instance, most UNIX-like
     systems have a limited number of "file descriptors." The
     operating system distributes file descriptors to processes to
     keep track of open files. Every process, socket, and open file
     needs its own file descriptor and when the system runs out of
     file descriptors it cannot start new processes, open files, or
     open new pconnections. There is also a per-process limit on file
     descriptors which can cause problems for software that needs to
     operate on a large number of file descriptors.

     In addition to file descriptors other limitations include: in odes
     (the file system structure that stores file system metadata, the
     number of which is a function of your disk size and the file
     systems block size which is configured when file systems are
     created or formatted;) Addressable/actual memory (RAM; a hardware
     configuration, or a boot-time and hardware-limitation if running
     in a virtualized environment;) and amount of virtual memory.

4. Look for correlations.

   Being good at spotting potential correlations between two events is
   a key problem solving skill for systems administrators. While it's
   important to be able confirm root causes, an instinct for finding
   correlations can make a lot of the potentially frustrating parts of
   systems administration much less irritating.

5. Develop tests to confirm behavior.

   Systems administrators must be able to take a theory about a
   current issue or the cause of a behavior or a problem and develop a
   test or script to "prove" the theory. Demonstrating a relationship,
   and ruling out other possible explanations is very difficult, but
   completely invaluable for systems administrators.

In point of fact if you think of yourself as a systems administrator
(and even if you don't!) you probably have most of these problem
solving skills. In some cases thinking about the things you already
do, from a new perspective may help you be able to be a more effective
problem solver and systems administrator.

Tools
-----

There are purpose-built (software) tools to solve, a nearly
disproportionate number of systems administration problems
(e.g. monitoring, reporting, multi-systems administration, directory
services, access control management systems, issue management systems,
and so forth.) This section addresses the basic tools that systems
administrators must have at their immediate disposal.

Scripting
~~~~~~~~~

In a UNIX-like environment you can express most systems administration
tasks in the form of a script. The language you choose is not
important, and often one has to perform a task "manually" before
understanding the problem sufficiently to be able to write a
script. Furthermore, for small or occasional tasks, the time required
to write and test a script may exceed the amount of time that it would
otherwise take to perform the task manually.

The key is not "understanding how to solve all your problems using
scripts," but rather approaching all problems as potentially
script-able and having a sense of the kinds of problems that make
sense to approach as scripting problems and the kinds of problems that
are small enough to make a script "cost" more than it saves.

The language or variant you use to write scripts doesn't matter
much. The main concern is that you write scripts in languages (and
versions) that all the systems you administrate or may be reasonably
expected to administrate can run without installing dependencies.

For instance, most systems will have ``bash`` installed but may not
have ``zsh`` installed. Most Linux and Unix distributions come with
Perl and Python installed as part of their base installs, but you must
install Ruby separately. Additionally, while the latest version of
Python may be 2.7 or even 3.2 on many desktop systems, the latest
version of Python on the Red Hat Enterprise Linux 5 Series (and
Cent OS) is 2.4. Also remember if you depend on additional module or
libraries that these dependencies must be compatible and present on
the systems you manage and not only your workstation. While "soft"
requirements in many ways, these (potential) dependency issues
constrain your choice of scripting environments somewhat, and demand
additional testing.

Google
~~~~~~

If you don't understand something, Google for it. Be able to Google
something without lifting your hand from the keyboard. Most of the
time when a program produces an error, you can find a record of
someone else having the same error and be able to more quickly resolve
your query.

If your initial search does not return anything useful, consider
appending the following information the queries:

- operating system and platform information, and

- relevant version names or numbers of the software you're
  running.

If Google doesn't provide any useful information, consider reaching
out to the provider of support for the system, product, or internal
developer as indicated, that produced the error. Without a doubt, when
you open a support case with a vendor, the level-one support staff are
going to run these Google searches on their own, so you might as well
save the time if the answer is obvious.

Free Software
~~~~~~~~~~~~~

Systems administrators who are more familiar with free software
[#examples-of-free-software]_ will be more effective--on the
whole--than administrators who are not. At least in the contemporary
moment this is at least partially attributable to the preference for
UNIX-like systems in free software. However, free software provides a
number of benefits to users that make them particularly adept systems
administrators. These advantages include:

- A curiosity regarding software and technology.

  In many cases operations work revolves around figuring out how to
  appropriately configure and use existing tools, products,
  abstractions, and systems to build a more reliable, more automated,
  and simpler system. Having a good understanding of current
  practices, systems, and tools makes it easier to develop these kinds
  of solutions and to avoid recreating things that already existing.

- A greater understanding of the operation of fundamental components.

  This nearly goes without saying, but systems administrators need to
  be able to have an intuitive sense of how technology works and
  should work. The way to develop this is to be curious and to figure
  out how everything works, at as many levels of the stack as
  possible.

- A high tolerance for poor user experiences.

  The best infrastructural and systems-level software tends to be very
  configurable, which often comes at the expense of "ease of use."
  This is true of web servers, application servers, databases,
  monitoring tools, and more. If you're the kind of computer user who
  yearns for polish and ease of use, it might be best to retrain
  yourself to tolerate poorly designed interfaces and figure out
  developing ways of needing to use them less.

  In truth the desire for good interfaces is not entirely a detriment
  as an eye for parsimony, intuitive interfaces, and robust systems
  design is valuable, but if you're considering systems work and you
  have a low tolerance for systems that *don't yet* conform to ideal
  operation, you may find systems administration endlessly
  frustrating. The upside is that systems administration specifically,
  and free software in general revolves around making the experience
  of using technology easier, smoother, and more rewarding for
  everyone.

- An extensive toolkit of software and solutions that are easily
  tested and reused.

  While there are some software domains (e.g. media and production
  software, identity management software, arguably "the desktop" etc.)
  where proprietary and open source/free software are more evenly
  matched, for most of the kinds of areas that systems administrators
  do the bulk of their work in, the free software options do not
  simply have parity with proprietary software but are better, more
  robust and more flexible technologies. In light of this, systems
  administrators who are comfortable with and understand free software
  are more likely to be successful systems operators.

.. [#examples-of-free-software] Examples of which include GNU, Linux,
   BSD, Postfix, PostgreSQL, Dovecot, OpenLDAP, OpenVPN, Python, and
   Perl.

Tactics and Strategy
--------------------

If "strategy" refers to planning for various circumstances, then
tactics refer to the actual practical responses to problems. Most
software manuals have a section that discuss "best practices." In
turn, this section discusses some general "best practices," along with
a discussion of how these recommendations relate to actual practices.

Obsession
~~~~~~~~~

While a sizable portion of systems administration work revolves around
understanding technology, developing the best and most appropriate
deployments, and troubleshooting things when they break; the harder
part of systems work revolves around figuring out how to get these
tools and components to integrate and how to "achieve scale," or get
the systems to operate quasi-autonomously and provide the maximum
amount of resources for the most limited amount of cost (both material
and labor-related) as possible.

To be successful at these kinds of massive logistical projects,
systems administrators need to have a certain obsessive
streak. [#attention-to-detail]_ The hard problems in integration and
scaling work are in devising ways of keeping track of a large number
of moving parts and in being rigorous in your approach to organization
to avoid loosing track of a system, or service, or dependency.

There are even "asset management" tools that provide database backed
records of and components of larger or smaller infrastructure. While
the capabilities of these systems vary, and the specifics are not
important, you dedicating some time to keeping track of what you're
administering, what it connects to, how it's configured, where it's
located, what depends on it, what it depends on, and any other
information required for figuring out "why things are the way they
are," particularly when something stops working at 2 am.

Think of the asset database, or asset and service tracking largely, as
an expression of an interesting in labeling things. While it's
possible to go a bit overboard, a reasonable labeling strategy (like a
reasonable asset/service tracking project) can save a lot of
time and headache in the future if properly executed. The problem is
that a system for tracking and describing an environment that is
poorly maintained, difficult to update, and doesn't capture all of the
required relationships, can be dangerous.

This is where an administrator with a deeply ingrained need for order
and a bent toward the obsessive can really do some good. Record
keeping systems and resource management systems are (for the most
part) only as good as the people using them.

.. [#attention-to-detail] I believe that in the language of job
   postings this is "attention to detail," but I don't think that
   there are many kinds of work that won't make use of a keen
   "attention to detail." persistent

Automation
~~~~~~~~~~

No one would deny that systems administration contains a fair amount
of tedium. A certain amount of frustration should be within
tolerances. What separates stellar systems administrators from the
merely competent is the ability to automate things that need are worth
automating and having a good sense of the right time to automate
things, and when the frustration isn't worth it.

Automation often takes the form of code, and while many systems
administrators are decent or even exception coders, most of the core
automatons that help make systems easier to administer, and enable
single administrator be able a larger group of resources, are quite
small. A few lines of shell script, a makefile to manage a process, a
few cronjobs here and maybe a few Python or Perl programs are enough
to take something that's unmanageable and make the process
controllable and consistent. Automating systems administration is task
and integration focused rather than application or service focused,
and while there is overlap and blurring [#dev-ops]_ between developers
and operations work, there is an undeniable difference in approach and
perspective.

Regardless, automation is a great tool, and every systems
administrator needs to be able to write a little code, write scripts
to enforce consistent practices and good policies; at the same time,
it's important to be able to recognize when tasks are difficult to
automate and when automating wouldn't save enough net time. There is
real skill in figuring out when a project falls in the "write a
script," category and when it falls in the "spend an hour or two and
plow through it," and making that distinction almost instinctively.

You should also apply the same basic "is it worth it," test to all
sorts of architectural changes, modifications and deployments. While
being proactive about infrastructure is useful, being *too* proactive
about infrastructural development can lead to under utilization and
services that don't match the actual demand very well. For example,
configuration management and automation tools are great, but if you're
not deploying new systems very frequently and/or most your systems are
different from each other, the overhead may be too high. Similarly,
high availability application and database systems are nearly
pointless if the front end servers represent single points of failure,
just as deploying high performance database and file systems that an
application layers can never saturate is less than useful.

While a few scripts here and there can increase administrator
productivity and sanity, automation often leads to greater reliability
and better adherence to technology policy. Code is predictable, is
capable of generating a full audit trail of its activity, and has
transparent methods. Where people are not great at being consistent
particularly over large tasks or long periods of time, scripts and
makefiles are *ruthlessly consistent*. When you want to make sure that
systems operate *the right way* over a long period of time,
potentially under the control of a large number of operators, scripts
are really the best way to enforce these practices.

.. [#dev-ops] Essentially, the "dev/ops," movement/moment has done
   a lot to integrate the lessons from Agile Methodologies and from
   the software development world into operations work, and while both
   of these developments are quite welcome, it's easy to overplay the
   amount of actual change that the "dev/ops" shift really
   represents. In most cases "dev/ops," is a recognition of the kind
   of work that systems administrators have been doing for ever in
   combination with some notable shifts in development cycles and
   deployment :term:`resource`


Record Keeping and Auditing
~~~~~~~~~~~~~~~~~~~~~~~~~~~



Driven by Data
~~~~~~~~~~~~~~

"Data driven" is a buzzword and because the term it often emerges from
the practice of "scientific management," declarations of being "data
driven," are often suspect to most Systems Administrators. At the same
time, regardless of the buzzword, the actual work of systems
administration has a great deal to do with collecting, managing, and
using data to provide actionable guidelines.

You can reduce many of the hard problems of systems administration to
equations that balance a complex costs, time, effort, benefit, and
risk. If you approach these challenges in these concrete terms, and
use data that you may already have (or can easily collect) to provide
actionable and definitive solutions to these problems.

The "data" in this case represents the information generated by the
systems themselves like from log files or monitoring systems, logs you
keep of your own work (to judge how long things take,) as well as
budget information. In aggregate this information can help you make
more informed decisions and inform expansion and growth planning,
direct you toward projects that require more attention, and otherwise
guide the direction of your work and efforts along the most
(hopefully) productive course.
